{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2008 by Giulio Bernardi

    Resource reader/compiler for MS RC script files

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$IFNDEF FPC_DOTTEDUNITS}
unit rcreader;
{$ENDIF FPC_DOTTEDUNITS}

{$MODE OBJFPC} {$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, System.SysUtils, System.Resources.Resource;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, SysUtils, resource;
{$ENDIF FPC_DOTTEDUNITS}

type

  { TRCResourceReader }

  TRCResourceReader = class(TAbstractResourceReader)
  private
    fExtensions : string;
    fDescription : string;
    fRCIncludeDirs: TStringList;
    fRCDefines: TStringList;
  protected
    function GetExtensions : string; override;
    function GetDescription : string; override;
    procedure Load(aResources : TResources; aStream : TStream); override;
    function CheckMagic(aStream : TStream) : boolean; override;
    procedure ReadRCFile(aResources : TResources; aLocation: String; aStream : TStream);
  public
    constructor Create; override;
    destructor Destroy; override;
    property RCIncludeDirs: TStringList read fRCIncludeDirs;
    property RCDefines: TStringList read fRCDefines;
  end;

implementation

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Streamio, System.Resources.DataStream, System.Resources.Factory, Pascal.Lexlib, System.Resources.Rc.Parser;
{$ELSE FPC_DOTTEDUNITS}
uses
  StreamIO, resdatastream, resfactory, lexlib, rcparser;
{$ENDIF FPC_DOTTEDUNITS}

{ TRCResourceReader }

function TRCResourceReader.GetExtensions: string;
begin
  Result:=fExtensions;
end;

function TRCResourceReader.GetDescription: string;
begin
  Result:=fDescription;
end;

procedure TRCResourceReader.Load(aResources: TResources; aStream: TStream);
var
  fd: String;
begin
  if aStream is TFileStream then
    fd:= ExtractFilePath(TFileStream(aStream).FileName)
  else
    fd:= IncludeTrailingPathDelimiter(GetCurrentDir);
  try
    ReadRCFile(aResources, fd, aStream);
  except
    on e : EReadError do
      raise EResourceReaderUnexpectedEndOfStreamException.Create('');
  end;
end;

function TRCResourceReader.CheckMagic(aStream: TStream): boolean;
begin
  { TODO : Check for Text-Only file }
  Result:= True;
end;

procedure TRCResourceReader.ReadRCFile(aResources: TResources; aLocation: String; aStream: TStream);
var
  i: Integer;
begin
  AssignStream({$IFDEF FPC_DOTTEDUNITS}Pascal.{$ENDIF}Lexlib.yyinput, aStream);
  Reset({$IFDEF FPC_DOTTEDUNITS}Pascal.{$ENDIF}Lexlib.yyinput);
  try
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yyfilename:= '#MAIN.RC';
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}SetDefaults;
    SetTextCodePage({$IFDEF FPC_DOTTEDUNITS}Pascal.{$ENDIF}Lexlib.yyinput, {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}opt_code_page);
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yinclude:= tyinclude.Create;
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yinclude.WorkDir:= aLocation;
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yinclude.SearchPaths.Assign(fRCIncludeDirs);
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}ypreproc:= typreproc.Create;
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}ypreproc.Defines.Add('RC_INVOKED', '');
    for i:= 0 to fRCDefines.Count-1 do
      {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}ypreproc.Defines.KeyData[fRCDefines.Names[i]]:= fRCDefines.ValueFromIndex[i];
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}aktresources:= aResources;
    if {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yyparse <> 0 then
      raise EReadError.Create('Parse Error');
  finally
    {$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}DisposePools;
    FreeAndNil({$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}ypreproc);
    FreeAndNil({$IFDEF FPC_DOTTEDUNITS}System.Resources.Rc.Parser.{$ELSE}rcparser.{$ENDIF}yinclude);
  end;
end;

constructor TRCResourceReader.Create;
begin
  fExtensions:='.rc';
  fDescription:='RC script resource reader';
  fRCDefines:= TStringList.Create;
  fRCIncludeDirs:= TStringList.Create;
end;

destructor TRCResourceReader.Destroy;
begin
  fRCIncludeDirs.Free;
  fRCDefines.Free;
  inherited;
end;

initialization
  { don't register automatically, as this is essentially a "catch all" }
  //TResources.RegisterReader('.rc',TRCResourceReader);

end.
