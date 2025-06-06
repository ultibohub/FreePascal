{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Florian Klaempfl

    This file implements the go32v2 support for the graph unit

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit Graph;
interface

{ the code of the unit fits in 64kb in the medium memory model, but exceeds 64kb
  in the large and huge memory models, so enable huge code in these models. }
{$if defined(FPC_MM_LARGE) or defined(FPC_MM_HUGE)}
  {$hugecode on}
{$endif}

{$define asmgraph}

{$i graphh.inc}
{$i vesah.inc}

CONST
  m640x200x16       = VGALo;
  m640x400x16       = VGAMed;
  m640x480x16       = VGAHi;

  { VESA Specific video modes. }
  m320x200x32k      = $10D;
  m320x200x64k      = $10E;
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
  m320x200x16m      = $10F;
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}

  m640x400x256      = $100;

  m640x480x256      = $101;
  m640x480x32k      = $110;
  m640x480x64k      = $111;
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
  m640x480x16m      = $112;
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}

  m800x600x16       = $102;
  m800x600x256      = $103;
  m800x600x32k      = $113;
  m800x600x64k      = $114;
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
  m800x600x16m      = $115;
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}

  m1024x768x16      = $104;
  m1024x768x256     = $105;
  m1024x768x32k     = $116;
  m1024x768x64k     = $117;
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
  m1024x768x16m     = $118;
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}

  m1280x1024x16     = $106;
  m1280x1024x256    = $107;
  m1280x1024x32k    = $119;
  m1280x1024x64k    = $11A;
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
  m1280x1024x16m    = $11B;
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}

{ Helpful variable to get save/restore support in IDE PM }
const
  DontClearGraphMemory : boolean = false;



implementation

uses
  dos,ports;

const
   InternalDriverName = 'DOSGX';

{$i graph.inc}

const
   VideoOfs : word = 0;   { Segment to draw to }
   FirstPlane = $0102;   (* 02 = Index to Color plane Select, *)
                         (* 01 = Enable color plane 1         *)

{    ; ===== VGA Register Values ===== }

    SCREEN_WIDTH    =     80     ; { MODE-X 320 SCREEN WIDTH         }
                                   { CHANGE THE VALUE IF OTHER MODES }
                                   { OTHER THEN 320 ARE USED.        }
    ATTRIB_Ctrl     =   $03C0    ; { VGA Attribute Controller        }
    GC_Index        =   $03CE    ; { VGA Graphics Controller         }
    SC_Index        =   $03C4    ; { VGA Sequencer Controller        }
    SC_Data         =   $03C5    ; { VGA Sequencer Data Port         }
    CRTC_Index      =   $03D4    ; { VGA CRT Controller              }
    CRTC_Data       =   $03D5    ; { VGA CRT Controller Data         }
    MISC_OUTPUT     =   $03C2    ; { VGA Misc Register               }
    INPUT_1         =   $03DA    ; { Input Status #1 Register        }

    DAC_WRITE_ADDR  =   $03C8    ; { VGA DAC Write Addr Register     }
    DAC_READ_ADDR   =   $03C7    ; { VGA DAC Read Addr Register      }
    PEL_DATA_REG    =   $03C9    ; { VGA DAC/PEL data Register R/W   }

    PIXEL_PAN_REG   =   $033     ; { Attrib Index: Pixel Pan Reg     }
    MAP_MASK        =   $002     ; { S=   $Index: Write Map Mask reg }
    READ_MAP        =   $004     ; { GC Index: Read Map Register     }
    START_DISP_HI   =   $00C     ; { CRTC Index: Display Start Hi    }
    START_DISP_LO   =   $00D     ; { CRTC Index: Display Start Lo    }

    MAP_MASK_PLANE1 =   $00102   ; { Map Register + Plane 1          }
    MAP_MASK_PLANE2 =   $01102   ; { Map Register + Plane 1          }
    ALL_PLANES_ON   =   $00F02   ; { Map Register + All Bit Planes   }

    CHAIN4_OFF      =   $00604   ; { Chain 4 mode Off                }
    ASYNC_RESET     =   $00100   ; { (A)synchronous Reset            }
    SEQU_RESTART    =   $00300   ; { Sequencer Restart               }

    LATCHES_ON      =   $00008   ; { Bit Mask + Data from Latches    }
    LATCHES_OFF     =   $0FF08   ; { Bit Mask + Data from CPU        }

    VERT_RETRACE    =   $08      ; { INPUT_1: Vertical Retrace Bit   }
    PLANE_BITS      =   $03      ; { Bits 0-1 of Xpos = Plane #      }
    ALL_PLANES      =   $0F      ; { All Bit Planes Selected         }
    CHAR_BITS       =   $0F      ; { Bits 0-3 of Character Data      }

    GET_CHAR_PTR    =   $01130   ; { VGA BIOS Func: Get AnsiChar Set     }
    ROM_8x8_Lo      =   $03      ; { ROM 8x8 AnsiChar Set Lo Pointer     }
    ROM_8x8_Hi      =   $04      ; { ROM 8x8 AnsiChar Set Hi Pointer     }

    { Constants Specific for these routines                          }

    NUM_MODES       =   $8       ; { # of Mode X Variations           }

    { in 16 color modes, the actual colors used are not 0..15, but: }
    ToRealCols16: Array[0..15] of word =
      (0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63);

  var
     ScrWidth : word absolute $40:$4a;
     inWindows: boolean;

{$ifndef tp}
  Procedure seg_bytemove(sseg : word;source : word;dseg : word;dest : word;count : word); assembler;
    asm
      push ds
      cld
      mov es, dseg
      mov si, source
      mov di, dest
      mov cx, count
      mov ds,sseg
      rep movsb
      pop ds
    end;
{$endif tp}

 Procedure CallInt10(val_ax : word); assembler;
   asm
     mov ax,val_ax
     push ds
     push bp
     int 10h
     pop bp
     pop ds
   end;

 Procedure InitInt10hMode(mode : byte);
   begin
     if DontClearGraphMemory then
       CallInt10(mode or $80)
     else
       CallInt10(mode);
   end;

{************************************************************************}
{*                   720x348x2 Hercules mode routines                   *}
{************************************************************************}

var
  DummyHGCBkColor: Word;

procedure InitHGC720;
const
  RegValues: array [0..11] of byte =
    ($35, $2D, $2E, $07, $5B, $02, $57, $57, $02, $03, $00, $00);
var
  I: Integer;
begin
  Port[$3BF] := 3; { graphic and page 2 possible }
  Port[$3B8] := 2; { display page 0, graphic mode, display off }
  for I := 0 to 11 do
    PortW[$3B4] := I or (RegValues[I] shl 8);
  Port[$3B8] := 10; { display page 0, graphic mode, display on }
  asm
{$ifdef FPC_MM_HUGE}
    mov ax, SEG SegB000
    mov es, ax
    mov es, es:[SegB000]
{$else FPC_MM_HUGE}
    mov es, [SegB000]
{$endif FPC_MM_HUGE}
    mov cx, 32768
    xor di, di
    xor ax, ax
    cld
    rep stosw
  end ['ax','cx','di'];
  VideoOfs := 0;
  DummyHGCBkColor := 0;
end;

{ compatible with TP7's HERC.BGI }
procedure SetBkColorHGC720(ColorNum: ColorType);
begin
  if ColorNum > 15 then
    exit;
  DummyHGCBkColor := ColorNum;
end;

{ compatible with TP7's HERC.BGI }
function GetBkColorHGC720: ColorType;
begin
  GetBkColorHGC720 := DummyHGCBkColor;
end;

procedure SetHGCRGBPalette(ColorNum, RedValue, GreenValue,
      BlueValue : smallint);
begin
end;

procedure GetHGCRGBPalette(ColorNum: smallint; Var
      RedValue, GreenValue, BlueValue : smallint);
begin
end;

procedure PutPixelHGC720(X, Y: SmallInt; Pixel: ColorType);
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  { verify clipping and then convert to absolute coordinates...}
  if ClipPixels then
  begin
    if (X < 0) or (X > ViewWidth) then
      exit;
    if (Y < 0) or (Y > ViewHeight) then
      exit;
  end;
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 2) * 90 + (X shr 3) + VideoOfs;
  case Y and 3 of
    1: Inc(Offset, $2000);
    2: Inc(Offset, $4000);
    3: Inc(Offset, $6000);
  end;
  Shift := 7 - (X and 7);
  Mask := 1 shl Shift;
  B := Mem[SegB000:Offset];
  B := B and (not Mask) or (Pixel shl Shift);
  Mem[SegB000:Offset] := B;
end;

function GetPixelHGC720(X, Y: SmallInt): ColorType;
var
  Offset: Word;
  B, Shift: Byte;
begin
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 2) * 90 + (X shr 3) + VideoOfs;
  case Y and 3 of
    1: Inc(Offset, $2000);
    2: Inc(Offset, $4000);
    3: Inc(Offset, $6000);
  end;
  Shift := 7 - (X and 7);
  B := Mem[SegB000:Offset];
  GetPixelHGC720 := (B shr Shift) and 1;
end;

procedure DirectPutPixelHGC720(X, Y: SmallInt);
 { x,y -> must be in global coordinates. No clipping. }
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  Offset := (Y shr 2) * 90 + (X shr 3) + VideoOfs;
  case Y and 3 of
    1: Inc(Offset, $2000);
    2: Inc(Offset, $4000);
    3: Inc(Offset, $6000);
  end;
  Shift := 7 - (X and 7);
  case CurrentWriteMode of
    XORPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB000:Offset] := Mem[SegB000:Offset] xor (CurrentColor shl Shift);
      end;
    OrPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB000:Offset] := Mem[SegB000:Offset] or (CurrentColor shl Shift);
      end;
    AndPut:
      begin
        { optimization }
        if CurrentColor = 1 then
          exit;
        { therefore, CurrentColor must be 0 }
        Mem[SegB000:Offset] := Mem[SegB000:Offset] and (not (1 shl Shift));
      end;
    NotPut:
      begin
        Mask := 1 shl Shift;
        B := Mem[SegB000:Offset];
        B := B and (not Mask) or ((CurrentColor xor $01) shl Shift);
        Mem[SegB000:Offset] := B;
      end
    else
      begin
        Mask := 1 shl Shift;
        B := Mem[SegB000:Offset];
        B := B and (not Mask) or (CurrentColor shl Shift);
        Mem[SegB000:Offset] := B;
      end;
  end;
end;

procedure HLineHGC720(X, X2, Y: SmallInt);
var
  Color: Word;
  YOffset, LOffset, ROffset, CurrentOffset, MiddleAreaLength: Word;
  B, ForeMask, LForeMask, LBackMask, RForeMask, RBackMask: Byte;
  xtmp: SmallInt;
begin
  { must we swap the values? }
  if x > x2 then
  begin
    xtmp := x2;
    x2 := x;
    x:= xtmp;
  end;
  { First convert to global coordinates }
  X   := X + StartXViewPort;
  X2  := X2 + StartXViewPort;
  Y   := Y + StartYViewPort;
  if ClipPixels then
  begin
    if LineClipped(x,y,x2,y,StartXViewPort,StartYViewPort,
           StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
      exit;
  end;
  YOffset := (Y shr 2) * 90 + VideoOfs;
  case Y and 3 of
    1: Inc(YOffset, $2000);
    2: Inc(YOffset, $4000);
    3: Inc(YOffset, $6000);
  end;
  LOffset := YOffset + (X shr 3);
  ROffset := YOffset + (X2 shr 3);

  if CurrentWriteMode = NotPut then
    Color := CurrentColor xor $01
  else
    Color := CurrentColor;
  if Color = 1 then
    ForeMask := $FF
  else
    ForeMask := $00;

  LBackMask := Byte($FF00 shr (X and $07));
  LForeMask := (not LBackMask) and ForeMask;

  RBackMask := Byte(not ($FF shl (7 - (X2 and $07))));
  RForeMask := (not RBackMask) and ForeMask;

  if LOffset = ROffset then
  begin
    LBackMask := LBackMask or RBackMask;
    LForeMask := LForeMask and RForeMask;
  end;

  CurrentOffset := LOffset;

  { check if the first byte is only partially full
    (otherwise, it's completely full and is handled as a part of the middle area) }
  if LBackMask <> 0 then
  begin
    { draw the first byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] xor LForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] or LForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] and LBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB000:CurrentOffset];
          B := B and LBackMask or LForeMask;
          Mem[SegB000:CurrentOffset] := B;
        end;
    end;
    Inc(CurrentOffset);
  end;

  if CurrentOffset > ROffset then
    exit;

  MiddleAreaLength := ROffset + 1 - CurrentOffset;
  if RBackMask <> 0 then
    Dec(MiddleAreaLength);

  { draw the middle area }
  if MiddleAreaLength > 0 then
  begin
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] xor $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB000:CurrentOffset] := $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB000:CurrentOffset] := 0;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      else
        begin
          { note: NotPut is also handled here }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB000:CurrentOffset] := ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
    end;
  end;

  { draw the final right byte, if less than 100% full }
  if RBackMask <> 0 then
  begin
    { draw the last byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] xor RForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] or RForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegB000:CurrentOffset] := Mem[SegB000:CurrentOffset] and RBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB000:CurrentOffset];
          B := B and RBackMask or RForeMask;
          Mem[SegB000:CurrentOffset] := B;
        end;
    end;
  end;
end;

procedure SetVisualHGC720(page: word);
{ two page supPort... }
begin
  if page > HardwarePages then exit;

  case page of
   0 : Port[$3B8] := 10; { display page 0, graphic mode, display on }
   1 : Port[$3B8] := 10+128; { display page 1, graphic mode, display on }
  end;
end;

procedure SetActiveHGC720(page: word);
{ two page supPort... }
begin
  case page of
   0 : VideoOfs := 0;
   1 : VideoOfs := 32768;
  else
    VideoOfs := 0;
  end;
end;

{************************************************************************}
{*                     320x200x4 CGA mode routines                      *}
{************************************************************************}
var
  CurrentCGABorder: Word;

procedure SetCGAPalette(CGAPaletteID: Byte); assembler;
asm
  mov al,CGAPaletteID
  mov bl, al
  mov bh, 1
  mov ah, 0Bh
  push ds
  push bp
  int 10h
  pop bp
  pop ds
end;

procedure SetCGABorder(CGABorder: Byte); assembler;
asm
  mov al,CGABorder
  mov bl, al
  mov bh, 0
  mov ah, 0Bh
  push ds
  push bp
  int 10h
  pop bp
  pop ds
end;

procedure SetBkColorCGA320(ColorNum: ColorType);
begin
  if ColorNum > 15 then
    exit;
  CurrentCGABorder := (CurrentCGABorder and 16) or ColorNum;
  SetCGABorder(CurrentCGABorder);
end;

function GetBkColorCGA320: ColorType;
begin
  GetBkColorCGA320 := CurrentCGABorder and 15;
end;

procedure InitCGA320C0;
begin
  InitInt10hMode($04);
  VideoOfs := 0;
  SetCGAPalette(0);
  SetCGABorder(16);
  CurrentCGABorder := 16;
end;

procedure InitCGA320C1;
begin
  InitInt10hMode($04);
  VideoOfs := 0;
  SetCGAPalette(1);
  SetCGABorder(16);
  CurrentCGABorder := 16;
end;

procedure InitCGA320C2;
begin
  InitInt10hMode($04);
  VideoOfs := 0;
  SetCGAPalette(2);
  SetCGABorder(0);
  CurrentCGABorder := 0;
end;

procedure InitCGA320C3;
begin
  InitInt10hMode($04);
  VideoOfs := 0;
  SetCGAPalette(3);
  SetCGABorder(0);
  CurrentCGABorder := 0;
end;

procedure PutPixelCGA320(X, Y: SmallInt; Pixel: ColorType);
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  { verify clipping and then convert to absolute coordinates...}
  if ClipPixels then
  begin
    if (X < 0) or (X > ViewWidth) then
      exit;
    if (Y < 0) or (Y > ViewHeight) then
      exit;
  end;
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 1) * 80 + (X shr 2);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 6 - ((X and 3) shl 1);
  Mask := $03 shl Shift;
  B := Mem[SegB800:Offset];
  B := B and (not Mask) or (Pixel shl Shift);
  Mem[SegB800:Offset] := B;
end;

function GetPixelCGA320(X, Y: SmallInt): ColorType;
var
  Offset: Word;
  B, Shift: Byte;
begin
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 1) * 80 + (X shr 2);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 6 - ((X and 3) shl 1);
  B := Mem[SegB800:Offset];
  GetPixelCGA320 := (B shr Shift) and $03;
end;

procedure DirectPutPixelCGA320(X, Y: SmallInt);
 { x,y -> must be in global coordinates. No clipping. }
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  Offset := (Y shr 1) * 80 + (X shr 2);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 6 - ((X and 3) shl 1);
  case CurrentWriteMode of
    XORPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB800:Offset] := Mem[SegB800:Offset] xor (CurrentColor shl Shift);
      end;
    OrPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB800:Offset] := Mem[SegB800:Offset] or (CurrentColor shl Shift);
      end;
    AndPut:
      begin
        { optimization }
        if CurrentColor = 3 then
          exit;
        Mask := $03 shl Shift;
        Mem[SegB800:Offset] := Mem[SegB800:Offset] and ((CurrentColor shl Shift) or (not Mask));
      end;
    NotPut:
      begin
        Mask := $03 shl Shift;
        B := Mem[SegB800:Offset];
        B := B and (not Mask) or ((CurrentColor xor $03) shl Shift);
        Mem[SegB800:Offset] := B;
      end
    else
      begin
        Mask := $03 shl Shift;
        B := Mem[SegB800:Offset];
        B := B and (not Mask) or (CurrentColor shl Shift);
        Mem[SegB800:Offset] := B;
      end;
  end;
end;

procedure HLineCGA320(X, X2, Y: SmallInt);
var
  Color: Word;
  YOffset, LOffset, ROffset, CurrentOffset, MiddleAreaLength: Word;
  B, ForeMask, LForeMask, LBackMask, RForeMask, RBackMask: Byte;
  xtmp: SmallInt;
begin
  { must we swap the values? }
  if x > x2 then
  begin
    xtmp := x2;
    x2 := x;
    x:= xtmp;
  end;
  { First convert to global coordinates }
  X   := X + StartXViewPort;
  X2  := X2 + StartXViewPort;
  Y   := Y + StartYViewPort;
  if ClipPixels then
  begin
    if LineClipped(x,y,x2,y,StartXViewPort,StartYViewPort,
           StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
      exit;
  end;
  YOffset := (Y shr 1) * 80;
  if (Y and 1) <> 0 then
    Inc(YOffset, 8192);
  LOffset := YOffset + (X shr 2);
  ROffset := YOffset + (X2 shr 2);

  if CurrentWriteMode = NotPut then
    Color := CurrentColor xor $03
  else
    Color := CurrentColor;
  case Color of
    0: ForeMask := $00;
    1: ForeMask := $55;
    2: ForeMask := $AA;
    3: ForeMask := $FF;
  end;

  LBackMask := Byte($FF00 shr ((X and $03) shl 1));
  LForeMask := (not LBackMask) and ForeMask;

  RBackMask := Byte(not ($FF shl (6 - ((X2 and $03) shl 1))));
  RForeMask := (not RBackMask) and ForeMask;

  if LOffset = ROffset then
  begin
    LBackMask := LBackMask or RBackMask;
    LForeMask := LForeMask and RForeMask;
  end;

  CurrentOffset := LOffset;

  { check if the first byte is only partially full
    (otherwise, it's completely full and is handled as a part of the middle area) }
  if LBackMask <> 0 then
  begin
    { draw the first byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor LForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] or LForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 3 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] and (LBackMask or LForeMask);
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB800:CurrentOffset];
          B := B and LBackMask or LForeMask;
          Mem[SegB800:CurrentOffset] := B;
        end;
    end;
    Inc(CurrentOffset);
  end;

  if CurrentOffset > ROffset then
    exit;

  MiddleAreaLength := ROffset + 1 - CurrentOffset;
  if RBackMask <> 0 then
    Dec(MiddleAreaLength);

  { draw the middle area }
  if MiddleAreaLength > 0 then
  begin
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] or ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 3 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] and ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      else
        begin
          { note: NotPut is also handled here }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
    end;
  end;

  { draw the final right byte, if less than 100% full }
  if RBackMask <> 0 then
  begin
    { draw the last byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor RForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] or RForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 3 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] and (RBackMask or RForeMask);
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB800:CurrentOffset];
          B := B and RBackMask or RForeMask;
          Mem[SegB800:CurrentOffset] := B;
        end;
    end;
  end;
end;

{************************************************************************}
{*                     640x200x2 CGA mode routines                      *}
{************************************************************************}

procedure InitCGA640;
begin
  InitInt10hMode($06);
  VideoOfs := 0;
  CurrentCGABorder := 0; {yes, TP7 CGA.BGI behaves *exactly* like that}
end;

{yes, TP7 CGA.BGI behaves *exactly* like that}
procedure SetBkColorCGA640(ColorNum: ColorType);
begin
  if ColorNum > 15 then
    exit;
  CurrentCGABorder := ColorNum;
  if ColorNum = 0 then
    exit;
  SetCGABorder(CurrentCGABorder);
end;

function GetBkColorCGA640: ColorType;
begin
  GetBkColorCGA640 := CurrentCGABorder and 15;
end;

procedure PutPixelCGA640(X, Y: SmallInt; Pixel: ColorType);
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  { verify clipping and then convert to absolute coordinates...}
  if ClipPixels then
  begin
    if (X < 0) or (X > ViewWidth) then
      exit;
    if (Y < 0) or (Y > ViewHeight) then
      exit;
  end;
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 1) * 80 + (X shr 3);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 7 - (X and 7);
  Mask := 1 shl Shift;
  B := Mem[SegB800:Offset];
  B := B and (not Mask) or (Pixel shl Shift);
  Mem[SegB800:Offset] := B;
end;

function GetPixelCGA640(X, Y: SmallInt): ColorType;
var
  Offset: Word;
  B, Shift: Byte;
begin
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := (Y shr 1) * 80 + (X shr 3);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 7 - (X and 7);
  B := Mem[SegB800:Offset];
  GetPixelCGA640 := (B shr Shift) and 1;
end;

procedure DirectPutPixelCGA640(X, Y: SmallInt);
 { x,y -> must be in global coordinates. No clipping. }
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  Offset := (Y shr 1) * 80 + (X shr 3);
  if (Y and 1) <> 0 then
    Inc(Offset, 8192);
  Shift := 7 - (X and 7);
  case CurrentWriteMode of
    XORPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB800:Offset] := Mem[SegB800:Offset] xor (CurrentColor shl Shift);
      end;
    OrPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegB800:Offset] := Mem[SegB800:Offset] or (CurrentColor shl Shift);
      end;
    AndPut:
      begin
        { optimization }
        if CurrentColor = 1 then
          exit;
        { therefore, CurrentColor must be 0 }
        Mem[SegB800:Offset] := Mem[SegB800:Offset] and (not (1 shl Shift));
      end;
    NotPut:
      begin
        Mask := 1 shl Shift;
        B := Mem[SegB800:Offset];
        B := B and (not Mask) or ((CurrentColor xor $01) shl Shift);
        Mem[SegB800:Offset] := B;
      end
    else
      begin
        Mask := 1 shl Shift;
        B := Mem[SegB800:Offset];
        B := B and (not Mask) or (CurrentColor shl Shift);
        Mem[SegB800:Offset] := B;
      end;
  end;
end;

procedure HLineCGA640(X, X2, Y: SmallInt);
var
  Color: Word;
  YOffset, LOffset, ROffset, CurrentOffset, MiddleAreaLength: Word;
  B, ForeMask, LForeMask, LBackMask, RForeMask, RBackMask: Byte;
  xtmp: SmallInt;
begin
  { must we swap the values? }
  if x > x2 then
  begin
    xtmp := x2;
    x2 := x;
    x:= xtmp;
  end;
  { First convert to global coordinates }
  X   := X + StartXViewPort;
  X2  := X2 + StartXViewPort;
  Y   := Y + StartYViewPort;
  if ClipPixels then
  begin
    if LineClipped(x,y,x2,y,StartXViewPort,StartYViewPort,
           StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
      exit;
  end;
  YOffset := (Y shr 1) * 80;
  if (Y and 1) <> 0 then
    Inc(YOffset, 8192);
  LOffset := YOffset + (X shr 3);
  ROffset := YOffset + (X2 shr 3);

  if CurrentWriteMode = NotPut then
    Color := CurrentColor xor $01
  else
    Color := CurrentColor;
  if Color = 1 then
    ForeMask := $FF
  else
    ForeMask := $00;

  LBackMask := Byte($FF00 shr (X and $07));
  LForeMask := (not LBackMask) and ForeMask;

  RBackMask := Byte(not ($FF shl (7 - (X2 and $07))));
  RForeMask := (not RBackMask) and ForeMask;

  if LOffset = ROffset then
  begin
    LBackMask := LBackMask or RBackMask;
    LForeMask := LForeMask and RForeMask;
  end;

  CurrentOffset := LOffset;

  { check if the first byte is only partially full
    (otherwise, it's completely full and is handled as a part of the middle area) }
  if LBackMask <> 0 then
  begin
    { draw the first byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor LForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] or LForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] and LBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB800:CurrentOffset];
          B := B and LBackMask or LForeMask;
          Mem[SegB800:CurrentOffset] := B;
        end;
    end;
    Inc(CurrentOffset);
  end;

  if CurrentOffset > ROffset then
    exit;

  MiddleAreaLength := ROffset + 1 - CurrentOffset;
  if RBackMask <> 0 then
    Dec(MiddleAreaLength);

  { draw the middle area }
  if MiddleAreaLength > 0 then
  begin
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := 0;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      else
        begin
          { note: NotPut is also handled here }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegB800:CurrentOffset] := ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
    end;
  end;

  { draw the final right byte, if less than 100% full }
  if RBackMask <> 0 then
  begin
    { draw the last byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] xor RForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] or RForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegB800:CurrentOffset] := Mem[SegB800:CurrentOffset] and RBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegB800:CurrentOffset];
          B := B and RBackMask or RForeMask;
          Mem[SegB800:CurrentOffset] := B;
        end;
    end;
  end;
end;

{************************************************************************}
{*                    640x480x2 MCGA mode routines                      *}
{************************************************************************}

procedure InitMCGA640;
begin
  InitInt10hMode($11);
  VideoOfs := 0;
  CurrentCGABorder := 0; {yes, TP7 CGA.BGI behaves *exactly* like that}
end;

procedure SetBkColorMCGA640(ColorNum: ColorType);
begin
  if ColorNum > 15 then
    exit;
  CurrentCGABorder := (CurrentCGABorder and 16) or ColorNum;
  SetCGABorder(CurrentCGABorder);
end;

function GetBkColorMCGA640: ColorType;
begin
  GetBkColorMCGA640 := CurrentCGABorder and 15;
end;

procedure PutPixelMCGA640(X, Y: SmallInt; Pixel: ColorType);
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  { verify clipping and then convert to absolute coordinates...}
  if ClipPixels then
  begin
    if (X < 0) or (X > ViewWidth) then
      exit;
    if (Y < 0) or (Y > ViewHeight) then
      exit;
  end;
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := Y * 80 + (X shr 3);
  Shift := 7 - (X and 7);
  Mask := 1 shl Shift;
  B := Mem[SegA000:Offset];
  B := B and (not Mask) or (Pixel shl Shift);
  Mem[SegA000:Offset] := B;
end;

function GetPixelMCGA640(X, Y: SmallInt): ColorType;
var
  Offset: Word;
  B, Shift: Byte;
begin
  X:= X + StartXViewPort;
  Y:= Y + StartYViewPort;
  Offset := Y * 80 + (X shr 3);
  Shift := 7 - (X and 7);
  B := Mem[SegA000:Offset];
  GetPixelMCGA640 := (B shr Shift) and 1;
end;

procedure DirectPutPixelMCGA640(X, Y: SmallInt);
 { x,y -> must be in global coordinates. No clipping. }
var
  Offset: Word;
  B, Mask, Shift: Byte;
begin
  Offset := Y * 80 + (X shr 3);
  Shift := 7 - (X and 7);
  case CurrentWriteMode of
    XORPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegA000:Offset] := Mem[SegA000:Offset] xor (CurrentColor shl Shift);
      end;
    OrPut:
      begin
        { optimization }
        if CurrentColor = 0 then
          exit;
        Mem[SegA000:Offset] := Mem[SegA000:Offset] or (CurrentColor shl Shift);
      end;
    AndPut:
      begin
        { optimization }
        if CurrentColor = 1 then
          exit;
        { therefore, CurrentColor must be 0 }
        Mem[SegA000:Offset] := Mem[SegA000:Offset] and (not (1 shl Shift));
      end;
    NotPut:
      begin
        Mask := 1 shl Shift;
        B := Mem[SegA000:Offset];
        B := B and (not Mask) or ((CurrentColor xor $01) shl Shift);
        Mem[SegA000:Offset] := B;
      end
    else
      begin
        Mask := 1 shl Shift;
        B := Mem[SegA000:Offset];
        B := B and (not Mask) or (CurrentColor shl Shift);
        Mem[SegA000:Offset] := B;
      end;
  end;
end;

procedure HLineMCGA640(X, X2, Y: SmallInt);
var
  Color: Word;
  YOffset, LOffset, ROffset, CurrentOffset, MiddleAreaLength: Word;
  B, ForeMask, LForeMask, LBackMask, RForeMask, RBackMask: Byte;
  xtmp: SmallInt;
begin
  { must we swap the values? }
  if x > x2 then
  begin
    xtmp := x2;
    x2 := x;
    x:= xtmp;
  end;
  { First convert to global coordinates }
  X   := X + StartXViewPort;
  X2  := X2 + StartXViewPort;
  Y   := Y + StartYViewPort;
  if ClipPixels then
  begin
    if LineClipped(x,y,x2,y,StartXViewPort,StartYViewPort,
           StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
      exit;
  end;
  YOffset := Y * 80;
  LOffset := YOffset + (X shr 3);
  ROffset := YOffset + (X2 shr 3);

  if CurrentWriteMode = NotPut then
    Color := CurrentColor xor $01
  else
    Color := CurrentColor;
  if Color = 1 then
    ForeMask := $FF
  else
    ForeMask := $00;

  LBackMask := Byte($FF00 shr (X and $07));
  LForeMask := (not LBackMask) and ForeMask;

  RBackMask := Byte(not ($FF shl (7 - (X2 and $07))));
  RForeMask := (not RBackMask) and ForeMask;

  if LOffset = ROffset then
  begin
    LBackMask := LBackMask or RBackMask;
    LForeMask := LForeMask and RForeMask;
  end;

  CurrentOffset := LOffset;

  { check if the first byte is only partially full
    (otherwise, it's completely full and is handled as a part of the middle area) }
  if LBackMask <> 0 then
  begin
    { draw the first byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] xor LForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] or LForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] and LBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegA000:CurrentOffset];
          B := B and LBackMask or LForeMask;
          Mem[SegA000:CurrentOffset] := B;
        end;
    end;
    Inc(CurrentOffset);
  end;

  if CurrentOffset > ROffset then
    exit;

  MiddleAreaLength := ROffset + 1 - CurrentOffset;
  if RBackMask <> 0 then
    Dec(MiddleAreaLength);

  { draw the middle area }
  if MiddleAreaLength > 0 then
  begin
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] xor $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          while MiddleAreaLength > 0 do
          begin
            Mem[SegA000:CurrentOffset] := $FF;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegA000:CurrentOffset] := 0;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
      else
        begin
          { note: NotPut is also handled here }
          while MiddleAreaLength > 0 do
          begin
            Mem[SegA000:CurrentOffset] := ForeMask;
            Inc(CurrentOffset);
            Dec(MiddleAreaLength);
          end;
        end;
    end;
  end;

  if RBackMask <> 0 then
  begin
    { draw the last byte }
    case CurrentWriteMode of
      XORPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] xor RForeMask;
        end;
      OrPut:
        begin
          { optimization }
          if CurrentColor = 0 then
            exit;
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] or RForeMask;
        end;
      AndPut:
        begin
          { optimization }
          if CurrentColor = 1 then
            exit;
          { therefore, CurrentColor must be 0 }
          Mem[SegA000:CurrentOffset] := Mem[SegA000:CurrentOffset] and RBackMask;
        end;
      else
        begin
          { note: NotPut is also handled here }
          B := Mem[SegA000:CurrentOffset];
          B := B and RBackMask or RForeMask;
          Mem[SegA000:CurrentOffset] := B;
        end;
    end;
  end;
end;

 {************************************************************************}
 {*                     4-bit planar VGA mode routines                   *}
 {************************************************************************}

  Procedure Init640x200x16;
    begin
      InitInt10hMode($e);
      VideoOfs := 0;
    end;


   Procedure Init640x350x16;
    begin
      InitInt10hMode($10);
      VideoOfs := 0;
    end;



  Procedure Init640x480x16;
    begin
      InitInt10hMode($12);
      VideoOfs := 0;
    end;




{$ifndef asmgraph}
 Procedure PutPixel16(X,Y : smallint; Pixel: ColorType);
 var offset: word;
     dummy: byte;
  Begin
    { verify clipping and then convert to absolute coordinates...}
    if ClipPixels then
    begin
      if (X < 0) or (X > ViewWidth) then
        exit;
      if (Y < 0) or (Y > ViewHeight) then
        exit;
    end;
    X:= X + StartXViewPort;
    Y:= Y + StartYViewPort;
     offset := y * 80 + (x shr 3) + VideoOfs;
     PortW[$3ce] := $0f01;       { Index 01 : Enable ops on all 4 planes }
     PortW[$3ce] := (Pixel and $ff) shl 8; { Index 00 : Enable correct plane and write color }

     PortW[$3ce] := ($8000 shr (x and $7)) or 8; { Select correct bits to modify }
     dummy := Mem[SegA000: offset];  { Latch the data into host space.  }
     Mem[Sega000: offset] := dummy;  { Write the data into video memory }
     PortW[$3ce] := $ff08;         { Enable all bit planes.           }
     PortW[$3ce] := $0001;         { Index 01 : Disable ops on all four planes.         }
   end;
{$else asmgraph}
 Procedure PutPixel16(X,Y : smallint; Pixel: ColorType); assembler;
  asm
    mov  si, [X]
    mov  bx, [Y]
    cmp  byte ptr [ClipPixels], 0
    je   @@ClipDone

    test si, si
    js   @@Done
    test bx, bx
    js   @@Done
    cmp  si, [ViewWidth]
    jg   @@Done
    cmp  bx, [ViewHeight]
    jg   @@Done

@@ClipDone:
    add  si, [StartXViewPort]
    add  bx, [StartYViewPort]
{$ifdef FPC_MM_HUGE}
    mov  ax, SEG SegA000
    mov  es, ax
    mov  es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov  es, [SegA000]
{$endif FPC_MM_HUGE}
    { enable the set / reset function and load the color }
    mov  dx, 3ceh
    mov  ax, 0f01h
    out  dx, ax
    { setup set/reset register }
    mov  ah, byte ptr [Pixel]
    xor  al, al
    out  dx, ax
    { setup the bit mask register }
    mov  al, 8
    { load the bitmask register }
    mov  cx, si
    and  cl, 07h
    mov  ah, 80h
    shr  ah, cl
    out  dx, ax
    { get the x index and divide by 8 for 16-color }
    mov  cl, 3
    shr  si, cl
    { determine the address }
    inc  cx               { CL=4 }
    shl  bx, cl
    mov  di, bx
    shl  di, 1
    shl  di, 1
    add  di, bx
    add  di, si
    add  di, [VideoOfs]
    { send the data through the display memory through set/reset }
    mov  bl,es:[di]
    stosb

    { reset for formal vga operation }
    mov  ax,0ff08h
    out  dx,ax

    { restore enable set/reset register }
    mov  ax,0001h
    out  dx,ax
@@Done:
  end;
{$endif asmgraph}


{$ifndef asmgraph}
 Function GetPixel16(X,Y: smallint):ColorType;
 Var dummy, offset: Word;
     shift: byte;
  Begin
    X:= X + StartXViewPort;
    Y:= Y + StartYViewPort;
    offset := Y * 80 + (x shr 3) + VideoOfs;
    PortW[$3ce] := $0004;
    shift := 7 - (X and 7);
    dummy := (Mem[Sega000:offset] shr shift) and 1;
    Port[$3cf] := 1;
    dummy := dummy or (((Mem[Sega000:offset] shr shift) and 1) shl 1);
    Port[$3cf] := 2;
    dummy := dummy or (((Mem[Sega000:offset] shr shift) and 1) shl 2);
    Port[$3cf] := 3;
    dummy := dummy or (((Mem[Sega000:offset] shr shift) and 1) shl 3);
    GetPixel16 := dummy;
  end;
{$else asmgraph}
 Function GetPixel16(X,Y: smallint):ColorType;assembler;
  asm
{$ifdef FPC_MM_HUGE}
    mov   ax, SEG SegA000
    mov   es, ax
    mov   es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov   es, [SegA000]
{$endif FPC_MM_HUGE}
    mov   dx,03ceh
    mov   ax,0304h
    out   dx,ax
    inc   dx

    mov   di, [X]          { Get X address                    }
    add   di, [StartXViewPort]
    mov   ax, di
    mov   cl, 3
    shr   di, cl

    mov   bx, [Y]
    add   bx, [StartYViewPort]
    inc   cx               { CL=4 }
    shl   bx, cl           { BX=16*(Y+StartYViewPort)*16 }
    mov   si, bx           { SI=16*(Y+StartYViewPort)*16 }
    shl   si, 1            { SI=32*(Y+StartYViewPort)*32 }
    shl   si, 1            { SI=64*(Y+StartYViewPort)*64 }
    add   si, bx           { SI=(64+16)*(Y+StartYViewPort)=80*(Y+StartYViewPort) }
    add   si, di           { SI=correct offset into video segment }
    add   si, [VideoOfs]   { Point to correct page offset... }

    xchg  ax, cx           { 1 byte shorter than 'mov cx, ax' }
    and   cl,7

    mov   bh, 080h
    shr   bh, cl

    { read plane 3 }
    mov   ah,es:[si]       { read display memory }
    and   ah,bh            { save bit in AH       }

    { read plane 2 }
    mov   al,2             { Select plane to read }
    out   dx,al
    mov   bl,es:[si]
    and   bl,bh
    rol   ah,1
    or    ah,bl            { save bit in AH      }

    { read plane 1 }
    dec   ax               { Select plane to read }
    out   dx,al
    mov   bl,es:[si]
    and   bl,bh
    rol   ah,1
    or    ah,bl            { save bit in AH       }

    { read plane 0 }
    dec   ax               { Select plane to read }
    out   dx,al
    seges lodsb
    and   al,bh
    rol   ah,1
    or    al,ah            { add previous bits from AH into AL }

    inc   cx
    rol   al,cl            { 16-bit pixel in AX   }
    { 1 byte shorter than 'xor ah, ah'; will always set ah to 0, because sign(al)=0 }
    cbw
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
    { 1 byte shorter than 'xor dx, dx'; will always set dx to 0, because sign(ah)=0 }
    cwd
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}
  end;
{$endif asmgraph}

Procedure GetScanLine16(x1, x2, y: smallint; var data);

var dummy: word;
    Offset, count, count2, amount, index: word;
    plane: byte;
Begin
  inc(x1,StartXViewPort);
  inc(x2,StartXViewPort);
{$ifdef logging}
  LogLn('GetScanLine16 start, length to get: '+strf(x2-x1+1)+' at y = '+strf(y));
{$Endif logging}
  offset := (Y + StartYViewPort) * 80 + (x1 shr 3) + VideoOfs;
{$ifdef logging}
  LogLn('Offset: '+HexStr(offset,4)+' - ' + strf(offset));
{$Endif logging}
  { first get enough pixels so offset is 16bit aligned }
  amount := 0;
  index := 0;
  If ((x1 and 15) <> 0) Or
     ((x2-x1+1) < 16) Then
    Begin
      If ((x2-x1+1) >= 16+16-(x1 and 15)) Then
        amount := 16-(x1 and 15)
      Else amount := x2-x1+1;
{$ifdef logging}
      LogLn('amount to align to 16bits or to get all: ' + strf(amount));
{$Endif logging}
      For count := 0 to amount-1 do
        WordArray(Data)[Count] := getpixel16(x1-StartXViewPort+Count,y);
      index := amount;
      Inc(Offset,(amount+7) shr 3);
{$ifdef logging}
      LogLn('offset now: '+HexStr(offset,4)+' - ' + strf(offset));
      LogLn('index now: '+strf(index));
{$Endif logging}
    End;
  amount := x2-x1+1 - amount;
{$ifdef logging}
  LogLn('amount left: ' + strf(amount));
{$Endif logging}
  If amount = 0 Then Exit;
  { first get everything from plane 3 (4th plane) }
  PortW[$3ce] := $0304;
  Count := 0;
  For Count := 1 to (amount shr 4) Do
    Begin
      dummy := MemW[SegA000:offset+(Count-1)*2];
      dummy :=
        ((dummy and $ff) shl 8) or
        ((dummy and $ff00) shr 8);
      For Count2 := 15 downto 0 Do
        Begin
          WordArray(Data)[index+Count2] := Dummy and 1;
          Dummy := Dummy shr 1;
        End;
      Inc(Index, 16);
    End;
{ Now get the data from the 3 other planes }
  plane := 3;
  Repeat
    Dec(Index,Count*16);
    Dec(plane);
    Port[$3cf] := plane;
    Count := 0;
    For Count := 1 to (amount shr 4) Do
      Begin
        dummy := MemW[SegA000:offset+(Count-1)*2];
        dummy :=
          ((dummy and $ff) shl 8) or
          ((dummy and $ff00) shr 8);
        For Count2 := 15 downto 0 Do
          Begin
            WordArray(Data)[index+Count2] :=
              (WordArray(Data)[index+Count2] shl 1) or (Dummy and 1);
            Dummy := Dummy shr 1;
          End;
        Inc(Index, 16);
      End;
  Until plane = 0;
  amount := amount and 15;
  Dec(index);
{$ifdef Logging}
  LogLn('Last array index written to: '+strf(index));
  LogLn('amount left: '+strf(amount)+' starting at x = '+strf(index+1));
{$Endif logging}
  dec(x1,startXViewPort);
  For Count := 1 to amount Do
    WordArray(Data)[index+Count] := getpixel16(x1+index+Count,y);
{$ifdef logging}
  inc(x1,startXViewPort);
  LogLn('First 16 bytes gotten with getscanline16: ');
  If x2-x1+1 >= 16 Then
    Count2 := 16
  Else Count2 := x2-x1+1;
  For Count := 0 to Count2-1 Do
    Log(strf(WordArray(Data)[Count])+' ');
  LogLn('');
  If x2-x1+1 >= 16 Then
    Begin
      LogLn('Last 16 bytes gotten with getscanline16: ');
      For Count := 15 downto 0 Do
      Log(strf(WordArray(Data)[x2-x1-Count])+' ');
    End;
  LogLn('');
  GetScanLineDefault(x1-StartXViewPort,x2-StartXViewPort,y,Data);
  LogLn('First 16 bytes gotten with getscanlinedef: ');
  If x2-x1+1 >= 16 Then
    Count2 := 16
  Else Count2 := x2-x1+1;
  For Count := 0 to Count2-1 Do
    Log(strf(WordArray(Data)[Count])+' ');
  LogLn('');
  If x2-x1+1 >= 16 Then
    Begin
      LogLn('Last 16 bytes gotten with getscanlinedef: ');
      For Count := 15 downto 0 Do
      Log(strf(WordArray(Data)[x2-x1-Count])+' ');
    End;
  LogLn('');
  LogLn('GetScanLine16 end');
{$Endif logging}
End;

{$ifndef asmgraph}
 Procedure DirectPutPixel16(X,Y : smallint);
 { x,y -> must be in global coordinates. No clipping. }
  var
   color: word;
  offset: word;
  dummy: byte;
 begin
    If CurrentWriteMode <> NotPut Then
      Color := CurrentColor
    else Color := not CurrentColor;

    case CurrentWriteMode of
       XORPut:
         PortW[$3ce]:=((3 shl 3) shl 8) or 3;
       ANDPut:
         PortW[$3ce]:=((1 shl 3) shl 8) or 3;
       ORPut:
         PortW[$3ce]:=((2 shl 3) shl 8) or 3;
       {not needed, this is the default state (e.g. PutPixel16 requires it)}
       {NormalPut, NotPut:
         PortW[$3ce]:=$0003
       else
         PortW[$3ce]:=$0003}
    end;
    offset := Y * 80 + (X shr 3) + VideoOfs;
    PortW[$3ce] := $f01;
    PortW[$3ce] := Color shl 8;
    PortW[$3ce] := ($8000 shr (X and 7)) or 8;
    dummy := Mem[SegA000: offset];
    Mem[Sega000: offset] := dummy;
    PortW[$3ce] := $ff08;
    PortW[$3ce] := $0001;
    if (CurrentWriteMode = XORPut) or
       (CurrentWriteMode = ANDPut) or
       (CurrentWriteMode = ORPut) then
      PortW[$3ce] := $0003;
 end;
{$else asmgraph}
 Procedure DirectPutPixel16(X,Y : smallint); assembler;
  const
    DataRotateRegTbl: array [NormalPut..NotPut] of Byte=($00,$18,$10,$08,$00);
 { x,y -> must be in global coordinates. No clipping. }
  asm
{$ifdef FPC_MM_HUGE}
    mov  ax, SEG SegA000
    mov  es, ax
    mov  es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov  es, [SegA000]
{$endif FPC_MM_HUGE}
    mov  dx, 3ceh
    xor  ch, ch  { Color mask = 0 }
    mov  bx, [CurrentWriteMode]
    test bl, 4   { NotPut? }
    jz   @@NoNotPut

    { NotPut }
    mov  ch, 15  { Color mask for NotPut }

@@NoNotPut:
    mov  ah, byte ptr [DataRotateRegTbl + bx]
    test ah, ah
    jz   @@NormalPut

    mov  al, 3
    out  dx, ax

@@NormalPut:
    { enable the set / reset function and load the color }
    mov  ax, 0f01h
    out  dx, ax
    { setup set/reset register }
    mov  ah, byte ptr [CurrentColor]
    xor  ah, ch  { Maybe apply the NotPut mask }
    xor  al, al
    out  dx, ax
    { setup the bit mask register }
    mov  al, 8
    { load the bitmask register }
    mov  si, [X]
    mov  cx, si
    and  cl, 07h
    mov  ah, 80h
    shr  ah, cl
    out  dx, ax
    { get the x index and divide by 8 for 16-color }
    mov  cl, 3
    shr  si, cl
    { determine the address }
    mov  bx, [Y]
    inc  cx               { CL=4 }
    shl  bx, cl
    mov  di, bx
    shl  di, 1
    shl  di, 1
    add  di, bx
    add  di, si
    add  di, [VideoOfs]   { add correct page }
    { send the data through the display memory through set/reset }
    mov  al,es:[di]
    stosb

    { reset for formal vga operation }
    mov  ax,0ff08h
    out  dx,ax

    { restore enable set/reset register }
    mov  ax,0001h
    out  dx,ax

    test bl, 3   { NormalPut or NotPut? }
    jz   @@Done  { If yes, skip }

    mov  ax,0003h
    out  dx,ax
@@Done:
  end;
{$endif asmgraph}


  procedure HLine16(x,x2,y: smallint);

   var
      xtmp: smallint;
      ScrOfs,HLength : word;
      LMask,RMask : byte;

   Begin

    { must we swap the values? }
    if x > x2 then
      Begin
        xtmp := x2;
        x2 := x;
        x:= xtmp;
      end;
    { First convert to global coordinates }
    X   := X + StartXViewPort;
    X2  := X2 + StartXViewPort;
    Y   := Y + StartYViewPort;
    if ClipPixels then
      Begin
         if LineClipped(x,y,x2,y,StartXViewPort,StartYViewPort,
                StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
            exit;
      end;
    ScrOfs:=y*ScrWidth+x div 8 + VideoOfs;
    HLength:=x2 div 8-x div 8;
    LMask:=$ff shr (x and 7);
{$push}
{$r-}
{$q-}
    RMask:=$ff shl (7-(x2 and 7));
{$pop}
    if HLength=0 then
      LMask:=LMask and RMask;
    If CurrentWriteMode <> NotPut Then
      PortW[$3ce]:= CurrentColor shl 8
    else PortW[$3ce]:= (not CurrentColor) shl 8;
    PortW[$3ce]:=$0f01;
    case CurrentWriteMode of
       XORPut:
         PortW[$3ce]:=((3 shl 3) shl 8) or 3;
       ANDPut:
         PortW[$3ce]:=((1 shl 3) shl 8) or 3;
       ORPut:
         PortW[$3ce]:=((2 shl 3) shl 8) or 3;
       NormalPut, NotPut:
         PortW[$3ce]:=$0003
       else
         PortW[$3ce]:=$0003
    end;

    PortW[$3ce]:=(LMask shl 8) or 8;
{$push}
{$r-}
{$q-}
    Mem[SegA000:ScrOfs]:=Mem[SegA000:ScrOfs]+1;
{$pop}
    {Port[$3ce]:=8;}{not needed, the register is already selected}
    if HLength>0 then
      begin
         dec(HLength);
         inc(ScrOfs);
         if HLength>0 then
           begin
              Port[$3cf]:=$ff;
{$ifndef tp}
              seg_bytemove(SegA000,ScrOfs,SegA000,ScrOfs,HLength);
{$else}
              move(Ptr(SegA000,ScrOfs)^, Ptr(SegA000,ScrOfs)^, HLength);
{$endif}
              ScrOfs:=ScrOfs+HLength;
           end;
         Port[$3cf]:=RMask;
{$push}
{$r-}
{$q-}
         Mem[Sega000:ScrOfs]:=Mem[SegA000:ScrOfs]+1;
{$pop}
      end;
    { clean up }
    {Port[$3cf]:=0;}{not needed, the register is reset by the next operation:}
    PortW[$3ce]:=$ff08;
    PortW[$3ce]:=$0001;
    PortW[$3ce]:=$0003;
   end;

  procedure VLine16(x,y,y2: smallint);

   var
     ytmp,i: smallint;
     ScrOfs: word;
     BitMask : byte;

  Begin
    { must we swap the values? }
    if y > y2 then
     Begin
       ytmp := y2;
       y2 := y;
       y:= ytmp;
     end;
    { First convert to global coordinates }
    X   := X + StartXViewPort;
    Y2  := Y2 + StartYViewPort;
    Y   := Y + StartYViewPort;
    if ClipPixels then
      Begin
         if LineClipped(x,y,x,y2,StartXViewPort,StartYViewPort,
                StartXViewPort+ViewWidth, StartYViewPort+ViewHeight) then
            exit;
      end;
    ScrOfs:=y*ScrWidth+x div 8 + VideoOfs;
    BitMask:=$80 shr (x and 7);
    If CurrentWriteMode <> NotPut Then
      PortW[$3ce]:= (CurrentColor shl 8)
    else PortW[$3ce]:= (not CurrentColor) shl 8;
    PortW[$3ce]:=$0f01;
    PortW[$3ce]:=(BitMask shl 8) or 8;
    case CurrentWriteMode of
       XORPut:
         PortW[$3ce]:=((3 shl 3) shl 8) or 3;
       ANDPut:
         PortW[$3ce]:=((1 shl 3) shl 8) or 3;
       ORPut:
         PortW[$3ce]:=((2 shl 3) shl 8) or 3;
       NormalPut, NotPut:
         PortW[$3ce]:=$0003
       else
         PortW[$3ce]:=$0003
    end;
    for i:=y to y2 do
      begin
{$push}
{$r-}
{$q-}
         Mem[SegA000:ScrOfs]:=Mem[Sega000:ScrOfs]+1;
{$pop}
         ScrOfs:=ScrOfs+ScrWidth;
      end;
    { clean up }
    {Port[$3cf]:=0;}{not needed, the register is reset by the next operation}
    PortW[$3ce]:=$ff08;
    PortW[$3ce]:=$0001;
    PortW[$3ce]:=$0003;
  End;


 procedure SetVisual200_350(page: word);
  begin
    if page > HardwarePages then exit;
    asm
      mov al, byte ptr [page]    { only lower byte is supported. }
      mov ah,05h
      push ds
      push bp
      int 10h
      pop bp
      pop ds
    end ['DX','CX','BX','AX','SI','DI'];
  end;

 procedure SetActive200(page: word);
  { four page support... }
  begin
    case page of
     0 : VideoOfs := 0;
     1 : VideoOfs := 16384;
     2 : VideoOfs := 32768;
     3 : VideoOfs := 49152;
    else
      VideoOfs := 0;
    end;
  end;

 procedure SetActive350(page: word);
  { one page supPort... }
  begin
    case page of
     0 : VideoOfs := 0;
     1 : VideoOfs := 32768;
    else
      VideoOfs := 0;
    end;
  end;





 {************************************************************************}
 {*                     320x200x256c Routines                            *}
 {************************************************************************}

 Procedure Init320;
    begin
      InitInt10hMode($13);
    end;



{$ifndef asmgraph}
 Procedure PutPixel320(X,Y : smallint; Pixel: ColorType);
 { x,y -> must be in local coordinates. Clipping if required. }
  Begin
    { verify clipping and then convert to absolute coordinates...}
    if ClipPixels then
    begin
      if (X < 0) or (X > ViewWidth) then
        exit;
      if (Y < 0) or (Y > ViewHeight) then
        exit;
    end;
    X:= X + StartXViewPort;
    Y:= Y + StartYViewPort;
    Mem[SegA000:Y*320+X] := Pixel;
  end;
{$else asmgraph}
 Procedure PutPixel320(X,Y : smallint; Pixel: ColorType); assembler;
  asm
    mov    ax, [Y]
    mov    di, [X]
    cmp    byte ptr [ClipPixels], 0
    je     @@ClipDone

    test   ax, ax
    js     @@Done
    test   di, di
    js     @@Done
    cmp    ax, [ViewHeight]
    jg     @@Done
    cmp    di, [ViewWidth]
    jg     @@Done

@@ClipDone:
{$ifdef FPC_MM_HUGE}
    mov    bx, SEG SegA000
    mov    es, bx
    mov    es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov    es, [SegA000]
{$endif FPC_MM_HUGE}
    add    ax, [StartYViewPort]
    add    di, [StartXViewPort]
    xchg   ah, al            { The value of Y must be in AH }
    add    di, ax
    shr    ax, 1
    shr    ax, 1
    add    di, ax
    mov    al, byte ptr [Pixel]
    stosb
@@Done:
  end;
{$endif asmgraph}


{$ifndef asmgraph}
 Function GetPixel320(X,Y: smallint):ColorType;
  Begin
   X:= X + StartXViewPort;
   Y:= Y + StartYViewPort;
   GetPixel320 := Mem[SegA000:Y*320+X];
  end;
{$else asmgraph}
 Function GetPixel320(X,Y: smallint):ColorType; assembler;
  asm
{$ifdef FPC_MM_HUGE}
    mov    ax, SEG SegA000
    mov    es, ax
    mov    es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov    es, [SegA000]
{$endif FPC_MM_HUGE}
    mov    ax, [Y]
    add    ax, [StartYViewPort]
    mov    si, [X]
    add    si, [StartXViewPort]
    xchg   ah, al            { The value of Y must be in AH }
    add    si, ax
    shr    ax, 1
    shr    ax, 1
    add    si, ax
    seges  lodsb
    xor    ah, ah
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
    { 1 byte shorter than 'xor dx, dx'; will always set dx to 0, because sign(ah)=0 }
    cwd
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}
  end;
{$endif asmgraph}


{$ifndef asmgraph}
 Procedure DirectPutPixel320(X,Y : smallint);
 { x,y -> must be in global coordinates. No clipping. }
 var offset: word;
     dummy: Byte;
 begin
   dummy := CurrentColor;
   offset := y * 320 + x;
   case CurrentWriteMode of
     XorPut: dummy := dummy xor Mem[Sega000:offset];
     OrPut: dummy := dummy or Mem[Sega000:offset];
     AndPut: dummy := dummy and Mem[SegA000:offset];
     NotPut: dummy := Not dummy;
   end;
   Mem[SegA000:offset] := dummy;
 end;
{$else asmgraph}
 Procedure DirectPutPixel320(X,Y : smallint); assembler;
 asm
{$ifdef FPC_MM_HUGE}
   mov    ax, SEG SegA000
   mov    es, ax
   mov    es, es:[SegA000]
{$else FPC_MM_HUGE}
   mov    es, [SegA000]
{$endif FPC_MM_HUGE}
   mov    ax, [Y]
   mov    di, [X]
   xchg   ah, al            { The value of Y must be in AH }
   add    di, ax
   shr    ax, 1
   shr    ax, 1
   add    di, ax
   mov    al, byte ptr [CurrentColor]
   { check write mode   }
   mov    bl, byte ptr [CurrentWriteMode]
   cmp    bl, NormalPut
   jne    @@1
   stosb
   jmp    @Done
@@1:
   cmp    bl, XorPut
   jne    @@2
   xor    es:[di], al
   jmp    @Done
@@2:
   cmp    bl, OrPut
   jne    @@3
   or     es:[di], al
   jmp    @Done
@@3:
   cmp    bl, AndPut
   jne    @NotPutMode
   and    es:[di], al
   jmp    @Done
@NotPutMode:
   not    al
   stosb
@Done:
 end;
{$endif asmgraph}


 procedure SetVisual320(page: word);
  { no page supPort... }
  begin
  end;

 procedure SetActive320(page: word);
  { no page supPort... }
  begin
  end;

 {************************************************************************}
 {*                       Mode-X related routines                        *}
 {************************************************************************}
const CrtAddress: word = 0;

{$ifndef asmgraph}
 procedure InitModeX;
   begin
     {see if we are using color-/monochrome display}
     if (Port[$3CC] and 1) <> 0 then
       CrtAddress := $3D4  { color }
     else
       CrtAddress := $3B4; { monochrome }

     InitInt10hMode($13);

     Port[$3C4] := $04;  {select memory-mode-register at sequencer port }
                         { bit 3 := 0: don't chain the 4 planes         }
                         { bit 2 := 1: no odd/even mechanism            }
     Port[$3C5] := (Port[$3C5] and $F7) or $04;

     Port[$3C4] := $02; {s.a.: address sequencer reg. 2 (=map-mask),... }
     Port[$3C5] := $0F; {...and allow access to all 4 bit maps          }

     { starting with segment A000h, set 8000h logical words = 4*8000h
       physical words (because of 4 bitplanes) to 0                     }
     asm
{$ifdef FPC_MM_HUGE}
       MOV AX,SEG SegA000
       MOV ES,AX
       MOV ES,ES:[SegA000]
{$else FPC_MM_HUGE}
       MOV ES, [SegA000]
{$endif FPC_MM_HUGE}
       XOR DI,DI
       XOR AX,AX
       MOV CX,8000h
       CLD
       REP STOSW
     end ['AX','CX','DI'];

     {address the underline-location-register at the CRT-controller
      port, read out the according data register:                       }
     Port[CRTAddress] := $14;
     {bit 6:=0: no double word addressing scheme in video RAM           }
     Port[CRTAddress+1] := Port[CRTAddress+1] and $BF;

     Port[CRTAddress] := $17; {select mode control register             }
     {bit 6 := 1: memory access scheme=linear bit array                 }
     Port[CRTAddress+1] := Port[CRTAddress+1] or $40;
   end;
{$else asmgraph}
 procedure InitModeX; assembler;
   asm
     {see if we are using color-/monochrome display}
     MOV DX,3CCh  {use output register:     }
     IN AL,DX
     TEST AL,1    {is it a color display?    }
     MOV DX,3D4h
     JNZ @L1      {yes  }
     MOV DX,3B4h  {no  }
  @L1:          {DX = 3B4h / 3D4h = CRTAddress-register for monochrome/color}
     MOV CRTAddress,DX

     MOV  AX, 0013h
     CMP  BYTE PTR [DontClearGraphMemory],0
     JE   @L2
     OR   AL, 080h
  @L2:
     push ds
     push bp
     INT  10h
     pop bp
     pop ds
     MOV DX,03C4h   {select memory-mode-register at sequencer Port    }
     MOV AL,04
     OUT DX,AL
     INC DX         {read in data via the according data register     }
     IN  AL,DX
     AND AL,0F7h    {bit 3 := 0: don't chain the 4 planes}
     OR  AL,04      {bit 2 := 1: no odd/even mechanism }
     OUT DX,AL      {activate new settings    }
     DEC DX         {s.a.: address sequencer reg. 2 (=map-mask),...   }
     MOV AL,02
     OUT DX,AL
     INC DX
     MOV AL,0Fh     {...and allow access to all 4 bit maps            }
     OUT DX,AL

     {starting with segment A000h, set 8000h logical   }
     {words = 4*8000h physical words (because of 4     }
     {bitplanes) to 0                                  }
{$ifdef FPC_MM_HUGE}
     MOV AX,SEG SegA000
     MOV ES,AX
     MOV ES,ES:[SegA000]
{$else FPC_MM_HUGE}
     MOV ES, [SegA000]
{$endif FPC_MM_HUGE}
     XOR DI,DI
     XOR AX,AX
     MOV CX,8000h
     CLD
     REP STOSW

     MOV DX,CRTAddress  {address the underline-location-register at }
     MOV AL,14h         {the CRT-controller Port, read out the according      }
     OUT DX,AL          {data register:                            }
     INC DX
     IN  AL,DX
     AND AL,0BFh    {bit 6:=0: no double word addressing scheme in}
     OUT DX,AL      {video RAM                              }
     DEC DX
     MOV AL,17h     {select mode control register     }
     OUT DX,AL
     INC DX
     IN  AL,DX
     OR  AL,40h     {bit 6 := 1: memory access scheme=linear bit array      }
     OUT DX,AL
  end;
{$endif asmgraph}


{$ifndef asmgraph}
 function GetPixelX(X,Y: smallint): ColorType;
  var offset: word;
  begin
    X := X + StartXViewPort;
    Y := Y + StartYViewPort;
    offset := y * 80 + x shr 2 + VideoOfs;
    PortW[$3ce] := ((x and 3) shl 8) + 4;
    GetPixelX := Mem[SegA000:offset];
  end;
{$else asmgraph}
 function GetPixelX(X,Y: smallint): ColorType; assembler;
  asm
{$ifdef FPC_MM_HUGE}
    mov ax, SEG SegA000
    mov es, ax
    mov es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov es, [SegA000]
{$endif FPC_MM_HUGE}
    mov si,[Y]                   ; (* SI = Y coordinate                 *)
    add si,[StartYViewPort]
    (* Multiply by 80 start *)
    mov cl, 4
    shl si, cl
    mov bx, si
    shl si, 1
    shl si, 1
    add si, bx                   ;  (* Multiply Value by 80             *)
    (* End multiply by 80  *)
    mov cx, [X]
    add cx, [StartXViewPort]
    mov ax, cx
    {SI = Y * LINESIZE, CX = X, coordinates admissible}
    shr ax, 1                    ; (* Faster on 286/86 machines         *)
    shr ax, 1
    add si, ax                ; {SI = Y * LINESIZE + (X SHR 2) }
    add si, [VideoOfs]  ; (* Pointing at start of Active page *)
    (* Select plane to use *)
    mov dx, 03ceh
    mov al, 4
    and cl, 03h
    mov ah, cl
    out dx, ax
    (* End selection of plane *)
    seges lodsb
    xor ah, ah
{$ifdef FPC_GRAPH_SUPPORTS_TRUECOLOR}
    { 1 byte shorter than 'xor dx, dx'; will always set dx to 0, because sign(ah)=0 }
    cwd
{$endif FPC_GRAPH_SUPPORTS_TRUECOLOR}
  end;
{$endif asmgraph}

 procedure SetVisualX(page: word);
  { 4 page supPort... }

   Procedure SetVisibleStart(AOffset: word); Assembler;
   (* Select where the left corner of the screen will be *)
   { By Matt Pritchard }
    asm
      { Wait if we are currently in a Vertical Retrace        }
     MOV     DX, INPUT_1         { Input Status #1 Register       }
   @DP_WAIT0:
     IN      AL, DX              { Get VGA status                 }
     AND     AL, VERT_RETRACE    { In Display mode yet?           }
     JNZ     @DP_WAIT0           { If Not, wait for it            }

    { Set the Start Display Address to the new page         }

     MOV     DX, CRTC_Index      { We Change the VGA Sequencer    }
     MOV     AL, START_DISP_LO   { Display Start Low Register     }
     MOV     AH, BYTE PTR [AOffset] { Low 8 Bits of Start Addr    }
     OUT     DX, AX              { Set Display Addr Low           }
     MOV     AL, START_DISP_HI   { Display Start High Register    }
     MOV     AH, BYTE PTR [AOffset+1] { High 8 Bits of Start Addr }
     OUT     DX, AX              { Set Display Addr High          }
     { Wait for a Vertical Retrace to smooth out things      }

     MOV     DX, INPUT_1         { Input Status #1 Register       }

  @DP_WAIT1:
     IN      AL, DX              { Get VGA status                 }
     AND     AL, VERT_RETRACE    { Vertical Retrace Start?        }
     JZ      @DP_WAIT1           { If Not, wait for it            }
    { Now Set Display Starting Address                     }
  end;

  begin
    Case page of
      0: SetVisibleStart(0);
      1: SetVisibleStart(16000);
      2: SetVisibleStart(32000);
      3: SetVisibleStart(48000);
    else
      SetVisibleStart(0);
    end;
  end;

 procedure SetActiveX(page: word);
  { 4 page supPort... }
  begin
   case page of
     0: VideoOfs := 0;
     1: VideoOfs := 16000;
     2: VideoOfs := 32000;
     3: VideoOfs := 48000;
   else
     VideoOfs:=0;
   end;
  end;

{$ifndef asmgraph}
 Procedure PutPixelX(X,Y: smallint; color:ColorType);
 var offset: word;
  begin
    { verify clipping and then convert to absolute coordinates...}
    if ClipPixels then
    begin
      if (X < 0) or (X > ViewWidth) then
        exit;
      if (Y < 0) or (Y > ViewHeight) then
        exit;
    end;
    X:= X + StartXViewPort;
    Y:= Y + StartYViewPort;
    offset := y * 80 + x shr 2 + VideoOfs;
    PortW[$3c4] := (hi(word(FirstPlane)) shl 8) shl (x and 3)+ lo(word(FirstPlane));
    Mem[SegA000:offset] := color;
  end;
{$else asmgraph}
 Procedure PutPixelX(X,Y: smallint; color:ColorType); assembler;
  asm
    mov ax, [X]
    mov di, [Y]                  ; (* DI = Y coordinate                 *)

    cmp byte ptr [ClipPixels], 0
    je @@ClipDone

    test   ax, ax
    js     @@Done
    test   di, di
    js     @@Done
    cmp    ax, [ViewWidth]
    jg     @@Done
    cmp    di, [ViewHeight]
    jg     @@Done

@@ClipDone:
{$ifdef FPC_MM_HUGE}
    mov bx, SEG SegA000
    mov es, bx
    mov es, es:[SegA000]
{$else FPC_MM_HUGE}
    mov es, [SegA000]
{$endif FPC_MM_HUGE}
    add di, [StartYViewPort]
    (* Multiply by 80 start *)
    mov cl, 4
    shl di, cl
    mov bx, di
    shl di, 1
    shl di, 1
    add di, bx                   ;  (* Multiply Value by 80             *)
    (* End multiply by 80  *)
    add ax, [StartXViewPort]
    mov cx, ax
    {DI = Y * LINESIZE, CX = X, coordinates admissible}
    shr ax, 1
    shr ax, 1
    add di, ax                ; {DI = Y * LINESIZE + (X SHR 2) }
    add di, [VideoOfs]        ; (* Pointing at start of Active page *)
    (* Select plane to use *)
    mov dx, 03c4h
    mov ax, FirstPlane        ; (* Map Mask & Plane Select Register *)
    and cl, 03h               ; (* Get Plane Bits                   *)
    shl ah, cl                ; (* Get Plane Select Value           *)
    out dx, ax
    (* End selection of plane *)
    mov al, byte ptr [Color]  ; { only lower byte is used. }
    stosb
@@Done:
  end;
{$endif asmgraph}


{$ifndef asmgraph}
 Procedure DirectPutPixelX(X,Y: smallint);
 { x,y -> must be in global coordinates. No clipping. }
 Var offset: Word;
     dummy: Byte;
 begin
   offset := y * 80 + x shr 2 + VideoOfs;
   case CurrentWriteMode of
     XorPut:
       begin
         PortW[$3ce] := ((x and 3) shl 8) + 4;
         dummy := CurrentColor xor Mem[Sega000: offset];
       end;
     OrPut:
       begin
         PortW[$3ce] := ((x and 3) shl 8) + 4;
         dummy := CurrentColor or Mem[Sega000: offset];
       end;
     AndPut:
       begin
         PortW[$3ce] := ((x and 3) shl 8) + 4;
         dummy := CurrentColor and Mem[Sega000: offset];
       end;
     NotPut: dummy := Not CurrentColor;
     else dummy := CurrentColor;
   end;
   PortW[$3c4] := (hi(word(FirstPlane)) shl 8) shl (x and 3)+ lo(word(FirstPlane));
   Mem[Sega000: offset] := Dummy;
 end;
{$else asmgraph}
 Procedure DirectPutPixelX(X,Y: smallint); assembler;
 asm
{$ifdef FPC_MM_HUGE}
   mov bx, SEG SegA000
   mov es, bx
   mov es, es:[SegA000]
{$else FPC_MM_HUGE}
   mov es, [SegA000]
{$endif FPC_MM_HUGE}
   mov di, [Y]                   ; (* DI = Y coordinate                 *)
 (* Multiply by 80 start *)
   mov cl, 4
   shl di, cl
   mov bx, di
   shl di, 1
   shl di, 1
   add di, bx                   ;  (* Multiply Value by 80             *)
 (* End multiply by 80  *)
   mov cx, [X]
   mov ax, cx
  {DI = Y * LINESIZE, CX = X, coordinates admissible}
   shr ax, 1
   shr ax, 1
   add di, ax                ; {DI = Y * LINESIZE + (X SHR 2) }
   add di, [VideoOfs]        ; (* Pointing at start of Active page *)
 (* Select plane to use *)
   mov dx, 03c4h
   mov ax, FirstPlane        ; (* Map Mask & Plane Select Register *)
   and cl, 03h               ; (* Get Plane Bits                   *)
   shl ah, cl                ; (* Get Plane Select Value           *)
   out dx, ax
 (* End selection of plane *)
   mov al, byte ptr [CurrentColor] ; { only lower byte is used. }
   { check write mode   }
   mov    bl, byte ptr [CurrentWriteMode]
   cmp    bl, NormalPut
   jne    @@1
   { NormalPut }
   stosb
   jmp    @Done
@@1:
   cmp    bl, XorPut
   jne    @@2
   { XorPut }
   mov    bh, al
   mov    dx, 03ceh
   mov    ah, cl
   mov    al, 4
   out    dx, ax
   xor    es:[di], bh
   jmp    @Done
@@2:
   cmp    bl, OrPut
   jne    @@3
   { OrPut }
   mov    bh, al
   mov    dx, 03ceh
   mov    ah, cl
   mov    al, 4
   out    dx, ax
   or     es:[di], bh
   jmp    @Done
@@3:
   cmp    bl, AndPut
   jne    @NotPutMode
   { AndPut }
   mov    bh, al
   mov    dx, 03ceh
   mov    ah, cl
   mov    al, 4
   out    dx, ax
   and    es:[di], bh
   jmp    @Done
@NotPutMode:
   { NotPut }
   not    al
   stosb
@Done:
 end;
{$endif asmgraph}



 {************************************************************************}
 {*                       General routines                               *}
 {************************************************************************}
 var
  SavePtr : pointer;    { pointer to video state                 }
{  CrtSavePtr: pointer;}  { pointer to video state when CrtMode gets called }
  StateSize: word;      { size in 64 byte blocks for video state }
  VideoMode: byte;      { old video mode before graph mode       }
  SaveSupPorted : Boolean;    { Save/Restore video state supPorted? }


 Procedure SaveStateVGA;
 var
  regs: Registers;
  begin
    SaveSupPorted := FALSE;
    SavePtr := nil;
    { Get the video mode }
    regs.ah:=$0f;
    intr($10,regs);
    VideoMode:=regs.al;
    { saving/restoring video state screws up Windows (JM) }
    if inWindows then
      exit;
    { Prepare to save video state...}
    regs.ax:=$1C00;       { get buffer size to save state }
    regs.cx:=%00000111;   { Save DAC / Data areas / Hardware states }
    intr($10,regs);
    StateSize:=regs.bx;
    SaveSupPorted:=(regs.al=$1c);
    if SaveSupPorted then
      begin
        GetMem(SavePtr, 64*StateSize); { values returned in 64-byte blocks }
        if not assigned(SavePtr) then
           RunError(203);
        { call the real mode interrupt ... }
        regs.ax := $1C01;      { save the state buffer                   }
        regs.cx := $07;        { Save DAC / Data areas / Hardware states }
        regs.es := Seg(SavePtr^);
        regs.bx := Ofs(SavePtr^);
        Intr($10,regs);
        { restore state, according to Ralph Brown Interrupt list }
        { some BIOS corrupt the hardware after a save...         }
        regs.ax := $1C02;      { restore the state buffer                }
        regs.cx := $07;        { rest DAC / Data areas / Hardware states }
        regs.es := Seg(SavePtr^);
        regs.bx := Ofs(SavePtr^);
        Intr($10,regs);
      end;
  end;

 procedure RestoreStateVGA;
  var
   regs:Registers;
   SavePtrCopy: Pointer;
  begin
     { go back to the old video mode...}
     regs.ax:=VideoMode;
     intr($10,regs);
     { then restore all state information }
     if assigned(SavePtr) and SaveSupPorted then
      begin
         regs.ax := $1C02;      { restore the state buffer                }
         regs.cx := $07;        { rest DAC / Data areas / Hardware states }
         regs.es := Seg(SavePtr^);
         regs.bx := Ofs(SavePtr^);
         Intr($10,regs);

         SavePtrCopy := SavePtr;
         SavePtr := nil;
         FreeMem(SavePtrCopy, 64*StateSize);
       end;
  end;


   Procedure SetVGARGBAllPalette(const Palette:PaletteType);
    var
      c: byte;
    begin
      { wait for vertical retrace start/end}
      while (port[$3da] and $8) <> 0 do;
      while (port[$3da] and $8) = 0 do;
      If MaxColor = 16 Then
        begin
          for c := 0 to 15 do
            begin
              { translate the color number for 16 color mode }
              portb[$3c8] := toRealCols16[c];
              portb[$3c9] := palette.colors[c].red shr 2;
              portb[$3c9] := palette.colors[c].green shr 2;
              portb[$3c9] := palette.colors[c].blue shr 2;
            end
        end
      else
        begin
          portb[$3c8] := 0;
          for c := 0 to 255 do
            begin
              { no need to set port[$3c8] every time if you set the entries }
              { for successive colornumbers (JM)                            }
              portb[$3c9] := palette.colors[c].red shr 2;
              portb[$3c9] := palette.colors[c].green shr 2;
              portb[$3c9] := palette.colors[c].blue shr 2;
          end
        end;
    End;


   { VGA is never a direct color mode, so no need to check ... }
   Procedure SetVGARGBPalette(ColorNum, RedValue, GreenValue,
      BlueValue : smallint);
    begin
      { translate the color number for 16 color mode }
      If MaxColor = 16 Then
        ColorNum := ToRealCols16[ColorNum];
      asm
        { on some hardware - there is a snow like effect       }
        { when changing the palette register directly          }
        { so we wait for a vertical retrace start period.      }
        push ax
        push dx
        mov dx, $03da
      @1:
        in    al, dx          { Get input status register    }
        test  al, $08         { check if in vertical retrace }
        jnz   @1              { yes, complete it             }
                              { we have to wait for the next }
                              { retrace to assure ourselves  }
                              { that we have time to complete }
                              { the DAC operation within      }
                              { the vertical retrace period   }
       @2:
        in    al, dx
        test  al, $08
        jz    @2              { repeat until vertical retrace start }

        mov dx, $03c8       { Set color register address to use }
        mov ax, [ColorNum]
        out dx, al
        inc dx              { Point to DAC registers            }
        mov ax, [RedValue]  { Get RedValue                      }
        shr ax, 1
        shr ax, 1
        out dx, al
        mov ax, [GreenValue]{ Get RedValue                      }
        shr ax, 1
        shr ax, 1
        out dx, al
        mov ax, [BlueValue] { Get RedValue                      }
        shr ax, 1
        shr ax, 1
        out dx, al
        pop dx
        pop ax
      end
    End;


   { VGA is never a direct color mode, so no need to check ... }
  Procedure GetVGARGBPalette(ColorNum: smallint; Var
      RedValue, GreenValue, BlueValue : smallint);
   begin
     If MaxColor = 16 Then
       ColorNum := ToRealCols16[ColorNum];
     Port[$03C7] := ColorNum;
     { we must convert to lsb values... because the vga uses the 6 msb bits }
     { which is not compatible with anything.                               }
     RedValue := smallint(Port[$3C9]) shl 2;
     GreenValue := smallint(Port[$3C9]) shl 2;
     BlueValue := smallint(Port[$3C9]) shl 2;
   end;


 {************************************************************************}
 {*                       VESA related routines                          *}
 {************************************************************************}
{$I vesa.inc}

 {************************************************************************}
 {*                       General routines                               *}
 {************************************************************************}
 procedure CloseGraph;
 Begin
    If not isgraphmode then
      begin
        _graphresult := grnoinitgraph;
        exit
      end;
    if not assigned(RestoreVideoState) then
      RunError(216);
    RestoreVideoState;
    isgraphmode := false;
 end;
(*
 procedure LoadFont8x8;

   var
      r : registers;
      x,y,c : longint;
      data : array[0..127,0..7] of byte;

   begin
      r.ah:=$11;
      r.al:=$30;
      r.bh:=1;
      RealIntr($10,r);
      dosmemget(r.es,r.bp,data,sizeof(data));
      for c:=0 to 127 do
        for y:=0 to 7 do
          for x:=0 to 7 do
            if (data[c,y] and ($80 shr x))<>0 then
              DefaultFontData[chr(c),y,x]:=1
            else
              DefaultFontData[chr(c),y,x]:=0;
      { second part }
      r.ah:=$11;
      r.al:=$30;
      r.bh:=0;
      RealIntr($10,r);
      dosmemget(r.es,r.bp,data,sizeof(data));
      for c:=0 to 127 do
        for y:=0 to 7 do
          for x:=0 to 7 do
            if (data[c,y] and ($80 shr x))<>0 then
              DefaultFontData[chr(c+128),y,x]:=1
            else
              DefaultFontData[chr(c+128),y,x]:=0;
   end;
*)
  function QueryAdapterInfo:PModeInfo;
  { This routine returns the head pointer to the list }
  { of supPorted graphics modes.                      }
  { Returns nil if no graphics mode supported.        }
  { This list is READ ONLY!                           }

    function Test6845(CRTCPort: Word): Boolean;
    const
      TestRegister = $0F;
    var
      OldValue, TestValue, ReadValue: Byte;
    begin
      { save the old value }
      Port[CRTCPort] := TestRegister;
      OldValue := Port[CRTCPort + 1];
      TestValue := OldValue xor $56;

      { try writing a new value to the CRTC register }
      Port[CRTCPort] := TestRegister;
      Port[CRTCPort + 1] := TestValue;

      { check if the value has been written }
      Port[CRTCPort] := TestRegister;
      ReadValue := Port[CRTCPort + 1];
      if ReadValue = TestValue then
      begin
        Test6845 := True;
        { restore old value }
        Port[CRTCPort] := TestRegister;
        Port[CRTCPort + 1] := OldValue;
      end
      else
        Test6845 := False;
    end;

    procedure FillCommonCGA320(var mode: TModeInfo);
    begin
      mode.HardwarePages := 0;
      mode.MaxColor := 4;
      mode.PaletteSize := 16;
      mode.DirectColor := FALSE;
      mode.MaxX := 319;
      mode.MaxY := 199;
      mode.DirectPutPixel:=@DirectPutPixelCGA320;
      mode.PutPixel:=@PutPixelCGA320;
      mode.GetPixel:=@GetPixelCGA320;
      mode.SetRGBPalette := @SetVGARGBPalette;
      mode.GetRGBPalette := @GetVGARGBPalette;
      mode.SetAllPalette := @SetVGARGBAllPalette;
      mode.HLine := @HLineCGA320;
      mode.SetBkColor := @SetBkColorCGA320;
      mode.GetBkColor := @GetBkColorCGA320;
      mode.XAspect := 8333;
      mode.YAspect := 10000;
    end;

    procedure FillCommonCGA640(var mode: TModeInfo);
    begin
      mode.HardwarePages := 0;
      mode.MaxColor := 2;
      mode.PaletteSize := 16;
      mode.DirectColor := FALSE;
      mode.MaxX := 639;
      mode.MaxY := 199;
      mode.DirectPutPixel:=@DirectPutPixelCGA640;
      mode.PutPixel:=@PutPixelCGA640;
      mode.GetPixel:=@GetPixelCGA640;
      mode.SetRGBPalette := @SetVGARGBPalette;
      mode.GetRGBPalette := @GetVGARGBPalette;
      mode.SetAllPalette := @SetVGARGBAllPalette;
      mode.HLine := @HLineCGA640;
      mode.SetBkColor := @SetBkColorCGA640;
      mode.GetBkColor := @GetBkColorCGA640;
      mode.XAspect := 4167;
      mode.YAspect := 10000;
    end;

    procedure FillCommonEGAVGA16(var mode: TModeInfo);
    begin
      mode.MaxColor := 16;
      mode.DirectColor := FALSE;
      mode.PaletteSize := mode.MaxColor;
      mode.DirectPutPixel:=@DirectPutPixel16;
      mode.PutPixel:=@PutPixel16;
      mode.GetPixel:=@GetPixel16;
      mode.SetRGBPalette := @SetVGARGBPalette;
      mode.GetRGBPalette := @GetVGARGBPalette;
      mode.SetAllPalette := @SetVGARGBAllPalette;
      mode.HLine := @HLine16;
      mode.VLine := @VLine16;
      mode.GetScanLine := @GetScanLine16;
    end;

    procedure FillCommonVESA16(var mode: TModeInfo);
    begin
      mode.MaxColor := 16;
      { the ModeInfo is automatically set if the mode is supPorted }
      { by the call to SearchVESAMode.                             }
      mode.HardwarePages := VESAModeInfo.NumberOfPages;
      mode.DirectColor := FALSE;
      mode.PaletteSize := mode.MaxColor;
      mode.DirectPutPixel:=@DirectPutPixVESA16;
      mode.SetRGBPalette := @SetVESARGBPalette;
      mode.GetRGBPalette := @GetVESARGBPalette;
{$ifdef fpc}
      mode.SetAllPalette := @SetVESARGBAllPalette;
{$endif fpc}
      mode.PutPixel:=@PutPixVESA16;
      mode.GetPixel:=@GetPixVESA16;
      mode.SetVisualPage := @SetVisualVESA;
      mode.SetActivePage := @SetActiveVESA;
      mode.HLine := @HLineVESA16;
    end;

    procedure FillCommonVESA256(var mode: TModeInfo);
    begin
      mode.MaxColor := 256;
      { the ModeInfo is automatically set if the mode is supPorted }
      { by the call to SearchVESAMode.                             }
      mode.HardwarePages := VESAModeInfo.NumberOfPages;
      mode.PaletteSize := mode.MaxColor;
      mode.DirectColor := FALSE;
      mode.DirectPutPixel:=@DirectPutPixVESA256;
      mode.PutPixel:=@PutPixVESA256;
      mode.GetPixel:=@GetPixVESA256;
      mode.SetRGBPalette := @SetVESARGBPalette;
      mode.GetRGBPalette := @GetVESARGBPalette;
{$ifdef fpc}
      mode.SetAllPalette := @SetVESARGBAllPalette;
{$endif fpc}
      mode.SetVisualPage := @SetVisualVESA;
      mode.SetActivePage := @SetActiveVESA;
      mode.hline := @HLineVESA256;
      mode.vline := @VLineVESA256;
      mode.GetScanLine := @GetScanLineVESA256;
      mode.PatternLine := @PatternLineVESA256;
    end;

    procedure FillCommonVESA32kOr64k(var mode: TModeInfo);
    begin
      { the ModeInfo is automatically set if the mode is supPorted }
      { by the call to SearchVESAMode.                             }
      mode.HardwarePages := VESAModeInfo.NumberOfPages;
      mode.DirectColor := TRUE;
      mode.DirectPutPixel:=@DirectPutPixVESA32kOr64k;
      mode.PutPixel:=@PutPixVESA32kOr64k;
      mode.GetPixel:=@GetPixVESA32kOr64k;
      mode.SetRGBPalette := @SetVESARGBPalette;
      mode.GetRGBPalette := @GetVESARGBPalette;
      mode.SetVisualPage := @SetVisualVESA;
      mode.SetActivePage := @SetActiveVESA;
      mode.HLine := @HLineVESA32kOr64k;
    end;

    procedure FillCommonVESA32k(var mode: TModeInfo);
    begin
      FillCommonVESA32kOr64k(mode);
      mode.MaxColor := 32768;
      mode.PaletteSize := mode.MaxColor;
    end;
    procedure FillCommonVESA64k(var mode: TModeInfo);
    begin
      FillCommonVESA32kOr64k(mode);
      mode.MaxColor := 65536;
      mode.PaletteSize := mode.MaxColor;
    end;

    procedure FillCommonVESA320x200(var mode: TModeInfo);
    begin
      mode.DriverNumber := VESA;
      mode.ModeName:='320 x 200 VESA';
      mode.MaxX := 319;
      mode.MaxY := 199;
      mode.XAspect := 8333;
      mode.YAspect := 10000;
    end;
    procedure FillCommonVESA640x480(var mode: TModeInfo);
    begin
      mode.DriverNumber := VESA;
      mode.ModeName:='640 x 480 VESA';
      mode.MaxX := 639;
      mode.MaxY := 479;
      mode.XAspect := 10000;
      mode.YAspect := 10000;
    end;
    procedure FillCommonVESA800x600(var mode: TModeInfo);
    begin
      mode.DriverNumber := VESA;
      mode.ModeName:='800 x 600 VESA';
      mode.MaxX := 799;
      mode.MaxY := 599;
      mode.XAspect := 10000;
      mode.YAspect := 10000;
    end;
    procedure FillCommonVESA1024x768(var mode: TModeInfo);
    begin
      mode.DriverNumber := VESA;
      mode.ModeName:='1024 x 768 VESA';
      mode.MaxX := 1023;
      mode.MaxY := 767;
      mode.XAspect := 10000;
      mode.YAspect := 10000;
    end;
    procedure FillCommonVESA1280x1024(var mode: TModeInfo);
    begin
      mode.DriverNumber := VESA;
      mode.ModeName:='1280 x 1024 VESA';
      mode.MaxX := 1279;
      mode.MaxY := 1023;
      mode.XAspect := 10000;
      mode.YAspect := 10000;
    end;

   var
    HGCDetected : Boolean = FALSE;
    CGADetected : Boolean = FALSE; { TRUE means real CGA, *not* EGA or VGA }
    EGAColorDetected : Boolean = FALSE; { TRUE means true EGA with a color monitor }
    EGAMonoDetected : Boolean = FALSE; { TRUE means true EGA with a monochrome (MDA) monitor }
    MCGADetected : Boolean = FALSE;
    VGADetected : Boolean = FALSE;
    mode: TModeInfo;
    regs: Registers;
   begin
     QueryAdapterInfo := ModeList;
     { If the mode listing already exists... }
     { simply return it, without changing    }
     { anything...                           }
     if assigned(ModeList) then
       exit;

     { check if VGA/MCGA adapter supported...       }
     regs.ax:=$1a00;
     intr($10,regs);    { get display combination code...}
     if regs.al=$1a then
       begin
         while regs.bx <> 0 do
           begin
             case regs.bl of
               1: { monochrome adapter (MDA or HGC) }
                 begin
                   { check if Hercules adapter supported ... }
                   HGCDetected:=Test6845($3B4);
                 end;
               2: CGADetected:=TRUE;
               4: EGAColorDetected:=TRUE;
               5: EGAMonoDetected:=TRUE;
               {6: PGA, this is rare stuff, how do we handle it? }
               7, 8: VGADetected:=TRUE;
               10, 11, 12: MCGADetected:=TRUE;
             end;
             { check both primary and secondary display adapter }
             regs.bx:=regs.bx shr 8;
           end;
       end;
     if VGADetected then
       begin
         { now check if this is the ATI EGA }
         regs.ax:=$1c00; { get state size for save...     }
                         { ... all important data         }
         regs.cx:=$07;
         intr($10,regs);
         VGADetected:=regs.al=$1c;
       end;
     if not VGADetected and not MCGADetected and
        not EGAColorDetected and not EGAMonoDetected and
        not CGADetected and not HGCDetected then
       begin
         { check if EGA adapter supported...       }
         regs.ah:=$12;
         regs.bx:=$FF10;
         intr($10,regs);     { get EGA information }
         if regs.bh<>$FF then
           case regs.cl of
             0..3, { primary: MDA/HGC,   secondary: EGA color }
             6..9: { primary: EGA color, secondary: MDA/HGC (optional) }
               begin
                 EGAColorDetected:=TRUE;
                 { check if Hercules adapter supported ... }
                 HGCDetected:=Test6845($3B4);
               end;
             4..5, { primary: CGA,        secondary: EGA mono }
             10..11: { primary: EGA mono, secondary: CGA (optional) }
               begin
                 EGAMonoDetected:=TRUE;
                 { check if CGA adapter supported ... }
                 CGADetected := Test6845($3D4);
               end;
           end;
       end;
     { older than EGA? }
     if not VGADetected and not MCGADetected and
        not EGAColorDetected and not EGAMonoDetected and
        not CGADetected and not HGCDetected then
       begin
         { check if Hercules adapter supported ... }
         HGCDetected := Test6845($3B4);
         { check if CGA adapter supported ... }
         CGADetected := Test6845($3D4);
       end;
{$ifdef logging}
     LogLn('HGC detected: '+strf(Longint(HGCDetected)));
     LogLn('CGA detected: '+strf(Longint(CGADetected)));
     LogLn('EGA color detected: '+strf(Longint(EGAColorDetected)));
     LogLn('EGA mono detected: '+strf(Longint(EGAMonoDetected)));
     LogLn('MCGA detected: '+strf(Longint(MCGADetected)));
     LogLn('VGA detected: '+strf(Longint(VGADetected)));
{$endif logging}
     if HGCDetected then
       begin
         { HACK:
           until we create Save/RestoreStateHGC, we use Save/RestoreStateVGA
           with the inWindows flag enabled (so we only save the mode number
           and nothing else) }
         if not VGADetected then
           inWindows := true;
         SaveVideoState := @SaveStateVGA;
         RestoreVideoState := @RestoreStateVGA;

         InitMode(mode);
         mode.DriverNumber := HercMono;
         mode.HardwarePages := 1;
         mode.ModeNumber := HercMonoHi;
         mode.ModeName:='720 x 348 HERCULES';
         mode.MaxColor := 2;
         mode.PaletteSize := 16;
         mode.DirectColor := FALSE;
         mode.MaxX := 719;
         mode.MaxY := 347;
         mode.DirectPutPixel:=@DirectPutPixelHGC720;
         mode.PutPixel:=@PutPixelHGC720;
         mode.GetPixel:=@GetPixelHGC720;
         mode.SetRGBPalette := @SetHGCRGBPalette;
         mode.GetRGBPalette := @GetHGCRGBPalette;
         mode.SetVisualPage := @SetVisualHGC720;
         mode.SetActivePage := @SetActiveHGC720;
         mode.InitMode := @InitHGC720;
         mode.HLine := @HLineHGC720;
         mode.SetBkColor := @SetBkColorHGC720;
         mode.GetBkColor := @GetBkColorHGC720;
         mode.XAspect := 7500;
         mode.YAspect := 10000;
         AddMode(mode);
       end;
     if CGADetected or EGAColorDetected or MCGADetected or VGADetected then
       begin
         { HACK:
           until we create Save/RestoreStateCGA, we use Save/RestoreStateVGA
           with the inWindows flag enabled (so we only save the mode number
           and nothing else) }
         if not VGADetected then
           inWindows := true;
         SaveVideoState := @SaveStateVGA;
         RestoreVideoState := @RestoreStateVGA;

         { now add all standard CGA modes...       }
         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := CGA;
         mode.ModeNumber := CGAC0;
         mode.ModeName:='320 x 200 CGA C0';
         mode.InitMode := @InitCGA320C0;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := CGA;
         mode.ModeNumber := CGAC1;
         mode.ModeName:='320 x 200 CGA C1';
         mode.InitMode := @InitCGA320C1;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := CGA;
         mode.ModeNumber := CGAC2;
         mode.ModeName:='320 x 200 CGA C2';
         mode.InitMode := @InitCGA320C2;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := CGA;
         mode.ModeNumber := CGAC3;
         mode.ModeName:='320 x 200 CGA C3';
         mode.InitMode := @InitCGA320C3;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA640(mode);
         mode.DriverNumber := CGA;
         mode.ModeNumber := CGAHi;
         mode.ModeName:='640 x 200 CGA';
         mode.InitMode := @InitCGA640;
         AddMode(mode);
       end;

     if EGAColorDetected or VGADetected then
       begin
         { HACK:
           until we create Save/RestoreStateEGA, we use Save/RestoreStateVGA
           with the inWindows flag enabled (so we only save the mode number
           and nothing else) }
         if not VGADetected then
           inWindows := true;
         SaveVideoState := @SaveStateVGA;
         RestoreVideoState := @RestoreStateVGA;

         InitMode(mode);
         FillCommonEGAVGA16(mode);
         mode.ModeNumber:=EGALo;
         mode.DriverNumber := EGA;
         mode.ModeName:='640 x 200 EGA';
         mode.MaxX := 639;
         mode.MaxY := 199;
         mode.HardwarePages := 3;
         mode.SetVisualPage := @SetVisual200_350;
         mode.SetActivePage := @SetActive200;
         mode.InitMode := @Init640x200x16;
         mode.XAspect := 4500;
         mode.YAspect := 10000;
         AddMode(mode);

         InitMode(mode);
         FillCommonEGAVGA16(mode);
         mode.ModeNumber:=EGAHi;
         mode.DriverNumber := EGA;
         mode.ModeName:='640 x 350 EGA';
         mode.MaxX := 639;
         mode.MaxY := 349;
         mode.HardwarePages := 1;
         mode.SetVisualPage := @SetVisual200_350;
         mode.SetActivePage := @SetActive350;
         mode.InitMode := @Init640x350x16;
         mode.XAspect := 7750;
         mode.YAspect := 10000;
         AddMode(mode);
       end;

     if MCGADetected or VGADetected then
       begin
         { HACK:
           until we create Save/RestoreStateEGA, we use Save/RestoreStateVGA
           with the inWindows flag enabled (so we only save the mode number
           and nothing else) }
         if not VGADetected then
           inWindows := true;
         SaveVideoState := @SaveStateVGA;
{$ifdef logging}
         LogLn('Setting VGA SaveVideoState to '+strf(longint(SaveVideoState)));
{$endif logging}
         RestoreVideoState := @RestoreStateVGA;
{$ifdef logging}
         LogLn('Setting VGA RestoreVideoState to '+strf(longint(RestoreVideoState)));
{$endif logging}

         { now add all standard MCGA modes...       }
         { yes, most of these are the same as the CGA modes; this is TP7
           compatible }
         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := MCGA;
         mode.ModeNumber := MCGAC0;
         mode.ModeName:='320 x 200 CGA C0'; { yes, it says 'CGA' even for the MCGA driver; this is TP7 compatible }
         mode.InitMode := @InitCGA320C0;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := MCGA;
         mode.ModeNumber := MCGAC1;
         mode.ModeName:='320 x 200 CGA C1'; { yes, it says 'CGA' even for the MCGA driver; this is TP7 compatible }
         mode.InitMode := @InitCGA320C1;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := MCGA;
         mode.ModeNumber := MCGAC2;
         mode.ModeName:='320 x 200 CGA C2'; { yes, it says 'CGA' even for the MCGA driver; this is TP7 compatible }
         mode.InitMode := @InitCGA320C2;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA320(mode);
         mode.DriverNumber := MCGA;
         mode.ModeNumber := MCGAC3;
         mode.ModeName:='320 x 200 CGA C3'; { yes, it says 'CGA' even for the MCGA driver; this is TP7 compatible }
         mode.InitMode := @InitCGA320C3;
         AddMode(mode);

         InitMode(mode);
         FillCommonCGA640(mode);
         mode.DriverNumber := MCGA;
         mode.ModeNumber := MCGAMed;
         mode.ModeName:='640 x 200 CGA'; { yes, it says 'CGA' even for the MCGA driver; this is TP7 compatible }
         mode.InitMode := @InitCGA640;
         AddMode(mode);

         InitMode(mode);
         mode.DriverNumber := MCGA;
         mode.HardwarePages := 0;
         mode.ModeNumber := MCGAHi;
         mode.ModeName:='640 x 480 MCGA';
         mode.MaxColor := 2;
         mode.PaletteSize := 16;
         mode.DirectColor := FALSE;
         mode.MaxX := 639;
         mode.MaxY := 479;
         mode.DirectPutPixel:=@DirectPutPixelMCGA640;
         mode.PutPixel:=@PutPixelMCGA640;
         mode.GetPixel:=@GetPixelMCGA640;
         mode.SetRGBPalette := @SetVGARGBPalette;
         mode.GetRGBPalette := @GetVGARGBPalette;
         mode.SetAllPalette := @SetVGARGBAllPalette;
         mode.InitMode := @InitMCGA640;
         mode.HLine := @HLineMCGA640;
         mode.SetBkColor := @SetBkColorMCGA640;
         mode.GetBkColor := @GetBkColorMCGA640;
         mode.XAspect := 10000;
         mode.YAspect := 10000;
         AddMode(mode);


         InitMode(mode);
         { now add all standard VGA modes...       }
         mode.DriverNumber:= LowRes;
         mode.HardwarePages:= 0;
         mode.ModeNumber:=0;
         mode.ModeName:='320 x 200 VGA';
         mode.MaxColor := 256;
         mode.PaletteSize := mode.MaxColor;
         mode.DirectColor := FALSE;
         mode.MaxX := 319;
         mode.MaxY := 199;
         mode.DirectPutPixel:=@DirectPutPixel320;
         mode.PutPixel:=@PutPixel320;
         mode.GetPixel:=@GetPixel320;
         mode.SetRGBPalette := @SetVGARGBPalette;
         mode.GetRGBPalette := @GetVGARGBPalette;
         mode.SetAllPalette := @SetVGARGBAllPalette;
         mode.InitMode := @Init320;
         mode.XAspect := 8333;
         mode.YAspect := 10000;
         AddMode(mode);
       end;

     if VGADetected then
       begin
         SaveVideoState := @SaveStateVGA;
{$ifdef logging}
         LogLn('Setting VGA SaveVideoState to '+strf(longint(SaveVideoState)));
{$endif logging}
         RestoreVideoState := @RestoreStateVGA;
{$ifdef logging}
         LogLn('Setting VGA RestoreVideoState to '+strf(longint(RestoreVideoState)));
{$endif logging}
         { now add all standard VGA modes...       }
         InitMode(mode);
         mode.DriverNumber:= LowRes;
         mode.ModeNumber:=1;
         mode.HardwarePages := 3; { 0..3 }
         mode.ModeName:='320 x 200 ModeX';
         mode.MaxColor := 256;
         mode.DirectColor := FALSE;
         mode.PaletteSize := mode.MaxColor;
         mode.MaxX := 319;
         mode.MaxY := 199;
         mode.DirectPutPixel:=@DirectPutPixelX;
         mode.PutPixel:=@PutPixelX;
         mode.GetPixel:=@GetPixelX;
         mode.SetRGBPalette := @SetVGARGBPalette;
         mode.GetRGBPalette := @GetVGARGBPalette;
         mode.SetAllPalette := @SetVGARGBAllPalette;
         mode.SetVisualPage := @SetVisualX;
         mode.SetActivePage := @SetActiveX;
         mode.InitMode := @InitModeX;
         mode.XAspect := 8333;
         mode.YAspect := 10000;
         AddMode(mode);

         InitMode(mode);
         FillCommonEGAVGA16(mode);
         mode.ModeNumber:=VGALo;
         mode.DriverNumber := VGA;
         mode.ModeName:='640 x 200 EGA'; { yes, it says 'EGA' even for the VGA driver; this is TP7 compatible }
         mode.MaxX := 639;
         mode.MaxY := 199;
         mode.HardwarePages := 3;
         mode.SetVisualPage := @SetVisual200_350;
         mode.SetActivePage := @SetActive200;
         mode.InitMode := @Init640x200x16;
         mode.XAspect := 4500;
         mode.YAspect := 10000;
         AddMode(mode);

         InitMode(mode);
         FillCommonEGAVGA16(mode);
         mode.ModeNumber:=VGAMed;
         mode.DriverNumber := VGA;
         mode.ModeName:='640 x 350 EGA'; { yes, it says 'EGA' even for the VGA driver; this is TP7 compatible }
         mode.MaxX := 639;
         mode.MaxY := 349;
         mode.HardwarePages := 1;
         mode.SetVisualPage := @SetVisual200_350;
         mode.SetActivePage := @SetActive350;
         mode.InitMode := @Init640x350x16;
         mode.XAspect := 7750;
         mode.YAspect := 10000;
         AddMode(mode);

         InitMode(mode);
         FillCommonEGAVGA16(mode);
         mode.ModeNumber:=VGAHi;
         mode.DriverNumber := VGA;
         mode.ModeName:='640 x 480 VGA';
         mode.MaxX := 639;
         mode.MaxY := 479;
         mode.HardwarePages := 0;
         mode.InitMode := @Init640x480x16;
         mode.XAspect := 10000;
         mode.YAspect := 10000;
         AddMode(mode);
       end;

     { check if VESA adapter supPorted...      }
{$ifndef noSupPortVESA}
     hasVesa := getVesaInfo(VESAInfo);
     { VBE Version v1.00 is unstable, therefore }
     { only VBE v1.1 and later are supported.   }
     if (hasVESA=TRUE) and (VESAInfo.Version <= $0100) then
       hasVESA := False;
{$else noSupPortVESA}
     hasVESA := false;
{$endif noSupPortVESA}
     if hasVesa then
       begin
         { We have to set and restore the entire VESA state }
         { otherwise, if we use the VGA BIOS only function  }
         { there might be a crash under DPMI, such as in the}
         { ATI Mach64                                       }
         SaveVideoState := @SaveStateVESA;
{$ifdef logging}
         LogLn('Setting SaveVideoState to '+strf(longint(SaveVideoState)));
{$endif logging}
         RestoreVideoState := @RestoreStateVESA;
{$ifdef logging}
         LogLn('Setting RestoreVideoState to '+strf(longint(RestoreVideoState)));
{$endif logging}
         { now check all supported modes...}
         if SearchVESAModes(m320x200x32k) then
           begin
             InitMode(mode);
             FillCommonVESA32k(mode);
             FillCommonVESA320x200(mode);
             mode.ModeNumber:=m320x200x32k;
             mode.InitMode := @Init320x200x32k;
             AddMode(mode);
           end;
         if SearchVESAModes(m320x200x64k) then
           begin
             InitMode(mode);
             FillCommonVESA64k(mode);
             FillCommonVESA320x200(mode);
             mode.ModeNumber:=m320x200x64k;
             mode.InitMode := @Init320x200x64k;
             AddMode(mode);
           end;
         if SearchVESAModes(m640x400x256) then
           begin
             InitMode(mode);
             FillCommonVESA256(mode);
             mode.ModeNumber:=m640x400x256;
             mode.DriverNumber := VESA;
             mode.ModeName:='640 x 400 VESA';
             mode.MaxX := 639;
             mode.MaxY := 399;
             mode.InitMode := @Init640x400x256;
             mode.XAspect := 8333;
             mode.YAspect := 10000;
             AddMode(mode);
           end;
         if SearchVESAModes(m640x480x256) then
           begin
             InitMode(mode);
             FillCommonVESA256(mode);
             FillCommonVESA640x480(mode);
             mode.ModeNumber:=m640x480x256;
             mode.InitMode := @Init640x480x256;
             AddMode(mode);
           end;
         if SearchVESAModes(m640x480x32k) then
           begin
             InitMode(mode);
             FillCommonVESA32k(mode);
             FillCommonVESA640x480(mode);
             mode.ModeNumber:=m640x480x32k;
             mode.InitMode := @Init640x480x32k;
             AddMode(mode);
           end;
         if SearchVESAModes(m640x480x64k) then
           begin
             InitMode(mode);
             FillCommonVESA64k(mode);
             FillCommonVESA640x480(mode);
             mode.ModeNumber:=m640x480x64k;
             mode.InitMode := @Init640x480x64k;
             AddMode(mode);
           end;
         if SearchVESAModes(m800x600x16) then
           begin
             InitMode(mode);
             FillCommonVESA16(mode);
             FillCommonVESA800x600(mode);
             mode.ModeNumber:=m800x600x16;
             mode.InitMode := @Init800x600x16;
             AddMode(mode);
           end;
         if SearchVESAModes(m800x600x256) then
           begin
             InitMode(mode);
             FillCommonVESA256(mode);
             FillCommonVESA800x600(mode);
             mode.ModeNumber:=m800x600x256;
             mode.InitMode := @Init800x600x256;
             AddMode(mode);
           end;
         if SearchVESAModes(m800x600x32k) then
           begin
             InitMode(mode);
             FillCommonVESA32k(mode);
             FillCommonVESA800x600(mode);
             mode.ModeNumber:=m800x600x32k;
             mode.InitMode := @Init800x600x32k;
             AddMode(mode);
           end;
         if SearchVESAModes(m800x600x64k) then
           begin
             InitMode(mode);
             FillCommonVESA64k(mode);
             FillCommonVESA800x600(mode);
             mode.ModeNumber:=m800x600x64k;
             mode.InitMode := @Init800x600x64k;
             AddMode(mode);
           end;
         if SearchVESAModes(m1024x768x16) then
           begin
             InitMode(mode);
             FillCommonVESA16(mode);
             FillCommonVESA1024x768(mode);
             mode.ModeNumber:=m1024x768x16;
             mode.InitMode := @Init1024x768x16;
             AddMode(mode);
           end;
         if SearchVESAModes(m1024x768x256) then
           begin
             InitMode(mode);
             FillCommonVESA256(mode);
             FillCommonVESA1024x768(mode);
             mode.ModeNumber:=m1024x768x256;
             mode.InitMode := @Init1024x768x256;
             AddMode(mode);
           end;
         if SearchVESAModes(m1024x768x32k) then
           begin
             InitMode(mode);
             FillCommonVESA32k(mode);
             FillCommonVESA1024x768(mode);
             mode.ModeNumber:=m1024x768x32k;
             mode.InitMode := @Init1024x768x32k;
             AddMode(mode);
           end;
         if SearchVESAModes(m1024x768x64k) then
           begin
             InitMode(mode);
             FillCommonVESA64k(mode);
             FillCommonVESA1024x768(mode);
             mode.ModeNumber:=m1024x768x64k;
             mode.InitMode := @Init1024x768x64k;
             AddMode(mode);
           end;
         if SearchVESAModes(m1280x1024x16) then
           begin
             InitMode(mode);
             FillCommonVESA16(mode);
             FillCommonVESA1280x1024(mode);
             mode.ModeNumber:=m1280x1024x16;
             mode.InitMode := @Init1280x1024x16;
             AddMode(mode);
           end;
         if SearchVESAModes(m1280x1024x256) then
           begin
             InitMode(mode);
             FillCommonVESA256(mode);
             FillCommonVESA1280x1024(mode);
             mode.ModeNumber:=m1280x1024x256;
             mode.InitMode := @Init1280x1024x256;
             AddMode(mode);
           end;
         if SearchVESAModes(m1280x1024x32k) then
           begin
             InitMode(mode);
             FillCommonVESA32k(mode);
             FillCommonVESA1280x1024(mode);
             mode.ModeNumber:=m1280x1024x32k;
             mode.InitMode := @Init1280x1024x32k;
             AddMode(mode);
           end;
         if SearchVESAModes(m1280x1024x64k) then
           begin
             InitMode(mode);
             FillCommonVESA64k(mode);
             FillCommonVESA1280x1024(mode);
             mode.ModeNumber:=m1280x1024x64k;
             mode.InitMode := @Init1280x1024x64k;
             AddMode(mode);
           end;
       end;
   end;

var
  go32exitsave: codepointer;

procedure freeSaveStateBuffer;
begin
  if savePtr <> nil then
    begin
      FreeMem(SavePtr, 64*StateSize);
      SavePtr := nil;
  end;
  exitproc := go32exitsave;
end;

var
  regs: Registers;
begin
  { must be done *before* initialize graph is called, because the save }
  { buffer can be used in the normal exit_proc (which is hooked in     }
  { initializegraph and as such executed first) (JM)                   }
  go32exitsave := exitproc;
  exitproc := @freeSaveStateBuffer;
  { windows screws up the display if the savestate/restore state  }
  { stuff is used (or uses an abnormal amount of cpu time after   }
  { such a problem has exited), so detect its presense and do not }
  { use those functions if it's running. I'm really tired of      }
  { working around Windows bugs :( (JM)                           }
  regs.ax:=$160a;
  intr($2f,regs);
  inWindows:=regs.ax=0;
  InitializeGraph;
end.
