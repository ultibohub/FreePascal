{
    Copyright (c) 1998-2002 by Peter Vreman

    This unit implements support import,export,link routines
    for the (i8086) MS-DOS target

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}
unit t_msdos;

{$i fpcdefs.inc}

{$define USE_LINKER_WLINK}

interface


implementation

    uses
       SysUtils,
       cutils,cfileutl,cclasses,
       globtype,globals,systems,verbose,cscript,
       fmodule,i_msdos,
       link,cpuinfo,
       aasmbase,aasmcnst,symbase,symdef,
       omfbase,ogbase,ogomf,owomflib;

    type
      { Borland TLINK support }
      TExternalLinkerMsDosTLink=class(texternallinker)
      private
         Function  WriteResponseFile(isdll:boolean) : Boolean;
      public
         constructor Create;override;
         procedure SetDefaultInfo;override;
         function  MakeExecutable:boolean;override;
      end;

      { the ALINK linker from http://alink.sourceforge.net/ }
      TExternalLinkerMsDosALink=class(texternallinker)
      private
         Function  WriteResponseFile(isdll:boolean) : Boolean;
      public
         constructor Create;override;
         procedure SetDefaultInfo;override;
         function  MakeExecutable:boolean;override;
      end;

      { the (Open) Watcom linker }
      TExternalLinkerMsDosWLink=class(texternallinker)
      private
         Function  WriteResponseFile(isdll:boolean) : Boolean;
         Function  PostProcessExecutable(const fn:string) : Boolean;
      public
         constructor Create;override;
         procedure SetDefaultInfo;override;
         function  MakeExecutable:boolean;override;
      end;

      { TInternalLinkerMsDos }

      TInternalLinkerMsDos=class(tinternallinker)
      private
        function GetTotalSizeForSegmentClass(aExeOutput: TExeOutput; const SegClass: string): QWord;
      protected
        function GetCodeSize(aExeOutput: TExeOutput): QWord;override;
        function GetDataSize(aExeOutput: TExeOutput): QWord;override;
        function GetBssSize(aExeOutput: TExeOutput): QWord;override;
        procedure DefaultLinkScript;override;
      public
        constructor create;override;
      end;

      { tmsdostai_typedconstbuilder }

      tmsdostai_typedconstbuilder = class(ttai_lowleveltypedconstbuilder)
      protected
        procedure add_link_ordered_symbol(sym: tasmsymbol; const secname: TSymStr); override;
      public
        class function get_vectorized_dead_strip_custom_section_name(const basename: TSymStr; st: tsymtable; options: ttcasmlistoptions; out secname: TSymStr): boolean; override;
        class function is_smartlink_vectorized_dead_strip: boolean; override;
      end;

{****************************************************************************
                               tmsdostai_typedconstbuilder
****************************************************************************}

  procedure tmsdostai_typedconstbuilder.add_link_ordered_symbol(sym: tasmsymbol; const secname: TSymStr);
    begin
      if (tf_smartlink_library in target_info.flags) and is_smartlink_vectorized_dead_strip then
        begin
          with current_module.linkorderedsymbols do
            if (Last=nil) or (TCmdStrListItem(Last).Str<>secname) then
              current_module.linkorderedsymbols.concat(secname);
        end;
    end;

  class function tmsdostai_typedconstbuilder.get_vectorized_dead_strip_custom_section_name(const basename: TSymStr; st: tsymtable; options: ttcasmlistoptions; out secname: TSymStr): boolean;
    begin
      result:=(tf_smartlink_library in target_info.flags) and is_smartlink_vectorized_dead_strip;
      if not result then
        exit;
      if tcalo_vectorized_dead_strip_start in options then
        secname:='1_START'
      else if tcalo_vectorized_dead_strip_item in options then
        secname:='2_ITEM'
      else if tcalo_vectorized_dead_strip_end in options then
        secname:='3_END'
      else
	secname:='4_INV';
      secname:=make_mangledname(basename,st,secname);
    end;

  class function tmsdostai_typedconstbuilder.is_smartlink_vectorized_dead_strip: boolean;
    begin
{$ifdef USE_LINKER_WLINK}
      result:=inherited or (tf_smartlink_library in target_info.flags);
{$else}
      result:=inherited and not (cs_link_extern in current_settings.globalswitches);
{$endif USE_LINKER_WLINK}
    end;

{****************************************************************************
                               TExternalLinkerMsDosTLink
****************************************************************************}

Constructor TExternalLinkerMsDosTLink.Create;
begin
  Inherited Create;
  { allow duplicated libs (PM) }
  SharedLibFiles.doubles:=true;
  StaticLibFiles.doubles:=true;
end;


procedure TExternalLinkerMsDosTLink.SetDefaultInfo;
begin
  with Info do
   begin
     ExeCmd[1]:='tlink $OPT $RES';
   end;
end;


Function TExternalLinkerMsDosTLink.WriteResponseFile(isdll:boolean) : Boolean;
Var
  linkres  : TLinkRes;
  s        : string;
begin
  WriteResponseFile:=False;

  { Open link.res file }
  LinkRes:=TLinkRes.Create(outputexedir+Info.ResName,true);

  { Add all options to link.res instead of passing them via command line:
    DOS command line is limited to 126 characters! }

  { add objectfiles, start with prt0 always }
  LinkRes.Add(GetShortName(FindObjectFile('prt0','',false)) + ' +');
  while not ObjectFiles.Empty do
  begin
    s:=ObjectFiles.GetFirst;
    if s<>'' then
      LinkRes.Add(GetShortName(s) + ' +');
  end;
  LinkRes.Add(', ' + maybequoted(current_module.exefilename));

  { Write and Close response }
  linkres.writetodisk;
  LinkRes.Free;

  WriteResponseFile:=True;
end;


function TExternalLinkerMsDosTLink.MakeExecutable:boolean;
var
  binstr,
  cmdstr  : TCmdStr;
  success : boolean;
begin
  if not(cs_link_nolink in current_settings.globalswitches) then
    Message1(exec_i_linking,current_module.exefilename);

  { Write used files and libraries and our own tlink script }
  WriteResponsefile(false);

  { Call linker }
  SplitBinCmd(Info.ExeCmd[1],binstr,cmdstr);
  Replace(cmdstr,'$RES','@'+maybequoted(outputexedir+Info.ResName));
  Replace(cmdstr,'$OPT',Info.ExtraOptions);
  success:=DoExec(FindUtil(utilsprefix+BinStr),cmdstr,true,false);

  { Remove ReponseFile }
  if (success) and not(cs_link_nolink in current_settings.globalswitches) then
    DeleteFile(outputexedir+Info.ResName);

  MakeExecutable:=success;   { otherwise a recursive call to link method }
end;

{****************************************************************************
                               TExternalLinkerMsDosALink
****************************************************************************}

{ TExternalLinkerMsDosALink }

function TExternalLinkerMsDosALink.WriteResponseFile(isdll: boolean): Boolean;
Var
  linkres  : TLinkRes;
  s        : string;
begin
  WriteResponseFile:=False;

  { Open link.res file }
  LinkRes:=TLinkRes.Create(outputexedir+Info.ResName,true);

  { Add all options to link.res instead of passing them via command line:
    DOS command line is limited to 126 characters! }

  { add objectfiles, start with prt0 always }
  LinkRes.Add(maybequoted(FindObjectFile('prt0','',false)));
  while not ObjectFiles.Empty do
  begin
    s:=ObjectFiles.GetFirst;
    if s<>'' then
      LinkRes.Add(maybequoted(s));
  end;
  LinkRes.Add('-oEXE');
  LinkRes.Add('-o ' + maybequoted(current_module.exefilename));

  { Write and Close response }
  linkres.writetodisk;
  LinkRes.Free;

  WriteResponseFile:=True;
end;

constructor TExternalLinkerMsDosALink.Create;
begin
  Inherited Create;
  { allow duplicated libs (PM) }
  SharedLibFiles.doubles:=true;
  StaticLibFiles.doubles:=true;
end;

procedure TExternalLinkerMsDosALink.SetDefaultInfo;
begin
  with Info do
   begin
     ExeCmd[1]:='alink $OPT $RES';
   end;
end;

function TExternalLinkerMsDosALink.MakeExecutable: boolean;
var
  binstr,
  cmdstr  : TCmdStr;
  success : boolean;
begin
  if not(cs_link_nolink in current_settings.globalswitches) then
    Message1(exec_i_linking,current_module.exefilename);

  { Write used files and libraries and our own tlink script }
  WriteResponsefile(false);

  { Call linker }
  SplitBinCmd(Info.ExeCmd[1],binstr,cmdstr);
  Replace(cmdstr,'$RES','@'+maybequoted(outputexedir+Info.ResName));
  Replace(cmdstr,'$OPT',Info.ExtraOptions);
  success:=DoExec(FindUtil(utilsprefix+BinStr),cmdstr,true,false);

  { Remove ReponseFile }
  if (success) and not(cs_link_nolink in current_settings.globalswitches) then
    DeleteFile(outputexedir+Info.ResName);

  MakeExecutable:=success;   { otherwise a recursive call to link method }
end;



{****************************************************************************
                               TExternalLinkerMsDosWLink
****************************************************************************}

{ TExternalLinkerMsDosWLink }

function TExternalLinkerMsDosWLink.WriteResponseFile(isdll: boolean): Boolean;
Var
  linkres  : TLinkRes;
  s        : string;
begin
  WriteResponseFile:=False;

  { Open link.res file }
  LinkRes:=TLinkRes.Create(outputexedir+Info.ResName,true);

  { Add all options to link.res instead of passing them via command line:
    DOS command line is limited to 126 characters! }

  LinkRes.Add('option quiet');

  if cs_debuginfo in current_settings.moduleswitches then
  begin
    if target_dbg.id in [dbg_dwarf2,dbg_dwarf3,dbg_dwarf4] then
      LinkRes.Add('debug dwarf')
    else if target_dbg.id=dbg_codeview then
      LinkRes.Add('debug codeview')
    else
      LinkRes.Add('debug watcom all');
    if cs_link_separate_dbg_file in current_settings.globalswitches then
      LinkRes.Add('option symfile');
  end;

  { add objectfiles, start with prt0 always }
  case current_settings.x86memorymodel of
    mm_tiny:    LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0t','',false)));
    mm_small:   LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0s','',false)));
    mm_medium:  LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0m','',false)));
    mm_compact: LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0c','',false)));
    mm_large:   LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0l','',false)));
    mm_huge:    LinkRes.Add('file ' + maybequoted(FindObjectFile('prt0h','',false)));
  end;
  while not ObjectFiles.Empty do
  begin
    s:=ObjectFiles.GetFirst;
    if s<>'' then
      LinkRes.Add('file ' + maybequoted(s));
  end;
  while not StaticLibFiles.Empty do
  begin
    s:=StaticLibFiles.GetFirst;
    if s<>'' then
      LinkRes.Add('library '+MaybeQuoted(s));
  end;
  if apptype=app_com then
    LinkRes.Add('format dos com')
  else
    LinkRes.Add('format dos');
  if current_settings.x86memorymodel=mm_tiny then
    LinkRes.Add('order clname CODE clname DATA clname BSS')
  else
    LinkRes.Add('order clname CODE clname FAR_DATA clname BEGDATA segment _NULL segment _AFTERNULL clname DATA clname BSS clname STACK clname HEAP');
  if (cs_link_map in current_settings.globalswitches) then
    LinkRes.Add('option map='+maybequoted(ChangeFileExt(current_module.exefilename,'.map')));
  LinkRes.Add('name ' + maybequoted(current_module.exefilename));

  { Write and Close response }
  linkres.writetodisk;
  LinkRes.Free;

  WriteResponseFile:=True;
end;

constructor TExternalLinkerMsDosWLink.Create;
begin
  Inherited Create;
  { allow duplicated libs (PM) }
  SharedLibFiles.doubles:=true;
  StaticLibFiles.doubles:=true;
end;

procedure TExternalLinkerMsDosWLink.SetDefaultInfo;
begin
  with Info do
   begin
     ExeCmd[1]:='wlink $OPT $RES';
   end;
end;

function TExternalLinkerMsDosWLink.MakeExecutable: boolean;
var
  binstr,
  cmdstr  : TCmdStr;
  success : boolean;
begin
  if not(cs_link_nolink in current_settings.globalswitches) then
    Message1(exec_i_linking,current_module.exefilename);

  { Write used files and libraries and our own tlink script }
  WriteResponsefile(false);

  { Call linker }
  SplitBinCmd(Info.ExeCmd[1],binstr,cmdstr);
  Replace(cmdstr,'$RES','@'+maybequoted(outputexedir+Info.ResName));
  Replace(cmdstr,'$OPT',Info.ExtraOptions);
  success:=DoExec(FindUtil(utilsprefix+BinStr),cmdstr,true,false);

  { Post process }
  if success then
    success:=PostProcessExecutable(current_module.exefilename);

  { Remove ReponseFile }
  if (success) and not(cs_link_nolink in current_settings.globalswitches) then
    DeleteFile(outputexedir+Info.ResName);

  MakeExecutable:=success;   { otherwise a recursive call to link method }
end;

{ In far data memory models, this function sets the MaxAlloc value in the DOS MZ
  header according to the difference between HeapMin and HeapMax. We have to do
  this manually, because WLink sets MaxAlloc to $FFFF and there seems to be no
  way to specify a different value with a linker option. }
function TExternalLinkerMsDosWLink.PostProcessExecutable(const fn: string): Boolean;
var
  f: file;
  minalloc,maxalloc: Word;
  heapmin_paragraphs, heapmax_paragraphs: Integer;
begin
  { nothing to do in the near data memory models }
  if current_settings.x86memorymodel in x86_near_data_models then
    exit(true);
  { .COM files are not supported in the far data memory models }
  if apptype=app_com then
    internalerror(2014062501);
  { open file }
  assign(f,fn);
  {$push}{$I-}
   reset(f,1);
  if ioresult<>0 then
    Message1(execinfo_f_cant_open_executable,fn);
  { read minalloc }
  seek(f,$A);
  BlockRead(f,minalloc,2);
  if source_info.endian<>target_info.endian then
    minalloc:=SwapEndian(minalloc);
  { calculate the additional number of paragraphs needed }
  heapmin_paragraphs:=(heapsize + 15) div 16;
  heapmax_paragraphs:=(maxheapsize + 15) div 16;
  maxalloc:=min(minalloc-heapmin_paragraphs+heapmax_paragraphs,$FFFF);
  { write maxalloc }
  seek(f,$C);
  if source_info.endian<>target_info.endian then
    maxalloc:=SwapEndian(maxalloc);
  BlockWrite(f,maxalloc,2);
  close(f);
  {$pop}
  Result:=ioresult=0;
end;

{****************************************************************************
                               TInternalLinkerMsDos
****************************************************************************}

function TInternalLinkerMsDos.GetTotalSizeForSegmentClass(
  aExeOutput: TExeOutput; const SegClass: string): QWord;
var
  objseclist: TFPObjectList;
  objsec: TOmfObjSection;
  i: Integer;
begin
  Result:=0;
  objseclist:=TMZExeOutput(aExeOutput).MZFlatContentSection.ObjSectionList;
  for i:=0 to objseclist.Count-1 do
    begin
      objsec:=TOmfObjSection(objseclist[i]);
      if objsec.ClassName=SegClass then
        Inc(Result,objsec.Size);
    end;
end;

function TInternalLinkerMsDos.GetCodeSize(aExeOutput: TExeOutput): QWord;
begin
  Result:=GetTotalSizeForSegmentClass(aExeOutput,'CODE');
end;

function TInternalLinkerMsDos.GetDataSize(aExeOutput: TExeOutput): QWord;
begin
  Result:=GetTotalSizeForSegmentClass(aExeOutput,'DATA')+
          GetTotalSizeForSegmentClass(aExeOutput,'FAR_DATA');
end;

function TInternalLinkerMsDos.GetBssSize(aExeOutput: TExeOutput): QWord;
begin
  Result:=GetTotalSizeForSegmentClass(aExeOutput,'BSS');
end;

procedure TInternalLinkerMsDos.DefaultLinkScript;
var
  s: TCmdStr;
begin
  { add objectfiles, start with prt0 always }
  case current_settings.x86memorymodel of
    mm_tiny:    LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0t','',false)));
    mm_small:   LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0s','',false)));
    mm_medium:  LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0m','',false)));
    mm_compact: LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0c','',false)));
    mm_large:   LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0l','',false)));
    mm_huge:    LinkScript.Concat('READOBJECT ' + maybequoted(FindObjectFile('prt0h','',false)));
  end;
  while not ObjectFiles.Empty do
  begin
    s:=ObjectFiles.GetFirst;
    if s<>'' then
      LinkScript.Concat('READOBJECT ' + maybequoted(s));
  end;
  LinkScript.Concat('GROUP');
  while not StaticLibFiles.Empty do
  begin
    s:=StaticLibFiles.GetFirst;
    if s<>'' then
      LinkScript.Concat('READSTATICLIBRARY '+MaybeQuoted(s));
  end;
  LinkScript.Concat('ENDGROUP');

  LinkScript.Concat('EXESECTION .MZ_flat_content');
  if current_settings.x86memorymodel=mm_tiny then
    begin
      LinkScript.Concat('  OBJSECTION _TEXT||CODE');
      LinkScript.Concat('  OBJSECTION *||CODE');
      LinkScript.Concat('  OBJSECTION *||DATA');
      LinkScript.Concat('  SYMBOL _edata');
      LinkScript.Concat('  OBJSECTION *||BSS');
      LinkScript.Concat('  SYMBOL _end');
    end
  else
    begin
      LinkScript.Concat('  OBJSECTION _TEXT||CODE');
      LinkScript.Concat('  OBJSECTION *||CODE');
      LinkScript.Concat('  OBJSECTION *||FAR_DATA');
      LinkScript.Concat('  OBJSECTION _NULL||BEGDATA');
      LinkScript.Concat('  OBJSECTION _AFTERNULL||BEGDATA');
      LinkScript.Concat('  OBJSECTION *||BEGDATA');
      LinkScript.Concat('  OBJSECTION *||DATA');
      LinkScript.Concat('  SYMBOL _edata');
      LinkScript.Concat('  OBJSECTION *||BSS');
      LinkScript.Concat('  SYMBOL _end');
      LinkScript.Concat('  OBJSECTION *||STACK');
      LinkScript.Concat('  OBJSECTION *||HEAP');
    end;
  LinkScript.Concat('ENDEXESECTION');

  if (cs_debuginfo in current_settings.moduleswitches) and
     (target_dbg.id in [dbg_dwarf2,dbg_dwarf3,dbg_dwarf4]) then
    begin
      LinkScript.Concat('EXESECTION .debug_info');
      LinkScript.Concat('  OBJSECTION .DEBUG_INFO||DWARF');
      LinkScript.Concat('ENDEXESECTION');
      LinkScript.Concat('EXESECTION .debug_abbrev');
      LinkScript.Concat('  OBJSECTION .DEBUG_ABBREV||DWARF');
      LinkScript.Concat('ENDEXESECTION');
      LinkScript.Concat('EXESECTION .debug_line');
      LinkScript.Concat('  OBJSECTION .DEBUG_LINE||DWARF');
      LinkScript.Concat('ENDEXESECTION');
      LinkScript.Concat('EXESECTION .debug_aranges');
      LinkScript.Concat('  OBJSECTION .DEBUG_ARANGES||DWARF');
      LinkScript.Concat('ENDEXESECTION');
    end;

  LinkScript.Concat('ENTRYNAME ..start');
end;

constructor TInternalLinkerMsDos.create;
begin
  inherited create;
  CArObjectReader:=TOmfLibObjectReader;
  CExeOutput:=TMZExeOutput;
  CObjInput:=TOmfObjInput;
end;

{*****************************************************************************
                                     Initialize
*****************************************************************************}

initialization
  ctai_typedconstbuilder:=tmsdostai_typedconstbuilder;
  RegisterLinker(ld_int_msdos,TInternalLinkerMsDos);
{$if defined(USE_LINKER_TLINK)}
  RegisterLinker(ld_msdos,TExternalLinkerMsDosTLink);
{$elseif defined(USE_LINKER_ALINK)}
  RegisterLinker(ld_msdos,TExternalLinkerMsDosALink);
{$elseif defined(USE_LINKER_WLINK)}
  RegisterLinker(ld_msdos,TExternalLinkerMsDosWLink);
{$else}
  {$fatal no linker defined}
{$endif}
  RegisterTarget(system_i8086_msdos_info);
end.
