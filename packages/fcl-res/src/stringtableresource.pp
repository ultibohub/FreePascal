{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2008 by Giulio Bernardi

    String table resource type

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$IFNDEF FPC_DOTTEDUNITS}
unit stringtableresource;
{$ENDIF FPC_DOTTEDUNITS}

{$MODE OBJFPC}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, System.SysUtils, System.Resources.Resource;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, SysUtils, resource;
{$ENDIF FPC_DOTTEDUNITS}

type
  EStringTableResourceException = class(EResourceException);
  EStringTableNameNotAllowedException = class(EStringTableResourceException);
  EStringTableIndexOutOfBoundsException = class(EStringTableResourceException);


resourcestring
  SNameNotAllowed = 'Resource ID must be an ordinal in the range 1-4096';
  SIndexOutOfBounds = 'String ID out of bounds: %d';

type

  { TStringTableResource }

  TStringTableResource = class(TAbstractResource)
  private
    fType : TResourceDesc;
    fName : TResourceDesc;
    fFirstID : word;
    fCount : integer;
    fList : array of UnicodeString;
    fCanChangeDesc : boolean;
    function IDtoIndex(const aId : word) : integer;
    procedure CheckListLoaded;
    function ReadWideString : string;
    procedure WriteWideString(const aString : string);
    function GetLastID : word;
    procedure SetFirstID(aId : word);
    function GetString(id : word) : string;
    procedure SetString(id : word; aString : string);
    procedure CheckIndex(const aIndex : word);
  protected
    function GetType : TResourceDesc; override;
    function GetName : TResourceDesc; override;
    function ChangeDescTypeAllowed(aDesc : TResourceDesc) : boolean; override;
    function ChangeDescValueAllowed(aDesc : TResourceDesc) : boolean; override;
    procedure NotifyResourcesLoaded; override;
  public
    constructor Create; override;
    constructor Create(aType,aName : TResourceDesc); override;
    destructor Destroy; override;
    procedure UpdateRawData; override;
    property FirstID : word read fFirstID write SetFirstID;
    property LastID : word read GetLastID;
    property Count : integer read fCount;
    property Strings[id : word] : string read GetString write SetString; default;
  end;

implementation

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Resources.Factory;
{$ELSE FPC_DOTTEDUNITS}
uses
  resfactory;
{$ENDIF FPC_DOTTEDUNITS}

{ TStringTableResource }

function TStringTableResource.IDtoIndex(const aId: word): integer;
begin
  Result:=aID-fFirstID;
end;

procedure TStringTableResource.CheckListLoaded;
var i : integer;
begin
  if Length(fList) <> 0 then exit;
  SetLength(fList, fCount);
  for i:=0 to high(fList) do
    fList[i]:= '';
  if RawData.Size=0 then exit;
  RawData.Position:=0;
  for i:=0 to high(fList) do
    fList[i]:= ReadWideString;
end;

function TStringTableResource.ReadWideString: string;
var ws : unicodestring;
    w : word;
    i : integer;
begin
  RawData.ReadBuffer(w,2);
  w:= LEtoN(w);
  setlength(ws,w);

  for i:=1 to length(ws) do
  begin
    RawData.ReadBuffer(w,2);
    w:= LEtoN(w);
    ws[i]:=widechar(w);
  end;
  Result:=ws;
end;

procedure TStringTableResource.WriteWideString(const aString: string);
var ws : unicodestring;
    w : word;
    i : integer;
begin
  w:=length(aString);
  w:= NtoLE(w);
  RawData.WriteBuffer(w,2);
  ws:=aString;
  for i:=1 to length(ws) do
  begin
    w:=word(ws[i]);
    w:= NtoLE(w);
    RawData.WriteBuffer(w,2);
  end;
end;

function TStringTableResource.GetLastID: word;
begin
  Result:=fFirstID+15;
end;

procedure TStringTableResource.SetFirstID(aId: word);
begin
  aId:=aID and $FFF0;
  fFirstID:=aID;
  fCanChangeDesc:=true;
  fName.ID:=(aID div 16)+1;
  fCanChangeDesc:=false;
end;

function TStringTableResource.GetString(id: word): string;
var idx : integer;
begin
  CheckIndex(id);
  CheckListLoaded;
  idx:=IDtoIndex(id);
  if idx>high(fList) then Result:= ''
  else Result:= fList[idx];
end;

procedure TStringTableResource.SetString(id: word; aString: string);
var idx,i : integer;
begin
  CheckIndex(id);
  CheckListLoaded;
  idx:=IDtoIndex(id);
  fList[idx]:= aString;
end;

procedure TStringTableResource.UpdateRawData;
var i : integer;
begin
  if fList=nil then exit;
  RawData.Size:=0;
  RawData.Position:=0;
  for i:=FirstID to LastID do
    WriteWideString(Strings[i]);
  fList:= nil;
end;

function TStringTableResource.GetType: TResourceDesc;
begin
  Result:=fType;
end;

function TStringTableResource.GetName: TResourceDesc;
begin
  Result:=fName;
end;

function TStringTableResource.ChangeDescTypeAllowed(aDesc: TResourceDesc
  ): boolean;
begin
  Result:=fCanChangeDesc;
end;

function TStringTableResource.ChangeDescValueAllowed(aDesc: TResourceDesc
  ): boolean;
begin
  Result:=fCanChangeDesc;
end;

procedure TStringTableResource.NotifyResourcesLoaded;
begin
end;

procedure TStringTableResource.CheckIndex(const aIndex: word);
begin
  if (aIndex<FirstID) or (aIndex>LastID) then
    raise EStringTableIndexOutOfBoundsException.CreateFmt(SIndexOutOfBounds,[aIndex])
end;

constructor TStringTableResource.Create;
begin
  inherited Create;
  fCanChangeDesc:=false;
  fList:= nil;
  fType:=TResourceDesc.Create(RT_STRING);
  fName:=TResourceDesc.Create(1);
  fCount:=16;
  fFirstID:=0;
  SetDescOwner(fType);
  SetDescOwner(fName);
end;

constructor TStringTableResource.Create(aType, aName: TResourceDesc);
begin
  Create;
  if (aName.DescType<>dtId) or ((aName.ID <1) or  (aName.ID >4096)) then
    raise EStringTableNameNotAllowedException.Create(SNameNotAllowed);
  fCanChangeDesc:=true;
  fName.Assign(aName);
  fCanChangeDesc:=false;
  fCount:=16;
  fFirstID:=(fName.ID-1) * 16;
end;

destructor TStringTableResource.Destroy;
begin
  fType.Free;
  fName.Free;
  SetLength(fList, 0);
  inherited Destroy;
end;

initialization
  TResourceFactory.RegisterResourceClass(RT_STRING,TStringTableResource);

end.
