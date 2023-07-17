{
    This file is part of the Free Pascal Integrated Development Environment
    Copyright (c) 2008 by Marco van de Voort

    Wrapper for CHM reading to avoid having to import Delphi units into whtmlhlp,
      which can cause all kinds of namespace conflicts.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit wchmhwrap;

interface
{$Mode Delphi}

Uses  wutils,whelp,whtml,SysUtils,ChmReader,ChmSiteMap,Classes;

Type
//      TopicLinks: PTopicLinkCollection;IndexEntries : PUnsortedIndexEntryCollection;

     TChmWrapper = Class
                     private
                       ffs   	   : Classes.TFileStream;
                       fchmr 	   : TChmReader;
                       findex	   : TChmSiteMap;
                       ftopic	   : TChmSiteMap;
                       floaded     : boolean;
                       fileid	   : integer;
                       fshortname  : string;
                       flongname   : string;
                       fTopicLinks : PTopicLinkCollection;
                     public
                      constructor Create(name:String;aid:integer;TopicLinks:PTopicLinkCollection);
                      function	  LoadIndex(id:integer;TopicLinks: PTopicLinkCollection;IndexEntries : PUnsortedIndexEntryCollection;helpfacility:PHelpFacility):boolean;
                      function    GetTopic(name:string):PMemoryTextFile;
                      destructor  Destroy;override;
                    end;

function combinepaths(relpath,basepath:String):String;
function CHMResolve( href: ansistring; var AFileId,ALinkId : longint):boolean;

function stringreplace(const s:ansistring;const oldstr:ansistring; const newstr:ansistring):ansistring;
implementation

var CHMIndex : TStringList; // list to register open CHMs.


function combinepaths(relpath,basepath:String):String;

begin
  {$ifdef combinedebug}
    debugmessageS({$i %file%},'combine in "'+relpath+'" and "'+basepath+'"',{$i %line%},'1',0,0);
  {$endif}

  if relpath='' then exit;
  if relpath[length(relpath)]<>'/' Then
    basepath:=extractfiledir(basepath);
  while (length(relpath)>0) and (copy(relpath,1,3)='../') do
     begin
       basepath:=extractfiledir(basepath);
       delete(relpath,1,3);
     end;

  {$ifdef combinedebug}
    debugmessageS({$i %file%},'combine out "'+relpath+'" and "'+basepath+'"',{$i %line%},'1',0,0);
  {$endif}
  if (length(basepath)>0) and (length(relpath)>0) then
    begin
      if (relpath[1]<>'/') and (basepath[length(basepath)]<>'/') then
        basepath:=basepath+'/';
       {$ifdef combinedebug}
        debugmessageS({$i %file%},'combine out2 "'+relpath+'" and "'+basepath+'"',{$i %line%},'1',0,0);
       {$endif}
    end;

  result:=basepath+relpath;
end;

Constructor TChmWrapper.Create(name:string;aid:integer;TopicLinks:PTopicLinkCollection);

begin
  ffs:=Classes.TFileStream.create(name,fmOpenRead or fmsharedenynone);
  fchmr:=TChmReader.Create(ffs,True); // owns ffs
  findex:=nil;
  FTopicLinks:=TopicLinks;
  if not fchmr.isvalidfile then
    begin
      freeandnil(fchmr);
      freeandnil(ffs);
      exit;
    end;
  fileid:=aid;
  flongname:=name;
  fshortname:=lowercase(extractfilename(name)); // We assume ms-its: urls are case insensitive wrt filename.
  chmindex.addobject(fshortname,self);
  {$ifdef wdebug}
    debugmessageS({$i %file%},'TCHMWrapper.Create: before sitemap creation '+fshortname+' id='+inttostr(aid),{$i %line%},'1',0,0);
  {$endif}
  findex:=TChmSiteMap.create(stindex);
  ftopic:=TChmSiteMap.create(sttoc);
  floaded:=false;
end;

function TChmWrapper.LoadIndex(id:integer;TopicLinks: PTopicLinkCollection;IndexEntries : PUnsortedIndexEntryCollection;helpfacility:PHelpFacility):boolean;
function FormatAlias(Alias: string): string;
begin
  if Assigned(HelpFacility) then
    if length(Alias)>HelpFacility^.IndexTabSize-4 then
       Alias:=Trim(copy(Alias,1,HelpFacility^.IndexTabSize-4-2))+'..';
//  if (length(alias)>0) and (alias[1]<>'/') then Alias:='/'+alias;
  FormatAlias:=Alias;
end;

function searchlocal(item:TChmSiteMapItem):string;
var i:integer;
    sitem : TChmSiteMapSubItem;
begin
  result:='';
  for i:=0 to item.SubItemcount-1 do
     begin
       sitem:=item.subitem[i];
       if sitem.local<>'' then
          exit(sitem.local);
     end;
end;

var
    m : Classes.TMemoryStream;
    i,j : integer;
    item : TChmSiteMapItem;
    tli: integer;
    s,s2 : String;
begin
 result:=false;
 if floaded then exit;
 if not assigned (fchmr) then exit;
 {$ifdef wdebug}
     debugmessageS({$i %file%},'TCHMWrapper: indexfilename:'+fchmr.indexfile,{$i %line%},'1',0,0);
 {$endif}

  if assigned(findex) then
    freeandnil(findex);
  findex:=fchmr.GetIndexSitemap(false);
  {$ifdef wdebug}
     debugmessageS({$i %file%},'TCHMWrapper: loadindex after final ',{$i %line%},'1',0,0);
  {$endif}

  tli:=TopicLinks^.AddItem(fchmr.defaultpage);
  TLI:=EncodeHTMLCtx(ID,TLI+1);
  IndexEntries^.Insert(NewIndexEntry(  FormatAlias('Table of contents'),ID,TLI));
  if findex= Nil Then
    begin
      floaded:=true;
      exit(true);
    end;
  if assigned(findex.items) and (findex.items.count>0) Then
  for i:=0 to findex.items.count-1 do
    begin
      item:=findex.items.item[i];
      s:=formatalias(item.text);
      if s<>'' then
        begin
          s2:='';
          if item.SubItemcount>1 then
           s2:=item.SubItem[1].local;
          if s2='' then
            s2:=searchlocal(item);
          if (length(s2)>0) and (s2[1]<>'/') then
            tli:=TopicLinks^.AddItem('/'+s2)
          else
            tli:=TopicLinks^.AddItem(s2);
          TLI:=EncodeHTMLCtx(ID,TLI+1);
          IndexEntries^.Insert(NewIndexEntry(  FormatAlias(item.text),ID,TLI));
        end;
    end;
   {$ifdef wdebug}
     debugmessageS({$i %file%},'TCHMWrapper: endloadindex ',{$i %line%},'1',0,0);
  {$endif}
  floaded:=true;
  result:=true;
end;

procedure splitline(idestream:PMemoryTextFile;s:ansistring);

function scanvalue:integer; // searches for a possible breaking point left of AnsiChar 255.
var n,i  : integer;
    lastpoint:integer;
    inquote : boolean;
begin
  lastpoint:=-1;
  n:=length(s);
  if n>250 then n:=250;
  i:=1; inquote:=false;
  while (i<=n) do
    begin
      while (s[i]<>' ') and (s[i]<>'"') and (i<=n) do inc(i);
      if (s[i]=' ') and not inquote then lastpoint:=i;
      if (s[i]='"') then inquote:=not inquote;
      inc(i);
    end;
  scanvalue:=lastpoint;
end;

var position : longint;

begin
  position:=0;
  while (length(s)>250) and (position<>-1) do
    begin
      position:=scanvalue;
      if position<>-1 then
        begin
          idestream.addline(copy(s,1,position-1));
          delete(s,1,position);
        end;
    end;
  if length(s)<>0 then
    idestream.addline(s);
end;

function   TChmWrapper.GetTopic(name:string):PMemoryTextFile;

var
  m : Classes.TMemorystream;
  linedata:Classes.TStringList;
  i : integer;
begin
  result:=nil;
  if not assigned(fchmr) or (name='') then exit;

  If (name[1]<>'/') and (copy(name,1,7)<>'ms-its:') Then
    name:='/'+name;
  linedata:=Classes.TStringList.create;
  try
    {$ifdef wdebug}
     debugmessageS({$i %file%},'TCHMWrapper: Getting file '+name,{$i %line%},'1',0,0);
    {$endif}
//    if uppercase(name)='TABLE OF CONTENTS' Then
  //    m:=fchmr.getobject(fchmr.tocfile)
//    else
      m:=fchmr.getobject(name);

    if not assigned(m) then exit;
    linedata.loadfromstream(m);
    result:=new(PMemoryTextFile,Init);
    for i:=0 to linedata.count-1 do
       begin
         if length(linedata[i])>250 Then
             splitline(result,linedata[i])
         else
           result.addline(linedata[i]);
       end;
  finally
    m.free;
    linedata.free;
  end;
end;

destructor TChmWrapper.Destroy;

var i : integer;
begin
  i:=chmindex.indexof(fshortname);
  if i<>-1 then
    begin
      chmindex.delete(i);
      {$ifdef wdebug}
       debugmessageS({$i %file%},'TCHMWrapper: deregistering '+fshortname,{$i %line%},'1',0,0);
      {$endif}
    end;
  freeandnil(ftopic);
  freeandnil(findex);
  freeandnil(fchmr);
  {$ifdef wdebug}
    debugmessageS({$i %file%},'TCHMWrapper: destroying ',{$i %line%},'1',0,0);
  {$endif}

end;

function CHMResolve( href: ansistring; var AFileId,ALinkId : longint):boolean;

var filename, restlink : ansistring;
    I :integer;
    chmw: TCHMWrapper;
begin
  result:=false;
  if copy(href,1,7)='ms-its:' then
    begin
      {$ifdef wdebug}
              debugmessageS({$i %file%},'TCHMWrapper: resolving '+href,{$i %line%},'1',0,0);
      {$endif}

       delete(href,1,7);
       i:=pos('::',href);
       if i<>0 then
         begin
           filename:=lowercase(copy(href,1,i-1));
           restlink:=lowercase(copy(href,i+2,length(href)-(I+2)+1));
           i:=chmindex.indexof(filename);
           if i<>-1 then
             begin
               {$ifdef wdebug}
                 debugmessageS({$i %file%},'TCHMWrapper: resolving '+filename+' '+inttostr(i),{$i %line%},'1',0,0);
                 debugmessageS({$i %file%},'TCHMWrapper: resolving '+restlink+' ',{$i %line%},'1',0,0);
               {$endif}
               chmw:=TCHMWrapper(chmindex.objects[i]);
               Afileid:=chmw.fileid;
               alinkid:=chmw.fTopicLinks.additem(restlink);
               result:=true;
            end;
         end;
    end
end;

function stringreplace(const s:ansistring;const oldstr:ansistring; const newstr:ansistring):ansistring;

begin
  result:=sysutils.stringreplace(s,oldstr,newstr,[rfreplaceall]);
end;
initialization
  ChmIndex:=TStringlist.create;
  ChmIndex.sorted:=true;
finalization
  ChmIndex.Free;
end.
