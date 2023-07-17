{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2013 by Yury Sidorov,
    member of the Free Pascal development team.

    Wide string support for Android

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 **********************************************************************}

{$mode objfpc}
{$inline on}
{$implicitexceptions off}

unit cwstring;

interface

procedure SetCWidestringManager;

implementation

uses dynlibs;

type
  UErrorCode = SizeInt;
  int32_t = longint;
  uint32_t = longword;
  PUConverter = pointer;
  PUCollator = pointer;
  UBool = LongBool;

var
  hlibICU: TLibHandle;
  hlibICUi18n: TLibHandle;
  LibVer: ansistring;

  ucnv_open: function (converterName: PAnsiChar; var pErrorCode: UErrorCode): PUConverter; cdecl;
  ucnv_close: procedure (converter: PUConverter); cdecl;
  ucnv_setSubstChars: procedure (converter: PUConverter; subChars: PAnsiChar; len: byte; var pErrorCode: UErrorCode); cdecl;
  ucnv_setFallback: procedure (cnv: PUConverter; usesFallback: UBool); cdecl;
  ucnv_fromUChars: function (cnv: PUConverter; dest: PAnsiChar; destCapacity: int32_t; src: PUnicodeChar; srcLength: int32_t; var pErrorCode: UErrorCode): int32_t; cdecl;
  ucnv_toUChars: function (cnv: PUConverter; dest: PUnicodeChar; destCapacity: int32_t; src: PAnsiChar; srcLength: int32_t; var pErrorCode: UErrorCode): int32_t; cdecl;
  u_strToUpper: function (dest: PUnicodeChar; destCapacity: int32_t; src: PUnicodeChar; srcLength: int32_t; locale: PAnsiChar; var pErrorCode: UErrorCode): int32_t; cdecl;
  u_strToLower: function (dest: PUnicodeChar; destCapacity: int32_t; src: PUnicodeChar; srcLength: int32_t; locale: PAnsiChar; var pErrorCode: UErrorCode): int32_t; cdecl;
  u_strCompare: function (s1: PUnicodeChar; length1: int32_t; s2: PUnicodeChar; length2: int32_t; codePointOrder: UBool): int32_t; cdecl;
  u_strCaseCompare: function (s1: PUnicodeChar; length1: int32_t; s2: PUnicodeChar; length2: int32_t; options: uint32_t; var pErrorCode: UErrorCode): int32_t; cdecl;
  u_getDataDirectory: function(): PAnsiChar; cdecl;
  u_setDataDirectory: procedure(directory: PAnsiChar); cdecl;
  u_init: procedure(var status: UErrorCode); cdecl;

  ucol_open: function(loc: PAnsiChar; var status: UErrorCode): PUCollator; cdecl;
  ucol_close: procedure (coll: PUCollator); cdecl;
  ucol_strcoll: function (coll: PUCollator; source: PUnicodeChar; sourceLength: int32_t; target: PUnicodeChar; targetLength: int32_t): int32_t; cdecl;
	ucol_setStrength: procedure (coll: PUCollator; strength: int32_t); cdecl;

threadvar
  ThreadDataInited: boolean;
  DefConv, LastConv: PUConverter;
  LastCP: TSystemCodePage;
  DefColl: PUCollator;

function MaskExceptions: dword;
begin
{$if defined(cpux86_64) or defined(cpui386)}
  Result:=GetMXCSR;
  SetMXCSR(Result or %0000000010000000 {MM_MaskInvalidOp} or %0001000000000000 {MM_MaskPrecision});
{$else}
  Result:=0;
{$endif}
end;

procedure UnmaskExceptions(oldmask: dword);
begin
{$if defined(cpux86_64) or defined(cpui386)}
  SetMXCSR(oldmask);
{$endif}
end;

function OpenConverter(const name: ansistring): PUConverter;
var
  err: UErrorCode;
  oldmask: dword;
begin
  { ucnv_open() must be called with some SSE exception masked on x86_64-android. }
  oldmask:=MaskExceptions;
  err:=0;
  Result:=ucnv_open(PAnsiChar(name), err);
  if Result <> nil then begin
    ucnv_setSubstChars(Result, '?', 1, err);
    ucnv_setFallback(Result, True);
  end;
  UnmaskExceptions(oldmask);
end;

procedure InitThreadData;
var
  err: UErrorCode;
  col: PUCollator;
begin
  if (hlibICU = 0) or ThreadDataInited then
    exit;
  ThreadDataInited:=True;
  DefConv:=OpenConverter('utf8');
  err:=0;
  col:=ucol_open(nil, err);
  if col <> nil then
    ucol_setStrength(col, 2);
  DefColl:=col;
end;

function GetConverter(cp: TSystemCodePage): PUConverter;
var
  s: ansistring;
begin
  if hlibICU = 0 then begin
    Result:=nil;
    exit;
  end;
  InitThreadData;
  if (cp = CP_UTF8) or (cp = CP_ACP) then
    Result:=DefConv
  else begin
    if cp <> LastCP then begin
      Str(cp, s);
      LastConv:=OpenConverter('cp' + s);
      LastCP:=cp;
    end;
    Result:=LastConv;
  end;
end;

procedure Unicode2AnsiMove(source: PUnicodeChar; var dest: RawByteString; cp: TSystemCodePage; len: SizeInt);
var
  len2: SizeInt;
  conv: PUConverter;
  err: UErrorCode;
begin
  if len = 0 then begin
    dest:='';
    exit;
  end;
  conv:=GetConverter(cp);
  if (conv = nil) and not ( (cp = CP_UTF8) or (cp = CP_ACP) ) then begin
    // fallback implementation
    DefaultUnicode2AnsiMove(source,dest,cp,len);
    exit;
  end;

  len2:=len*3;
  SetLength(dest, len2);
  err:=0;
  if conv <> nil then
    len2:=ucnv_fromUChars(conv, PAnsiChar(dest), len2, source, len, err)
  else begin
    // Use UTF-8 conversion from RTL
    cp:=CP_UTF8;
    len2:=UnicodeToUtf8(PAnsiChar(dest), len2, source, len) - 1;
  end;
  if len2 > Length(dest) then begin
    SetLength(dest, len2);
    err:=0;
    if conv <> nil then
      len2:=ucnv_fromUChars(conv, PAnsiChar(dest), len2, source, len, err)
    else
      len2:=UnicodeToUtf8(PAnsiChar(dest), len2, source, len) - 1;
  end;
  if len2 < 0 then
    len2:=0;
  SetLength(dest, len2);
  SetCodePage(dest, cp, False);
end;

procedure Ansi2UnicodeMove(source:PAnsiChar;cp : TSystemCodePage;var dest:unicodestring;len:SizeInt);
var
  len2: SizeInt;
  conv: PUConverter;
  err: UErrorCode;
begin
  if len = 0 then begin
    dest:='';
    exit;
  end;
  conv:=GetConverter(cp);
  if (conv = nil) and not ( (cp = CP_UTF8) or (cp = CP_ACP) ) then begin
    // fallback implementation
    DefaultAnsi2UnicodeMove(source,cp,dest,len);
    exit;
  end;

  len2:=len;
  SetLength(dest, len2);
  err:=0;
  if conv <> nil then
    len2:=ucnv_toUChars(conv, PUnicodeChar(dest), len2, source, len, err)
  else
    // Use UTF-8 conversion from RTL
    len2:=Utf8ToUnicode(PUnicodeChar(dest), len2, source, len) - 1;
  if len2 > Length(dest) then begin
    SetLength(dest, len2);
    err:=0;
    if conv <> nil then
      len2:=ucnv_toUChars(conv, PUnicodeChar(dest), len2, source, len, err)
    else
      len2:=Utf8ToUnicode(PUnicodeChar(dest), len2, source, len) - 1;
  end;
  if len2 < 0 then
    len2:=0;
  SetLength(dest, len2);
end;

function UpperUnicodeString(const s : UnicodeString) : UnicodeString;
var
  len, len2: SizeInt;
  err: UErrorCode;
begin
  if hlibICU = 0 then begin
    // fallback implementation
    Result:=UnicodeString(UpCase(AnsiString(s)));
    exit;
  end;
  len:=Length(s);
  SetLength(Result, len);
  if len = 0 then
    exit;
  err:=0;
  len2:=u_strToUpper(PUnicodeChar(Result), len, PUnicodeChar(s), len, nil, err);
  if len2 > len then begin
    SetLength(Result, len2);
    err:=0;
    len2:=u_strToUpper(PUnicodeChar(Result), len2, PUnicodeChar(s), len, nil, err);
  end;
  SetLength(Result, len2);
end;

function LowerUnicodeString(const s : UnicodeString) : UnicodeString;
var
  len, len2: SizeInt;
  err: UErrorCode;
begin
  if hlibICU = 0 then begin
    // fallback implementation
    Result:=UnicodeString(LowerCase(AnsiString(s)));
    exit;
  end;
  len:=Length(s);
  SetLength(Result, len);
  if len = 0 then
    exit;
  err:=0;
  len2:=u_strToLower(PUnicodeChar(Result), len, PUnicodeChar(s), len, nil, err);
  if len2 > len then begin
    SetLength(Result, len2);
    err:=0;
    len2:=u_strToLower(PUnicodeChar(Result), len2, PUnicodeChar(s), len, nil, err);
  end;
  SetLength(Result, len2);
end;

function _CompareStr(const S1, S2: UnicodeString): PtrInt;
var
  count, count1, count2: SizeInt;
begin
  result := 0;
  Count1 := Length(S1);
  Count2 := Length(S2);
  if Count1>Count2 then
    Count:=Count2
  else
    Count:=Count1;
  result := CompareByte(PUnicodeChar(S1)^, PUnicodeChar(S2)^, Count*SizeOf(UnicodeChar));
  if result=0 then
    result:=Count1 - Count2;
end;

function CompareUnicodeString(const s1, s2 : UnicodeString; Options : TCompareOptions) : PtrInt;
const
  U_COMPARE_CODE_POINT_ORDER = $8000;
var
  err: UErrorCode;
begin
  if hlibICU = 0 then begin
    // fallback implementation
    Result:=_CompareStr(s1, s2);
    exit;
  end;
  if (coIgnoreCase in Options) then begin
    err:=0;
    Result:=u_strCaseCompare(PUnicodeChar(s1), Length(s1), PUnicodeChar(s2), Length(s2), U_COMPARE_CODE_POINT_ORDER, err);
  end
  else begin
    InitThreadData;
    if DefColl <> nil then
      Result:=ucol_strcoll(DefColl, PUnicodeChar(s1), Length(s1), PUnicodeChar(s2), Length(s2))
    else
      Result:=u_strCompare(PUnicodeChar(s1), Length(s1), PUnicodeChar(s2), Length(s2), True);
  end;
end;

function UpperAnsiString(const s : AnsiString) : AnsiString;
begin
  Result:=AnsiString(UpperUnicodeString(UnicodeString(s)));
end;

function LowerAnsiString(const s : AnsiString) : AnsiString;
begin
  Result:=AnsiString(LowerUnicodeString(UnicodeString(s)));
end;

function CompareStrAnsiString(const s1, s2: ansistring): PtrInt;
begin
  Result:=CompareUnicodeString(UnicodeString(s1), UnicodeString(s2), []);
end;

function StrCompAnsi(s1,s2 : PAnsiChar): PtrInt;
begin
  Result:=CompareUnicodeString(UnicodeString(s1), UnicodeString(s2), []);
end;

function AnsiCompareText(const S1, S2: ansistring): PtrInt;
begin
  Result:=CompareUnicodeString(UnicodeString(s1), UnicodeString(s2), [coIgnoreCase]);
end;

function AnsiStrIComp(S1, S2: PAnsiChar): PtrInt;
begin
  Result:=CompareUnicodeString(UnicodeString(s1), UnicodeString(s2), [coIgnoreCase]);
end;

function AnsiStrLComp(S1, S2: PAnsiChar; MaxLen: PtrUInt): PtrInt;
var
  as1, as2: ansistring;
begin
  SetString(as1, S1, MaxLen);
  SetString(as2, S2, MaxLen);
  Result:=CompareUnicodeString(UnicodeString(as1), UnicodeString(as2), []);
end;

function AnsiStrLIComp(S1, S2: PAnsiChar; MaxLen: PtrUInt): PtrInt;
var
  as1, as2: ansistring;
begin
  SetString(as1, S1, MaxLen);
  SetString(as2, S2, MaxLen);
  Result:=CompareUnicodeString(UnicodeString(as1), UnicodeString(as2), [coIgnoreCase]);
end;

function AnsiStrLower(Str: PAnsiChar): PAnsiChar;
var
  s, res: ansistring;
begin
  s:=Str;
  res:=LowerAnsiString(s);
  if Length(res) > Length(s) then
    SetLength(res, Length(s));
  Move(PAnsiChar(res)^, Str, Length(res) + 1);
  Result:=Str;
end;

function AnsiStrUpper(Str: PAnsiChar): PAnsiChar;
var
  s, res: ansistring;
begin
  s:=Str;
  res:=UpperAnsiString(s);
  if Length(res) > Length(s) then
    SetLength(res, Length(s));
  Move(PAnsiChar(res)^, Str, Length(res) + 1);
  Result:=Str;
end;

function CodePointLength(const Str: PAnsiChar; MaxLookAead: PtrInt): Ptrint;
var
  c: byte;
begin
  // Only UTF-8 encoding is supported
  c:=byte(Str^);
  if c =  0 then
    Result:=0
  else begin
    Result:=1;
    if c < $80 then
      exit; // 1-byte ASCII char
    while c and $C0 = $C0 do begin
      Inc(Result);
      c:=c shl 1;
    end;
    if Result > 6 then
      Result:=1 // Invalid code point
    else
      if Result > MaxLookAead then
        Result:=-1; // Incomplete code point
  end;
end;

function GetStandardCodePage(const stdcp: TStandardCodePageEnum): TSystemCodePage;
begin
  Result := CP_UTF8; // Android always uses UTF-8
end;

procedure SetStdIOCodePage(var T: Text); inline;
begin
  case TextRec(T).Mode of
    fmInput:TextRec(T).CodePage:=DefaultSystemCodePage;
    fmOutput:TextRec(T).CodePage:=DefaultSystemCodePage;
  end;
end;

procedure SetStdIOCodePages; inline;
begin
  SetStdIOCodePage(Input);
  SetStdIOCodePage(Output);
  SetStdIOCodePage(ErrOutput);
  SetStdIOCodePage(StdOut);
  SetStdIOCodePage(StdErr);
end;

procedure Ansi2WideMove(source:PAnsiChar; cp:TSystemCodePage; var dest:widestring; len:SizeInt);
var
  us: UnicodeString;
begin
  Ansi2UnicodeMove(source,cp,us,len);
  dest:=us;
end;

function UpperWideString(const s : WideString) : WideString;
begin
  Result:=UpperUnicodeString(s);
end;

function LowerWideString(const s : WideString) : WideString;
begin
  Result:=LowerUnicodeString(s);
end;

function CompareWideString(const s1, s2 : WideString; Options : TCompareOptions) : PtrInt;
begin
  Result:=CompareUnicodeString(s1, s2, Options);
end;

Procedure SetCWideStringManager;
Var
  CWideStringManager : TUnicodeStringManager;
begin
  CWideStringManager:=widestringmanager;
  With CWideStringManager do
    begin
      Wide2AnsiMoveProc:=@Unicode2AnsiMove;
      Ansi2WideMoveProc:=@Ansi2WideMove;
      UpperWideStringProc:=@UpperWideString;
      LowerWideStringProc:=@LowerWideString;
      CompareWideStringProc:=@CompareWideString;

      UpperAnsiStringProc:=@UpperAnsiString;
      LowerAnsiStringProc:=@LowerAnsiString;
      CompareStrAnsiStringProc:=@CompareStrAnsiString;
      CompareTextAnsiStringProc:=@AnsiCompareText;
      StrCompAnsiStringProc:=@StrCompAnsi;
      StrICompAnsiStringProc:=@AnsiStrIComp;
      StrLCompAnsiStringProc:=@AnsiStrLComp;
      StrLICompAnsiStringProc:=@AnsiStrLIComp;
      StrLowerAnsiStringProc:=@AnsiStrLower;
      StrUpperAnsiStringProc:=@AnsiStrUpper;

      Unicode2AnsiMoveProc:=@Unicode2AnsiMove;
      Ansi2UnicodeMoveProc:=@Ansi2UnicodeMove;
      UpperUnicodeStringProc:=@UpperUnicodeString;
      LowerUnicodeStringProc:=@LowerUnicodeString;
      CompareUnicodeStringProc:=@CompareUnicodeString;

      GetStandardCodePageProc:=@GetStandardCodePage;
      CodePointLengthProc:=@CodePointLength;
    end;
  SetUnicodeStringManager(CWideStringManager);
end;

procedure UnloadICU;
begin
  if DefColl <> nil then
    ucol_close(DefColl);
  if DefConv <> nil then
    ucnv_close(DefConv);
  if LastConv <> nil then
    ucnv_close(LastConv);

  if LibVer = '_3_8' then
    exit;  // ICU v3.8 on Android 1.5-2.1 is buggy and can't be unloaded properly

  if hlibICU <> 0 then begin
    UnloadLibrary(hlibICU);
    hlibICU:=0;
  end;
  if hlibICUi18n <> 0 then begin
    UnloadLibrary(hlibICUi18n);
    hlibICUi18n:=0;
  end;
end;

function GetIcuProc(const Name: AnsiString; out ProcPtr; libId: longint = 0): boolean;
var
  p: pointer;
  hLib: TLibHandle;
begin
  Result:=False;
  if libId = 0 then
    hLib:=hlibICU
  else
    hLib:=hlibICUi18n;
  if hLib = 0 then
    exit;
  p:=GetProcedureAddress(hlib, Name + LibVer);
  if p = nil then
    exit;
  pointer(ProcPtr):=p;
  Result:=True;
end;

function LoadICU: boolean;
const
  ICUver: array [1..15] of ansistring =
    ('3_8', '4_2', '44', '46', '48', '50', '51', '53', '55', '56', '58', '60',
     '63', '66', '68');
  TestProcName = 'ucnv_open';

var
  i: longint;
  s: ansistring;
  dir: PAnsiChar;
  err: UErrorCode;
begin
  Result:=False;
{$ifdef android}
  hlibICU:=LoadLibrary('libicuuc.so');
  hlibICUi18n:=LoadLibrary('libicui18n.so');
{$else}
  hlibICU:=LoadLibrary('icuuc40.dll');
  hlibICUi18n:=LoadLibrary('icuin40.dll');
  LibVer:='_4_0';
{$endif android}
  if (hlibICU = 0) or (hlibICUi18n = 0) then begin
    UnloadICU;
    exit;
  end;
  // Finding ICU version using known versions table
  for i:=High(ICUver) downto Low(ICUver) do begin
    s:='_' + ICUver[i];
    if GetProcedureAddress(hlibICU, TestProcName + s) <> nil then begin
      LibVer:=s;
      break;
    end;
  end;

  if LibVer = '' then begin
    // Finding unknown ICU version
    Val(ICUver[High(ICUver)], i);
    repeat
      Inc(i);
      Str(i, s);
      s:='_'  + s;
      if GetProcedureAddress(hlibICU, TestProcName + s) <> nil then begin
        LibVer:=s;
        break;
      end;
    until i >= 100;
  end;

  if LibVer = '' then begin
    // Trying versionless name
    if GetProcedureAddress(hlibICU, TestProcName) = nil then begin
      // Unable to get ICU version
      SysLogWrite(ANDROID_LOG_ERROR, 'cwstring: Unable to get ICU version.');
      UnloadICU;
      exit;
    end;
  end;

  if not GetIcuProc('ucnv_open', ucnv_open) then exit;
  if not GetIcuProc('ucnv_close', ucnv_close) then exit;
  if not GetIcuProc('ucnv_setSubstChars', ucnv_setSubstChars) then exit;
  if not GetIcuProc('ucnv_setFallback', ucnv_setFallback) then exit;
  if not GetIcuProc('ucnv_fromUChars', ucnv_fromUChars) then exit;
  if not GetIcuProc('ucnv_toUChars', ucnv_toUChars) then exit;
  if not GetIcuProc('u_strToUpper', u_strToUpper) then exit;
  if not GetIcuProc('u_strToLower', u_strToLower) then exit;
  if not GetIcuProc('u_strCompare', u_strCompare) then exit;
  if not GetIcuProc('u_strCaseCompare', u_strCaseCompare) then exit;
  if not GetIcuProc('u_getDataDirectory', u_getDataDirectory) then exit;
  if not GetIcuProc('u_setDataDirectory', u_setDataDirectory) then exit;
  if not GetIcuProc('u_init', u_init) then exit;

  if not GetIcuProc('ucol_open', ucol_open, 1) then exit;
  if not GetIcuProc('ucol_close', ucol_close, 1) then exit;
  if not GetIcuProc('ucol_strcoll', ucol_strcoll, 1) then exit;
  if not GetIcuProc('ucol_setStrength', ucol_setStrength, 1) then exit;

  // Checking if ICU data dir is set
  dir:=u_getDataDirectory();
  if (dir = nil) or (dir^ = #0) then
    u_setDataDirectory('/system/usr/icu');

  err:=0;
  u_init(err);

  Result:=True;
end;

var
  oldm: TUnicodeStringManager;
{$ifdef android}
  SysGetIcuProc: pointer; external name 'ANDROID_GET_ICU_PROC';
{$endif android}

initialization
  GetUnicodeStringManager(oldm);
  DefaultSystemCodePage:=GetStandardCodePage(scpAnsi);
  DefaultUnicodeCodePage:=CP_UTF16;
  if LoadICU then begin
    SetCWideStringManager;
    {$ifdef android}
    SysGetIcuProc:=@GetIcuProc;
    SetStdIOCodePages;
    {$endif android}
  end
  else
    SysLogWrite(ANDROID_LOG_ERROR, 'cwstring: Failed to load ICU.');

finalization
  SetUnicodeStringManager(oldm);
  UnloadICU;

end.

