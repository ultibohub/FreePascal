program tcustomvar1;

{$APPTYPE CONSOLE}
{$MODE Delphi}

uses
  Variants, SysUtils;

type
  TSampleVariant = class(TCustomVariantType)
  protected
    procedure DispInvoke(Dest: PVarData; var Source: TVarData; CallDesc: PCallDesc; Params: Pointer); override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean ); override;
  end;

procedure TSampleVariant.Clear(var V: TVarData);
begin
  V.VType:=varEmpty;
end;

procedure TSampleVariant.Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else with Dest do
    VType:=Source.VType;
end;

var
  funcname: String;
  argnames: array of String;
  argtypes: array of Byte;
  argvalues: array of Variant;

procedure TSampleVariant.DispInvoke(Dest: PVarData; var Source: TVarData; CallDesc: PCallDesc; Params: Pointer);
var
  n: AnsiString;
  nptr: PChar;
  arg: Pointer;
  t: Byte;
  i: LongInt;
  v: Variant;
begin
  nptr := PChar(@CallDesc^.argtypes[CallDesc^.argcount]);
  n := StrPas(nptr);
  if n <> funcname then begin
    Writeln('Func name: got: ', n, ', expected: ', funcname);
    Halt(1);
  end;
  if Length(argnames) <> CallDesc^.namedargcount then
    Halt(1);
  nptr := nptr + Length(n) + 1;
  arg := Params;
  for i := 0 to CallDesc^.namedargcount - 1 do begin
    n := StrPas(nptr);
    if n <> argnames[i] then begin
      Writeln('Arg ', i, ': got: ', n, ', expected: ', argnames[i]);
      Halt(1);
    end;
    if CallDesc^.argtypes[i] <> argtypes[i] then begin
      Writeln('Arg ', i, ' type: got: ', CallDesc^.ArgTypes[i], ', expected: ', argtypes[i]);
      Halt(1);
    end;
    t := argtypes[i] and $7f;
    if argtypes[i] and $80 <> 0 then begin
      TVarData(v).VType := t or varByRef;
      TVarData(v).VPointer := PPointer(arg)^;
    end else begin
      TVarData(v).VType := t;
      case t of
        varStrArg: begin
          TVarData(v).VType := varString;
          AnsiString(TVarData(v).VString) := AnsiString(StrPas(PPWideChar(arg)^));
        end;
        varUStrArg: begin
          TVarData(v).VType := varUString;
          UnicodeString(TVarData(v).VUString) := StrPas(PPWideChar(arg)^);
        end;
        varSingle:
          TVarData(v).VSingle := PLongint(arg)^;
        varSmallint:
          TVarData(v).VSmallInt := PLongint(arg)^;
        varInteger:
          TVarData(v).VInteger := PLongint(arg)^;
        varLongWord:
          TVarData(v).VLongWord := PLongint(arg)^;
        varBoolean:
          TVarData(v).VBoolean := Boolean(PLongint(arg)^);
        varShortInt:
          TVarData(v).VShortInt := PLongint(arg)^;
        varByte:
          TVarData(v).VByte := PLongint(arg)^;
        varWord:
          TVarData(v).VWord := PLongint(arg)^;
        else
          TVarData(v).VAny := PPointer(arg)^;
      end;
    end;
    if (not VarIsStr(v) and (v <> argvalues[i])) or (VarIsStr(v) and (UnicodeString(v) <> UnicodeString(argvalues[i]))) then begin
      Writeln('Arg ', i, ' value: got: ', String(v), ', expected: ', String(argvalues[i]));
      Halt(1);
    end;
    nptr := nptr + Length(n) + 1;
    arg := PByte(arg) + SizeOf(Pointer);
    { unset so that VarClear doesn't try to free the constant WideChar }
    TVarData(v).vtype:=varEmpty;
  end;
end;

function ConvertArgType(aType: Word): Byte;
var
  ref: Boolean;
begin
  ref := (aType and varByRef) <> 0;
  aType := aType and not varByRef;
  case aType of
    {$ifndef windows}
    varOleStr:
      Result := varUStrArg;
    {$endif}
    varString:
    {$ifdef windows}
      Result := varOleStr;
    {$else}
      Result := varUStrArg; { not varStrArg }
    {$endif}
    varUString:
    {$ifdef windows}
      Result := varOleStr;
    {$else}
      Result := varUStrArg;
    {$endif}
    otherwise
      Result := aType;
  end;
  if ref then
    Result := Result or $80;
end;

var
  SampleVariant: TSampleVariant;
  v, v1: Variant;

begin
  SampleVariant:=TSampleVariant.Create;
  TVarData(v).VType:=SampleVariant.VarType;

  funcname := 'SomeProc';
  SetLength(argnames, 0);
  v.SomeProc;

  funcname := 'SomeFunc';
  SetLength(argnames, 0);
  v1 := v.SomeFunc;

  funcname := 'Begin';
  SetLength(argnames, 2);
  SetLength(argtypes, 2);
  SetLength(argvalues, 2);
  { the parameters are passed right-to-left }
  argnames[1] := 'Date';
  argnames[0] := 'Foobar';
  argvalues[1] := 42;
  argvalues[0] := UnicodeString('Hello');
  argtypes[1] := ConvertArgType(TVarData(argvalues[1]).VType);
  argtypes[0] := ConvertArgType(TVarData(argvalues[0]).VType);
  v.&Begin(Date:=42,Foobar:='Hello');

  argvalues[1] := 3542;
  argvalues[0] := UnicodeString('Hello');
  argtypes[1] := ConvertArgType(TVarData(argvalues[1]).VType);
  argtypes[0] := ConvertArgType(TVarData(argvalues[0]).VType);
  v.&Begin(Date:=3542,Foobar:='Hello');

  argvalues[1] := 1233542;
  argvalues[0] := UnicodeString('Hello');
  argtypes[1] := ConvertArgType(TVarData(argvalues[1]).VType);
  argtypes[0] := ConvertArgType(TVarData(argvalues[0]).VType);
  v.&Begin(Date:=1233542,Foobar:='Hello');

  funcname := '_';
  SetLength(argnames, 0);
  v._;

  writeln('ok');
end.
