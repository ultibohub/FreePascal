  {
    This file is part of the Free Pascal run time library.
    Copyright (c) 2019 by Michael Van Canneyt, member of the
    Free Pascal development team

    VCL compatible TNetEncoding unit

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$mode objfpc}
{$H+}

unit System.NetEncoding;

interface

{$IFDEF FPC_DOTTEDUNITS}
uses System.SysUtils, System.Classes, System.Types;
{$ELSE FPC_DOTTEDUNITS}
uses Sysutils, Classes, Types;
{$ENDIF FPC_DOTTEDUNITS}

type
  // Not used here
  EHTTPException = class(Exception);

  UnsafeChar = Byte;
  TUnsafeChars = set of UnsafeChar;
  TURLEncoding = Class;

  { TNetEncoding }

  TNetEncoding = class
  private
    Const
      StdCount = 3;
    Class var
      FStdEncodings : Array[1..StdCount] of TNetEncoding;
    Class Function GetStdEncoding(aIndex : Integer) : TNetEncoding; Static;
    Class Destructor Destroy;
    class function GetURLEncoding: TURLEncoding; static;
  protected
    // These must be implemented by descendents
    Function DoDecode(const aInput: RawByteString): RawByteString; overload; virtual; abstract;
    Function DoEncode(const aInput: RawByteString): RawByteString; overload; virtual; abstract;

    // These can be overridden by descendents for effiency
    Function DoDecode(const aInput: UnicodeString): UnicodeString; overload; virtual;
    Function DoEncode(const aInput: UnicodeString): UnicodeString; overload; virtual;

    Function DoDecode(const aInput, aOutput: TStream): Integer; overload; virtual;
    Function DoEncode(const aInput, aOutput: TStream): Integer; overload; virtual;

    Function DoDecode(const aInput: array of Byte): TBytes; overload; virtual;
    Function DoEncode(const aInput: array of Byte): TBytes; overload; virtual;

    Function DoDecodeStringToBytes(const aInput: RawByteString): TBytes; virtual; overload;
    Function DoDecodeStringToBytes(const aInput: UnicodeString): TBytes; virtual; overload;
    Function DoEncodeBytesToString(const aInput: array of Byte): UnicodeString; overload; virtual;
    Function DoEncodeBytesToString(const aInput: Pointer; Size: Integer): UnicodeString; overload; virtual;
  public
    Class Procedure FreeStdEncodings;
    // Public stubs, they call the Do* versions
    // Stream
    Function Decode(const aInput, aOutput: TStream): Integer; overload;
    Function Encode(const aInput, aOutput: TStream): Integer; overload;
    // TBytes
    Function Decode(const aInput: array of Byte): TBytes; overload;
    Function Encode(const aInput: array of Byte): TBytes; overload;
    // Strings
    Function Decode(const aInput: UnicodeString): UnicodeString; overload;
    Function Encode(const aInput: UnicodeString): UnicodeString; overload;
    Function Decode(const aInput: RawByteString): RawByteString; overload;
    Function Encode(const aInput: RawByteString): RawByteString; overload;
    // UnicodeString to Bytes
    Function DecodeStringToBytes(const aInput: UnicodeString): TBytes;
    Function DecodeStringToBytes(const aInput: RawByteString): TBytes;
    Function EncodeBytesToString(const aInput: array of Byte): UnicodeString; overload;
    Function EncodeBytesToString(const aInput: Pointer; Size: Integer): UnicodeString; overload;
    // Default instances
    class property Base64: TNetEncoding Index 1 read GetStdEncoding;
    class property HTML: TNetEncoding Index 2 read GetStdEncoding;
    class property URL: TURLEncoding read GetURLEncoding;
  end;

  { TBase64Encoding }

  TBase64Encoding = class(TNetEncoding)
  protected
    Function DoDecode(const aInput, aOutput: TStream): Integer; overload; override;
    Function DoEncode(const aInput, aOutput: TStream): Integer; overload; override;

    Function DoDecode(const aInput: RawByteString): RawByteString; overload; override;
    Function DoEncode(const aInput: RawByteString): RawByteString; overload; override;
  end;

  { TURLEncoding }

  TURLEncoding = class(TNetEncoding)
  protected
    Function DoEncode(const aInput: RawBytestring): RawBytestring; overload; override;
    Function DoDecode(const aInput: RawBytestring): RawBytestring; overload; override;
  Public
    Type
      UnsafeChar = Byte;
      TUnsafeChars = set of UnsafeChar;
      TEncodeOption = (SpacesAsPlus, EncodePercent);
      TEncodeOptions = set of TEncodeOption;
      TDecodeOption = (PlusAsSpaces);
      TDecodeOptions = set of TDecodeOption;
  Public
    function Encode(const aInput: string; const aSet: TUnsafeChars; const aOptions: TEncodeOptions; aEncoding: TEncoding = nil): string; overload;
    function EncodeQuery(const aInput: string; const aExtraUnsafeChars: TUnsafeChars): string;
    function EncodePath(const aPath: string; const aExtraUnsafeChars: TUnsafeChars): string;
    class function URIDecode(const aValue: string; aPlusAsSpaces: Boolean): string;
  end;

  THTMLEncoding = class(TNetEncoding)
  protected
    Function DoDecode(const aInput: UnicodeString): UnicodeString; override;
    Function DoDecode(const aInput: RawBytestring): RawBytestring; overload; override;
    Function DoEncode(const aInput: UnicodeString): UnicodeString; override;
    Function DoEncode(const aInput: RawBytestring): RawBytestring; overload; override;
  end;

implementation

{$IFDEF FPC_DOTTEDUNITS}
uses System.Hash.Base64, FpWeb.Http.Protocol, Html.Defs, Xml.Read;
{$ELSE FPC_DOTTEDUNITS}
uses base64, httpprotocol, HTMLDefs, xmlread;
{$ENDIF FPC_DOTTEDUNITS}

Resourcestring
  sInvalidHTMLEntity = 'Invalid HTML encoded character: %s';

{ TBase64Encoding }

function TBase64Encoding.DoDecode(const aInput, aOutput: TStream): Integer;

Var
  S : TBase64DecodingStream;

begin
  S:=TBase64DecodingStream.Create(aInput,bdmMIME);
  try
    Result:=S.Size;
    aOutput.CopyFrom(S,Result);
  finally
    S.Free;
  end;
end;

function TBase64Encoding.DoEncode(const aInput, aOutput: TStream): Integer;
Var
  S : TBase64EncodingStream;

begin
  S:=TBase64EncodingStream.Create(aInput);
  try
    Result:=S.Size;
    aOutput.CopyFrom(S,Result);
  finally
    S.Free;
  end;
end;

function TBase64Encoding.DoDecode(const aInput: RawByteString): RawByteString;
begin
  Result:=DecodeStringBase64(aInput,False);
end;

function TBase64Encoding.DoEncode(const aInput: RawByteString): RawByteString;
begin
  Result:=EncodeStringBase64(aInput);
end;

{ ---------------------------------------------------------------------
  TNetEncoding
  ---------------------------------------------------------------------}

class procedure TNetEncoding.FreeStdEncodings;

Var
  I : Integer;

begin
  For I:=1 to StdCount do
    FreeAndNil(FStdEncodings[i]);
end;

class destructor TNetEncoding.Destroy;
begin
  FreeStdEncodings;
end;

class function TNetEncoding.GetURLEncoding: TURLEncoding; static;
begin
  Result:=TURLEncoding(GetStdEncoding(3));
end;

class function TNetEncoding.GetStdEncoding(aIndex: Integer): TNetEncoding;
begin
  if FStdEncodings[aIndex]=Nil then
    case aIndex of
      1 : FStdEncodings[1]:=TBase64Encoding.Create;
      2 : FStdEncodings[2]:=THTMLEncoding.Create;
      3 : FStdEncodings[3]:=TURLEncoding.Create;
    end;
  Result:=FStdEncodings[aIndex];
end;

// Public API

function TNetEncoding.Encode(const aInput: array of Byte): TBytes;
begin
  Result:=DoEncode(aInput);
end;

function TNetEncoding.Encode(const aInput, aOutput: TStream): Integer;
begin
  Result:=DoEncode(aInput, aOutput);
end;

function TNetEncoding.Decode(const aInput: RawByteString): RawByteString;
begin
  Result:=DoDecode(aInput);
end;

function TNetEncoding.Encode(const aInput: RawByteString): RawByteString;

begin
  Result:=DoEncode(aInput);
end;

function TNetEncoding.Encode(const aInput: UnicodeString): UnicodeString;
begin
  Result:=DoEncode(aInput);
end;

function TNetEncoding.EncodeBytesToString(const aInput: array of Byte): UnicodeString;
begin
  Result:=DoEncodeBytesToString(aInput);
end;

function TNetEncoding.EncodeBytesToString(const aInput: Pointer; Size: Integer): UnicodeString;
begin
  Result:=DoEncodeBytesToString(aInput, Size);
end;

function TNetEncoding.Decode(const aInput, aOutput: TStream): Integer;
begin
  Result:=DoDecode(aInput,aOutput);
end;

function TNetEncoding.Decode(const aInput: UnicodeString): UnicodeString;
begin
  Result:=DoDecode(aInput);
end;

function TNetEncoding.DecodeStringToBytes(const aInput: UnicodeString): TBytes;
begin
  Result:=DoDecodeStringToBytes(aInput);
end;

function TNetEncoding.DecodeStringToBytes(const aInput: RawByteString): TBytes;
begin
  Result:=DoDecodeStringToBytes(aInput);
end;

function TNetEncoding.Decode(const aInput: array of Byte): TBytes;
begin
  Result:=DoDecode(aInput);
end;

// Protected

function TNetEncoding.DoDecode(const aInput: UnicodeString): UnicodeString;

Var
  U : UTF8String;

begin
  U:=UTF8Encode(aInput);
  Result:=UTF8Decode(DoDecode(U));
end;

function TNetEncoding.DoEncode(const aInput: UnicodeString): UnicodeString;

Var
  U : UTF8String;

begin
  U:=UTF8Encode(aInput);
  Result:=UTF8Decode(DoEncode(U));
end;

function TNetEncoding.DoDecode(const aInput: array of Byte): TBytes;

begin
  if Length(aInput)=0 then
    Result:=Default(TBytes)
  else
    Result:=TEncoding.UTF8.GetBytes(DoDecode(UTF8ToString(aInput)));
end;

function TNetEncoding.DoDecode(const aInput, aOutput: TStream): Integer;

var
  Src,Dest: TBytes;
  Len : Integer;

begin
  Result:=0;
  Len:=aInput.Size;
  if Len<>0 then
    begin
    Src:=Default(TBytes);
    SetLength(Src,Len);
    aInput.ReadBuffer(Src,Len);
    Dest:=DoDecode(Src);
    Result:=Length(Dest);
    aOutput.WriteBuffer(Dest,Result);
    end
end;

function TNetEncoding.DoDecodeStringToBytes(const aInput: UnicodeString): TBytes;

begin
  Result:=TEncoding.UTF8.GetBytes(DoDecode(aInput));
end;

function TNetEncoding.DoEncode(const aInput: array of Byte): TBytes;
begin
  if Length(aInput)=0 then
    Result:=Default(TBytes)
  else
    Result:=TEncoding.UTF8.GetBytes(DoEncode(UTF8ToString(aInput)))
end;

function TNetEncoding.DoDecodeStringToBytes(const aInput: RawByteString): TBytes;

Var
  U : RawByteString;

begin
  U:=AInput;
  UniqueString(U);
  SetCodePage(U,CP_UTF8,True);
  Result:=DoDecodeStringToBytes(UTF8Decode(U));
end;

function TNetEncoding.DoEncodeBytesToString(const aInput: array of Byte): UnicodeString;
begin
  Result:=TEncoding.UTF8.GetString(DoEncode(aInput));
end;


function TNetEncoding.DoEncodeBytesToString(const aInput: Pointer; Size: Integer): UnicodeString;

Var
  Src : TBytes;

begin
  Src:=Default(TBytes);
  SetLength(Src,Size);
  Move(aInput^,Src[0],Size);
  Result:=DoEncodeBytesToString(Src);
end;

function TNetEncoding.DoEncode(const aInput, aOutput: TStream): Integer;
var
  InBuf: array of Byte;
  OutBuf: TBytes;
begin
  if aInput.Size > 0 then
  begin
    SetLength(InBuf, aInput.Size);
    aInput.Read(InBuf[0], aInput.Size);
    OutBuf:=DoEncode(InBuf);
    Result:=Length(OutBuf);
    aOutput.Write(OutBuf, Result);
    SetLength(InBuf, 0);
  end
  else
    Result:=0;
end;

{ TBase64Encoding }


{ TURLEncoding }

function TURLEncoding.DoDecode(const aInput: RawBytestring): RawBytestring;

begin
  Result:=HTTPDecode(aInput);
end;

function TURLEncoding.Encode(const aInput: string; const aSet: TUnsafeChars; const aOptions: TEncodeOptions; aEncoding: TEncoding): string;


var
  S : TUnsafeChars;

begin
  S:=aSet;
  if (TEncodeOption.EncodePercent in aOptions) then
    S:=aSet+[Ord('%')];
  Result:=HttpEncode(aInput,S,TEncodeOption.SpacesAsPlus in aOptions);
end;

function TURLEncoding.DoEncode(const aInput: RawBytestring): RawBytestring;

begin
  Result:=HTTPEncode(aInput)
end;

function TURLEncoding.EncodeQuery(const aInput: string; const aExtraUnsafeChars: TUnsafeChars): string;

const
  QueryUnsafeChars: TUnsafeChars = [Ord('''')+Ord('%')];

var
  Unsafe: TUnsafeChars;

begin
  Unsafe:=QueryUnsafeChars+aExtraUnsafeChars;
  Result:=HTTPEncode(aInput,Unsafe,True);
end;

function TURLEncoding.EncodePath(const aPath: string; const aExtraUnsafeChars: TUnsafeChars): string;


var
  lPaths: TStringDynArray;
  I,Last: Integer;
  LUnsafeChars: TUnsafeChars;

begin
  if APath = '' then
    Exit('/');
  Result:='';
  lPaths:=APath.Split(['/'], TStringSplitOptions.ExcludeEmpty);
  Last:=Length(lPaths)-1;
  for I:=0 to Last do
    Result:=Result+'/'+HTTPEncode(LPaths[I],aExtraUnsafeChars,True);
end;

class function TURLEncoding.URIDecode(const aValue: string; aPlusAsSpaces: Boolean): string;
begin
  Result:=HTTPDecode(aValue,aPlusAsSpaces);
end;


{ THTMLEncoding }

Function THTMLEncoding.DoEncode(const aInput: UnicodeString): UnicodeString;

Var
  S : UTF8String;

begin
  S:=UTF8Encode(aInput);
  Result:=UTF8Decode(DoEncode(S));
end;

Function THTMLEncoding.DoEncode(const aInput: RawByteString): RawByteString;

var
  Src, Curr, OrigDest,Dest : PAnsiChar;

  Procedure CopyData(S : String);

  Var
    len : integer;

  begin
    Len:=(Curr-Src);
    if Len>0 then
      Move(Src^,Dest^,Len);
    Src:=Curr;
    Inc(Src);
    inc(Dest,Len);
    Len:=Length(S);
    if Len>0 then
      Move(S[1],Dest^,Len);
    inc(Dest,Len);
  end;

begin
  SetLength(Result,Length(aInput)*6);
  if Length(aInput)=0 then exit;
  Src:=PAnsiChar(aInput);
  Curr:=Src;
  OrigDest:=PAnsiChar(Result);
  Dest:=OrigDest;
  // Convert: &, <, >, "
  while Curr^<>#0 do
    begin
    case Curr^ of
      '&': CopyData('&amp;');
      '<': CopyData('&lt;');
      '>': CopyData('&gt;');
      '"': CopyData('&quot;');
    end;
    Inc(Curr);
    end;
  CopyData('');
  SetLength(Result,Dest-OrigDest);
end;

Function THTMLEncoding.DoDecode(const aInput: RawByteString): RawByteString;

Var
  S : RawByteString;


begin
  S:=aInput;
  UniqueString(S);
  SetCodePage(S,CP_UTF8,true);
  Result:=UTF8Encode(DoDecode(UTF8Decode(S)));
end;

Function THTMLEncoding.DoDecode(const aInput: UnicodeString): UnicodeString;

var
  Src, Curr, Dest : PWideChar;

  Procedure CopyData(S : UnicodeString);

  Var
    len : integer;

  begin
    Len:=(Curr-Src);
    if Len>0 then
      begin
      Move(Src^,Dest^,Len*Sizeof(UnicodeChar));
      inc(Dest,Len);
      end;
    Len:=Length(S);
    if Len>0 then
      begin
      Move(S[1],Dest^,Len*Sizeof(UnicodeChar));
      inc(Dest,Len);
      end;
  end;

Var
  Len : Integer;
  U : UnicodeChar;
  US : Unicodestring;
  Ent,OrigDest : PWideChar;

begin
  SetLength(Result, Length(aInput));
  if Length(Result)=0 then exit;
  Src:=PWideChar(aInput);
  OrigDest:=PWideChar(Result);
  Dest:=OrigDest;
  Curr:=Src;
  while Curr^ <> #0 do
    begin
    If Curr^='&' then
      begin
      CopyData('');
      Src:=Curr;
      Ent:=Curr;
      While Not (Ent^ in [#0,';']) do
        Inc(Ent);
      Len:=Ent-Curr-1;
      SetLength(US,Len);
      if Len>0 then
        Move(Curr[1],US[1],Len*SizeOf(UnicodeChar));
      if not ResolveHTMLEntityReference(US,U) then
        raise EConvertError.CreateFmt(sInvalidHTMLEntity,[US]);
      CopyData(U);
      Curr:=Ent;
      Src:=Curr;
      Inc(Src);
      end;
    Inc(Curr);
    end;
  CopyData('');
  SetLength(Result,Dest-OrigDest);
end;

end.

