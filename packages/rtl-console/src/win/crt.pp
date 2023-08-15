{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team.

    Borland Pascal 7 Compatible CRT Unit - win32 implementation

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$IFNDEF FPC_DOTTEDUNITS}
unit crt;
{$ENDIF FPC_DOTTEDUNITS}

interface

{$i crth.inc}

procedure SetSafeCPSwitching(Switching:Boolean);
procedure SetUseACP(ACP:Boolean);
procedure Window32(X1,Y1,X2,Y2: DWord);
procedure GotoXY32(X,Y: DWord);
function WhereX32: DWord;
function WhereY32: DWord;

implementation

{$DEFINE FPC_CRT_CTRLC_TREATED_AS_KEY}
(* Treatment of Ctrl-C as a regular key ensured during initialization (SetupConsoleInput). *)

{$IFDEF FPC_DOTTEDUNITS}
uses
  WinApi.Windows;
{$ELSE FPC_DOTTEDUNITS}
uses
  windows;
{$ENDIF FPC_DOTTEDUNITS}

var
    SaveCursorSize: Longint;
    Win32Platform : Longint; // pulling in sysutils changes exception behaviour

    UseACP        : Boolean; (* True means using active process codepage for
                                console output, False means use the original
                                setting (usually OEM codepage). *)
    SafeCPSwitching : Boolean; (* True in combination with UseACP means that
                                  the console codepage will be set on every
                                  output, False means that the console codepage
                                  will only be set on Initialization and
                                  Finalization *)
    OriginalConsoleOutputCP : Word;
 

{****************************************************************************
                           Low level Routines
****************************************************************************}

function GetScreenHeight : DWord;
var
  ConsoleInfo: TConsoleScreenBufferinfo;
begin
  if (not GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), ConsoleInfo)) then begin
{$ifdef SYSTEMDEBUG}
    Writeln(stderr,'GetScreenHeight failed GetLastError returns ',GetLastError);
    Halt(1);
{$endif SYSTEMDEBUG}
    // ts: this is really silly assumption; imho better: issue a halt
    GetScreenHeight:=25;
  end else
    GetScreenHeight := ConsoleInfo.dwSize.Y;
end; { func. GetScreenHeight }

function GetScreenWidth : DWord;
var
  ConsoleInfo: TConsoleScreenBufferInfo;
begin
  if (not GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), ConsoleInfo)) then begin
{$ifdef SYSTEMDEBUG}
    Writeln(stderr,'GetScreenWidth failed GetLastError returns ',GetLastError);
    Halt(1);
{$endif SYSTEMDEBUG}
    // ts: this is really silly assumption; imho better: issue a halt
    GetScreenWidth:=80;
  end else
    GetScreenWidth := ConsoleInfo.dwSize.X;
end; { func. GetScreenWidth }


procedure GetScreenCursor(var x : DWord; var y : DWord);
var
  ConsoleInfo : TConsoleScreenBufferInfo;
begin
  FillChar(ConsoleInfo, SizeOf(ConsoleInfo), 0);
  GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), ConsoleInfo);
  X := ConsoleInfo.dwCursorPosition.X + 1;
  Y := ConsoleInfo.dwCursorPosition.Y + 1;
end;

procedure SetScreenCursor(x,y : DWord);
var
  CurInfo: TCoord;
begin
  FillChar(Curinfo, SizeOf(Curinfo), 0);
  CurInfo.X := X - 1;
  CurInfo.Y := Y - 1;
  SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), CurInfo);
end;

{****************************************************************************
                             Public Crt Functions
****************************************************************************}

procedure SetSafeCPSwitching(Switching:Boolean);
begin
    SafeCPSwitching:=Switching;
    if SafeCPSwitching then
      SetConsoleOutputCP(OriginalConsoleOutputCP)  // Set Console back to Original since it will now be switched
                                                   // every read and write
    else
      if UseACP then
        SetConsoleOutputCP(GetACP);   // Set Console only once here if SafeCPSwitching is False and
                                      // if UseACP is true
end;

procedure SetUseACP(ACP:Boolean);
begin
    UseACP:=ACP;
    if not(SafeCPSwitching) then
     begin
      if UseACP then
        SetConsoleOutputCP(GetACP)   // Set console CP only once here if SafeCPSwitching is False and
                                     // if UseACP is True
      else
        SetConsoleOutputCP(OriginalConsoleOutputCP)    // Set console back to original if UseACP is False
     end;
end;

procedure TextMode (Mode: word);
begin
end;

Procedure TextColor(Color: Byte);
{ Switch foregroundcolor }
Begin
  TextAttr:=(Color and $8f) or (TextAttr and $70);
End;

Procedure TextBackground(Color: Byte);
{ Switch backgroundcolor }
Begin
  TextAttr:=((Color shl 4) and ($f0 and not Blink)) or (TextAttr and ($0f OR Blink) );
End;

Procedure HighVideo;
{ Set highlighted output. }
Begin
  TextColor(TextAttr Or $08);
End;

Procedure LowVideo;
{ Set normal output }
Begin
  TextColor(TextAttr And $77);
End;

Procedure NormVideo;
{ Set normal back and foregroundcolors. }
Begin
  TextColor(7);
  TextBackGround(0);
End;

Procedure GotoXY(X: tcrtcoord; Y: tcrtcoord);

begin
  GotoXY32(X,Y);
end;

Procedure GotoXY32(X: DWord; Y: DWord);

{ Go to coordinates X,Y in the current window. }
Begin
  If (X > 0) and (X <= (WindMaxX - WindMinX + 1)) and
    (Y > 0) and (Y <= (WindMaxY - WindMinY + 1)) Then Begin
    Inc(X, WindMinX - 1);
    Inc(Y, WindMinY - 1);
    SetScreenCursor(x,y);
  End;
End;

Procedure Window(X1, Y1, X2, Y2: Byte);

begin
  Window32(X1,Y1,X2,Y2);
end;

Procedure Window32(X1, Y1, X2, Y2: DWord);
{
  Set screen window to the specified coordinates.
}
Begin
  if (X1 > X2) or (X2 > GetScreenWidth) or
    (Y1 > Y2) or (Y2 > GetScreenHeight) then
    exit;
  WindMinY := Y1;
  WindMaxY := Y2;
  WindMinX := X1;
  WindMaxX := X2;
  WindMin:=((Y1-1) Shl 8)+(X1-1);
  WindMax:=((Y2-1) Shl 8)+(X2-1);
  GotoXY(1, 1);
End;

procedure ClrScr;
var
  DestCoor: TCoord;
  numChars, x : DWord;
begin
  DestCoor.X := WindMinX - 1;
  DestCoor.Y := WindMinY - 1;
  numChars := (WindMaxX - WindMinX + 1);

  repeat
    FillConsoleOutputAttribute(GetStdHandle(STD_OUTPUT_HANDLE), TextAttr,
      numChars, DestCoor, x);
    FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), #32,
      numChars, DestCoor, x);
    inc(DestCoor.Y);
  until DWord(DestCoor.Y)=WindMaxY;

  GotoXY(1, 1);
end; { proc. ClrScr }


procedure ClrEol;
{
  Clear from current position to end of line.
}
var
  Temp: DWord;
  CharInfo: AnsiChar;
  Coord: TCoord;
  X,Y: DWord;
begin
  GetScreenCursor(x, y);

  CharInfo := #32;
  Coord.X := X - 1;
  Coord.Y := Y - 1;

  FillConsoleOutputCharacter(GetStdHandle(STD_OUTPUT_HANDLE), CharInfo, WindMaxX - X + 1,
    Coord, @Temp);
  FillConsoleOutputAttribute(GetStdHandle(STD_OUTPUT_HANDLE), TextAttr, WindMaxX - X + 1,
    Coord, @Temp);
end;

Function WhereX: tcrtcoord;


begin
  WhereX:=WhereX32 mod 256;
end;

Function WhereX32: DWord;
{
  Return current X-position of cursor.
}
var
  x,y : DWord;
Begin
  GetScreenCursor(x, y);
  WhereX32:= x - WindMinX +1;
End;

Function WhereY: tcrtcoord;

begin
  WhereY:=WhereY32 mod 256;
end;

Function WhereY32: DWord;
{
  Return current Y-position of cursor.
}
var
  x, y : DWord;
Begin
  GetScreenCursor(x, y);
  WhereY32:= y - WindMinY + 1;
End;


{*************************************************************************
                            KeyBoard
*************************************************************************}

var
   ScanCode : AnsiChar;
   SpecialKey : boolean;
   DoingNumChars: Boolean;
   DoingNumCode: Byte;

Function RemapScanCode (ScanCode: word; CtrlKeyState: dword; keycode:word): byte;
  { Several remappings of scancodes are necessary to comply with what
    we get with MSDOS. Special Windows keys, as Alt-Tab, Ctrl-Esc etc.
    are excluded }
var
  AltKey, CtrlKey, ShiftKey: boolean;
const
  {
    Keypad key scancodes:

      Ctrl Norm

      $77  $47 - Home
      $8D  $48 - Up arrow
      $84  $49 - PgUp
      $8E  $4A - -
      $73  $4B - Left Arrow
      $8F  $4C - 5
      $74  $4D - Right arrow
      $4E  $4E - +
      $75  $4F - End
      $91  $50 - Down arrow
      $76  $51 - PgDn
      $92  $52 - Ins
      $93  $53 - Del
  }
  CtrlKeypadKeys: array[$47..$53] of byte =
    ($77, $8D, $84, $8E, $73, $8F, $74, $4E, $75, $91, $76, $92, $93);

begin
  AltKey := ((CtrlKeyState AND
            (RIGHT_ALT_PRESSED OR LEFT_ALT_PRESSED)) > 0);
  CtrlKey := ((CtrlKeyState AND
            (RIGHT_CTRL_PRESSED OR LEFT_CTRL_PRESSED)) > 0);
  ShiftKey := ((CtrlKeyState AND SHIFT_PRESSED) > 0);

  if AltKey then
   begin
    case ScanCode of
    // Digits, -, =
    $02..$0D: inc(ScanCode, $76);
    // Function keys
    $3B..$44: inc(Scancode, $2D);
    $57..$58: inc(Scancode, $34);
    // Extended cursor block keys
    $47..$49, $4B, $4D, $4F..$53:
              inc(Scancode, $50);
    // Other keys
    $1C:      Scancode := $A6;   // Enter
    $35:      Scancode := $A4;   // / (keypad and normal!)
    end
   end
  else if CtrlKey then
    case Scancode of
    // Tab key
    $0F:      Scancode := $94;
    // Function keys
    $3B..$44: inc(Scancode, $23);
    $57..$58: inc(Scancode, $32);
    // Keypad keys
    $35:      Scancode := $95;   // \
    $37:      Scancode := $96;   // *
    $47..$53: Scancode := CtrlKeypadKeys[Scancode];
    //Enter on Numpad
    $1C:
    begin
      Scancode := $0A;
      SpecialKey := False;
    end;
    end
  else if ShiftKey then
    case Scancode of
    // Function keys
    $3B..$44: inc(Scancode, $19);
    $57..$58: inc(Scancode, $30);
    //Enter on Numpad
    $1C:
    begin
      Scancode := $0D;
      SpecialKey := False;
    end;
    end
  else
    case Scancode of
      // Function keys
      $57..$58: inc(Scancode, $2E); // F11 and F12
      //Enter on NumPad
      $1C:
        begin
          Scancode := $0D;
          SpecialKey := False;
        end;
  end;
  RemapScanCode := ScanCode;
end;


function KeyPressed : boolean;
var
  nevents,nread : dword;
  buf : TINPUTRECORD;
  AltKey: Boolean;
  c : longint;
begin
  KeyPressed := FALSE;
  if ScanCode <> #0 then
    KeyPressed := TRUE
  else
   begin
     GetNumberOfConsoleInputEvents(TextRec(input).Handle,nevents);
     while nevents>0 do
       begin
          ReadConsoleInputA(TextRec(input).Handle,buf,1,nread);
          if buf.EventType = KEY_EVENT then
            if buf.Event.KeyEvent.bKeyDown then
              begin
                 { Alt key is VK_MENU }
                 { Capslock key is VK_CAPITAL }

                 AltKey := ((Buf.Event.KeyEvent.dwControlKeyState AND
                            (RIGHT_ALT_PRESSED OR LEFT_ALT_PRESSED)) > 0);
                 if not(Buf.Event.KeyEvent.wVirtualKeyCode in [VK_SHIFT, VK_MENU, VK_CONTROL,
                                                      VK_CAPITAL, VK_NUMLOCK,
                                                      VK_SCROLL]) then
                   begin
                      keypressed:=true;

                      if (ord(buf.Event.KeyEvent.AsciiChar) = 0) or
                         (buf.Event.KeyEvent.dwControlKeyState and (LEFT_ALT_PRESSED or ENHANCED_KEY) > 0) then
                        begin
                           SpecialKey := TRUE;
                           ScanCode := Chr(RemapScanCode(Buf.Event.KeyEvent.wVirtualScanCode, Buf.Event.KeyEvent.dwControlKeyState,
                                           Buf.Event.KeyEvent.wVirtualKeyCode));
                        end
                      else
                        begin
                           { Map shift-tab }
                           if (buf.Event.KeyEvent.AsciiChar=#9) and
                              (buf.Event.KeyEvent.dwControlKeyState and SHIFT_PRESSED > 0) then
                            begin
                              SpecialKey := TRUE;
                              ScanCode := #15;
                            end
                           else
                            begin
                              SpecialKey := FALSE;
                              ScanCode := Chr(Ord(buf.Event.KeyEvent.AsciiChar));
                            end;
                        end;

                      if AltKey then
                        begin
                           case Buf.Event.KeyEvent.wVirtualScanCode of
                             71 : c:=7;
                             72 : c:=8;
                             73 : c:=9;
                             75 : c:=4;
                             76 : c:=5;
                             77 : c:=6;
                             79 : c:=1;
                             80 : c:=2;
                             81 : c:=3;
                             82 : c:=0;
                           else
                             break;
                           end;
                           DoingNumChars := true;
                           DoingNumCode := Byte((DoingNumCode * 10) + c);
                           Keypressed := false;
                           Specialkey := false;
                           ScanCode := #0;
                        end
                      else
                        break;
                   end;
              end
             else
              begin
                if (Buf.Event.KeyEvent.wVirtualKeyCode in [VK_MENU]) then
               if DoingNumChars then
                 if DoingNumCode > 0 then
                   begin
                      ScanCode := Chr(DoingNumCode);
                      Keypressed := true;

                      DoingNumChars := false;
                      DoingNumCode := 0;
                      break
                   end; { if }
              end;
          { if we got a key then we can exit }
          if keypressed then
            exit;
          GetNumberOfConsoleInputEvents(TextRec(input).Handle,nevents);
       end;
   end;
end;


function ReadKey: AnsiChar;
begin
  while (not KeyPressed) do
    Sleep(1);
  if SpecialKey then begin
    ReadKey := #0;
    SpecialKey := FALSE;
  end else begin
    ReadKey := ScanCode;
    ScanCode := #0;
  end;
end;

{$ifndef win64}
//----Windows 9x Sound Helper ---
{$ASMMODE INTEL}
function InPort(PortAddr:word): byte; assembler; stdcall;
asm
  mov dx,PortAddr
  in al,dx
end;

procedure OutPort(PortAddr: word; Databyte: byte); assembler; stdcall;
asm
  mov al,Databyte
  mov dx,PortAddr
  out dx,al
end;
{$endif win64}

//----Windows 2000/XP Sound Helper ---
const IOCTL_BEEP_SET={CTL_CODE(FILE_DEVICE_BEEP, 0, METHOD_BUFFERED, FILE_ANY_ACCESS)}1 shl 16;
type TBeepSetParams=record
  Frequency:longint;
  Duration:longint;
end;
type TDefineDosDeviceFunction=function (dwFlags:DWORD; lpDeviceName:LPCSTR; lpTargetPath:LPCSTR):WINBOOL; stdcall;
var defineDosDevice: TDefineDosDeviceFunction = nil;  //not supported on 9x
    beeperDevice: THandle = INVALID_HANDLE_VALUE;
{*************************************************************************
                                   Sound
*************************************************************************}

var opt: TBeepSetParams;
    result:longword;

{*************************************************************************
                                   Delay
*************************************************************************}

procedure Delay(MS: Word);
begin
  Sleep(ms);
end; { proc. Delay }


procedure sound(hz : word);
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    if beeperDevice = INVALID_HANDLE_VALUE then begin
      if defineDosDevice = nil then begin
        defineDosDevice:=TDefineDosDeviceFunction(GetProcAddress(GetModuleHandle('kernel32.dll'),'DefineDosDeviceA'));
        if defineDosDevice=nil then begin
          {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Windows.Beep(hz,1000); //fallback
          exit;
        end;
        DefineDosDevice(DDD_RAW_TARGET_PATH,'DosBeep','\Device\Beep');
      end;
      beeperDevice:=CreateFile('\\.\DosBeep',0,0,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
      if beeperDevice = INVALID_HANDLE_VALUE then begin
        {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Windows.Beep(hz,1000); //fallback
        exit;
      end;
    end;
    opt.Frequency:=hz;
    opt.Duration:=-1; //very long
    DeviceIoControl(beeperDevice,IOCTL_BEEP_SET,@opt,sizeof(opt),nil,0,@result,nil);
  end else begin
{$ifndef win64}
    OutPort($43,182);
    OutPort($61,InPort($61) or 3);
    OutPort($42,lo(1193180 div hz));
    OutPort($42, hi(1193180 div hz));
{$endif win64}
  end;
end;


procedure nosound;
var opt: TBeepSetParams;
    result:longword;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    if beeperDevice = INVALID_HANDLE_VALUE then exit;
    opt.Frequency:=0; //stop
    opt.Duration:=0;
    DeviceIoControl(beeperDevice,IOCTL_BEEP_SET,@opt,sizeof(opt),nil,0,@result,nil);
  end else begin
{$ifndef win64}
    OutPort($43,182);
    OutPort($61,InPort($61) and 3);
{$endif win64}
  end;
end;


{****************************************************************************
                          HighLevel Crt Functions
****************************************************************************}
procedure removeline(y : DWord);
var
  ClipRect: TSmallRect;
  SrcRect: TSmallRect;
  DestCoor: TCoord;
  CharInfo: TCharInfo;
begin
  CharInfo.UnicodeChar := #32;
  CharInfo.Attributes := TextAttr;

  Y := (WindMinY - 1) + (Y - 1) + 1;

  SrcRect.Top := Y;
  SrcRect.Left := WindMinX - 1;
  SrcRect.Right := WindMaxX - 1;
  SrcRect.Bottom := WindMaxY - 1;

  DestCoor.X := WindMinX - 1;
  DestCoor.Y := Y - 1;

  ClipRect := SrcRect;
  cliprect.top := destcoor.y;

  ScrollConsoleScreenBuffer(GetStdHandle(STD_OUTPUT_HANDLE), SrcRect, ClipRect,
    DestCoor, CharInfo);
end; { proc. RemoveLine }


procedure delline;
begin
  removeline(wherey);
end; { proc. DelLine }


procedure insline;
var
  ClipRect: TSmallRect;
  SrcRect: TSmallRect;
  DestCoor: TCoord;
  CharInfo: TCharInfo;
  X,Y: DWord;
begin
  GetScreenCursor(X, Y);

  CharInfo.UnicodeChar := #32;
  CharInfo.Attributes := TextAttr;

  SrcRect.Top := Y - 1;
  SrcRect.Left := WindMinX - 1;
  SrcRect.Right := WindMaxX - 1;
  SrcRect.Bottom := WindMaxY - 1 + 1;

  DestCoor.X := WindMinX - 1;
  DestCoor.Y := Y;
  ClipRect := SrcRect;
  ClipRect.Bottom := WindMaxY - 1;

  ScrollConsoleScreenBuffer(GetStdHandle(STD_OUTPUT_HANDLE), SrcRect, ClipRect,
    DestCoor, CharInfo);
end; { proc. InsLine }


{****************************************************************************
                             Extra Crt Functions
****************************************************************************}

procedure cursoron;
var CursorInfo: TConsoleCursorInfo;
begin
  GetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
  CursorInfo.dwSize := SaveCursorSize;
  CursorInfo.bVisible := true;
  SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
end;


procedure cursoroff;
var CursorInfo: TConsoleCursorInfo;
begin
  GetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
  CursorInfo.bVisible := false;
  SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
end;


procedure cursorbig;
var CursorInfo: TConsoleCursorInfo;
begin
  GetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
  CursorInfo.dwSize := 93;
  CursorInfo.bVisible := true;
  SetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
end;


{*****************************************************************************
                          Read and Write routines
*****************************************************************************}

var
  CurrX, CurrY : DWord;

procedure WriteChar(c : AnsiChar);
var
    WritePos: Coord;                       { Upper-left cell to write from }
    numWritten : DWord;
    WinAttr : word;
begin
  Case C of
    #10 : begin
      Inc(CurrY);
    end;
    #13 : begin
      CurrX := WindMinX;
    end; { if }
    #08 : begin
      if CurrX > WindMinX then Dec(CurrX);
    end; { ^H }
    #07 : begin
      //MessagBeep(0);
    end; { ^G }
    else begin
      WritePos.X := currX - 1;
      WritePos.Y := currY - 1;

      WriteConsoleOutputCharacter(GetStdhandle(STD_OUTPUT_HANDLE),
        @c, 1, writePos, numWritten);

      WinAttr:=TextAttr;
      WriteConsoleOutputAttribute(GetStdhandle(STD_OUTPUT_HANDLE),
        @WinAttr, 1, writePos, numWritten);

      Inc(CurrX);
    end; { else }
  end; { case }
  if CurrX > WindMaxX then begin
    CurrX := WindMinX;
    Inc(CurrY);
  end; { if }
  While CurrY > WindMaxY do begin
    RemoveLine(1);
    Dec(CurrY);
  end; { while }
end;


procedure WriteStr(const s: shortstring);
var
  WritePos: Coord; { Upper-left cell to write from }
  numWritten : DWord;
  WinAttr : word;
  i: integer;
begin
  WritePos.X:=currX-2;
  WritePos.Y:=currY-1;

  WinAttr:=TextAttr;
  for i:=1 to Length(s) do
    begin
      Inc(WritePos.X);
      WriteConsoleOutputCharacter(GetStdhandle(STD_OUTPUT_HANDLE), @s[i], 1, writePos, numWritten);
      WriteConsoleOutputAttribute(GetStdhandle(STD_OUTPUT_HANDLE),@WinAttr, 1, writePos, numWritten);
      Inc(CurrX);
      if CurrX>WindMaxX then
        begin
          CurrX:=WindMinX;
          Inc(CurrY);
          While CurrY>WindMaxY do
            begin
              RemoveLine(1);
              Dec(CurrY);
            end;
          WritePos.X:=currX-2;
          WritePos.Y:=currY-1;
        end;
    end;
end;


Procedure CrtWrite(var f : textrec);
var
  i : longint;
  s : shortstring;
  OldConsoleOutputCP : Word;
begin
  if SafeCPSwitching and UseACP then    //Switch codepage on every Write.
    begin
      OldConsoleOutputCP:=GetConsoleOutputCP;
      SetConsoleOutputCP(GetACP);
    end;

  GetScreenCursor(CurrX, CurrY);
  s:='';
  for i:=0 to f.bufpos-1 do
    if f.buffer[i] in [#7,#8,#10,#13] then // special chars directly.
      begin
        if s<>'' then
          begin
            WriteStr(s);
 	    s:='';
          end;
        WriteChar(f.buffer[i]);
      end
    else
      begin
        if length(s)=255 then
          begin
            WriteStr(s);
            s:='';
          end;
        s:=s+f.buffer[i];
      end;
  if s<>'' then
    WriteStr(s);
  SetScreenCursor(CurrX, CurrY);

  if SafeCPSwitching and UseACP then     //restore codepage on every write if set previously
    SetConsoleOutputCP(OldConsoleOutputCP);

  f.bufpos:=0;
end;

Procedure CrtRead(Var F: TextRec);

  procedure BackSpace;
  begin
    if (f.bufpos>0) and (f.bufpos=f.bufend) then begin
      WriteChar(#8);
      WriteChar(' ');
      WriteChar(#8);
      dec(f.bufpos);
      dec(f.bufend);
    end;
  end;

var
  ch : AnsiChar;
  OldConsoleOutputCP : Word;
begin
  if SafeCPSwitching and UseACP then    //Switch codepage on every Read
    begin
      OldConsoleOutputCP:=GetConsoleOutputCP;
      SetConsoleOutputCP(GetACP);
    end;

  GetScreenCursor(CurrX,CurrY);
  f.bufpos:=0;
  f.bufend:=0;
  repeat
    if f.bufpos>f.bufend then
      f.bufend:=f.bufpos;
      SetScreenCursor(CurrX,CurrY);
      ch:=readkey;
      case ch of
        #0 : case readkey of
          #71 : while f.bufpos>0 do begin
            dec(f.bufpos);
            WriteChar(#8);
          end;
          #75 : if f.bufpos>0 then begin
            dec(f.bufpos);
            WriteChar(#8);
          end;
          #77 : if f.bufpos<f.bufend then begin
            WriteChar(f.bufptr^[f.bufpos]);
            inc(f.bufpos);
          end;
          #79 : while f.bufpos<f.bufend do begin
            WriteChar(f.bufptr^[f.bufpos]);
            inc(f.bufpos);
          end;
          #28: begin                    // numpad enter
                WriteChar(#13);
                WriteChar(#10);
                f.bufptr^[f.bufend]:=#13;
                f.bufptr^[f.bufend+1]:=#10;
                inc(f.bufend,2);
                break;
               end;
          #53: begin
                 ch:='/';
                 if f.bufpos<f.bufsize-2 then begin
                    f.buffer[f.bufpos]:=ch;
                    inc(f.bufpos);
                    WriteChar(ch);
                 end;
               end;
        end;
        ^S,
      #8 : BackSpace;
      ^Y,
      #27 : begin
        while f.bufpos<f.bufend do begin
         WriteChar(f.bufptr^[f.bufpos]);
         inc(f.bufpos);
        end;
        while f.bufend>0 do
          BackSpace;
      end;
      #13 : begin
        WriteChar(#13);
        WriteChar(#10);
        f.bufptr^[f.bufend]:=#13;
        f.bufptr^[f.bufend+1]:=#10;
        inc(f.bufend,2);
        break;
      end;
      #26 : if CheckEOF then begin
        f.bufptr^[f.bufend]:=#26;
        inc(f.bufend);
        break;
      end;
      else begin
        if f.bufpos<f.bufsize-2 then begin
          f.bufptr^[f.bufpos]:=ch;
          inc(f.bufpos);
          WriteChar(ch);
        end;
      end;
      end;
  until false;

  if SafeCPSwitching and UseACP then    //Restore codepage on every Read if set previously
    SetConsoleOutputCP(OldConsoleOutputCP);
	
  f.bufpos:=0;
  SetScreenCursor(CurrX, CurrY);
End;


Procedure CrtReturn(Var F:TextRec);
Begin
end;


Procedure CrtClose(Var F: TextRec);
Begin
  F.Mode:=fmClosed;
End;


Procedure CrtOpen(Var F: TextRec);
Begin
  If F.Mode=fmOutput Then begin
    TextRec(F).InOutFunc:=@CrtWrite;
    TextRec(F).FlushFunc:=@CrtWrite;
  end Else begin
    F.Mode:=fmInput;
    TextRec(F).InOutFunc:=@CrtRead;
    TextRec(F).FlushFunc:=@CrtReturn;
  end;
  TextRec(F).CloseFunc:=@CrtClose;
End;


procedure AssignCrt(var F: Text);
begin
  Assign(F,'');
  TextRec(F).OpenFunc:=@CrtOpen;
end;

var
  CursorInfo  : TConsoleCursorInfo;
  ConsoleInfo : TConsoleScreenBufferinfo;

procedure LoadVersionInfo;
Var
   versioninfo : TOSVERSIONINFO;
begin
  versioninfo.dwOSVersionInfoSize:=sizeof(versioninfo);
  GetVersionEx(versioninfo);
  Win32Platform:=versionInfo.dwPlatformId;
end;

procedure SetupConsoleInput(ihnd: THANDLE);
var
  Mode : DWORD;
begin
  GetConsoleMode(ihnd, Mode);
  Mode:=Mode and not ENABLE_PROCESSED_INPUT;
  SetConsoleMode(ihnd, Mode);
end;

var
  PrevCtrlBreakHandler: TCtrlBreakHandler;


function CrtCtrlBreakHandler (CtrlBreak: boolean): boolean;
begin
(* Earlier registered handlers (e.g. FreeVision) have priority. *)
  if Assigned (PrevCtrlBreakHandler) then
    if PrevCtrlBreakHandler (CtrlBreak) then
      begin
        CrtCtrlBreakHandler := true;
        Exit;
      end;
(* If Ctrl-Break was pressed, either ignore it or allow default processing. *)
  if CtrlBreak then
    CrtCtrlBreakHandler := not (CheckBreak)
  else (* Ctrl-C pressed *)
{$IFDEF FPC_CRT_CTRLC_TREATED_AS_KEY}
 (* If Ctrl-C is really treated as a key, the following branch should never *)
 (* be executed, but let's stay on the safe side and ensure predictability. *)
   CrtCtrlBreakHandler := false;
{$ELSE FPC_CRT_CTRLC_TREATED_AS_KEY}
    begin
      if not (SpecialKey) and (ScanCode = 0) then
        ScanCode := 3;
      CrtCtrlBreakHandler := true;
    end;
{$ENDIF FPC_CRT_CTRLC_TREATED_AS_KEY}
end;

// ts


Initialization
  LoadVersionInfo;


  { Initialize the output handles }
  LastMode := 3;

  SetActiveWindow(0);

  OriginalConsoleOutputCP:=GetConsoleOutputCP;  //Always save the original console codepage so it can be restored on exit.
  UseACP:=True;  // Default to use GetACP CodePage to remain compatible with previous CRT version.
  SafeCPSwitching:=True;  // Default to switch codepage on every read and write to remain compatible with previous CRT version.

  //SetSafeCPSwitching(False); // With these defaults the code page does not need to be changed here. If SafeCPSwitching defaulted
                               // to False and UseACP to True then SetSafeCPSwitching(False) needs to be run here.

  {--------------------- Get the cursor size and such -----------------------}
  FillChar(CursorInfo, SizeOf(CursorInfo), 00);
  GetConsoleCursorInfo(GetStdHandle(STD_OUTPUT_HANDLE), CursorInfo);
  SaveCursorSize := CursorInfo.dwSize;

  {------------------ Get the current cursor position and attr --------------}
  FillChar(ConsoleInfo, SizeOf(ConsoleInfo), 0);
  GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), ConsoleInfo);

  TextAttr := ConsoleInfo.wAttributes;

  { Not required, the dos crt does also not touch the mouse }
  {TurnMouseOff;}

  WindMinX := (ConsoleInfo.srWindow.Left) + 1;
  WindMinY := (ConsoleInfo.srWindow.Top) + 1;
  WindMaxX := (ConsoleInfo.srWindow.Right) + 1;
  WindMaxY := (ConsoleInfo.srWindow.Bottom) + 1;
  WindMax:=((WindMaxY-1) Shl 8)+(WindMaxX-1);

  DoingNumChars := false;
  DoingNumCode := 0;

  { Redirect the standard output }
  AssignCrt(Output);
  Rewrite(Output);
  TextRec(Output).Handle:= GetStdHandle(STD_OUTPUT_HANDLE);

  AssignCrt(Input);
  Reset(Input);
  TextRec(Input).Handle:= GetStdHandle(STD_INPUT_HANDLE);

  SetupConsoleInput(TextRec(Input).Handle);

  PrevCtrlBreakHandler := SysSetCtrlBreakHandler (@CrtCtrlBreakHandler);
  if PrevCtrlBreakHandler = TCtrlBreakHandler (pointer (-1)) then
   PrevCtrlBreakHandler := nil;
  CheckBreak := true;

finalization
  if beeperDevice <> INVALID_HANDLE_VALUE then begin
    nosound;
    CloseHandle(beeperDevice);
    DefineDosDevice(DDD_REMOVE_DEFINITION,'DosBeep','\Device\Beep');
  end;
  SetConsoleOutputCP(OriginalConsoleOutputCP);  //Always put the console back the way it was on start;
                                                //useful if the program is executed from command line.
end. { unit Crt }
