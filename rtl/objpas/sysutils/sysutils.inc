{%MainUnit sysutils.pp}
{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Florian Klaempfl
    member of the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

  { MCBS functions }
  {$i sysansi.inc}
  {$i syscodepages.inc}

{$macro on}
{$define PathStr:=UnicodeString}
{$define PathPChar:=PUnicodeChar}
{$define SYSUTILSUNICODE}
  { Read filename handling functions implementation }
  {$i fina.inc}
  { Read disk function implementations }
  {$i disk.inc}
{$undef SYSUTILSUNICODE}
{$define PathStr:=RawByteString}
{$define PathPChar:=PAnsiChar}
  { Read filename handling functions implementation }
  {$i fina.inc}
  { Read disk function implementations }
  {$i disk.inc}
{$undef PathStr}
{$undef PathPChar}

  { Read file utility functions implementation }
  {$i filutil.inc}

  { variant error codes }
  {$i varerror.inc}

  { Type helpers}
  {$i syshelp.inc}

{$IFDEF FPC_HAS_FEATURE_UNICODESTRINGS}
  { strange Delphi thing }
  {$i sysmarshal.inc}
{$ENDIF}

  {$ifndef OS_FILEISREADONLY}
  Function FileIsReadOnly(const FileName: RawByteString): Boolean;
  begin
    Result := (FileGetAttr(FileName) and faReadOnly) <> 0;
  end;


  Function FileIsReadOnly(const FileName: UnicodeString): Boolean;
  begin
    Result := (FileGetAttr(FileName) and faReadOnly) <> 0;
  end;
  {$endif OS_FILEISREADONLY}


  {$ifndef OS_FILESETDATEBYNAME}
  Function FileSetDate (Const FileName : RawByteString;Age : Int64) : Longint;
  Var
    fd : THandle;
  begin
    { at least windows requires fmOpenWrite here }
    fd:=FileOpen(FileName,fmOpenWrite);
    If (Fd<>feInvalidHandle) then
      try
        Result:=FileSetDate(fd,Age);
      finally
        FileClose(fd);
      end
    else
  {$ifdef HAS_OSERROR}
      Result:=GetLastOSError;
  {$else}
      Result:=-1;
  {$endif}
  end;


  Function FileSetDate (Const FileName : UnicodeString;Age : Int64) : Longint;
  Var
    fd : THandle;
  begin
    { at least windows requires fmOpenWrite here }
    fd:=FileOpen(FileName,fmOpenWrite);
    If (Fd<>feInvalidHandle) then
      try
        Result:=FileSetDate(fd,Age);
      finally
        FileClose(fd);
      end
    else
  {$ifdef HAS_OSERROR}
      Result:=GetLastOSError;
  {$else}
      Result:=-1;
  {$endif}
  end;
  {$endif}

  { Read String Handling functions implementation }
  {$i sysstr.inc}

  { Read date & Time function implementations }
{$ifndef FPUNONE}
  {$i dati.inc}
{$endif}

{$IFNDEF HAS_GETTICKCOUNT}
function GetTickCount: LongWord;
begin
  Result := LongWord(GetTickCount64);
end;
{$ENDIF}

{$IFNDEF HAS_GETTICKCOUNT64}
function GetTickCount64: QWord;
begin
{$IFDEF FPU_NONE}
  {$IFDEF HAS_SYSTIMERTICK}
  Result := SysTimerTick;
  {$ELSE}
  Result := 0;
  {$ENDIF}
{$ELSE}
  Result := Trunc(Now * 24 * 60 * 60 * 1000);
{$ENDIF}
end;
{$ENDIF}

  { Read PAnsiChar handling functions implementation }
  {$i syspch.inc}

  { generic internationalisation code }
  {$i sysint.inc}

  { wide string functions }
  {$i syswide.inc}

{$ifdef FPC_HAS_UNICODESTRING}
  { unicode string functions }
  {$i sysuni.inc}
  {$i sysencoding.inc}
{$endif FPC_HAS_UNICODESTRING}

  { threading stuff }
  {$i sysuthrd.inc}

  { OS utility code }
  {$i osutil.inc}

    {$IFDEF CPULLVM}
    // LLVM does not like the constref construction. 
    // So when LLVM is used, we keep the untyped version.
    // This allows users of other platforms to enjoy the type safety of FreeAndNil.
    procedure FreeAndNil(var obj);
      var 
        temp: tobject;
      begin
        temp:=tobject(obj);
        pointer(obj):=nil;
        temp.free;
      end;
    {$ELSE}
    procedure FreeAndNil(constref obj: TObject);
      type
        PObject = ^TObject;
      var
        temp: tobject;
      begin
        temp:=obj;
        PObject(@obj)^:=nil;
        temp.free;
      end;
    {$ENDIF}

    procedure FreeMemAndNil(var p);

    var
      temp:Pointer;
    begin
      temp := Pointer(p);
      Pointer(P):=nil;
      FreeMem(temp);
    end;

  { Interfaces support }
  {$i sysuintf.inc}

    constructor Exception.Create(const msg : string);

      begin
         inherited create;
         fmessage:=msg;
      end;


    constructor Exception.CreateFmt(const msg : string; const args : array of const);

      begin
         inherited create;
         fmessage:=Format(msg,args);
      end;


    constructor Exception.CreateRes(ResString: PResStringRec);

      begin
         inherited create;
         fmessage:=ResString^;
      end;


    constructor Exception.CreateResFmt(ResString: PResStringRec; const Args: array of const);

      begin
         inherited create;
         fmessage:=Format(ResString^,args);
      end;


    constructor Exception.CreateHelp(const Msg: string; AHelpContext: Longint);

      begin
         inherited create;
         fmessage:=Msg;
         fhelpcontext:=AHelpContext;
      end;


    constructor Exception.CreateFmtHelp(const Msg: string; const Args: array of const;
      AHelpContext: Longint);

    begin
       inherited create;
       fmessage:=Format(Msg,args);
       fhelpcontext:=AHelpContext;
    end;


    constructor Exception.CreateResHelp(ResString: PResStringRec; AHelpContext: Longint);

    begin
       inherited create;
       fmessage:=ResString^;
       fhelpcontext:=AHelpContext;
    end;


    constructor Exception.CreateResFmtHelp(ResString: PResStringRec; const Args: array of const;
      AHelpContext: Longint);

    begin
       inherited create;
       fmessage:=Format(ResString^,args);
       fhelpcontext:=AHelpContext;
    end;

    Function Exception.ToString : RTLString;
    begin
      Result:=ClassName+': '+Message;
    end;

Var OutOfMemory : EOutOfMemory;
    InValidPointer : EInvalidPointer;

    procedure EHeapMemoryError.FreeInstance;
    begin
       if (pointer(self)<>pointer(OutOfMemory)) and (pointer(self)<>pointer(InvalidPointer)) then
         inherited FreeInstance;
    end;


    function Exception.GetBaseException : Exception;
      var
        _ExceptObjectStack : PExceptObject;
      begin
        _ExceptObjectStack:=RaiseList;
        While Assigned(_ExceptObjectStack) do
          begin
            result:=Exception(_ExceptObjectStack^.FObject);
            _ExceptObjectStack:=_ExceptObjectStack^.Next;
          end;
      end;


    Constructor EVariantError.CreateCode (Code : longint);
    begin
       case Code of
         VAR_OK:
           Create(SNoError);
         VAR_PARAMNOTFOUND:
           Create(SVarParamNotFound);
         VAR_TYPEMISMATCH:
           Create(SInvalidVarCast);
         VAR_BADVARTYPE:
           Create(SVarBadType);
         VAR_OVERFLOW:
           Create(SVarOverflow);
         VAR_BADINDEX:
           Create(SVarArrayBounds);
         VAR_ARRAYISLOCKED:
           Create(SVarArrayLocked);
         VAR_NOTIMPL:
           Create(SVarNotImplemented);
         VAR_OUTOFMEMORY:
           Create(SVarOutOfMemory);
         VAR_INVALIDARG:
           Create(SVarInvalid);
         VAR_UNEXPECTED,
         VAR_EXCEPTION:
           Create(SVarUnexpected);
         else
           CreateFmt(SUnknownErrorCode,[Code]);
       end;
       ErrCode:=Code;
    end;


constructor EInOutArgumentException.Create(const aMsg, aPath: string); overload;

begin
  Path:=aPath;
  Inherited Create(aMsg);
end;

constructor EInOutArgumentException.CreateRes(ResStringRec: PResStringRec; const aPath: string); overload;

begin
  Path:=aPath;
  Inherited CreateRes(ResStringRec);
end;

constructor EInOutArgumentException.CreateFmt(const fmt: string;  const args : array of const; const aPath : String);

begin
  Path:=aPath;
  inherited CreateFmt(fmt,args);
end;

{$if defined(win32) or defined(win64) or defined (wince)}
function EExternal.GetExceptionRecord: PExceptionRecord;
begin
  result:=@FExceptionRecord;
end;

{$endif win32 or win64 or wince}

{$push}
{$S-}
Procedure CatchUnhandledException (Obj : TObject; Addr: CodePointer; FrameCount: Longint; Frames: PCodePointer);[public,alias:'FPC_BREAK_UNHANDLED_EXCEPTION'];
Var
  i : longint;
  hstdout : ^text;

begin
  if WriteErrorsToStdErr then
    hstdout:=@stderr
  else
    hstdout:=@stdout;
  Writeln(hstdout^,'An unhandled exception occurred at $',HexStr(Addr),':');
  if Obj is exception then
    Writeln(hstdout^,Obj.ClassName,': ',Exception(Obj).Message)
  else if Obj is TObject then
    Writeln(hstdout^,'Exception object ',Obj.ClassName,' is not of class Exception.')
  else
    Writeln(hstdout^,'Exception object is not a valid class.');
{$IFDEF HAS_OSERROR}
 {$IFDEF DEBUG_EXCEPTIONS_LASTOSERROR}
  WriteLn (HStdOut^, 'Last OS error detected in the RTL: ', GetLastOSError);
 {$ENDIF DEBUG_EXCEPTIONS_LASTOSERROR}
{$ENDIF HAS_OSERROR}
  Writeln(hstdout^,BackTraceStrFunc(Addr));
  if (FrameCount>0) then
    begin
      for i:=0 to FrameCount-1 do
        Writeln(hstdout^,BackTraceStrFunc(Frames[i]));
    end;
  Writeln(hstdout^,'');
end;

type
  PExceptMapEntry=^TExceptMapEntry;
  TExceptMapEntry=record
    code: byte;
    cls:  ExceptClass;
{$IFDEF FPC_HAS_FEATURE_RESOURCES}  // This is necessary for 2.4.4, which does not have reasources as a separate feature
    msg:  PResStringRec;
{$else FPC_HAS_FEATURE_RESOURCES}
    msg:  PAnsiString;
{$endif FPC_HAS_FEATURE_RESOURCES}
  end;

const
  exceptmap: array[0..30] of TExceptMapEntry = (
    (code: 200; cls: EDivByZero;     msg: @SDivByZero),
    (code: 201; cls: ERangeError;    msg: @SRangeError),
    (code: 202; cls: EStackOverflow; msg: @SStackOverflow),
    (code: 205; cls: EOverflow;      msg: @SOverflow),
    (code: 206; cls: EUnderflow;     msg: @SUnderflow),
    (code: 207; cls: EInvalidOp;     msg: @SInvalidOp),
    { Delphi distinguishes reDivByZero from reZeroDivide, but maps both to code 200. }
    (code: 208; cls: EZeroDivide;    msg: @SZeroDivide),
    (code: 210; cls: EObjectCheck;   msg: @SObjectCheckError),
    (code: 211; cls: EAbstractError; msg: @SAbstractError),
    (code: 212; cls: EExternalException; msg: @SExternalException),
    (code: 214; cls: EBusError;      msg: @SBusError),
    (code: 215; cls: EIntOverflow;   msg: @SIntOverflow),
    (code: 216; cls: EAccessViolation; msg: @SAccessViolation),
    (code: 217; cls: EControlC;      msg: @SControlC),
    (code: 218; cls: EPrivilege;     msg: @SPrivilege),
    (code: 219; cls: EInvalidCast;   msg: @SInvalidCast),
    (code: 220; cls: EVariantError;  msg: @SInvalidVarCast),
    (code: 221; cls: EVariantError;  msg: @SInvalidVarOp),
    (code: 222; cls: EVariantError;  msg: @SDispatchError),
    (code: 223; cls: EVariantError;  msg: @SVarArrayCreate),
    (code: 224; cls: EVariantError;  msg: @SVarNotArray),
    (code: 225; cls: EVariantError;  msg: @SVarArrayBounds),
    (code: 227; cls: EAssertionFailed; msg: @SAssertionFailed),
    (code: 228; cls: EIntfCastError; msg: @SIntfCastError),
    (code: 229; cls: ESafecallException; msg: @SSafecallException),
    (code: 231; cls: EConvertError;  msg: @SiconvError),
    (code: 232; cls: ENoThreadSupport; msg: @SNoThreadSupport),
    (code: 233; cls: ESigQuit; msg: @SSigQuit),
    (code: 234; cls: ENoWideStringSupport; msg: @SMissingWStringManager),
    (code: 235; cls: ENoDynLibsSupport; msg: @SNoDynLibsSupport),
    (code: 236; cls: EThreadError; msg: @SThreadError)
  );

function FindExceptMapEntry(err: longint): PExceptMapEntry;
var
  i: longint;
begin
  for i:=low(exceptmap) to high(exceptmap) do
    if err=exceptmap[i].code then
    begin
      result:=@exceptmap[i];
      exit;
    end;
  result:=nil;
end;

Procedure RunErrorToExcept (ErrNo : Longint; Address : CodePointer; Frame : Pointer);
var
  E: Exception;
  HS: PResStringRec;
  Entry: PExceptMapEntry;
begin
  Case Errno of
   1,203 : E:=OutOfMemory;
   204 : E:=InvalidPointer;
  else
    Entry:=FindExceptMapEntry(ErrNo);
    if Assigned(Entry) then
      E:=Entry^.cls.CreateRes(Entry^.msg)
    else
    begin
     HS:=nil;
     Case Errno of
       2 : HS:=@SFileNotFound;
       3 : HS:=@SInvalidFileName;
       4 : HS:=@STooManyOpenFiles;
       5 : HS:=@SAccessDenied;
       6 : HS:=@SInvalidFileHandle;
       15 : HS:=@SInvalidDrive;
       100 : HS:=@SEndOfFile;
       101 : HS:=@SDiskFull;
       102 : HS:=@SFileNotAssigned;
       103 : HS:=@SFileNotOpen;
       104 : HS:=@SFileNotOpenForInput;
       105 : HS:=@SFileNotOpenForOutput;
       106 : HS:=@SInvalidInput;
     end;
     if Assigned(HS) then
       E:=EInOutError.CreateRes(HS)
     else
       E:=EInOutError.CreateResFmt(@SUnknownRunTimeError,[errno]);
     // this routine can be called from FPC_IOCHECK,
     // which clears inoutres and then passes its
     // original value to HandleErrorFrame() (which calls
     // us). So use errno rather than IOResult, and clear
     // InOutRes explicitly in case we can also be called
     // from a place that does not clear InOutRes explicitly
     EInoutError(E).ErrorCode:=errno;
     inoutres:=0;
     end;
  end;
  Raise E at Address,Frame;
end;

{$IFDEF HAS_OSERROR}
Procedure RaiseLastOSError;overload;
begin
  RaiseLastOSError(GetLastOSError);
end;

Procedure RaiseLastOSError(LastError: Integer);overload;
var
  E : EOSError;
begin
  If (LastError<>0) then
    E:=EOSError.CreateFmt(SOSError, [LastError, SysErrorMessage(LastError)])
  else
    E:=EOSError.Create(SUnkOSError);
  E.ErrorCode:=LastError;
  Raise E;
end;

{$else}
Procedure RaiseLastOSError;overload;
begin
  Raise Exception.Create('RaiseLastOSError not implemented on this platform.');
end;

Procedure RaiseLastOSError(LastError: Integer);overload;
begin
  RaiseLastOSError;
end;

{$endif}

procedure CheckOSError(LastError: Integer);
begin
  if LastError <> 0 then
    RaiseLastOSError(LastError);
end;

Procedure AssertErrorHandler (Const Msg,FN : ShortString;LineNo:longint; TheAddr : pointer);
Var
  S : String;
begin
  If Msg='' then
    S:=SAssertionFailed
  else
    S:=Msg;
  Raise EAssertionFailed.Createfmt(SAssertError,[S,Fn,LineNo]) at get_caller_addr(theAddr), get_caller_frame(theAddr);
end;

{$pop} //{$S-} for Error handling functions

procedure RangeIndexError(aIndex, aMaxIndex: SizeInt; aListObj: TObject);

begin
  raise ERangeError.Create(ListIndexErrorMsg(aIndex,aMaxIndex,aListObj));
end;

Procedure InitExceptions;
{
  Must install uncaught exception handler (ExceptProc)
  and install exceptions for system exceptions or signals.
  (e.g: SIGSEGV -> ESegFault or so.)
}
begin
  ExceptionClass := Exception;
  ExceptProc:=@CatchUnhandledException;
  // Create objects that may have problems when there is no memory.
  OutOfMemory:=EOutOfMemory.Create(SOutOfMemory);
  InvalidPointer:=EInvalidPointer.Create(SInvalidPointer);
  AssertErrorProc:=@AssertErrorHandler;
  ErrorProc:=@RunErrorToExcept;
  OnShowException:=Nil;
end;


Procedure DoneExceptions;
begin
  FreeAndNil(OutOfMemory); { These will automatically work as they first set pointer to nil, then free the object. See EHeapMemoryError.FreeInstance. }
  FreeAndNil(InValidPointer);
end;


{ Exception handling routines }

function ExceptObject: TObject;

begin
  If RaiseList=Nil then
    Result:=Nil
  else
    Result:=RaiseList^.FObject;
end;

function ExceptAddr: CodePointer;

begin
  If RaiseList=Nil then
    Result:=Nil
  else
    Result:=RaiseList^.Addr;
end;

function ExceptFrameCount: Longint;

begin
  If RaiseList=Nil then
    Result:=0
  else
    Result:=RaiseList^.Framecount;
end;

function ExceptFrames: PCodePointer;

begin
  If RaiseList=Nil then
    Result:=Nil
  else
    Result:=RaiseList^.Frames;
end;

function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
                               Buffer: PAnsiChar; Size: Integer): Integer;

Var
  S : AnsiString;
  Len : Integer;

begin
  S:=Format(SExceptionErrorMessage,[ExceptAddr,ExceptObject.ClassName]);
  If ExceptObject is Exception then
    S:=Format('%s:'#10'%s',[S,Exception(ExceptObject).Message]);
  Len:=Length(S);
  If S[Len]<>'.' then
    begin
    S:=S+'.';
    Inc(len);
    end;
  If Len>Size then
    Len:=Size;
  if Len > 0 then
    Move(S[1],Buffer^,Len);
  Result:=Len;
end;

procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);

// use shortstring. On exception, the heap may be corrupt.

Var
  Buf : ShortString;

begin
  SetLength(Buf,ExceptionErrorMessage(ExceptObject,ExceptAddr,@Buf[1],255));
  If IsConsole Then
    writeln(Buf)
  else
    If Assigned(OnShowException) Then
      OnShowException (Buf);
end;

procedure Abort;

begin
  Raise EAbort.Create(SAbortError) at CodePointer(Get_Caller_addr(Get_Frame));
end;

procedure OutOfMemoryError;

begin
  Raise OutOfMemory;
end;

function ListIndexErrorMsg(aIndex, aMaxIndex: SizeInt; const aListObjName: string): string; overload;

begin
  if aMaxIndex<0 then
    Result:=Format(SListIndexErrorEmptyReason,[aListObjName])
  else
    Result:=Format(SListIndexErrorRangeReason,[aListObjName]);
  Result:=Format(SListIndexError, [aIndex])+Result;
end;

function ListIndexErrorMsg(AIndex, AMaxIndex: SizeInt; AListObj: TObject): string; overload;

Var
  aName : string;

begin
  if Assigned(aListObj) then
   Result:=aListObj.ClassName
 else
   Result:='<Nil>';
  Result:=ListIndexErrorMsg(aIndex, aMaxIndex, aName);
end;

procedure ListIndexError(aIndex,aMax: Integer; aObj: TObject);

var
 aClassName : string;

begin
  if Assigned(aObj) then
    aClassName:=aObj.ClassName
  else
    aClassName:='<nil>';
  Raise EListError.CreateFmt(SErrListIndexExt,[aIndex,aClassName,aMax])
end;


{ ---------------------------------------------------------------------
    Initialization/Finalization/exit code
  ---------------------------------------------------------------------}

Type
  PPRecord = ^TPRecord;
  TPRecord = Record
    Func : TTerminateProc;
    NextFunc : PPRecord;
  end;

Const
  TPList : PPRecord = Nil;

procedure AddTerminateProc(TermProc: TTerminateProc);

Var
  TPR : PPRecord;

begin
  New(TPR);
  With TPR^ do
    begin
    NextFunc:=TPList;
    Func:=TermProc;
    end;
  TPList:=TPR;
end;

function CallTerminateProcs: Boolean;

Var
  TPR : PPRecord;

begin
  Result:=True;
  TPR:=TPList;
  While Result and (TPR<>Nil) do
    begin
    Result:=TPR^.Func();
    TPR:=TPR^.NextFunc;
    end;
end;

procedure FreeTerminateProcs;
var
  TPR1, TPR2: PPRecord;
begin
  TPR1 := TPList;
  TPList := Nil;
  while Assigned(TPR1) do begin
    TPR2 := TPR1^.NextFunc;
    Dispose(TPR1);
    TPR1 := TPR2;
  end;
end;

{ ---------------------------------------------------------------------
    Diskh functions, OS independent.
  ---------------------------------------------------------------------}

Function GetCurrentDir: {$ifdef FPC_UNICODE_RTL}UnicodeString{$else}AnsiString{$endif};
begin
  GetDir(0,Result);
end;

{ ---------------------------------------------------------------------
    Other functions, OS independent.
  ---------------------------------------------------------------------}

Var
  GUIDCalledRandomize : Boolean = False;

Procedure GetRandomBytes(Var Buf; NBytes : Integer);

Var
  I : Integer;
  P : PByte;

begin
  P:=@Buf;
  If Not GUIDCalledRandomize then
    begin
    Randomize;
    GUIDCalledRandomize:=True;
    end;
  For I:=0 to NBytes-1 do
    P[i]:=Random(256);
end;

{$IFDEF HASCREATEGUID}
Function SysCreateGUID(out GUID : TGUID) : Integer; forward;
{$ENDIF}

Function CreateGUID(out GUID : TGUID) : Integer;
begin
  If Assigned(OnCreateGUID) then
    Result:=OnCreateGUID(GUID)
  else
    begin
    {$IFDEF HASCREATEGUID}
    Result:=SysCreateGUID(GUID);
    {$ELSE}
    GetRandomBytes(GUID,SizeOf(Guid));
    guid.clock_seq_hi_and_reserved:=(guid.clock_seq_hi_and_reserved and $3F) + 64;
    guid.time_hi_and_version      :=(guid.time_hi_and_version and $0FFF)+ $4000;
    Result:=0;
    {$ENDIF}
    end;
end;


function SafeLoadLibrary(const FileName: AnsiString; ErrorMode: DWord = {$ifdef windows}SEM_NOOPENFILEERRORBOX{$else windows}0{$endif windows}): HMODULE;

{$if defined(win64) or defined(win32)}
var
  mode : DWord;

begin
  mode:=SetErrorMode(ErrorMode);
  try
    Result:=System.SafeLoadLibrary(FileName);
  finally
    SetErrorMode(mode);
  end;
end;
{$else}
begin
{$ifdef FPC_HAS_FEATURE_DYNLIBS}
  Result:=System.SafeLoadLibrary(FileName);
{$else}
  Result:=HModule(nil);
{$endif not FPC_HAS_FEATURE_DYNLIBS}
end;
{$endif}

{$if defined(win32) or defined(win64) or defined(wince)}
function GetModuleName(Module: HMODULE): string;
var
  ResultLength, BufferLength: DWORD;
  Buffer: UnicodeString;
begin
  BufferLength := MAX_PATH div 2;
  repeat
    Inc(BufferLength, BufferLength);
    SetLength(Buffer, BufferLength);
    ResultLength := GetModuleFileNameW(Module, Pointer(Buffer), BufferLength);
    if ResultLength = 0 then
      Exit('');
  until ResultLength < BufferLength;
  SetLength(Buffer, ResultLength);
  Result := Buffer;
end;
{$elseif defined(win16)}
function GetModuleName(Module: HMODULE): string;
var
  ResultLength, BufferLength: DWORD;
  Buffer: RawByteString;
begin
  BufferLength := MAX_PATH div 2;
  repeat
    Inc(BufferLength, BufferLength);
    SetLength(Buffer, BufferLength);
    ResultLength := GetModuleFileName(Module, FarAddr(Buffer[1]), BufferLength);
    if ResultLength = 0 then
      Exit('');
  until ResultLength < BufferLength;
  SetLength(Buffer, ResultLength);
  Result := Buffer;
end;
{$else}
function GetModuleName(Module: HMODULE): string;
begin
  Result:='';
end;
{$endif}

{ Beep support }

procedure Beep;
begin
  If Assigned(OnBeep) then
    OnBeep;
end;

// OSes that only provide 1 byte versions can enable the following define
{$ifdef executeprocuni}
function ExecuteProcess(Const Path: UnicodeString; Const ComLine: UnicodeString;Flags:TExecuteFlags=[]):integer;
begin
  result:=ExecuteProcess(ToSingleByteFileSystemEncodedFileName(Path),ToSingleByteFileSystemEncodedFileName(ComLine));
end;

function ExecuteProcess(Const Path: UnicodeString; Const ComLine: Array of UnicodeString;Flags:TExecuteFlags=[]):integer;
var
  ComLineA : array of RawByteString;
  I        : Integer;
begin
  SetLength(ComLineA,high(comline)-low(comline)+1);
  For I:=0 to length(ComLineA)-1 Do
    ComLineA[i]:=ToSingleByteFileSystemEncodedFileName(ComLine[I]);
  result:=ExecuteProcess(ToSingleByteFileSystemEncodedFileName(Path),ComLineA);
end;
{$endif}


// generic ifthen..
generic function IfThen<T>(val:boolean;const iftrue:T; const iffalse:T) :T; inline; overload;
begin
  if val then
    Result := ifTrue
  else
    Result:=ifFalse;
end;

generic function Exchange<T>(var target:T; const newvalue:T) :T;
begin
  Result := target;
  target := newvalue;
end;

generic function Extract<T>(var from: T) :T;
type
  RawT = array[0 .. sizeof(T) - 1] of byte;
begin
  Finalize(Result);
  RawT(Result):=RawT(from);
  Initialize(from);
end;

generic procedure Swap<T>(var lhs,rhs: T);
type
  RawT = array[0 .. sizeof(T) - 1] of byte;
var
  tmp:RawT;
begin
  tmp:=RawT(lhs);
  RawT(lhs):=RawT(rhs);
  RawT(rhs):=tmp;
end;

Function ArrayOfConstToStrArray(const Args: array of const) : TUTF8StringDynArray;

var
  i: Integer;
  O : TObject;
  C : TClass;
  S : String;

begin
  SetLength(Result,Length(Args));
  for i:=Low(Args) to High(Args) do
    case Args[i].VType of
      vtInteger:      Result[i]:=IntToStr(Args[i].VInteger);
      vtBoolean:      Result[i]:=BoolToStr(Args[i].VBoolean);
      vtChar:         Result[i] := Args[i].VChar;
      {$ifndef FPUNONE}
      vtExtended:     Result[i]:= FloatToStr(Args[i].VExtended^);
      {$ENDIF}
      vtString:       Result[i] := Args[i].VString^;
      vtPointer:      Result[i] := '0x'+HexStr(PtrInt(Args[i].VPointer),SizeOF(PtrInt));
      vtPChar:        Result[i] := Args[i].VPChar;
      vtObject:
        begin
        O:=Args[i].VObject;
        if Assigned(O) then
          begin
          try
            S:=O.ClassName;
          except
            S:='<Invalid instance>';
          end;
          end
        else
          S:='';
        Result[I] := '<Object '+S+' 0x'+HexStr(PtrInt(O),SizeOF(PtrInt))+'>';
        end;
      vtClass:
        begin
        C:=Args[i].VClass;
        if Assigned(C) then
          begin
          try
            S:=C.ClassName;
          except
            S:='<Invalid Class>';
          end;
          end
        else
          S:='';
        Result[I] := '<Class '+S+' 0x'+HexStr(PtrInt(C),SizeOF(PtrInt))+'>';
        end;
      vtWideChar:     Result[i] := UTF8Encode(Args[i].VWideChar);
      vtPWideChar:    Result[i] := UTF8Encode(Args[i].VPWideChar^);
      vtAnsiString:   Result[i] := AnsiString(Args[i].VAnsiString);
      vtCurrency:     Result[i] := FLoatToSTr(Args[i].VCurrency^);
      vtVariant:      Result[i] := Args[i].VVariant^;
      vtInterface:    Result[I] := '<Interface 0x'+HexStr(PtrInt(Args[i].VInterface),SizeOF(PtrInt))+'>';
      vtWidestring:   Result[i] := UTF8ENcode(WideString(Args[i].VWideString));
      vtInt64:        Result[i] := IntToStr(Args[i].VInt64^);
      vtQWord:        Result[i] := IntToStr(Args[i].VQWord^);
      vtUnicodeString:Result[i] := UTF8Encode(UnicodeString(Args[i].VUnicodeString));
    end;
end;

Function ArrayOfConstToStr(const Args: array of const ; aSeparator : Char = ','; aQuoteBegin : Char = '"'; aQuoteEnd : Char = '"') : UTF8String;

  Procedure Add(s: UTF8String);

  begin
    if aQuoteBegin<>#0 then
      S:=aQuoteBegin+S;
    if aQuoteEnd<>#0 then
      S:=S+aQuoteEnd;
    if Result<>'' then
      Result:=Result+aSeparator;
    Result:=Result+S;
  end;


Var
  S : UTF8String;

begin
  Result:='';
  For S in ArrayOfConstToStrArray(Args) do
    Add(S);
end;

Function GetCompiledArchitecture : TOSVersion.TArchitecture;

begin
  Result:=arOther;
  {$ifdef i386}
  Result:=arIntelX86;
  {$endif i386}

  {$ifdef m68k}
  Result:=arM68k;
  {$endif m68k}

  {$ifdef powerpc}
  Result:=arPowerPC
  {$endif powerpc}

  {$ifdef powerpc64}
  Result:=arPower64
  {$endif powerpc64}

  {$ifdef arm}
  Result:=arARM32;
  {$endif arm}

  {$ifdef aarch64}
  Result:=arARM64
  {$endif aarch64}

  {$ifdef sparc}
  Result:=arSparc;
  {$endif sparc}

  {$ifdef sparc64}
  Result:=arSparc64;
  {$endif sparc64}

  {$ifdef CPUX86_64}
  Result:=arIntelX64;
  {$endif x86_64}

  {$ifdef mipsel}
  Result:=arMipsel
  {$else : not mipsel}
    {$ifdef mips}
      Result:=arMips;
    {$endif mips}
  {$endif not mipsel}

  {$ifdef riscv32}
  Result:=arRiscV32;
  {$endif riscv32}

  {$ifdef riscv64}
  Result:=arRiscV64;
  {$endif riscv64}

  {$ifdef xtensa}
  Result:=arXtensa;
  {$endif xtensa}

  {$ifdef wasm32}
  Result:=arWasm32;
  {$endif wasm32}

  {$ifdef loongarch64}
  Result:=arLoongArch64;
  {$endif loongarch64}
end;

Function GetCompiledPlatform : TOSVersion.TPlatform;

begin
  Result:=pfOther;
  {$IFDEF WINDOWS}
  Result:=pfWindows;
  {$ENDIF}
  {$Ifdef darwin}
  Result:=pfMacOS;
  {$ENDIF}
  {$IFDEF IOS}
  Result:=pfiOS;
  {$ENDIF}
  {$IFDEF ANDROID}
  Result:=pfAndroid;
  {$ENDIF}
  {$IFDEF LINUX}
  Result:=pfLinux;
  {$ENDIF}
  {$IFDEF GO32V2}
  Result:=pfGo32v2;
  {$ENDIF}
  {$IFDEF OS2}
  Result:=pfOS2;
  {$ENDIF}
  {$IFDEF FREEBSD}
  Result:=pfFreeBSD;
  {$ENDIF}
  {$IFDEF BEOS}
  Result:=pfBeos;
  {$ENDIF}
  {$IFDEF NETBSD}
  Result:=pfNetBSD;
  {$ENDIF}
  {$IFDEF AMIGA}
  Result:=pfAmiga;
  {$ENDIF}
  {$IFDEF ATARI}
  Result:=pfAtari;
  {$ENDIF}
  {$IFDEF SUNOS}
  Result:=pfSolaris;
  {$ENDIF}
  {$IFDEF QNX}
  Result:=pfQNX;
  {$ENDIF}
  {$IFDEF Netware}
  Result:=pfNetware;
  {$ENDIF}
  {$IFDEF OpenBSD}
  Result:=pfOpenBSD;
  {$ENDIF}
  {$IFDEF WDosX}
  Result:=pfWDosX;
  {$ENDIF}
  {$IFDEF PALMOS}
  Result:=pfPalmos;
  {$ENDIF}
  {$IFDEF MacOSClassic}
  Result:=pfMacOSClassic;
  {$ENDIF}
  {$IFDEF DARWIN}
  Result:=pfDarwin;
  {$ENDIF}
  {$IFDEF EMX}
  Result:=pfEMX;
  {$ENDIF}
  {$IFDEF WATCOM}
  Result:=pfWatcom;
  {$ENDIF}
  {$IFDEF MORPHOS}
  Result:=pfMorphos;
  {$ENDIF}
  {$IFDEF NETWLIBC}
  Result:=pfNetwLibC;
  {$ENDIF}
  {$IFDEF WINCE}
  Result:=pfWinCE;
  {$ENDIF}
  {$IFDEF GBA}
  Result:=pfGBA;
  {$ENDIF}
  {$IFDEF NDS}
  Result:=pfNDS;
  {$ENDIF}
  {$IFDEF EMBEDDED}
  Result:=pfEmbedded;
  {$ENDIF}
  {$IFDEF SYMBIAN}
  Result:=pfSymbian;
  {$ENDIF}
  {$IFDEF HAIKU}
  Result:=pfHaiku;
  {$ENDIF}
  {$IFDEF IPHONESIM}
  Result:=pfIPhoneSim;
  {$ENDIF}
  {$IFDEF AIX}
  Result:=pfAIX;
  {$ENDIF}
  {$IFDEF JAVA}
  Result:=pfJava;
  {$ENDIF}
  {$IFDEF NATIVENT}
  Result:=pfNativeNT;
  {$ENDIF}
  {$IFDEF MSDOS}
  Result:=pfMSDos;
  {$ENDIF}
  {$IFDEF WII}
  Result:=pfWII;
  {$ENDIF}
  {$IFDEF AROS}
  Result:=pfAROS;
  {$ENDIF}
  {$IFDEF DRAGONFLY}
  Result:=pfDragonFly;
  {$ENDIF}
  {$IFDEF WIN16}
  Result:=pfWin16;
  {$ENDIF}
  {$IFDEF FREERTOS}
  Result:=pfFreeRTOS;
  {$ENDIF}
  {$IFDEF ZXSPECTRUM}
  Result:=pfZXSpectrum;
  {$ENDIF}
  {$IFDEF MSXDOS}
  Result:=pfMSXDOS;
  {$ENDIF}
  {$IFDEF AMSTRADCPC}
  Result:=pfAmstradCPC;
  {$ENDIF}
  {$IFDEF SINCLAIRQL}
  Result:=pfSinclairQL;
  {$ENDIF}
  {$IFDEF WASI}
  Result:=pfWasi;
  {$ENDIF}
end;

class constructor TOSVersion.Create;

{$IFNDEF HAS_OSVERSION}
var
  S : String;
{$ENDIF}
begin
  FArchitecture:=GetCompiledArchitecture;
  FPlatform:=GetCompiledPlatform;
  FBuild:=0;
  FMajor:=0;
  FMinor:=0;
  FServicePackMajor:=0;
  FServicePackMinor:=0;
{$IFDEF HAS_OSVERSION}
  InitOSVersion;
{$ELSE}
  WriteStr(S,GetCompiledPlatform);
  FName:=Copy(S,3);
  WriteStr(S,GetCompiledArchitecture);
  FFull:=Copy(S,3)+'-'+FName;
{$ENDIF}
end;

class function TOSVersion.Check(aMajor: Integer): Boolean; overload; static; inline;

begin
  Result:=(Major>=aMajor);
end;


class function TOSVersion.Check(aMajor, aMinor: Integer): Boolean; overload; static; inline;

begin
 Result:=(Major>aMajor)
         or ((Major=aMajor) and (Minor>=aMinor))
end;


class function TOSVersion.Check(aMajor, aMinor, aServicePackMajor: Integer): Boolean; overload; static; inline;

begin
  Result:=(Major>AMajor)
          or ((Major=aMajor) and (Minor>aMinor))
          or ((Major=aMajor) and (Minor=aMinor) and (ServicePackMajor>=aServicePackMajor));
end;


class function TOSVersion.ToString: string; static;

begin
  Result:=FFull;
end;


