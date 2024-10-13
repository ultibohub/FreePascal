unit system;
interface

{$define FPC_IS_SYSTEM}

{$DEFINE FPCRTL_FILESYSTEM_SINGLE_BYTE_API}

{$I systemh.inc}

{$ifndef FPUNONE}
{$ifdef FPC_HAS_FEATURE_SOFTFPU}

{$define fpc_softfpu_interface}
{$i softfpu.pp}
{$undef fpc_softfpu_interface}

{$endif FPC_HAS_FEATURE_SOFTFPU}

{$endif FPUNONE}

const
    maxExitCode = 255;
    AllowDirectorySeparators : set of AnsiChar = ['\','/'];
    DirectorySeparator = '/';
  { Default filehandles }
    UnusedHandle    = $ffff;{ instead of -1, as it is a word value}
    StdInputHandle  = 0;
    StdOutputHandle = 1;
    StdErrorHandle  = 2;
    CtrlZMarksEOF: boolean = true; (* #26 is considered as end of file *)
    DefaultTextLineBreakStyle : TTextLineBreakStyle = tlbsLF;
    LineEnding = #10;
    PathSeparator = '/';
    MaxPathLen = 255;
    LFNSupport = true;
    FileNameCaseSensitive = true;
    sLineBreak = #10;
    AllFilesMask = '*';

var
  argc:longint=0;
  argv:PPAnsiChar;
  envp:PPAnsiChar;

implementation

var
  StkLen: SizeUInt; external name '__stklen';
  bss_end: record end; external name '__bss_end__';

procedure _InitHeap(p: pdword; l: dword); external name 'InitHeap2';
procedure _free(p: pointer); external name 'free2';
function _malloc(l: dword): pointer; external name 'malloc2';
procedure _putchar(ch: char); external name 'putchar';

{I ../mips/setjump.inc}
{$I system.inc}

{$ifndef FPUNONE}
{$ifdef FPC_HAS_FEATURE_SOFTFPU}

{$define fpc_softfpu_implementation}
{$i softfpu.pp}
{$undef fpc_softfpu_implementation}

{ we get these functions and types from the softfpu code }
{$define FPC_SYSTEM_HAS_float64}
{$define FPC_SYSTEM_HAS_float32}
{$define FPC_SYSTEM_HAS_flag}
{$define FPC_SYSTEM_HAS_extractFloat64Frac0}
{$define FPC_SYSTEM_HAS_extractFloat64Frac1}
{$define FPC_SYSTEM_HAS_extractFloat64Exp}
{$define FPC_SYSTEM_HAS_extractFloat64Frac}
{$define FPC_SYSTEM_HAS_extractFloat64Sign}
{$define FPC_SYSTEM_HAS_ExtractFloat32Frac}
{$define FPC_SYSTEM_HAS_extractFloat32Exp}
{$define FPC_SYSTEM_HAS_extractFloat32Sign}

{$endif FPC_HAS_FEATURE_SOFTFPU}
{$endif FPUNONE}

procedure Randomize;
begin
  randseed:= 1234;
end;

function GetProcessID: LongWord;
begin
  result:= 0;
end;

function ParamCount: LongInt;
begin
  ParamCount:= 0;
end;

function ParamStr(l: LongInt): ShortString;
begin
  result:='';
end;

procedure SysInitStdIO;
begin
  OpenStdIO(Input,fmInput,StdInputHandle);
  OpenStdIO(Output,fmOutput,StdOutputHandle);
  OpenStdIO(ErrOutput,fmOutput,StdErrorHandle);
  OpenStdIO(StdOut,fmOutput,StdOutputHandle);
  OpenStdIO(StdErr,fmOutput,StdErrorHandle);
end;

function CheckInitialStkLen(stklen : SizeUInt) : SizeUInt;
const
  MinHeap = 1024;  // always leave at least 1k heap
var
  MaxStack: SizeInt;
begin
  MaxStack:=SizeInt(PtrUInt($80200000)-PtrUInt(@bss_end))-MinHeap;
  if stklen<MaxStack then
    result:= stklen
  else
    result:=MaxStack;
end;

procedure system_exit;
begin
  repeat
  until false;
end;


begin
  StackLength:=CheckInitialStkLen(stklen);
  StackBottom:=Pointer(PtrUInt($80200000)-PtrUInt(StackLength));

  { Debug printing via writeln (visible in emulator logs) is possible, so
    pretend to be a console application. }
  IsConsole := TRUE;
  { To be set if this is a library and not a program  }
  IsLibrary := FALSE;

  { Setup heap }
  _InitHeap(pdword(@bss_end),PtrUInt(StackBottom)-PtrUInt(@bss_end));
  InitHeap;

  { Init exceptions }
  SysInitExceptions;

  { Init unicode strings }
  initunicodestringmanager;

  { Setup stdin, stdout and stderr }
  SysInitStdIO;

  { Reset IO Error }
  InOutRes:= 0;

{$ifdef FPC_HAS_FEATURE_THREADING}
  { Initialize the thread manager }
  InitSystemThreads;
{$endif}
end.
