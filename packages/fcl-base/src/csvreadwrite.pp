{
  CSV Parser, Builder classes.
  Version 0.5 2014-10-25

  Copyright (C) 2010-2014 Vladimir Zhirov <vvzh.home@gmail.com>

  Contributors:
    Luiz Americo Pereira Camara
    Mattias Gaertner
    Reinier Olislagers

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
}

{$IFNDEF FPC_DOTTEDUNITS}
unit csvreadwrite;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}
{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, System.SysUtils, System.StrUtils;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, SysUtils, strutils;
{$ENDIF FPC_DOTTEDUNITS}

Type
  TCSVChar = Char;

  { TCSVHandler }

  TCSVHandler = class(TPersistent)
  private
    function GetDelimiter: TCSVChar;
    function GetLineEnding: String;
    function GetQuoteChar: TCSVChar;
    procedure SetDelimiter(const AValue: TCSVChar);
    procedure SetLineEnding(AValue: String);
    procedure SetQuoteChar(const AValue: TCSVChar);
    procedure UpdateCachedChars;
  protected
    // special chars
    FDelimiter: AnsiChar;
    FQuoteChar: AnsiChar;
    FLineEnding: AnsiString;
    // cached values to speed up special chars operations
    FSpecialChars: TSysCharSet;
    FDoubleQuote: AnsiString;
    // parser settings
    FIgnoreOuterWhitespace: Boolean;
    // builder settings
    FQuoteOuterWhitespace: Boolean;
    // document settings
    FEqualColCountPerRow: Boolean;
  public
    constructor Create; virtual;
    procedure Assign(ASource: TPersistent); override;
    procedure AssignCSVProperties(ASource: TCSVHandler);
    // Delimiter that separates the field, e.g. comma, semicolon, tab
    property Delimiter: TCSVChar read GetDelimiter write SetDelimiter;
    // Character used to quote "problematic" data
    // (e.g. with delimiters or spaces in them)
    // A common quotechar is "
    property QuoteChar: TCSVChar read GetQuoteChar write SetQuoteChar;
    // String at the end of the line of data (e.g. CRLF)
    property LineEnding: String read GetLineEnding write SetLineEnding;
    // Ignore whitespace between delimiters and field data
    property IgnoreOuterWhitespace: Boolean read FIgnoreOuterWhitespace write FIgnoreOuterWhitespace;
    // Use quotes when outer whitespace is found
    property QuoteOuterWhitespace: Boolean read FQuoteOuterWhitespace write FQuoteOuterWhitespace;
    // When reading and writing: make sure every line has the same column count, create empty cells in the end of row if required
    property EqualColCountPerRow: Boolean read FEqualColCountPerRow write FEqualColCountPerRow;
  end;

  // Sequential input from CSV stream

  { TCSVParser }

  TCSVByteOrderMark = (bomNone, bomUTF8, bomUTF16LE, bomUTF16BE);

  TCSVParser = class(TCSVHandler)
  private
    FFreeStream: Boolean;
    // fields
    FSourceStream: TStream;
    FStrStreamWrapper: TStringStream;
    FBOM: TCSVByteOrderMark;
    FDetectBOM: Boolean;
    // parser state
    EndOfFile: Boolean;
    EndOfLine: Boolean;
    FCurrentChar: AnsiChar;
    FCurrentRow: Integer;
    FCurrentCol: Integer;
    FMaxColCount: Integer;
    // output buffers
    FCellBuffer: RawByteString;
    FWhitespaceBuffer: RawByteString;
    procedure ClearOutput;
    function GetCurrentCell: String;
    // basic parsing
    procedure SkipEndOfLine;
    procedure SkipDelimiter;
    procedure SkipWhitespace;
    procedure NextChar;
    // complex parsing
    procedure ParseCell;
    procedure ParseQuotedValue;
    // simple parsing
    procedure ParseValue;
  public
    constructor Create; override;
    destructor Destroy; override;
    // Source data stream
    procedure SetSource(AStream: TStream); overload;
    // Source data string.
    procedure SetSource(const AString: String); overload;
    // Rewind to beginning of data
    procedure ResetParser;
    // Read next cell data; return false if end of file reached
    function  ParseNextCell: Boolean;
    // Current row (0 based)
    property CurrentRow: Integer read FCurrentRow;
    // Current column (0 based); -1 if invalid/before beginning of file
    property CurrentCol: Integer read FCurrentCol;
    // Data in current cell
    property CurrentCellText: String read GetCurrentCell;
    // The maximum number of columns found in the stream:
    property MaxColCount: Integer read FMaxColCount;
    // Does the parser own the stream ? If true, a previous stream is freed when set or when parser is destroyed.
    Property FreeStream : Boolean Read FFreeStream Write FFreeStream;
    // Return BOM found in file
    property BOM: TCSVByteOrderMark read FBOM;
    // Detect whether a BOM marker is present. If set to True, then BOM can be used to see what BOM marker there was.
    property DetectBOM: Boolean read FDetectBOM write FDetectBOM default false;
  end;

  // Sequential output to CSV stream
  TCSVBuilder = class(TCSVHandler)
  private
    FOutputStream: TStream;
    FDefaultOutput: TMemoryStream;
    FNeedLeadingDelimiter: Boolean;
    function GetDefaultOutputAsString: String;
  protected
    procedure AppendStringToStream(const AString: String; AStream: TStream);
    function  QuoteCSVString(const AValue: String): String;
  public
    constructor Create; override;
    destructor Destroy; override;
    // Set output/destination stream.
    // If not called, output is sent to DefaultOutput
    procedure SetOutput(AStream: TStream);
    // If using default stream, reset output to beginning.
    // If using user-defined stream, user should reposition stream himself
    procedure ResetBuilder;
    // Add a cell to the output with data AValue
    procedure AppendCell(const AValue: String);
    // Write end of row to the output, starting a new row
    procedure AppendRow;
    // Default output as memorystream (if output not set using SetOutput)
    property DefaultOutput: TMemoryStream read FDefaultOutput;
    // Default output in string format (if output not set using SetOutput)
    property DefaultOutputAsString: String read GetDefaultOutputAsString;
  end;

function ChangeLineEndings(const AString, ALineEnding: String): String;

implementation

const
  CsvCharSize = SizeOf(TCSVChar);
  CR    = #13;
  LF    = #10;
  HTAB  = #9;
  SPACE = #32;
  WhitespaceChars = [HTAB, SPACE];
  LineEndingChars = [CR, LF];

Procedure AppendStr(Var Dest : RawByteString; Src : RawByteString); inline;

begin
  Dest:=Dest+Src;
end;

procedure RemoveTrailingChars(VAR S: RawByteString; const CSet: TSysCharset);

VAR I,J: LONGINT;

Begin
 I:=Length(S);
 IF (I>0) Then
  Begin
   J:=I;
   While (j>0) and (S[J] IN CSet) DO DEC(J);
   IF J<>I Then
    SetLength(S,J);
  End;
End;


// The following implementation of ChangeLineEndings function originates from
// Lazarus CodeTools library by Mattias Gaertner. It was explicitly allowed
// by Mattias to relicense it under modified LGPL and include into CsvDocument.

function ChangeLineEndings(const AString, ALineEnding: String): String;
var
  I: Integer;
  Src: PChar;
  Dest: PChar;
  DestLength: Integer;
  EndingLength: Integer;
  EndPos: PChar;
begin
  if AString = '' then
    Exit(AString);
  EndingLength := Length(ALineEnding);
  DestLength := Length(AString);

  Src := PChar(AString);
  EndPos := Src;
  Inc(EndPos,DestLength);
  while Src < EndPos do
  begin
    if (Src^ = CR) then
    begin
      Inc(Src);
      if (Src^ = LF) then
      begin
        Inc(Src);
        Inc(DestLength, EndingLength - 2);
      end else
        Inc(DestLength, EndingLength - 1);
    end else
    begin
      if (Src^ = LF) then
        Inc(DestLength, EndingLength - 1);
      Inc(Src);
    end;
  end;

  SetLength(Result, DestLength);
  Src := PChar(AString);
  Dest := PChar(Result);
  EndPos := Dest + DestLength;
  while (Dest < EndPos) do
  begin
    if Src^ in LineEndingChars then
    begin
      for I := 1 to EndingLength do
      begin
        Dest^ := ALineEnding[I];
        Inc(Dest);
      end;
      if (Src^ = CR) and (Src[1] = LF) then
        Inc(Src, 2)
      else
        Inc(Src);
    end else
    begin
      Dest^ := Src^;
      Inc(Src);
      Inc(Dest);
    end;
  end;
end;

{ TCSVHandler }

function TCSVHandler.GetDelimiter: TCSVChar;
begin
  Result:=FDelimiter;
end;

function TCSVHandler.GetLineEnding: String;
begin
  Result:=UTF8Decode(FLineEnding);
end;

function TCSVHandler.GetQuoteChar: TCSVChar;
begin
  Result:=FQuoteChar;
end;

procedure TCSVHandler.SetDelimiter(const AValue: TCSVChar);
begin
  if FDelimiter <> AValue then
  begin
    FDelimiter := AValue;
    UpdateCachedChars;
  end;
end;

procedure TCSVHandler.SetLineEnding(AValue: String);
begin
  FLineEnding:=UTF8ENcode(AValue)
end;

procedure TCSVHandler.SetQuoteChar(const AValue: TCSVChar);
begin
  if FQuoteChar <> AValue then
  begin
    FQuoteChar := AValue;
    UpdateCachedChars;
  end;
end;

procedure TCSVHandler.UpdateCachedChars;
begin
  FDoubleQuote := FQuoteChar + FQuoteChar;
  FSpecialChars := [CR, LF, FDelimiter, FQuoteChar];
end;

constructor TCSVHandler.Create;
begin
  inherited Create;
  FDelimiter := ',';
  FQuoteChar := '"';
  FLineEnding := sLineBreak;
  FIgnoreOuterWhitespace := False;
  FQuoteOuterWhitespace := True;
  FEqualColCountPerRow := True;
  UpdateCachedChars;
end;

procedure TCSVHandler.Assign(ASource: TPersistent);
begin
  if (ASource is TCSVHandler) then
    AssignCSVProperties(ASource as TCSVHandler)
  else
    inherited Assign(ASource);
end;

procedure TCSVHandler.AssignCSVProperties(ASource: TCSVHandler);
begin
  FDelimiter := ASource.FDelimiter;
  FQuoteChar := ASource.FQuoteChar;
  FLineEnding := ASource.FLineEnding;
  FIgnoreOuterWhitespace := ASource.FIgnoreOuterWhitespace;
  FQuoteOuterWhitespace := ASource.FQuoteOuterWhitespace;
  FEqualColCountPerRow := ASource.FEqualColCountPerRow;
  UpdateCachedChars;
end;

{ TCSVParser }

procedure TCSVParser.ClearOutput;
begin
  FCellBuffer := '';
  FWhitespaceBuffer := '';
  FCurrentRow := 0;
  FCurrentCol := -1;
  FMaxColCount := 0;
end;

function TCSVParser.GetCurrentCell: String;
begin
  Result:=FCellBuffer
end;

procedure TCSVParser.SkipEndOfLine;
begin
  // treat LF+CR as two linebreaks, not one
  if (FCurrentChar = CR) then
    NextChar;
  if (FCurrentChar = LF) then
    NextChar;
end;

procedure TCSVParser.SkipDelimiter;
begin
  if FCurrentChar = FDelimiter then
    NextChar;
end;

procedure TCSVParser.SkipWhitespace;
begin
  while FCurrentChar = SPACE do
    NextChar;
end;

procedure TCSVParser.NextChar;
begin
  if FSourceStream.Read(FCurrentChar, SizeOf(FCurrentChar)) < SizeOf(FCurrentChar) then
  begin
    FCurrentChar := #0;
    EndOfFile := True;
  end;
  EndOfLine := FCurrentChar in LineEndingChars;
end;

procedure TCSVParser.ParseCell;
begin
  FCellBuffer := '';
  if FIgnoreOuterWhitespace then
    SkipWhitespace;
  if FCurrentChar = FQuoteChar then
    ParseQuotedValue
  else
    ParseValue;
end;

procedure TCSVParser.ParseQuotedValue;
var
  QuotationEnd: Boolean;
begin
  NextChar; // skip opening quotation AnsiChar
  repeat
    // read value up to next quotation AnsiChar
    while not ((FCurrentChar = FQuoteChar) or EndOfFile) do
    begin
      if EndOfLine then
      begin
        AppendStr(FCellBuffer, FLineEnding);
        SkipEndOfLine;
      end else
      begin
        AppendStr(FCellBuffer, FCurrentChar);
        NextChar;
      end;
    end;
    // skip quotation AnsiChar (closing or escaping)
    if not EndOfFile then
      NextChar;
    // check if it was escaping
    if FCurrentChar = FQuoteChar then
    begin
      AppendStr(FCellBuffer, FCurrentChar);
      QuotationEnd := False;
      NextChar;
    end else
      QuotationEnd := True;
  until QuotationEnd;
  // read the rest of the value until separator or new line
  ParseValue;
end;

procedure TCSVParser.ParseValue;
begin
  while not ((FCurrentChar = FDelimiter) or EndOfLine or EndOfFile or (FCurrentChar = FQuoteChar)) do
  begin
    AppendStr(FCellBuffer, FCurrentChar);
    NextChar;
  end;
  if FCurrentChar = FQuoteChar then
    ParseQuotedValue;
  // merge whitespace buffer
  if FIgnoreOuterWhitespace then
    RemoveTrailingChars(FWhitespaceBuffer, WhitespaceChars);
  AppendStr(FWhitespaceBuffer,FCellBuffer);
  FWhitespaceBuffer := '';
end;

constructor TCSVParser.Create;
begin
  inherited Create;
  ClearOutput;
  FStrStreamWrapper := nil;
  EndOfFile := True;
end;

destructor TCSVParser.Destroy;
begin
  if FFreeStream and (FSourceStream<>FStrStreamWrapper) then
     FreeAndNil(FSourceStream);
  FreeAndNil(FStrStreamWrapper);
  inherited Destroy;
end;

procedure TCSVParser.SetSource(AStream: TStream);
begin
  If FSourceStream=AStream then exit;
  if FFreeStream and (FSourceStream<>FStrStreamWrapper) then
     FreeAndNil(FSourceStream);
  FSourceStream := AStream;
  ResetParser;
end;

procedure TCSVParser.SetSource(const AString: String); overload;
begin
  FreeAndNil(FStrStreamWrapper);
  FStrStreamWrapper := TStringStream.Create(AString);
  SetSource(FStrStreamWrapper);
end;

procedure TCSVParser.ResetParser;
var
  b: packed array[0..2] of byte;
  n: Integer;
begin
  B[0]:=0; B[1]:=0; B[2]:=0;
  ClearOutput;
  FSourceStream.Seek(0, soFromBeginning);
  if FDetectBOM then
  begin
    if FSourceStream.Read(b[0], 3)<3 then
      begin
      n:=0;
      FBOM:=bomNone;
      end
    else if (b[0] = $EF) and (b[1] = $BB) and (b[2] = $BF) then begin
      FBOM := bomUTF8;
      n := 3;
    end else
    if (b[0] = $FE) and (b[1] = $FF) then begin
      FBOM := bomUTF16BE;
      n := 2;
    end else
    if (b[0] = $FF) and (b[1] = $FE) then begin
      FBOM := bomUTF16LE;
      n := 2;
    end else begin
      FBOM := bomNone;
      n := 0;
    end;
    FSourceStream.Seek(n, soFromBeginning);
  end;
  EndOfFile := False;
  NextChar;
end;

// Parses next cell; returns True if there are more cells in the input stream.
function TCSVParser.ParseNextCell: Boolean;
var
  LineColCount: Integer;
begin
  if EndOfLine or EndOfFile then
  begin
    // Having read the previous line, adjust column count if necessary:
    LineColCount := FCurrentCol + 1;
    if LineColCount > FMaxColCount then
      FMaxColCount := LineColCount;
  end;

  if EndOfFile then
    Exit(False);

  // Handle line ending
  if EndOfLine then
  begin
    SkipEndOfLine;
    if EndOfFile then
      Exit(False);
    FCurrentCol := 0;
    Inc(FCurrentRow);
  end else
    Inc(FCurrentCol);

  // Skipping a delimiter should be immediately followed by parsing a cell
  // without checking for line break first, otherwise we miss last empty cell.
  // But 0th cell does not start with delimiter unlike other cells, so
  // the following check is required not to miss the first empty cell:
  if FCurrentCol > 0 then
    SkipDelimiter;
  ParseCell;
  Result := True;
end;

{ TCSVBuilder }

function TCSVBuilder.GetDefaultOutputAsString: String;
var
  StreamSize: Integer;
begin
  Result := '';
  StreamSize := FDefaultOutput.Size;
  if StreamSize > 0 then
  begin
    SetLength(Result, StreamSize);
    FDefaultOutput.Position:=0;
    FDefaultOutput.ReadBuffer(Result[1], StreamSize);
  end;
end;

procedure TCSVBuilder.AppendStringToStream(const AString: String; AStream: TStream);
var
  StrLen: Integer;
  S : AnsiString;

begin
  S:=aString;
  StrLen := Length(S);
  if StrLen > 0 then
    AStream.WriteBuffer(S[1], StrLen);
end;

function TCSVBuilder.QuoteCSVString(const AValue: String): String;
var
  I: Integer;
  ValueLen: Integer;
  NeedQuotation: Boolean;
  S : String;
begin
  ValueLen := Length(AValue);

  NeedQuotation := (AValue <> '') and FQuoteOuterWhitespace
    and ((AValue[1] in WhitespaceChars) or (AValue[ValueLen] in WhitespaceChars));

  if not NeedQuotation then
    for I := 1 to ValueLen do
    begin
      if AValue[I] in FSpecialChars then
      begin
        NeedQuotation := True;
        Break;
      end;
    end;

  if NeedQuotation then
  begin
    // double existing quotes
    Result := FDoubleQuote;
    S:=StringReplace(AValue, FQuoteChar, FDoubleQuote, [rfReplaceAll]);
    Insert(S,Result, 2);
  end else
    Result := AValue;
end;

constructor TCSVBuilder.Create;
begin
  inherited Create;
  FDefaultOutput := TMemoryStream.Create;
  FOutputStream := FDefaultOutput;
end;

destructor TCSVBuilder.Destroy;
begin
  FreeAndNil(FDefaultOutput);
  inherited Destroy;
end;

procedure TCSVBuilder.SetOutput(AStream: TStream);
begin
  if Assigned(AStream) then
    FOutputStream := AStream
  else
    FOutputStream := FDefaultOutput;

  ResetBuilder;
end;

procedure TCSVBuilder.ResetBuilder;
begin
  if FOutputStream = FDefaultOutput then
    FDefaultOutput.Clear;

  // Do not clear external FOutputStream because it may be pipe stream
  // or something else that does not support size and position.
  // To clear external output is up to the user of TCSVBuilder.

  FNeedLeadingDelimiter := False;
end;

procedure TCSVBuilder.AppendCell(const AValue: String);
var
  CellValue: String;
begin
  if FNeedLeadingDelimiter then
    FOutputStream.WriteBuffer(FDelimiter, SizeOf(FDelimiter));

  CellValue := ChangeLineEndings(AValue, FLineEnding);
  CellValue := QuoteCSVString(CellValue);
  AppendStringToStream(CellValue, FOutputStream);

  FNeedLeadingDelimiter := True;
end;

procedure TCSVBuilder.AppendRow;
begin
  AppendStringToStream(FLineEnding, FOutputStream);
  FNeedLeadingDelimiter := False;
end;

end.

