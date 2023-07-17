{
    Copyright (c) 2015 by Nikolay Nikolov
    Copyright (c) 1998 by Peter Vreman

    This is a replacement for GDBCon, implemented on top of GDB/MI,
    instead of LibGDB. This allows integration of GDB/MI support in the
    text mode IDE.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

unit gdbmicon;

{$MODE fpc}{$H-}

{$I globdir.inc}

interface

uses
  gdbmiint, gdbmiwrap;

type
  TBreakpointFlags = set of (bfTemporary, bfHardware);
  TWatchpointType = (wtWrite, wtReadWrite, wtRead);
  TPrintFormatType = (pfbinary, pfdecimal, pfhexadecimal, pfoctal, pfnatural);

  TGDBController = object(TGDBInterface)
  private
    FRegisterNames: array of AnsiString;
    procedure UpdateRegisterNames;
    function GetGdbRegisterNo(const RegName: string): LongInt;
    function GetRegisterAsString(const RegName, Format: string; var Value: string): Boolean;
    procedure RunExecCommand(const Cmd: string);
  protected
    TBreakNumber,
    start_break_number: LongInt;
    in_command: LongInt;

    procedure CommandBegin(const s: string); virtual;
    procedure CommandEnd(const s: string); virtual;

  public
    constructor Init;
    destructor Done;

    procedure Command(const s: string);
    procedure Reset; virtual;
    { tracing }
    procedure StartTrace;
    procedure Run; virtual;
    procedure TraceStep;
    procedure TraceNext;
    procedure TraceStepI;
    procedure TraceNextI;
    procedure Continue; virtual;
    procedure UntilReturn; virtual;
    { registers }
    function GetIntRegister(const RegName: string; var Value: UInt64): Boolean;
    function GetIntRegister(const RegName: string; var Value: Int64): Boolean;
    function GetIntRegister(const RegName: string; var Value: UInt32): Boolean;
    function GetIntRegister(const RegName: string; var Value: Int32): Boolean;
    function GetIntRegister(const RegName: string; var Value: UInt16): Boolean;
    function GetIntRegister(const RegName: string; var Value: Int16): Boolean;
    { set command }
    function SetCommand(Const SetExpr : string) : boolean;
    { print }
    function PrintCommand(const expr : string): AnsiString;
    function PrintFormattedCommand(const expr : string; Format : TPrintFormatType): AnsiString;
    { breakpoints }
    function BreakpointInsert(const location: string; BreakpointFlags: TBreakpointFlags): LongInt;
    function WatchpointInsert(const location: string; WatchpointType: TWatchpointType): LongInt;
    function BreakpointDelete(BkptNo: LongInt): Boolean;
    function BreakpointEnable(BkptNo: LongInt): Boolean;
    function BreakpointDisable(BkptNo: LongInt): Boolean;
    function BreakpointCondition(BkptNo: LongInt; const ConditionExpr: string): Boolean;
    function BreakpointSetIgnoreCount(BkptNo: LongInt; const IgnoreCount: LongInt): Boolean;
    procedure SetTBreak(tbreakstring : string);
    { frame commands }
    procedure Backtrace;
    function SelectFrameCommand(level :longint) : boolean;
    function LoadFile(var fn: string): Boolean;
    procedure SetDir(const s: string);
    procedure SetArgs(const s: string);
  end;

implementation

uses
{$ifdef Windows}
  Windebug,
{$endif Windows}
  strings;

procedure UnixDir(var s : string);
var i : longint;
begin
  for i:=1 to length(s) do
    if s[i]='\' then
{$ifdef windows}
  { Don't touch at '\ ' used to escapes spaces in windows file names PM }
     if (i=length(s)) or (s[i+1]<>' ') then
{$endif windows}
      s[i]:='/';
{$ifdef windows}
  { if we are using cygwin, we need to convert e:\ into /cygdriveprefix/e/ PM }
  if using_cygwin_gdb and (length(s)>2) and (s[2]=':') and (s[3]='/') then
    s:=CygDrivePrefix+'/'+s[1]+copy(s,3,length(s));
{$endif windows}
end;

constructor TGDBController.Init;
begin
  inherited Init;
end;

destructor TGDBController.Done;
begin
  inherited Done;
end;

procedure TGDBController.CommandBegin(const s: string);
begin
end;

procedure TGDBController.Command(const s: string);
begin
  Inc(in_command);
  CommandBegin(s);
  GDBOutputBuf.Reset;
  GDBErrorBuf.Reset;
{$ifdef GDB_RAW_OUTPUT}
  GDBRawBuf.reset;
{$endif GDB_RAW_OUTPUT}
  i_gdb_command(s);
  CommandEnd(s);
  Dec(in_command);
end;

procedure TGDBController.CommandEnd(const s: string);
begin
end;

procedure TGDBController.UpdateRegisterNames;
var
  I: LongInt;
  ResultList: TGDBMI_ListValue;
begin
  SetLength(FRegisterNames, 0);
  Command('-data-list-register-names');
  if not GDB.ResultRecord.Success then
    exit;
  ResultList := GDB.ResultRecord.Parameters['register-names'].AsList;
  SetLength(FRegisterNames, ResultList.Count);
  for I := 0 to ResultList.Count - 1 do
    FRegisterNames[I] := ResultList.ValueAt[I].AsString;
end;

function TGDBController.GetGdbRegisterNo(const RegName: string): LongInt;
var
  I: LongInt;
begin
  for I := Low(FRegisterNames) to High(FRegisterNames) do
    if FRegisterNames[I] = RegName then
    begin
      GetGdbRegisterNo := I;
      exit;
    end;
  GetGdbRegisterNo := -1;
end;

procedure TGDBController.Reset;
begin
end;

procedure TGDBController.StartTrace;
begin
  Command('-break-insert -t PASCALMAIN');
  if not GDB.ResultRecord.Success then
    exit;
  start_break_number := GDB.ResultRecord.Parameters['bkpt'].AsTuple['number'].AsLongInt;
  Run;
end;

procedure TGDBController.RunExecCommand(const Cmd: string);
begin
  UserScreen;
  Command(Cmd);
  if not GDB.ResultRecord.Success then
  begin
    DebuggerScreen;
    got_error := True;
    exit;
  end;
  WaitForProgramStop;
end;

procedure TGDBController.Run;
begin
  RunExecCommand('-exec-run');
end;

procedure TGDBController.TraceStep;
begin
  RunExecCommand('-exec-step');
end;

procedure TGDBController.TraceNext;
begin
  RunExecCommand('-exec-next');
end;

procedure TGDBController.TraceStepI;
begin
  RunExecCommand('-exec-step-instruction');
end;

procedure TGDBController.TraceNextI;
begin
  RunExecCommand('-exec-next-instruction');
end;

procedure TGDBController.Continue;
begin
  RunExecCommand('-exec-continue');
end;

procedure TGDBController.UntilReturn;
begin
  RunExecCommand('-exec-finish');
end;

function TGDBController.GetRegisterAsString(const RegName, Format: string; var Value: string): Boolean;
var
  RegNo: LongInt;
  RegNoStr: string;
begin
  GetRegisterAsString := False;
  Value := '';

  RegNo := GetGdbRegisterNo(RegName);
  if RegNo = -1 then
    exit;
  Str(RegNo, RegNoStr);
  Command('-data-list-register-values ' + Format + ' ' + RegNoStr);
  if not GDB.ResultRecord.Success then
    exit;
  Value := GDB.ResultRecord.Parameters['register-values'].AsList.ValueAt[0].AsTuple['value'].AsString;
  GetRegisterAsString := True;
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: UInt64): Boolean;
var
  RegValueStr: string;
  Code: LongInt;
begin
  GetIntRegister := False;
  Value := 0;
  if not GetRegisterAsString(RegName, 'x', RegValueStr) then
    exit;
  Val(RegValueStr, Value, Code);
  if Code <> 0 then
    exit;
  GetIntRegister := True;
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: Int64): Boolean;
var
  U64Value: UInt64;
begin
  GetIntRegister := GetIntRegister(RegName, U64Value);
  Value := Int64(U64Value);
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: UInt32): Boolean;
var
  U64Value: UInt64;
begin
  GetIntRegister := GetIntRegister(RegName, U64Value);
  Value := UInt32(U64Value);
  if (U64Value shr 32) <> 0 then
    GetIntRegister := False;
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: Int32): Boolean;
var
  U32Value: UInt32;
begin
  GetIntRegister := GetIntRegister(RegName, U32Value);
  Value := Int32(U32Value);
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: UInt16): Boolean;
var
  U64Value: UInt64;
begin
  GetIntRegister := GetIntRegister(RegName, U64Value);
  Value := UInt16(U64Value);
  if (U64Value shr 16) <> 0 then
    GetIntRegister := False;
end;

function TGDBController.GetIntRegister(const RegName: string; var Value: Int16): Boolean;
var
  U16Value: UInt16;
begin
  GetIntRegister := GetIntRegister(RegName, U16Value);
  Value := Int16(U16Value);
end;


{ set command }
function TGDBController.SetCommand(Const SetExpr : string) : boolean;
begin
  SetCommand:=false;
  Command('-gdb-set '+SetExpr);
  if error then
    exit;
  SetCommand:=true;
end;


{ print }
function TGDBController.PrintCommand(const expr : string): AnsiString;
begin
  Command('-data-evaluate-expression '+QuoteString(expr));
  if GDB.ResultRecord.Success then
    PrintCommand:=GDB.ResultRecord.Parameters['value'].AsString
  else
    PrintCommand:=AnsiString(GetError);
end;

const
  PrintFormatName : Array[TPrintFormatType] of string[11] =
  ('binary', 'decimal', 'hexadecimal', 'octal', 'natural');

function TGDBController.PrintFormattedCommand(const expr : string; Format : TPrintFormatType): ansistring;
begin
  Command('-var-evaluate-expression -f '+PrintFormatName[Format]+' '+QuoteString(expr));
  if GDB.ResultRecord.Success then
    PrintFormattedCommand:=GDB.ResultRecord.Parameters['value'].AsString
  else
    PrintFormattedCommand:=AnsiString(GetError);
end;

function TGDBController.BreakpointInsert(const location: string; BreakpointFlags: TBreakpointFlags): LongInt;
var
  Options: string = '';
begin
  if bfTemporary in BreakpointFlags then
    Options := Options + '-t ';
  if bfHardware in BreakpointFlags then
    Options := Options + '-h ';
  Command('-break-insert ' + Options + location);
  if GDB.ResultRecord.Success then
    BreakpointInsert := GDB.ResultRecord.Parameters['bkpt'].AsTuple['number'].AsLongInt
  else
    BreakpointInsert := 0;
end;

function TGDBController.WatchpointInsert(const location: string; WatchpointType: TWatchpointType): LongInt;
begin
  case WatchpointType of
    wtWrite:
      Command('-break-watch ' + location);
    wtReadWrite:
      Command('-break-watch -a ' + location);
    wtRead:
      Command('-break-watch -r ' + location);
  end;
  if GDB.ResultRecord.Success then
    case WatchpointType of
      wtWrite:
        WatchpointInsert := GDB.ResultRecord.Parameters['wpt'].AsTuple['number'].AsLongInt;
      wtReadWrite:
        WatchpointInsert := GDB.ResultRecord.Parameters['hw-awpt'].AsTuple['number'].AsLongInt;
      wtRead:
        WatchpointInsert := GDB.ResultRecord.Parameters['hw-rwpt'].AsTuple['number'].AsLongInt;
    end
  else
    WatchpointInsert := 0;
end;

function TGDBController.BreakpointDelete(BkptNo: LongInt): Boolean;
var
  BkptNoStr: string;
begin
  Str(BkptNo, BkptNoStr);
  Command('-break-delete ' + BkptNoStr);
  BreakpointDelete := GDB.ResultRecord.Success;
end;

function TGDBController.BreakpointEnable(BkptNo: LongInt): Boolean;
var
  BkptNoStr: string;
begin
  Str(BkptNo, BkptNoStr);
  Command('-break-enable ' + BkptNoStr);
  BreakpointEnable := GDB.ResultRecord.Success;
end;

function TGDBController.BreakpointDisable(BkptNo: LongInt): Boolean;
var
  BkptNoStr: string;
begin
  Str(BkptNo, BkptNoStr);
  Command('-break-disable ' + BkptNoStr);
  BreakpointDisable := GDB.ResultRecord.Success;
end;

function TGDBController.BreakpointCondition(BkptNo: LongInt; const ConditionExpr: string): Boolean;
var
  BkptNoStr: string;
begin
  Str(BkptNo, BkptNoStr);
  Command('-break-condition ' + BkptNoStr + ' ' + ConditionExpr);
  BreakpointCondition := GDB.ResultRecord.Success;
end;

function TGDBController.BreakpointSetIgnoreCount(BkptNo: LongInt; const IgnoreCount: LongInt): Boolean;
var
  BkptNoStr, IgnoreCountStr: string;
begin
  Str(BkptNo, BkptNoStr);
  Str(IgnoreCount, IgnoreCountStr);
  Command('-break-after ' + BkptNoStr + ' ' + IgnoreCountStr);
  BreakpointSetIgnoreCount := GDB.ResultRecord.Success;
end;

procedure TGDBController.SetTBreak(tbreakstring : string);
begin
  Command('-break-insert -t ' + tbreakstring);
  TBreakNumber := GDB.ResultRecord.Parameters['bkpt'].AsTuple['number'].AsLongInt;
end;

procedure TGDBController.Backtrace;
var
  FrameList,FrameArgList,ArgList: TGDBMI_ListValue;
  I,J,arg_count: LongInt;
  s : ansistring;
begin
  { forget all old frames }
  clear_frames;

  Command('-stack-list-frames');
  if not GDB.ResultRecord.Success then
    exit;

  FrameList := GDB.ResultRecord.Parameters['stack'].AsList;
  frame_count := FrameList.Count;
  frames := AllocMem(SizeOf(PFrameEntry) * frame_count);
  for I := 0 to frame_count - 1 do
    frames[I] := New(PFrameEntry, Init);
  for I := 0 to FrameList.Count - 1 do
  begin
    frames[I]^.address := FrameList.ValueAt[I].AsTuple['addr'].AsCoreAddr;
    frames[I]^.level := FrameList.ValueAt[I].AsTuple['level'].AsLongInt;
    if Assigned(FrameList.ValueAt[I].AsTuple['line']) then
      frames[I]^.line_number := FrameList.ValueAt[I].AsTuple['line'].AsLongInt;
    if Assigned(FrameList.ValueAt[I].AsTuple['func']) then
      frames[I]^.function_name := StrNew(PAnsiChar(FrameList.ValueAt[I].AsTuple['func'].AsString));
    if Assigned(FrameList.ValueAt[I].AsTuple['fullname']) then
      frames[I]^.file_name := StrNew(PAnsiChar(FrameList.ValueAt[I].AsTuple['fullname'].AsString));
  end;
  Command('-stack-list-arguments 1');
  if not GDB.ResultRecord.Success then
    exit;

  FrameArgList := GDB.ResultRecord.Parameters['stack-args'].AsList;
  arg_count:=FrameArgList.Count;
  if arg_count>frame_count then
    arg_count:=frame_count;
  for I := 0 to arg_count - 1 do
  begin
    ArgList:=FrameArgList.ValueAt[I].AsTuple['args'].AsList;
    s:='(';
    for J:=0 to ArgList.Count-1 do
      begin
        if J>0 then s:=s+', ';
        s:=s+ArgList.ValueAt[J].AsTuple['name'].AsString;
        if Assigned(ArgList.ValueAt[J].AsTuple['value']) then
          s:=s+':='+ArgList.ValueAt[J].AsTuple['value'].ASString;
      end;
    s:=s+')';
    frames[I]^.args:=StrNew(PAnsiChar(s));
  end;
end;

function TGDBController.SelectFrameCommand(level :longint) : boolean;
var
  LevelStr : String;
begin
  Str(Level, LevelStr);
  Command('-stack-select-frame '+LevelStr);
  SelectFrameCommand:=not error;
end;

function TGDBController.LoadFile(var fn: string): Boolean;
var
  cmd: string;
begin
  getdir(0,cmd);
  UnixDir(cmd);
  Command('-environment-cd ' + cmd);
  GDBOutputBuf.Reset;
  GDBErrorBuf.Reset;
{$ifdef GDB_RAW_OUTPUT}
  GDBRawBuf.reset;
{$endif GDB_RAW_OUTPUT}
  UnixDir(fn);
  Command('-file-exec-and-symbols ' + fn);
  if not GDB.ResultRecord.Success then
    begin
      LoadFile:=false;
      exit;
    end;
  { the register list may change *after* loading a file, because there }
  { are gdb versions that support multiple archs, e.g. i386 and x86_64 }
  UpdateRegisterNames;               { so that's why we update it here }
  LoadFile := True;
end;

procedure TGDBController.SetDir(const s: string);
var
  hs: string;
begin
  hs:=s;
  UnixDir(hs);
  { Avoid error message if s is empty }
  if hs<>'' then
    Command('-environment-cd ' + hs);
end;

procedure TGDBController.SetArgs(const s: string);
begin
  Command('-exec-arguments ' + s);
end;

end.
