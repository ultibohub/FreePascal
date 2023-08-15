{
    This file is part of the Free Component Library (FCL)
    Copyright (c) 2012 by the Free Pascal development team

    Plain text reader
    
    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$IFNDEF FPC_DOTTEDUNITS}
unit IReaderTXT;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, FpIndexer.Indexer;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, fpIndexer;
{$ENDIF FPC_DOTTEDUNITS}

type

  { TIReaderTXT }

  TIReaderTXT = class(TCustomFileReader)
  private
  protected
    function AllowedToken(token: UTF8String): boolean; override;
  public
    procedure LoadFromStream(FileStream: TStream); override;
  end;

implementation

{ TIReaderTXT }

function TIReaderTXT.AllowedToken(token: UTF8String): boolean;
begin
  Result := inherited AllowedToken(token) and (Length(token) > 1);
end;

procedure TIReaderTXT.LoadFromStream(FileStream: TStream);
var
  token: UTF8String;
  p: TSearchWordData;
begin
  inherited LoadFromStream(FileStream);
  token := GetToken;
  while token <> '' do
  begin
    if AllowedToken(token) then
    begin
      p.SearchWord := token;
      P.Position:=TokenStartPos;
      p.Context:=GetContext;
      Add(p);
    end;
    token := GetToken;
  end;
end;

initialization
  FileHandlers.RegisterFileReader('Text format', 'txt', TIReaderTXT);

end.

