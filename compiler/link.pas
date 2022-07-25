{
    Copyright (c) 1998-2002 by Peter Vreman

    This unit handles the linker and binder calls for programs and
    libraries

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
unit link;

{$i fpcdefs.inc}

{ $define DEBUG_MACHO_INFO}

interface

    uses
      sysutils,
      cclasses,
      systems,
      fmodule,
      globtype,
      ldscript,
      ogbase,
      owbase;

    Type
      TLinkerInfo=record
        ExeCmd,
        DllCmd,
        ExtDbgCmd     : array[1..3] of ansistring;
        ResName       : string[100];
        ScriptName    : string[100];
        ExtraOptions  : TCmdStr;
        DynamicLinker : string[100];
      end;

      TLinker = class(TObject)
      public
         HasResources,
         HasExports      : boolean;
         SysInitUnit     : string[20];
         ObjectFiles,
         SharedLibFiles,
         StaticLibFiles,
         FrameworkFiles,
         OrderedSymbols: TCmdStrList;
         Constructor Create;virtual;
         Destructor Destroy;override;
         procedure AddModuleFiles(hp:tmodule);
         Procedure AddObject(const S,unitpath : TPathStr;isunit:boolean);
         Procedure AddStaticLibrary(const S : TCmdStr);
         Procedure AddSharedLibrary(S : TCmdStr);
         Procedure AddStaticCLibrary(const S : TCmdStr);
         Procedure AddSharedCLibrary(S : TCmdStr);
         Procedure AddFramework(S : TCmdStr);
         Procedure AddOrderedSymbol(const s: TCmdStr);
         procedure AddImportSymbol(const libname,symname,symmangledname:TCmdStr;OrdNr: longint;isvar:boolean);virtual;
         Procedure InitSysInitUnitName;virtual;
         Function  MakeExecutable:boolean;virtual;
         Function  MakeSharedLibrary:boolean;virtual;
         Function  MakeStaticLibrary:boolean;virtual;
         procedure ExpandAndApplyOrder(var Src:TCmdStrList);
         procedure LoadPredefinedLibraryOrder;virtual;
         function  ReOrderEntries : boolean;
       end;

      TExternalLinker = class(TLinker)
      protected
         Function WriteSymbolOrderFile: TCmdStr;
         Function GetSanitizerLibName(const basename: TCmdStr; withArch: boolean): TCmdStr;
         Function AddSanitizerLibrariesAndGetSearchDir(const platformname: TCmdStr; out sanitizerlibrarydir: TCmdStr): boolean;
      public
         Info : TLinkerInfo;
         Constructor Create;override;
         Destructor Destroy;override;
         Function  FindUtil(const s:TCmdStr):TCmdStr;
         Function  CatFileContent(para:TCmdStr):TCmdStr;
         Function  DoExec(const command:TCmdStr; para:TCmdStr;showinfo,useshell:boolean):boolean;
         procedure SetDefaultInfo;virtual;
         Function  MakeStaticLibrary:boolean;override;

         Function UniqueName(const str:TCmdStr): TCmdStr;

         function PostProcessELFExecutable(const fn: string; isdll: boolean): boolean;
         function PostProcessMachExecutable(const fn: string; isdll: boolean): boolean;
       end;

      TBooleanArray = array [1..100000] of boolean;
      PBooleanArray = ^TBooleanArray;

      TInternalLinker = class(TLinker)
      private
         FCExeOutput : TExeOutputClass;
         FCObjInput  : TObjInputClass;
         FCArObjectReader : TObjectReaderClass;
         { Libraries }
         FStaticLibraryList : TFPObjectList;
         FImportLibraryList : TFPHashObjectList;
         FGroupStack : TFPObjectList;
         procedure Load_ReadObject(const para:TCmdStr);
         procedure Load_ReadStaticLibrary(const para:TCmdStr;asneededflag:boolean=false);
         procedure Load_Group;
         procedure Load_EndGroup;
         procedure ParseScript_Handle;
         procedure ParseScript_PostCheck;
         procedure ParseScript_Load;
         function  ParsePara(const para : string) : string;
         procedure ParseScript_Order;
         procedure ParseScript_MemPos;
         procedure ParseScript_DataPos;
         procedure PrintLinkerScript;
         function  RunLinkScript(const outputname:TCmdStr):boolean;
         procedure ParseLdScript(src:TScriptLexer);
      protected
         linkscript : TCmdStrList;
         ScriptCount : longint;
         IsHandled : PBooleanArray;
         property CArObjectReader:TObjectReaderClass read FCArObjectReader write FCArObjectReader;
         property CObjInput:TObjInputClass read FCObjInput write FCObjInput;
         property CExeOutput:TExeOutputClass read FCExeOutput write FCExeOutput;
         property StaticLibraryList:TFPObjectList read FStaticLibraryList;
         property ImportLibraryList:TFPHashObjectList read FImportLibraryList;
         procedure DefaultLinkScript;virtual;abstract;
         procedure ScriptAddGenericSections(secnames:string);
         procedure ScriptAddSourceStatements(AddSharedAsStatic:boolean);virtual;
         function GetCodeSize(aExeOutput: TExeOutput): QWord;virtual;
         function GetDataSize(aExeOutput: TExeOutput): QWord;virtual;
         function GetBssSize(aExeOutput: TExeOutput): QWord;virtual;
         function ExecutableFilename:String;virtual;
         function SharedLibFilename:String;virtual;
      public
         IsSharedLibrary : boolean;
         UseStabs : boolean;
         Constructor Create;override;
         Destructor Destroy;override;
         Function  MakeExecutable:boolean;override;
         Function  MakeSharedLibrary:boolean;override;
         procedure AddImportSymbol(const libname,symname,symmangledname:TCmdStr;OrdNr: longint;isvar:boolean);override;
       end;

      TLinkerClass = class of Tlinker;

    var
      Linker  : TLinker;

    function FindObjectFile(s : TCmdStr;const unitpath:TCmdStr;isunit:boolean) : TCmdStr;
    function FindLibraryFile(s:TCmdStr;const prefix,ext:TCmdStr;var foundfile : TCmdStr) : boolean;
    function FindDLL(const s:TCmdStr;var founddll:TCmdStr):boolean;

    procedure RegisterLinker(id:tlink;c:TLinkerClass);

    procedure InitLinker;
    procedure DoneLinker;


Implementation

    uses
      cutils,cfileutl,cstreams,
{$ifdef hasUnix}
      baseunix,
{$endif hasUnix}
      cscript,globals,verbose,comphook,ppu,fpchash,triplet,tripletcpu,
      aasmbase,aasmcpu,
      ogmap;

    var
      CLinker : array[tlink] of TLinkerClass;

{*****************************************************************************
                                   Helpers
*****************************************************************************}

    function GetFileCRC(const fn:TPathStr):cardinal;
      var
        fs : TCStream;
        bufcount,
        bufsize  : Integer;
        buf      : pbyte;
      begin
        result:=0;
        bufsize:=64*1024;
        fs:=CFileStreamClass.Create(fn,fmOpenRead or fmShareDenyNone);
        if CStreamError<>0 then
          begin
            fs.Free;
            Comment(V_Error,'Can''t open file: '+fn);
            exit;
          end;
        getmem(buf,bufsize);
        repeat
          bufcount:=fs.Read(buf^,bufsize);
          result:=UpdateCrc32(result,buf^,bufcount);
        until bufcount<bufsize;
        freemem(buf);
        fs.Free;
      end;


    { searches an object file }
    function FindObjectFile(s:TCmdStr;const unitpath:TCmdStr;isunit:boolean) : TCmdStr;
      var
        found : boolean;
        foundfile : TCmdStr;
      begin
        findobjectfile:='';
        if s='' then
         exit;

        {When linking on target, the units has not been assembled yet,
         if assembling is also done on target,
         so there is no object files to look for at
         the host. Look for the corresponding assembler file instead,
         because it will be assembled to object file on the target.}
        if isunit and (cs_assemble_on_target in current_settings.globalswitches) then
          s:=ChangeFileExt(s,target_info.asmext);

        { when it does not belong to the unit then check if
          the specified file exists without searching any paths }
        if not isunit then
         begin
           if FileExists(FixFileName(s),false) then
            begin
              foundfile:=ScriptFixFileName(s);
              found:=true;
            end;
         end;
        if pos('.',s)=0 then
         s:=s+target_info.objext;
        { find object file
           1. output unit path
           2. output exe path
           3. specified unit path (if specified)
           4. cwd
           5. unit search path
           6. local object path
           7. global object path
           8. exepath (not when linking on target)
          for all finds don't use the directory caching }
        found:=false;
        if isunit and (OutputUnitDir<>'') then
          found:=FindFile(s,OutPutUnitDir,false,foundfile)
        else
          if OutputExeDir<>'' then
            found:=FindFile(s,OutPutExeDir,false,foundfile);
        if (not found) and (unitpath<>'') then
         found:=FindFile(s,unitpath,false,foundfile);
        if (not found) then
         found:=FindFile(s, CurDirRelPath(source_info),false,foundfile);
        if (not found) then
         found:=UnitSearchPath.FindFile(s,false,foundfile);
        if (not found) then
         found:=current_module.localobjectsearchpath.FindFile(s,false,foundfile);
        if (not found) then
         found:=objectsearchpath.FindFile(s,false,foundfile);
        if not(cs_link_on_target in current_settings.globalswitches) and (not found) then
         found:=FindFile(s,exepath,false,foundfile);
        if not(cs_link_nolink in current_settings.globalswitches) and (not found) then
         Message1(exec_w_objfile_not_found,s);

        {Restore file extension}
        if isunit and (cs_assemble_on_target in current_settings.globalswitches) then
          foundfile:= ChangeFileExt(foundfile,target_info.objext);

        findobjectfile:=ScriptFixFileName(foundfile);
      end;


    { searches a (windows) DLL file }
    function FindDLL(const s:TCmdStr;var founddll:TCmdStr):boolean;
      var
        sysdir : TCmdStr;
        Found : boolean;
      begin
        Found:=false;
        { Look for DLL in:
          1. Current dir
          2. Library Path
          3. windir,windir/system,windir/system32 }
        Found:=FindFile(s,'.'+source_info.DirSep,false,founddll);
        if (not found) then
         Found:=librarysearchpath.FindFile(s,false,founddll);

        { when cross compiling, it is pretty useless to search windir etc. for dlls }
        if (not found) and (source_info.system=target_info.system) then
         begin
           sysdir:=FixPath(GetEnvironmentVariable('windir'),false);
           Found:=FindFile(s,sysdir+';'+sysdir+'system'+source_info.DirSep+';'+sysdir+'system32'+source_info.DirSep,false,founddll);
         end;
        if (not found) then
         begin
           message1(exec_w_libfile_not_found,s);
           FoundDll:=s;
         end;
        FindDll:=Found;
      end;


    { searches an library file }
    function FindLibraryFile(s:TCmdStr;const prefix,ext:TCmdStr;var foundfile : TCmdStr) : boolean;
      var
        found : boolean;
        paths : TCmdStr;
      begin
        findlibraryfile:=false;
        foundfile:=s;
        if s='' then
         exit;
        { split path from filename }
        paths:=ExtractFilePath(s);
        s:=ExtractFileName(s);
        { add prefix 'lib' }
        if (prefix<>'') and (Copy(s,1,length(prefix))<>prefix) then
         s:=prefix+s;
        { add extension }
        if (ext<>'') and (Copy(s,length(s)-length(ext)+1,length(ext))<>ext) then
         s:=s+ext;
        { readd the split path }
        s:=paths+s;
        if FileExists(s,false) then
         begin
           foundfile:=ScriptFixFileName(s);
           FindLibraryFile:=true;
           exit;
         end;
        { find libary
           1. cwd
           2. local libary dir
           3. global libary dir
           4. exe path of the compiler (not when linking on target)
          for all searches don't use the directory cache }
        found:=FindFile(s, CurDirRelPath(source_info), false,foundfile);
        if (not found) and (current_module.outputpath<>'') then
         found:=FindFile(s,current_module.outputpath,false,foundfile);
        if (not found) then
         found:=current_module.locallibrarysearchpath.FindFile(s,false,foundfile);
        if (not found) then
         found:=librarysearchpath.FindFile(s,false,foundfile);
        if not(cs_link_on_target in current_settings.globalswitches) and (not found) then
         found:=FindFile(s,exepath,false,foundfile);
        foundfile:=ScriptFixFileName(foundfile);
        findlibraryfile:=found;
      end;


{*****************************************************************************
                                   TLINKER
*****************************************************************************}

    Constructor TLinker.Create;
      begin
        Inherited Create;
        ObjectFiles:=TCmdStrList.Create_no_double;
        SharedLibFiles:=TCmdStrList.Create_no_double;
        StaticLibFiles:=TCmdStrList.Create_no_double;
        FrameworkFiles:=TCmdStrList.Create_no_double;
        OrderedSymbols:=TCmdStrList.Create;
      end;


    Destructor TLinker.Destroy;
      begin
        ObjectFiles.Free;
        SharedLibFiles.Free;
        StaticLibFiles.Free;
        FrameworkFiles.Free;
        OrderedSymbols.Free;
        inherited;
      end;


    procedure TLinker.AddModuleFiles(hp:tmodule);
      var
        mask : longint;
        i,j  : longint;
        ImportLibrary : TImportLibrary;
        ImportSymbol  : TImportSymbol;
      begin
        with hp do
         begin
           if mf_has_resourcefiles in moduleflags then
             HasResources:=true;
           if mf_has_exports in moduleflags then
             HasExports:=true;
         { link unit files }
           if (headerflags and uf_no_link)=0 then
            begin
              { create mask which unit files need linking }
              mask:=link_always;
              { lto linking ?}
              if (cs_lto in current_settings.moduleswitches) and
                 ((headerflags and uf_lto_linked)<>0) and
                 (not(cs_lto_nosystem in init_settings.globalswitches) or
                  (hp.modulename^<>'SYSTEM')) then
                begin
                  mask:=mask or link_lto;
                end
              else
                begin
                  { static linking ? }
                  if (cs_link_static in current_settings.globalswitches) then
                   begin
                     if (headerflags and uf_static_linked)=0 then
                      begin
                        { if static not avail then try smart linking }
                        if (headerflags and uf_smart_linked)<>0 then
                         begin
                           Message1(exec_t_unit_not_static_linkable_switch_to_smart,modulename^);
                           mask:=mask or link_smart;
                         end
                        else
                         Message1(exec_e_unit_not_smart_or_static_linkable,modulename^);
                      end
                     else
                       mask:=mask or link_static;
                   end;
                  { smart linking ? }
                  if (cs_link_smart in current_settings.globalswitches) then
                   begin
                     if (headerflags and uf_smart_linked)=0 then
                      begin
                        { if smart not avail then try static linking }
                        if (headerflags and uf_static_linked)<>0 then
                         begin
                           { if not create_smartlink_library, then smart linking happens using the
                             regular object files
                           }
                           if create_smartlink_library then
                             Message1(exec_t_unit_not_smart_linkable_switch_to_static,modulename^);
                           mask:=mask or link_static;
                         end
                        else
                         Message1(exec_e_unit_not_smart_or_static_linkable,modulename^);
                      end
                     else
                      mask:=mask or link_smart;
                   end;
                  { shared linking }
                  if (cs_link_shared in current_settings.globalswitches) then
                   begin
                     if (headerflags and uf_shared_linked)=0 then
                      begin
                        { if shared not avail then try static linking }
                        if (headerflags and uf_static_linked)<>0 then
                         begin
                           Message1(exec_t_unit_not_shared_linkable_switch_to_static,modulename^);
                           mask:=mask or link_static;
                         end
                        else
                         Message1(exec_e_unit_not_shared_or_static_linkable,modulename^);
                      end
                     else
                      mask:=mask or link_shared;
                   end;
                end;
              { unit files }
              while not linkunitofiles.empty do
                AddObject(linkunitofiles.getusemask(mask),path,true);
              while not linkunitstaticlibs.empty do
                AddStaticLibrary(linkunitstaticlibs.getusemask(mask));
              while not linkunitsharedlibs.empty do
                AddSharedLibrary(linkunitsharedlibs.getusemask(mask));
            end;
           { Other needed .o and libs, specified using $L,$LINKLIB,external }
           mask:=link_always;
           while not linkotherofiles.empty do
            AddObject(linkotherofiles.Getusemask(mask),path,false);
           while not linkotherstaticlibs.empty do
            AddStaticCLibrary(linkotherstaticlibs.Getusemask(mask));
           while not linkothersharedlibs.empty do
            AddSharedCLibrary(linkothersharedlibs.Getusemask(mask));
           while not linkotherframeworks.empty do
             AddFramework(linkotherframeworks.Getusemask(mask));
           { Known Library/DLL Imports }
           for i:=0 to ImportLibraryList.Count-1 do
             begin
               ImportLibrary:=TImportLibrary(ImportLibraryList[i]);
               for j:=0 to ImportLibrary.ImportSymbolList.Count-1 do
                 begin
                   ImportSymbol:=TImportSymbol(ImportLibrary.ImportSymbolList[j]);
                   AddImportSymbol(ImportLibrary.Name,ImportSymbol.Name,
                     ImportSymbol.MangledName,ImportSymbol.OrdNr,ImportSymbol.IsVar);
                 end;
             end;
           { ordered symbols }
           OrderedSymbols.concatList(linkorderedsymbols);
         end;
      end;


    procedure TLinker.AddImportSymbol(const libname,symname,symmangledname:TCmdStr;OrdNr: longint;isvar:boolean);
      begin
      end;


    Procedure TLinker.AddObject(const S,unitpath : TPathStr;isunit:boolean);
      begin
        ObjectFiles.Concat(FindObjectFile(s,unitpath,isunit))
      end;


    Procedure TLinker.AddSharedLibrary(S:TCmdStr);
      begin
        if s='' then
          exit;
        { remove prefix 'lib' }
        if Copy(s,1,length(target_info.sharedlibprefix))=target_info.sharedlibprefix then
          Delete(s,1,length(target_info.sharedlibprefix));
        { remove extension if any }
        if Copy(s,length(s)-length(target_info.sharedlibext)+1,length(target_info.sharedlibext))=target_info.sharedlibext then
          Delete(s,length(s)-length(target_info.sharedlibext)+1,length(target_info.sharedlibext)+1);
        { ready to be added }
        SharedLibFiles.Concat(S);
      end;


    Procedure TLinker.AddStaticLibrary(const S:TCmdStr);
      var
        ns : TCmdStr;
        found : boolean;
      begin
        if s='' then
          exit;
        found:=FindLibraryFile(s,target_info.staticlibprefix,target_info.staticlibext,ns);
        if not(cs_link_nolink in current_settings.globalswitches) and (not found) then
          Message1(exec_w_libfile_not_found,s);
        StaticLibFiles.Concat(ns);
      end;


    Procedure TLinker.AddSharedCLibrary(S:TCmdStr);
      begin
        if s='' then
          exit;
        { remove prefix 'lib' }
        if Copy(s,1,length(target_info.sharedclibprefix))=target_info.sharedclibprefix then
          Delete(s,1,length(target_info.sharedclibprefix));
        { remove extension if any }
        if Copy(s,length(s)-length(target_info.sharedclibext)+1,length(target_info.sharedclibext))=target_info.sharedclibext then
          Delete(s,length(s)-length(target_info.sharedclibext)+1,length(target_info.sharedclibext)+1);
        { ready to be added }
        SharedLibFiles.Concat(S);
      end;


    Procedure TLinker.AddFramework(S:TCmdStr);
      begin
        if s='' then
          exit;
        { ready to be added }
        FrameworkFiles.Concat(S);
      end;


    procedure TLinker.AddOrderedSymbol(const s: TCmdStr);
      begin
        OrderedSymbols.Concat(s);
      end;


    Procedure TLinker.AddStaticCLibrary(const S:TCmdStr);
      var
        ns : TCmdStr;
        found : boolean;
      begin
        if s='' then
         exit;
        found:=FindLibraryFile(s,target_info.staticclibprefix,target_info.staticclibext,ns);
        if not(cs_link_nolink in current_settings.globalswitches) and (not found) then
         Message1(exec_w_libfile_not_found,s);
        StaticLibFiles.Concat(ns);
      end;


    procedure TLinker.InitSysInitUnitName;
      begin
      end;


    function TLinker.MakeExecutable:boolean;
      begin
        MakeExecutable:=false;
        Message(exec_e_exe_not_supported);
      end;


    Function TLinker.MakeSharedLibrary:boolean;
      begin
        MakeSharedLibrary:=false;
        Message(exec_e_dll_not_supported);
      end;


    Function TLinker.MakeStaticLibrary:boolean;
      begin
        MakeStaticLibrary:=false;
        Message(exec_e_static_lib_not_supported);
      end;


    Procedure TLinker.ExpandAndApplyOrder(var Src:TCmdStrList);
      var
        p : TLinkStrMap;
        i : longint;
      begin
        // call Virtual TLinker method to initialize
        LoadPredefinedLibraryOrder;

        // something to do?
        if (LinkLibraryAliases.count=0) and (LinkLibraryOrder.Count=0) Then
          exit;
        p:=TLinkStrMap.Create;

        // expand libaliases, clears src
        LinkLibraryAliases.expand(src,p);

        // writeln(src.count,' ',p.count,' ',linklibraryorder.count,' ',linklibraryaliases.count);
        // apply order
        p.UpdateWeights(LinkLibraryOrder);
        p.SortOnWeight;

        // put back in src
        for i:=0 to p.count-1 do
          src.insert(p[i].Key);
        p.free;
      end;


    procedure TLinker.LoadPredefinedLibraryOrder;
      begin
      end;


    function  TLinker.ReOrderEntries : boolean;
      begin
        result:=(LinkLibraryOrder.count>0) or (LinkLibraryAliases.count>0);
      end;


{*****************************************************************************
                              TEXTERNALLINKER
*****************************************************************************}

    Function TExternalLinker.WriteSymbolOrderFile: TCmdStr;
      var
        item: TCmdStrListItem;
        symfile: TScript;
      begin
        result:='';
        { only for darwin for now; can also enable for other platforms when using
          the LLVM linker }
        if (OrderedSymbols.Empty) or
           not(tf_supports_symbolorderfile in target_info.flags) then
          exit;
        symfile:=TScript.Create(outputexedir+UniqueName('symbol_order')+'.fpc');
        item:=TCmdStrListItem(OrderedSymbols.First);
        while assigned(item) do
          begin
            symfile.add(item.str);
            item:=TCmdStrListItem(item.next);
          end;
        symfile.WriteToDisk;
        result:=symfile.fn;
        symfile.Free;
      end;


    Function TExternalLinker.GetSanitizerLibName(const basename: TCmdStr; withArch: boolean): TCmdStr;
      begin
        result:=target_info.sharedClibprefix+'clang_rt.'+basename;
        if target_info.system in systems_darwin then
          begin
            { Darwin never adds the arch, it uses fat binaries. But it has the
              extra '_dynamic' for some reason, and also adds the platform type
            }
            if target_info.system in systems_macosx then
              result:=result+'_osx_dynamic'
            else if target_info.system in systems_ios then
              result:='_ios_dynamic'
            else if target_info.system in systems_iphonesym then
              result:='_iossim_dynamic'
            else
              internalerror(2022071010);
          end
        else
          begin
            if withArch then
              begin
                result:=result+'-'+tripletcpustr(triplet_llvmrt);
                if target_info.system in systems_android then
                  result:=result+'-android';
              end;
          end;
        result:=result+target_info.sharedClibext;
      end;


    function TExternalLinker.AddSanitizerLibrariesAndGetSearchDir(const platformname: TCmdStr; out sanitizerlibrarydir: TCmdStr): boolean;
      var
        clang,
        clangsearchdirs,
        textline,
        clangsearchdirspath,
        sanitizerlibname,
        sanitizerlibrarypath: TCmdStr;
        sanitizerlibraryfiles: TCmdStrList;
        searchrec: TSearchRec;
        searchres: longint;
        clangsearchdirsfile: text;
      begin
        sanitizerlibraryfiles:=TCmdStrList.Create;
        result:=false;
        if (cs_sanitize_address in current_settings.moduleswitches) and
           not(cs_link_on_target in current_settings.globalswitches) then
          begin
          { ask clang }
          clang:=FindUtil('clang'+llvmutilssuffix);
          if clang<>'' then
            begin
              clangsearchdirspath:=outputexedir+UniqueName('clangsearchdirs');
              searchres:=shell(maybequoted(clang)+' -target '+targettriplet(triplet_llvm)+' -print-file-name=lib > '+maybequoted(clangsearchdirspath));
              if searchres=0 then
                begin
                  AssignFile(clangsearchdirsfile,clangsearchdirspath);
{$push}{$i-}
                  reset(clangsearchdirsfile);
{$pop}
                  if ioresult=0 then
                    begin
                      readln(clangsearchdirsfile,textline);
                      sanitizerlibrarydir:=FixFileName(textline+'/'+platformname);
                      sanitizerlibrarypath:=FixFileName(sanitizerlibrarydir+'/');
                      { from clang:
                        Check for runtime files in the new layout without the architecture first.
                      }
                      sanitizerlibname:=GetSanitizerLibName('asan',false);
                      result:=FileExists(sanitizerlibrarypath+sanitizerlibname,false);
                      if result then
                        begin
                          sanitizerlibraryfiles.Concat(sanitizerlibrarypath+sanitizerlibname);
                        end
                      else
                        begin
                          sanitizerlibname:=GetSanitizerLibName('asan',true);
                          result:=FileExists(sanitizerlibrarypath+sanitizerlibname,false);
                          if result then
                            sanitizerlibraryfiles.Concat(sanitizerlibrarypath+sanitizerlibname);
                        end;
                    end;
                end;
              if FileExists(clangsearchdirspath,false) then
                DeleteFile(clangsearchdirspath);
            end;
          end;
        if result then
          ObjectFiles.concatList(sanitizerlibraryfiles);
        sanitizerlibraryfiles.free;
      end;


    Constructor TExternalLinker.Create;
      begin
        inherited Create;
        { set generic defaults }
        FillChar(Info,sizeof(Info),0);
        if cs_link_on_target in current_settings.globalswitches then
          begin
            Info.ResName:=ChangeFileExt(inputfilename,'_link.res');
            Info.ScriptName:=ChangeFileExt(inputfilename,'_script.res');
          end
        else
          begin
            Info.ResName:=UniqueName('link')+'.res';
            Info.ScriptName:=UniqueName('script')+'.res';
          end;
        { set the linker specific defaults }
        SetDefaultInfo;
        { Allow Parameter overrides for linker info }
        with Info do
         begin
           if ParaLinkOptions<>'' then
            ExtraOptions:=ParaLinkOptions;
           if ParaDynamicLinker<>'' then
            DynamicLinker:=ParaDynamicLinker;
         end;
      end;


    Destructor TExternalLinker.Destroy;
      begin
        inherited destroy;
      end;


    Procedure TExternalLinker.SetDefaultInfo;
      begin
      end;


    Function TExternalLinker.FindUtil(const s:TCmdStr):TCmdStr;
      var
        Found    : boolean;
        FoundBin : TCmdStr;
        UtilExe  : TCmdStr;
      begin
        if cs_link_on_target in current_settings.globalswitches then
          begin
            { If linking on target, don't add any path PM }
            { change extension only on platforms that use an exe extension, otherwise on OpenBSD 'ld.bfd' gets
              converted to 'ld' }
            if target_info.exeext<>'' then
              FindUtil:=ChangeFileExt(s,target_info.exeext)
            else
              FindUtil:=s;
            exit;
          end;
        { change extension only on platforms that use an exe extension, otherwise on OpenBSD 'ld.bfd' gets converted
          to 'ld' }
        if source_info.exeext<>'' then
          UtilExe:=ChangeFileExt(s,source_info.exeext)
        else
          UtilExe:=s;
        FoundBin:='';
        Found:=false;
        if utilsdirectory<>'' then
         Found:=FindFile(utilexe,utilsdirectory,false,Foundbin);
        if (not Found) then
         Found:=FindExe(utilexe,false,Foundbin);
        if (not Found) and not(cs_link_nolink in current_settings.globalswitches) then
         begin
           Message1(exec_e_util_not_found,utilexe);
           current_settings.globalswitches:=current_settings.globalswitches+[cs_link_nolink];
         end;
        if (FoundBin<>'') then
         Message1(exec_t_using_util,FoundBin);
        FindUtil:=FoundBin;
      end;


    Function TExternalLinker.CatFileContent(para : TCmdStr) : TCmdStr;
      var
        filecontent : TCmdStr;
        f : text;
        st : TCmdStr;
      begin
        if not (tf_no_backquote_support in source_info.flags) or
           (cs_link_on_target in current_settings.globalswitches) then
           begin
             CatFileContent:='`cat '+MaybeQuoted(para)+'`';
             Exit;
           end;
        assign(f,para);
        filecontent:='';
        {$push}{$I-}
        reset(f);
        {$pop}
        if IOResult<>0 then
          begin
            Message1(exec_n_backquote_cat_file_not_found,para);
          end
        else
          begin
            while not eof(f) do
              begin
                readln(f,st);
                if st<>'' then
                  filecontent:=filecontent+' '+st;
              end;
            close(f);
          end;
        CatFileContent:=filecontent;
      end;

    Function TExternalLinker.DoExec(const command:TCmdStr; para:TCmdStr;showinfo,useshell:boolean):boolean;
      var
        exitcode: longint;
      begin
        DoExec:=true;
        if not(cs_link_nolink in current_settings.globalswitches) then
         begin
           FlushOutput;
           if useshell then
             exitcode:=shell(maybequoted(command)+' '+para)
           else
             try
               exitcode:=RequotedExecuteProcess(command,para);
             except on E:EOSError do
               begin
                 Message(exec_e_cant_call_linker);
                 current_settings.globalswitches:=current_settings.globalswitches+[cs_link_nolink];
                 DoExec:=false;
               end;
             end;
           if (exitcode<>0) then
             begin
               Message(exec_e_error_while_linking);
               current_settings.globalswitches:=current_settings.globalswitches+[cs_link_nolink];
               DoExec:=false;
             end;
         end;
      { Update asmres when externmode is set }
        if cs_link_nolink in current_settings.globalswitches then
         begin
           if showinfo then
             begin
               if current_module.islibrary then
                 AsmRes.AddLinkCommand(Command,Para,current_module.sharedlibfilename)
               else
                 AsmRes.AddLinkCommand(Command,Para,current_module.exefilename);
             end
           else
            AsmRes.AddLinkCommand(Command,Para,'');
         end;
      end;


    Function TExternalLinker.MakeStaticLibrary:boolean;

        function GetNextFiles(const maxCmdLength : Longint; var item : TCmdStrListItem; const addfilecmd : string) : TCmdStr;
          begin
            result := '';
            while (assigned(item) and ((length(result) + length(item.str) + 1) < maxCmdLength)) do begin
              result := result + ' ' + addfilecmd + item.str;
              item := TCmdStrListItem(item.next);
            end;
          end;

        function get_wlib_record_size: integer;
          begin
            result:=align(align(SmartLinkOFiles.Count,128) div 128,16);
          end;

      var
        binstr, firstbinstr, scriptfile : TCmdStr;
        cmdstr, firstcmd, nextcmd, smartpath : TCmdStr;
        current : TCmdStrListItem;
        script: Text;
        scripted_ar : boolean;
        ar_creates_different_output_file : boolean;
        success : boolean;
        first : boolean;
      begin
        MakeStaticLibrary:=false;
      { remove the library, to be sure that it is rewritten }
        DeleteFile(current_module.staticlibfilename);
      { Call AR }
        smartpath:=FixPath(ChangeFileExt(current_module.asmfilename,target_info.smartext),false);
        SplitBinCmd(target_ar.arcmd,binstr,cmdstr);
        binstr := FindUtil(utilsprefix + binstr);
        if target_ar.arfirstcmd<>'' then
          begin
            SplitBinCmd(target_ar.arfirstcmd,firstbinstr,firstcmd);
            firstbinstr := FindUtil(utilsprefix + firstbinstr);
          end
        else
          begin
            firstbinstr:=binstr;
            firstcmd:=cmdstr;
          end;


        scripted_ar:=(target_ar.id=ar_gnu_ar_scripted) or
                     (target_ar.id=ar_watcom_wlib_omf_scripted) or
                     (target_ar.id=ar_sdcc_sdar_scripted);

        if scripted_ar then
          begin
            scriptfile := FixFileName(smartpath+'arscript.txt');
            Replace(cmdstr,'$SCRIPT',maybequoted(scriptfile));
            Assign(script, scriptfile);
            Rewrite(script);
            try
              if (target_ar.id in [ar_gnu_ar_scripted,ar_sdcc_sdar_scripted]) then
                writeln(script, 'CREATE ' + current_module.staticlibfilename)
              else { wlib case }
                writeln(script,'-q -p=',get_wlib_record_size,' -fo -c -b '+
                  maybequoted(current_module.staticlibfilename));
              current := TCmdStrListItem(SmartLinkOFiles.First);
              while current <> nil do
                begin
                  if (target_ar.id in [ar_gnu_ar_scripted,ar_sdcc_sdar_scripted]) then
                  writeln(script, 'ADDMOD ' + current.str)
                  else
                    writeln(script,'+' + current.str);
                  current := TCmdStrListItem(current.next);
                end;
              if (target_ar.id in [ar_gnu_ar_scripted,ar_sdcc_sdar_scripted]) then
                begin
                  writeln(script, 'SAVE');
                  writeln(script, 'END');
                end;
            finally
              Close(script);
            end;
            success:=DoExec(binstr,cmdstr,false,true);
          end
        else
          begin
            ar_creates_different_output_file:=(Pos('$OUTPUTLIB',cmdstr)>0) or (Pos('$OUTPUTLIB',firstcmd)>0);
            Replace(cmdstr,'$LIB',maybequoted(current_module.staticlibfilename));
            Replace(firstcmd,'$LIB',maybequoted(current_module.staticlibfilename));
            Replace(cmdstr,'$OUTPUTLIB',maybequoted(current_module.staticlibfilename+'.tmp'));
            Replace(firstcmd,'$OUTPUTLIB',maybequoted(current_module.staticlibfilename+'.tmp'));
            if target_ar.id=ar_watcom_wlib_omf then
              begin
                Replace(cmdstr,'$RECSIZE','-p='+IntToStr(get_wlib_record_size));
                Replace(firstcmd,'$RECSIZE','-p='+IntToStr(get_wlib_record_size));
              end;
            { create AR commands }
            success := true;
            current := TCmdStrListItem(SmartLinkOFiles.First);
            first := true;
            repeat
              if first then
                nextcmd := firstcmd
              else
                nextcmd := cmdstr;
              Replace(nextcmd,'$FILES',GetNextFiles(2047, current, target_ar.addfilecmd));
              if first then
                success:=DoExec(firstbinstr,nextcmd,false,true)
              else
                success:=DoExec(binstr,nextcmd,false,true);
              if ar_creates_different_output_file then
                begin
                  if FileExists(current_module.staticlibfilename,false) then
                    DeleteFile(current_module.staticlibfilename);
                  if FileExists(current_module.staticlibfilename+'.tmp',false) then
                    RenameFile(current_module.staticlibfilename+'.tmp',current_module.staticlibfilename);
                end;
              first := false;
            until (not assigned(current)) or (not success);
          end;

        if (target_ar.arfinishcmd <> '') then
          begin
            SplitBinCmd(target_ar.arfinishcmd,binstr,cmdstr);
            binstr := FindUtil(utilsprefix + binstr);
            Replace(cmdstr,'$LIB',maybequoted(current_module.staticlibfilename));
            success:=DoExec(binstr,cmdstr,false,true);
          end;

        { Clean up }
        if not(cs_asm_leave in current_settings.globalswitches) then
         if not(cs_link_nolink in current_settings.globalswitches) then
          begin
            while not SmartLinkOFiles.Empty do
              DeleteFile(SmartLinkOFiles.GetFirst);
            if scripted_ar then
              DeleteFile(scriptfile);
            RemoveDir(smartpath);
          end
         else
          begin
            while not SmartLinkOFiles.Empty do
              AsmRes.AddDeleteCommand(SmartLinkOFiles.GetFirst);
            if scripted_ar then
              AsmRes.AddDeleteCommand(scriptfile);
            AsmRes.AddDeleteDirCommand(smartpath);
          end;
        MakeStaticLibrary:=success;
      end;

    function TExternalLinker.UniqueName(const str: TCmdStr): TCmdStr;
      const
        pid: SizeUInt = 0;
      begin
        if pid=0 then
          pid:=GetProcessID;
        if pid>0 then
          result:=str+tostr(pid)
        else
          result:=str;
      end;


    function TExternalLinker.PostProcessELFExecutable(const fn : string;isdll:boolean):boolean;
      type
        TElf32header=packed record
          magic0123         : array[0..3] of char;
          file_class        : byte;
          data_encoding     : byte;
          file_version      : byte;
          padding           : array[$07..$0f] of byte;

          e_type            : word;
          e_machine         : word;
          e_version         : longint;
          e_entry           : longint;          { entrypoint }
          e_phoff           : longint;          { program header offset }

          e_shoff           : longint;          { sections header offset }
          e_flags           : longint;
          e_ehsize          : word;             { elf header size in bytes }
          e_phentsize       : word;             { size of an entry in the program header array }
          e_phnum           : word;             { 0..e_phnum-1 of entrys }
          e_shentsize       : word;             { size of an entry in sections header array }
          e_shnum           : word;             { 0..e_shnum-1 of entrys }
          e_shstrndx        : word;             { index of string section header }
        end;
        TElf32sechdr=packed record
          sh_name           : longint;
          sh_type           : longint;
          sh_flags          : longint;
          sh_addr           : longint;

          sh_offset         : longint;
          sh_size           : longint;
          sh_link           : longint;
          sh_info           : longint;

          sh_addralign      : longint;
          sh_entsize        : longint;
        end;

        telf64header=packed record
          magic0123         : array[0..3] of char;
          file_class        : byte;
          data_encoding     : byte;
          file_version      : byte;
          padding           : array[$07..$0f] of byte;

          e_type            : word;
          e_machine         : word;
          e_version         : longword;
          e_entry           : qword;            { entrypoint }
          e_phoff           : qword;            { program header offset }
          e_shoff           : qword;            { sections header offset }
          e_flags           : longword;
          e_ehsize          : word;             { elf header size in bytes }
          e_phentsize       : word;             { size of an entry in the program header array }
          e_phnum           : word;             { 0..e_phnum-1 of entrys }
          e_shentsize       : word;             { size of an entry in sections header array }
          e_shnum           : word;             { 0..e_shnum-1 of entrys }
          e_shstrndx        : word;             { index of string section header }
        end;
        TElf64sechdr=packed record
          sh_name           : longword;
          sh_type           : longword;
          sh_flags          : qword;
          sh_addr           : qword;
          sh_offset         : qword;
          sh_size           : qword;
          sh_link           : longword;
          sh_info           : longword;
          sh_addralign      : qword;
          sh_entsize        : qword;
        end;


      function MayBeSwapHeader(h : telf32header) : telf32header;
        begin
          result:=h;
          if source_info.endian<>target_info.endian then
            with h do
              begin
                result.e_type:=swapendian(e_type);
                result.e_machine:=swapendian(e_machine);
                result.e_version:=swapendian(e_version);
                result.e_entry:=swapendian(e_entry);
                result.e_phoff:=swapendian(e_phoff);
                result.e_shoff:=swapendian(e_shoff);
                result.e_flags:=swapendian(e_flags);
                result.e_ehsize:=swapendian(e_ehsize);
                result.e_phentsize:=swapendian(e_phentsize);
                result.e_phnum:=swapendian(e_phnum);
                result.e_shentsize:=swapendian(e_shentsize);
                result.e_shnum:=swapendian(e_shnum);
                result.e_shstrndx:=swapendian(e_shstrndx);
              end;
        end;


      function MayBeSwapHeader(h : telf64header) : telf64header;
        begin
          result:=h;
          if source_info.endian<>target_info.endian then
            with h do
              begin
                result.e_type:=swapendian(e_type);
                result.e_machine:=swapendian(e_machine);
                result.e_version:=swapendian(e_version);
                result.e_entry:=swapendian(e_entry);
                result.e_phoff:=swapendian(e_phoff);
                result.e_shoff:=swapendian(e_shoff);
                result.e_flags:=swapendian(e_flags);
                result.e_ehsize:=swapendian(e_ehsize);
                result.e_phentsize:=swapendian(e_phentsize);
                result.e_phnum:=swapendian(e_phnum);
                result.e_shentsize:=swapendian(e_shentsize);
                result.e_shnum:=swapendian(e_shnum);
                result.e_shstrndx:=swapendian(e_shstrndx);
              end;
        end;


      function MaybeSwapSecHeader(h : telf32sechdr) : telf32sechdr;
        begin
          result:=h;
          if source_info.endian<>target_info.endian then
            with h do
              begin
                result.sh_name:=swapendian(sh_name);
                result.sh_type:=swapendian(sh_type);
                result.sh_flags:=swapendian(sh_flags);
                result.sh_addr:=swapendian(sh_addr);
                result.sh_offset:=swapendian(sh_offset);
                result.sh_size:=swapendian(sh_size);
                result.sh_link:=swapendian(sh_link);
                result.sh_info:=swapendian(sh_info);
                result.sh_addralign:=swapendian(sh_addralign);
                result.sh_entsize:=swapendian(sh_entsize);
              end;
        end;


      function MaybeSwapSecHeader(h : telf64sechdr) : telf64sechdr;
        begin
          result:=h;
          if source_info.endian<>target_info.endian then
            with h do
              begin
                result.sh_name:=swapendian(sh_name);
                result.sh_type:=swapendian(sh_type);
                result.sh_flags:=swapendian(sh_flags);
                result.sh_addr:=swapendian(sh_addr);
                result.sh_offset:=swapendian(sh_offset);
                result.sh_size:=swapendian(sh_size);
                result.sh_link:=swapendian(sh_link);
                result.sh_info:=swapendian(sh_info);
                result.sh_addralign:=swapendian(sh_addralign);
                result.sh_entsize:=swapendian(sh_entsize);
              end;
        end;

      var
        f : file;

      function ReadSectionName(pos : longint) : String;
        var
          oldpos : longint;
          c : char;
        begin
          oldpos:=filepos(f);
          seek(f,pos);
          Result:='';
          while true do
            begin
              blockread(f,c,1);
              if c=#0 then
                break;
              Result:=Result+c;
            end;
          seek(f,oldpos);
        end;

      var
        elfheader32 : TElf32header;
        secheader32 : TElf32sechdr;
        elfheader64 : TElf64header;
        secheader64 : TElf64sechdr;
        i : longint;
        stringoffset : longint;
        secname : string;
      begin
        Result:=false;
        { open file }
        assign(f,fn);
        {$push}{$I-}
        reset(f,1);
        if ioresult<>0 then
          Message1(execinfo_f_cant_open_executable,fn);
        { read header }
        blockread(f,elfheader32,sizeof(tElf32header));
        with elfheader32 do
          if not((magic0123[0]=#$7f) and (magic0123[1]='E') and (magic0123[2]='L') and (magic0123[3]='F')) then
            Exit;
        case elfheader32.file_class of
          1:
            begin
              elfheader32:=MayBeSwapHeader(elfheader32);
              seek(f,elfheader32.e_shoff);
              { read string section header }
              seek(f,elfheader32.e_shoff+sizeof(TElf32sechdr)*elfheader32.e_shstrndx);
              blockread(f,secheader32,sizeof(secheader32));
              secheader32:=MaybeSwapSecHeader(secheader32);
              stringoffset:=secheader32.sh_offset;

              seek(f,elfheader32.e_shoff);
              status.datasize:=0;
              for i:=0 to elfheader32.e_shnum-1 do
                begin
                  blockread(f,secheader32,sizeof(secheader32));
                  secheader32:=MaybeSwapSecHeader(secheader32);
                  secname:=ReadSectionName(stringoffset+secheader32.sh_name);
                  case secname of
                    '.text':
                      begin
                        Message1(execinfo_x_codesize,tostr(secheader32.sh_size));
                        status.codesize:=secheader32.sh_size;
                      end;
                    '.fpcdata',
                    '.rodata',
                    '.data':
                      begin
                        Message1(execinfo_x_initdatasize,tostr(secheader32.sh_size));
                        inc(status.datasize,secheader32.sh_size);
                      end;
                    '.bss':
                      begin
                        Message1(execinfo_x_uninitdatasize,tostr(secheader32.sh_size));
                        inc(status.datasize,secheader32.sh_size);
                      end;
                  end;
                end;
            end;
          2:
            begin
              seek(f,0);
              blockread(f,elfheader64,sizeof(tElf64header));
              with elfheader64 do
                if not((magic0123[0]=#$7f) and (magic0123[1]='E') and (magic0123[2]='L') and (magic0123[3]='F')) then
                  Exit;
              elfheader64:=MayBeSwapHeader(elfheader64);
              seek(f,elfheader64.e_shoff);
              { read string section header }
              seek(f,elfheader64.e_shoff+sizeof(TElf64sechdr)*elfheader64.e_shstrndx);
              blockread(f,secheader64,sizeof(secheader64));
              secheader64:=MaybeSwapSecHeader(secheader64);
              stringoffset:=secheader64.sh_offset;

              seek(f,elfheader64.e_shoff);
              status.datasize:=0;
              for i:=0 to elfheader64.e_shnum-1 do
                begin
                  blockread(f,secheader64,sizeof(secheader64));
                  secheader64:=MaybeSwapSecHeader(secheader64);
                  secname:=ReadSectionName(stringoffset+secheader64.sh_name);
                  case secname of
                    '.text':
                      begin
                        Message1(execinfo_x_codesize,tostr(secheader64.sh_size));
                        status.codesize:=secheader64.sh_size;
                      end;
                    '.fpcdata',
                    '.rodata',
                    '.data':
                      begin
                        Message1(execinfo_x_initdatasize,tostr(secheader64.sh_size));
                        inc(status.datasize,secheader64.sh_size);
                      end;
                    '.bss':
                      begin
                        Message1(execinfo_x_uninitdatasize,tostr(secheader64.sh_size));
                        inc(status.datasize,secheader64.sh_size);
                      end;
                  end;
                end;
            end;
          else
            exit;
        end;
        close(f);
        {$pop}
        if ioresult<>0 then
          ;
        Result:=true;
      end;


    function TExternalLinker.PostProcessMachExecutable(const fn : string;isdll:boolean):boolean;
      type
        TMachHeader=record
          magic       : longword;
          cputype     : integer;
          cpusubtype  : integer;
          filetype    : longword;
          ncmds       : longword;
          sizeofcmds  : longword;
          flags       : longword;
          reserved    : longword;
        end;

        TMachLoadCommand = record
          cmd : longword;
          cmdsize : longword;
        end;

        TMachSegmentCommand64 = record
          segname  : array[0..15] of char;
          vmaddr   : qword;
          vmsize   : qword;
          fileoff  : qword;
          filesize : qword;
          maxprot  : integer;
          initprot : integer;
          nsects   : dword;
          flags    : dword;
        end;

      var
        f : file;
        machheader : TMachHeader;
        machloadcmd : TMachLoadCommand;
        machsegmentcommand64 :TMachSegmentCommand64;
        i : longint;
      begin
        Result:=false;
        { open file }
        assign(f,fn);
        {$push}{$I-}
        reset(f,1);
        if ioresult<>0 then
          Message1(execinfo_f_cant_open_executable,fn);

{$ifdef DEBUG_MACHO_INFO}
        writeln('Start reading Mach-O file');
{$endif DEBUG_MACHO_INFO}
        blockread(f,machheader,sizeof(TMachHeader));
        if machheader.magic<>$feedfacf then
          Exit;

{$ifdef DEBUG_MACHO_INFO}
        writeln('Magic header recognized (64 Bit, Little Endian)');
        writeln('Reading ',machheader.ncmds,' commands');
{$endif DEBUG_MACHO_INFO}

        for i:=1 to machheader.ncmds do
          begin
            blockread(f,machloadcmd,sizeof(machloadcmd));
            case machloadcmd.cmd of
              $19:
                begin
                  blockread(f,machsegmentcommand64,sizeof(machsegmentcommand64));
{$ifdef DEBUG_MACHO_INFO}
                  writeln('Found SegmentCommand64: Name = ',StrPas(@machsegmentcommand64.segname),
                    '; VMSize = $',hexstr(machsegmentcommand64.vmsize,8),
                    '; FileSize = $',hexstr(machsegmentcommand64.filesize,8));
{$endif DEBUG_MACHO_INFO}
                  case StrPas(@machsegmentcommand64.segname) of
                    '__TEXT':
                      begin
                        Message1(execinfo_x_codesize,tostr(machsegmentcommand64.vmsize));
                        status.codesize:=machsegmentcommand64.vmsize;
                      end;
                    '__DATA_CONST':
                      begin
                        Message1(execinfo_x_initdatasize,tostr(machsegmentcommand64.vmsize));
                        inc(status.datasize,machsegmentcommand64.vmsize);
                      end;
                    '__DATA':
                      begin
                        Message1(execinfo_x_uninitdatasize,tostr(machsegmentcommand64.vmsize));
                        inc(status.datasize,machsegmentcommand64.vmsize);
                      end;
                  end;
                  Seek(f,FilePos(f)+machloadcmd.cmdsize-sizeof(machloadcmd)-sizeof(machsegmentcommand64));
                end;
              else
                begin
{$ifdef DEBUG_MACHO_INFO}
                  writeln('Found Load Command: $',hexstr(machloadcmd.cmd,4),', skipping');
{$endif DEBUG_MACHO_INFO}
                  Seek(f,FilePos(f)+machloadcmd.cmdsize-sizeof(machloadcmd));
                end;
            end;
          end;
        close(f);
        {$pop}
        if ioresult<>0 then
          ;
        Result:=true;
      end;


{*****************************************************************************
                              TINTERNALLINKER
*****************************************************************************}

    Constructor TInternalLinker.Create;
      begin
        inherited Create;
        linkscript:=TCmdStrList.Create;
        FStaticLibraryList:=TFPObjectList.Create(true);
        FImportLibraryList:=TFPHashObjectList.Create(true);
        FGroupStack:=TFPObjectList.Create(false);
        exemap:=nil;
        exeoutput:=nil;
        UseStabs:=false;
        CObjInput:=TObjInput;
        ScriptCount:=0;
        IsHandled:=nil;
      end;


    Destructor TInternalLinker.Destroy;
      begin
        FGroupStack.Free;
        linkscript.free;
        StaticLibraryList.Free;
        ImportLibraryList.Free;
        if assigned(IsHandled) then
          begin
            FreeMem(IsHandled,sizeof(boolean)*ScriptCount);
            IsHandled:=nil;
            ScriptCount:=0;
          end;
        if assigned(exeoutput) then
          begin
            exeoutput.free;
            exeoutput:=nil;
          end;
        if assigned(exemap) then
          begin
            exemap.free;
            exemap:=nil;
          end;
        inherited destroy;
      end;


    procedure TInternalLinker.AddImportSymbol(const libname,symname,symmangledname:TCmdStr;OrdNr: longint;isvar:boolean);
      var
        ImportLibrary : TImportLibrary;
        ImportSymbol  : TFPHashObject;
      begin
        ImportLibrary:=TImportLibrary(ImportLibraryList.Find(libname));
        if not assigned(ImportLibrary) then
          ImportLibrary:=TImportLibrary.Create(ImportLibraryList,libname);
        ImportSymbol:=TFPHashObject(ImportLibrary.ImportSymbolList.Find(symname));
        if not assigned(ImportSymbol) then
          ImportSymbol:=TImportSymbol.Create(ImportLibrary.ImportSymbolList,symname,symmangledname,OrdNr,isvar);
      end;


    procedure TInternalLinker.ScriptAddSourceStatements(AddSharedAsStatic:boolean);
      var
        s,s2: TCmdStr;
      begin
        while not ObjectFiles.Empty do
          begin
            s:=ObjectFiles.GetFirst;
            if s<>'' then
              LinkScript.Concat('READOBJECT '+MaybeQuoted(s));
          end;
        while not StaticLibFiles.Empty do
          begin
            s:=StaticLibFiles.GetFirst;
            if s<>'' then
              LinkScript.Concat('READSTATICLIBRARY '+MaybeQuoted(s));
          end;
        if not AddSharedAsStatic then
          exit;
        while not SharedLibFiles.Empty do
          begin
            S:=SharedLibFiles.GetFirst;
            if FindLibraryFile(s,target_info.staticClibprefix,target_info.staticClibext,s2) then
              LinkScript.Concat('READSTATICLIBRARY '+MaybeQuoted(s2))
            else
              Comment(V_Error,'Import library not found for '+S);
          end;
      end;


    function TInternalLinker.GetCodeSize(aExeOutput: TExeOutput): QWord;
      begin
        Result:=aExeOutput.findexesection('.text').size;
      end;


    function TInternalLinker.GetDataSize(aExeOutput: TExeOutput): QWord;
      begin
        Result:=aExeOutput.findexesection('.data').size;
      end;


    function TInternalLinker.GetBssSize(aExeOutput: TExeOutput): QWord;
      var
        bsssec: TExeSection;
      begin
        bsssec:=aExeOutput.findexesection('.bss');
        if assigned(bsssec) then
          Result:=bsssec.size
        else
          Result:=0;
      end;


    procedure TInternalLinker.ParseLdScript(src:TScriptLexer);
      var
        asneeded: boolean;
        group: TStaticLibrary;

      procedure ParseInputList;
        var
          saved_asneeded: boolean;
        begin
          src.Expect('(');
          repeat
            if src.CheckForIdent('AS_NEEDED') then
              begin
                saved_asneeded:=asneeded;
                asneeded:=true;
                ParseInputList;
                asneeded:=saved_asneeded;
              end
            else if src.token in [tkIDENT,tkLITERAL] then
              begin
                Load_ReadStaticLibrary(src.tokenstr,asneeded);
                src.nextToken;
              end
            else if src.CheckFor('-') then
              begin
                { TODO: no whitespace between '-' and name;
                  name must begin with 'l' }
                src.nextToken;
              end
            else      { syntax error, no input_list_element term }
              Break;
            if src.CheckFor(',') then
              Continue;
          until src.CheckFor(')');
        end;

      begin
        asneeded:=false;
        src.nextToken;
        repeat
          if src.CheckForIdent('OUTPUT_FORMAT') then
            begin
              src.Expect('(');
              //writeln('output_format(',src.tokenstr,')');
              src.nextToken;
              src.Expect(')');
            end
          else if src.CheckForIdent('GROUP') then
            begin
              group:=TStaticLibrary.create_group;
              TFPObjectList(FGroupStack.Last).Add(group);
              FGroupStack.Add(group.GroupMembers);
              ParseInputList;
              FGroupStack.Delete(FGroupStack.Count-1);
            end
          else if src.CheckFor(';') then
            {skip semicolon};
        until src.token in [tkEOF,tkINVALID];
      end;

    procedure TInternalLinker.Load_ReadObject(const para:TCmdStr);
      var
        objdata   : TObjData;
        objinput  : TObjinput;
        objreader : TObjectReader;
        fn        : TCmdStr;
      begin
        fn:=FindObjectFile(para,'',false);
        Comment(V_Tried,'Reading object '+fn);
        objinput:=CObjInput.Create;
        objreader:=TObjectreader.create;
        if objreader.openfile(fn) then
          begin
            if objinput.ReadObjData(objreader,objdata) then
              exeoutput.addobjdata(objdata);
          end;
        { release input object }
        objinput.free;
        objreader.free;
      end;


    procedure TInternalLinker.Load_ReadStaticLibrary(const para:TCmdStr;asneededflag:boolean);
      var
        objreader : TObjectReader;
        objinput: TObjInput;
        objdata: TObjData;
        ScriptLexer: TScriptLexer;
        stmt:TStaticLibrary;
      begin
{ TODO: Cleanup ignoring of   FPC generated libimp*.a files}
        { Don't load import libraries }
        if copy(ExtractFileName(para),1,6)='libimp' then
          exit;
        Comment(V_Tried,'Opening library '+para);
        objreader:=CArObjectreader.createAr(para,true);
        if ErrorCount>0 then
          exit;
        if objreader.isarchive then
          TFPObjectList(FGroupStack.Last).Add(TStaticLibrary.Create(para,objreader,CObjInput))
        else
          if CObjInput.CanReadObjData(objreader) then
            begin
              { may be a regular object as well as a dynamic one }
              objinput:=CObjInput.Create;
              if objinput.ReadObjData(objreader,objdata) then
                begin
                  stmt:=TStaticLibrary.create_object(objdata);
                  stmt.AsNeeded:=asneededflag;
                  TFPObjectList(FGroupStack.Last).Add(stmt);
                end;
              objinput.Free;
              objreader.Free;
            end
          else       { try parsing as script }
            begin
              Comment(V_Tried,'Interpreting '+para+' as ld script');
              ScriptLexer:=TScriptLexer.Create(objreader);
              ParseLdScript(ScriptLexer);
              ScriptLexer.Free;
              objreader.Free;
            end;
      end;


    procedure TInternalLinker.Load_Group;
      var
        group: TStaticLibrary;
      begin
        group:=TStaticLibrary.create_group;
        TFPObjectList(FGroupStack.Last).Add(group);
        FGroupStack.Add(group.GroupMembers);
      end;


    procedure TInternalLinker.Load_EndGroup;
      begin
        FGroupStack.Delete(FGroupStack.Count-1);
      end;


    procedure TInternalLinker.ParseScript_Handle;
      var
        s{, para}, keyword : String;
        hp : TCmdStrListItem;
        i : longint;
      begin
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            s:=hp.str;
            if (s='') or (s[1]='#') then
              begin
                hp:=TCmdStrListItem(hp.next);
                continue;
              end;
            keyword:=Upper(GetToken(s,' '));
            {para:=}GetToken(s,' ');
            if Trim(s)<>'' then
              Comment(V_Warning,'Unknown part "'+s+'" in "'+hp.str+'" internal linker script');
            if (keyword<>'SYMBOL') and
               (keyword<>'SYMBOLS') and
               (keyword<>'STABS') and
               (keyword<>'PROVIDE') and
               (keyword<>'ZEROS') and
               (keyword<>'BYTE') and
               (keyword<>'WORD') and
               (keyword<>'LONG') and
               (keyword<>'QUAD') and
               (keyword<>'ENTRYNAME') and
               (keyword<>'ISSHAREDLIBRARY') and
               (keyword<>'IMAGEBASE') and
               (keyword<>'READOBJECT') and
               (keyword<>'READSTATICLIBRARY') and
               (keyword<>'EXESECTION') and
               (keyword<>'ENDEXESECTION') and
               (keyword<>'OBJSECTION') and
               (keyword<>'HEADER') and
               (keyword<>'GROUP') and
               (keyword<>'ENDGROUP')
               then
              Comment(V_Warning,'Unknown keyword "'+keyword+'" in "'+hp.str
                +'" internal linker script');
            hp:=TCmdStrListItem(hp.next);
          end;
        ScriptCount:=i;
        if ScriptCount>0 then
          begin
            GetMem(IsHandled,sizeof(boolean)*ScriptCount);
            Fillchar(IsHandled^,sizeof(boolean)*ScriptCount,#0);
          end;
      end;

    procedure TInternalLinker.ParseScript_PostCheck;
      var
        hp : TCmdStrListItem;
        i : longint;
      begin
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            if not IsHandled^[i] then
              begin
                Comment(V_Warning,'"'+hp.str+
                  '" internal linker script not handled');
              end;
            hp:=TCmdStrListItem(hp.next);
          end;
      end;

    function  TInternalLinker.ParsePara(const para : string) : string;
      var
        res : string;
      begin
        res:=trim(para);
        { Remove enclosing braces }
        if (length(res)>0) and (res[1]='(') and
           (res[length(res)]=')') then
          res:=trim(copy(res,2,length(res)-2));
        result:=res;
      end;

    procedure TInternalLinker.ParseScript_Load;
      var
        s,
        para,
        keyword : String;
        hp : TCmdStrListItem;
        i : longint;
        handled : boolean;
      begin
        exeoutput.Load_Start;
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            s:=hp.str;
            if (s='') or (s[1]='#') then
              begin
                IsHandled^[i]:=true;
                hp:=TCmdStrListItem(hp.next);
                continue;
              end;
            handled:=true;
            keyword:=Upper(GetToken(s,' '));
            para:=ParsePara(GetToken(s,' '));
            if keyword='SYMBOL' then
              ExeOutput.Load_Symbol(para)
            else if keyword='PROVIDE' then
              ExeOutput.Load_ProvideSymbol(para)
            else if keyword='ENTRYNAME' then
              ExeOutput.Load_EntryName(para)
            else if keyword='ISSHAREDLIBRARY' then
              ExeOutput.Load_IsSharedLibrary
            else if keyword='IMAGEBASE' then
              ExeOutput.Load_ImageBase(para)
            else if keyword='READOBJECT' then
              Load_ReadObject(para)
            else if keyword='STABS' then
              UseStabs:=true
            else if keyword='READSTATICLIBRARY' then
              Load_ReadStaticLibrary(para)
            else if keyword='GROUP' then
              Load_Group
            else if keyword='ENDGROUP' then
              Load_EndGroup
            else
              handled:=false;
            if handled then
              IsHandled^[i]:=true;
            hp:=TCmdStrListItem(hp.next);
          end;
      end;


    procedure TInternalLinker.ParseScript_Order;
      var
        s,
        para,
        keyword : String;
        hp : TCmdStrListItem;
        i : longint;
        handled : boolean;
      begin
        exeoutput.Order_Start;
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            s:=hp.str;
            if (s='') or (s[1]='#') then
              begin
                hp:=TCmdStrListItem(hp.next);
                continue;
              end;
            handled:=true;
            keyword:=Upper(GetToken(s,' '));
            para:=ParsePara(GetToken(s,' '));

            if keyword='EXESECTION' then
              ExeOutput.Order_ExeSection(para)
            else if keyword='ENDEXESECTION' then
              ExeOutput.Order_EndExeSection
            else if keyword='OBJSECTION' then
              ExeOutput.Order_ObjSection(para)
            else if keyword='ZEROS' then
              ExeOutput.Order_Zeros(para)
            else if keyword='BYTE' then
              ExeOutput.Order_Values(1,para)
            else if keyword='WORD' then
              ExeOutput.Order_Values(2,para)
            else if keyword='LONG' then
              ExeOutput.Order_Values(4,para)
            else if keyword='QUAD' then
              ExeOutput.Order_Values(8,para)
            else if keyword='SYMBOL' then
              ExeOutput.Order_Symbol(para)
            else if keyword='PROVIDE' then
              ExeOutput.Order_ProvideSymbol(para)
            else
              handled:=false;
            if handled then
              IsHandled^[i]:=true;
            hp:=TCmdStrListItem(hp.next);
          end;
        exeoutput.Order_End;
      end;


    procedure TInternalLinker.ParseScript_MemPos;
      var
        s,
        para,
        keyword : String;
        hp : TCmdStrListItem;
        i : longint;
        handled : boolean;
      begin
        exeoutput.MemPos_Start;
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            s:=hp.str;
            if (s='') or (s[1]='#') then
              begin
                hp:=TCmdStrListItem(hp.next);
                continue;
              end;
            handled:=true;
            keyword:=Upper(GetToken(s,' '));
            para:=ParsePara(GetToken(s,' '));
            if keyword='EXESECTION' then
              ExeOutput.MemPos_ExeSection(para)
            else if keyword='ENDEXESECTION' then
              ExeOutput.MemPos_EndExeSection
            else if keyword='HEADER' then
              ExeOutput.MemPos_Header
            else
              handled:=false;
            if handled then
              IsHandled^[i]:=true;
            hp:=TCmdStrListItem(hp.next);
          end;
      end;


    procedure TInternalLinker.ParseScript_DataPos;
      var
        s,
        para,
        keyword : String;
        hp : TCmdStrListItem;
        i : longint;
        handled : boolean;
      begin
        exeoutput.DataPos_Start;
        hp:=TCmdStrListItem(linkscript.first);
        i:=0;
        while assigned(hp) do
          begin
            inc(i);
            s:=hp.str;
            if (s='') or (s[1]='#') then
              begin
                hp:=TCmdStrListItem(hp.next);
                continue;
              end;
            handled:=true;
            keyword:=Upper(GetToken(s,' '));
            para:=ParsePara(GetToken(s,' '));
            if keyword='EXESECTION' then
              ExeOutput.DataPos_ExeSection(para)
            else if keyword='ENDEXESECTION' then
              ExeOutput.DataPos_EndExeSection
            else if keyword='HEADER' then
              ExeOutput.DataPos_Header
            else if keyword='SYMBOLS' then
              ExeOutput.DataPos_Symbols
            else
              handled:=false;
            if handled then
              IsHandled^[i]:=true;
            hp:=TCmdStrListItem(hp.next);
          end;
      end;


    procedure TInternalLinker.PrintLinkerScript;
      var
        hp : TCmdStrListItem;
      begin
        if not assigned(exemap) then
          exit;
        exemap.Add('Used linker script');
        exemap.Add('');
        hp:=TCmdStrListItem(linkscript.first);
        while assigned(hp) do
          begin
            exemap.Add(hp.str);
            hp:=TCmdStrListItem(hp.next);
          end;
      end;


    function TInternalLinker.RunLinkScript(const outputname:TCmdStr):boolean;
      label
        myexit;
      var
        bsssize : qword;
        dbgname : TCmdStr;
      begin
        result:=false;

        Message1(exec_i_linking,outputname);
        FlushOutput;

        exeoutput:=CExeOutput.Create;

{ TODO: Load custom linker script}
        DefaultLinkScript;

        if (cs_link_map in current_settings.globalswitches) then
          exemap:=texemap.create(current_module.mapfilename);

        PrintLinkerScript;

        { Check that syntax is OK }
        ParseScript_Handle;
        { Load .o files and resolve symbols }
        FGroupStack.Add(FStaticLibraryList);
        ParseScript_Load;
        if ErrorCount>0 then
          goto myexit;
        exeoutput.ResolveSymbols(StaticLibraryList);
        { Generate symbols and code to do the importing }
        exeoutput.GenerateLibraryImports(ImportLibraryList);
        { Fill external symbols data }
        exeoutput.FixupSymbols;
        if ErrorCount>0 then
          goto myexit;

        { parse linker options specific for output format }
        exeoutput.ParseScript (linkscript);

        { Create .exe sections and add .o sections }
        ParseScript_Order;
        exeoutput.RemoveUnreferencedSections;
        { if UseStabs then, this would remove
          STABS for empty linker scripts }
          exeoutput.MergeStabs;
        exeoutput.MarkEmptySections;
        exeoutput.AfterUnusedSectionRemoval;
        if ErrorCount>0 then
          goto myexit;

        { Calc positions in mem }
        ParseScript_MemPos;
        exeoutput.FixupRelocations;
        exeoutput.RemoveUnusedExeSymbols;
        exeoutput.PrintMemoryMap;
        if ErrorCount>0 then
          goto myexit;

        if cs_link_separate_dbg_file in current_settings.globalswitches then
          begin
            { create debuginfo, which is an executable without data on disk }
            dbgname:=ChangeFileExt(outputname,'.dbg');
            exeoutput.ExeWriteMode:=ewm_dbgonly;
            ParseScript_DataPos;
            exeoutput.WriteExeFile(dbgname);
            { create executable with link to just created debuginfo file }
            exeoutput.ExeWriteMode:=ewm_exeonly;
            exeoutput.RemoveDebugInfo;
            exeoutput.GenerateDebugLink(ExtractFileName(dbgname),GetFileCRC(dbgname));
            ParseScript_MemPos;
            ParseScript_DataPos;
            exeoutput.WriteExeFile(outputname);
          end
        else
          begin
            exeoutput.ExeWriteMode:=ewm_exefull;
            ParseScript_DataPos;
            exeoutput.WriteExeFile(outputname);
          end;

        { Post check that everything was handled }
        ParseScript_PostCheck;

        status.codesize:=GetCodeSize(exeoutput);
        status.datasize:=GetDataSize(exeoutput);
        bsssize:=GetBssSize(exeoutput);

        { Executable info }
        Message1(execinfo_x_codesize,tostr(status.codesize));
        Message1(execinfo_x_initdatasize,tostr(status.datasize));
        Message1(execinfo_x_uninitdatasize,tostr(bsssize));
        Message1(execinfo_x_stackreserve,tostr(stacksize));

      myexit:
        { close map }
        if assigned(exemap) then
          begin
            exemap.free;
            exemap:=nil;
          end;

        { close exe }
        exeoutput.free;
        exeoutput:=nil;

        result:=true;
      end;


    function TInternalLinker.ExecutableFilename:String;
      begin
        result:=current_module.exefilename;
      end;


    function TInternalLinker.SharedLibFilename:String;
      begin
        result:=current_module.sharedlibfilename;
      end;


    function TInternalLinker.MakeExecutable:boolean;
      begin
        IsSharedLibrary:=false;
        result:=RunLinkScript(ExecutableFilename);
{$ifdef hasUnix}
        fpchmod(current_module.exefilename,493);
{$endif hasUnix}
      end;


    function TInternalLinker.MakeSharedLibrary:boolean;
      begin
        IsSharedLibrary:=true;
        result:=RunLinkScript(SharedLibFilename);
      end;


    procedure TInternalLinker.ScriptAddGenericSections(secnames:string);
      var
        secname:string;
      begin
        repeat
          secname:=gettoken(secnames,',');
          if secname='' then
            break;
          linkscript.Concat('EXESECTION '+secname);
          linkscript.Concat('  OBJSECTION '+secname+'*');
          linkscript.Concat('ENDEXESECTION');
        until false;
      end;

{*****************************************************************************
                                 Init/Done
*****************************************************************************}

    procedure RegisterLinker(id:tlink;c:TLinkerClass);
      begin
        CLinker[id]:=c;
      end;


    procedure InitLinker;
      begin
        if (cs_link_extern in current_settings.globalswitches) and
           assigned(CLinker[target_info.linkextern]) then
          begin
            linker:=CLinker[target_info.linkextern].Create;
          end
        else
          if assigned(CLinker[target_info.link]) then
            begin
              linker:=CLinker[target_info.link].Create;
            end
        else
          linker:=Tlinker.Create;
      end;


    procedure DoneLinker;
      begin
        if assigned(linker) then
         Linker.Free;
      end;


{*****************************************************************************
                                   Initialize
*****************************************************************************}

    const
      ar_gnu_ar_info : tarinfo =
          (
            id          : ar_gnu_ar;
            addfilecmd  : '';
            arfirstcmd  : '';
            arcmd       : 'ar qS $LIB $FILES';
            arfinishcmd : 'ar s $LIB'
          );

      ar_gnu_ar_scripted_info : tarinfo =
          (
            id    : ar_gnu_ar_scripted;
            addfilecmd  : '';
            arfirstcmd  : '';
            arcmd : 'ar -M < $SCRIPT';
            arfinishcmd : ''
          );

      ar_gnu_gar_info : tarinfo =
          ( id          : ar_gnu_gar;
            addfilecmd  : '';
            arfirstcmd  : '';
            arcmd       : 'gar qS $LIB $FILES';
            arfinishcmd : 'gar s $LIB'
          );

      ar_watcom_wlib_omf_info : tarinfo =
          ( id          : ar_watcom_wlib_omf;
            addfilecmd  : '+';
            arfirstcmd  : 'wlib -q $RECSIZE -fo -c -b -n -o=$OUTPUTLIB $LIB $FILES';
            arcmd       : 'wlib -q $RECSIZE -fo -c -b -o=$OUTPUTLIB $LIB $FILES';
            arfinishcmd : ''
          );

      ar_watcom_wlib_omf_scripted_info : tarinfo =
          (
            id    : ar_watcom_wlib_omf_scripted;
            addfilecmd  : '+';
            arfirstcmd  : '';
            arcmd : 'wlib @$SCRIPT';
            arfinishcmd : ''
          );

      ar_sdcc_sdar_info : tarinfo =
          ( id          : ar_sdcc_sdar;
          addfilecmd  : '';
          arfirstcmd  : '';
          arcmd       : 'sdar qS $LIB $FILES';
          arfinishcmd : 'sdar s $LIB'
          );

      ar_sdcc_sdar_scripted_info : tarinfo =
          (
            id    : ar_sdcc_sdar_scripted;
            addfilecmd  : '';
            arfirstcmd  : '';
            arcmd : 'sdar -M < $SCRIPT';
            arfinishcmd : ''
          );


initialization
  RegisterAr(ar_gnu_ar_info);
  RegisterAr(ar_gnu_ar_scripted_info);
  RegisterAr(ar_gnu_gar_info);
  RegisterAr(ar_watcom_wlib_omf_info);
  RegisterAr(ar_watcom_wlib_omf_scripted_info);
  RegisterAr(ar_sdcc_sdar_info);
  RegisterAr(ar_sdcc_sdar_scripted_info);
end.
