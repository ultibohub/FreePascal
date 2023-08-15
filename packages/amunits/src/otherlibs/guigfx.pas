{
  This file is part of the Free Pascal run time library.

  A file in Amiga system run time library.
  Copyright (c) 2003 by Nils Sj�holm.
  member of the Amiga RTL development team.

  This is a unit for guigfx.library

  See the file COPYING.FPC, included in this distribution,
  for details about the copyright.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

**********************************************************************}
{
  History:

  First version of this unit.
  15 Jan 2003.

  Changed cardinal > longword.
  Changed startcode for unit.
  12 Feb 2003.

  nils.sjoholm@mailbox.swipnet.se Nils Sjoholm
}


{$IFNDEF FPC_DOTTEDUNITS}
UNIT GUIGFX;
{$ENDIF FPC_DOTTEDUNITS}

INTERFACE
{$IFDEF FPC_DOTTEDUNITS}
USES Amiga.Core.Exec,Amiga.Core.Utility,Amiga.Core.Agraphics;
{$ELSE FPC_DOTTEDUNITS}
USES Exec,utility,agraphics;
{$ENDIF FPC_DOTTEDUNITS}

VAR GuiGFXBase : pLibrary;

const
    GUIGFXNAME : PAnsiChar = 'guigfx.library';


  {
        $VER: guigfx.h 17.2 (9.2.2000)

        guigfx.library definitions

        � 1997-2000 TEK neoscientists
   }

  {
        Tags
    }

  const
     GGFX_Dummy = 4567 + TAG_USER;
  { strictly private  }
     GGFX_Owner = GGFX_Dummy + 0;
     GGFX_HSType = GGFX_Dummy + 1;
     GGFX_DitherMode = GGFX_Dummy + 2;
     GGFX_DitherAmount = GGFX_Dummy + 3;
     GGFX_AutoDither = GGFX_Dummy + 4;
     GGFX_DitherThreshold = GGFX_Dummy + 5;
     GGFX_AspectX = GGFX_Dummy + 6;
     GGFX_AspectY = GGFX_Dummy + 7;
     GGFX_PixelFormat = GGFX_Dummy + 8;
     GGFX_Palette = GGFX_Dummy + 9;
     GGFX_PaletteFormat = GGFX_Dummy + 10;
     GGFX_NumColors = GGFX_Dummy + 11;
     GGFX_Precision = GGFX_Dummy + 12;
     GGFX_Weight = GGFX_Dummy + 13;
     GGFX_Ratio = GGFX_Dummy + 14;
     GGFX_SourceWidth = GGFX_Dummy + 15;
     GGFX_SourceHeight = GGFX_Dummy + 16;
     GGFX_SourceX = GGFX_Dummy + 17;
     GGFX_SourceY = GGFX_Dummy + 18;
     GGFX_DestWidth = GGFX_Dummy + 19;
     GGFX_DestHeight = GGFX_Dummy + 20;
     GGFX_DestX = GGFX_Dummy + 21;
     GGFX_DestY = GGFX_Dummy + 22;
     GGFX_CallBackHook = GGFX_Dummy + 23;
     GGFX_ErrorCode = GGFX_Dummy + 24;
     GGFX_MaxAllocPens = GGFX_Dummy + 25;
     GGFX_BufferSize = GGFX_Dummy + 26;
     GGFX_AlphaPresent = GGFX_Dummy + 27;
     GGFX_Independent = GGFX_Dummy + 28;
     GGFX_ModeID = GGFX_Dummy + 29;
     GGFX_PenTable = GGFX_Dummy + 30;
  { obsolete  }
     GGFX_License = GGFX_Dummy + 31;
     GGFX_BGColor = GGFX_Dummy + 32;
     GGFX_UseMask = GGFX_Dummy + 33;
     GGFX_RastLock = GGFX_Dummy + 34;
     GGFX_FormatName = GGFX_Dummy + 35;
  {
        Picture Attributes
    }
     PICATTR_Dummy = 123 + TAG_USER;
     PICATTR_Width = PICATTR_Dummy + 0;
     PICATTR_Height = PICATTR_Dummy + 1;
     PICATTR_RawData = PICATTR_Dummy + 2;
     PICATTR_PixelFormat = PICATTR_Dummy + 3;
     PICATTR_AspectX = PICATTR_Dummy + 4;
     PICATTR_AspectY = PICATTR_Dummy + 5;
     PICATTR_AlphaPresent = PICATTR_Dummy + 6;
  {
        Picture Methods
    }
     PICMTHD_CROP = 1;
     PICMTHD_RENDER = 2;
     PICMTHD_SCALE = 3;
     PICMTHD_MIX = 4;
     PICMTHD_SETALPHA = 5;
     PICMTHD_MIXALPHA = 6;
     PICMTHD_MAPDRAWHANDLE = 7;
     PICMTHD_CREATEALPHAMASK = 8;
     PICMTHD_TINT = 9;
     PICMTHD_TEXTURE = 10;
     PICMTHD_SET = 11;
     PICMTHD_TINTALPHA = 12;
     PICMTHD_INSERT = 13;
     PICMTHD_FLIPX = 14;
     PICMTHD_FLIPY = 15;
     PICMTHD_CHECKAUTODITHER = 16;
     PICMTHD_NEGATIVE = 17;
     PICMTHD_AUTOCROP = 18;
     PICMTHD_CONVOLVE = 19;
  {
        hook message types
    }
     GGFX_MSGTYPE_LINEDRAWN = 1;
  {
        picture locking
    }
     LOCKMODE_DRAWHANDLE = 1;
     LOCKMODE_FORCE = 1 shl 8;
     LOCKMODE_MASK = $ff;

  {
        bitmap attributes
        (strictly internal)
    }

  const
     BMAPATTR_Width = 0 + TAG_USER;
     BMAPATTR_Height = 1 + TAG_USER;
     BMAPATTR_Depth = 2 + TAG_USER;
     BMAPATTR_CyberGFX = 3 + TAG_USER;
     BMAPATTR_BitMapFormat = 4 + TAG_USER;
     BMAPATTR_PixelFormat = 5 + TAG_USER;
     BMAPATTR_Flags = 6 + TAG_USER;


FUNCTION AddPaletteA(psm : POINTER location 'a0'; palette : POINTER location 'a1'; tags : pTagItem location 'a2') : POINTER; syscall GuiGFXBase 72;
FUNCTION AddPictureA(psm : POINTER location 'a0'; pic : POINTER location 'a1'; tags : pTagItem location 'a2') : POINTER; syscall GuiGFXBase 66;
FUNCTION AddPixelArrayA(psm : POINTER location 'a0'; _array : POINTER location 'a1'; width : WORD location 'd0'; height : WORD location 'd1'; tags : pTagItem location 'a2') : POINTER; syscall GuiGFXBase 78;
FUNCTION ClonePictureA(pic : POINTER location 'a0'; tags : pTagItem location 'a1') : POINTER; syscall GuiGFXBase 48;
FUNCTION CreateDirectDrawHandleA(drawhandle : POINTER location 'a0'; sw : WORD location 'd0'; sh : WORD location 'd1'; dw : WORD location 'd2'; dh : WORD location 'd3'; tags : pTagItem location 'a1') : POINTER; syscall GuiGFXBase 168;
FUNCTION CreatePenShareMapA(tags : pTagItem location 'a0') : POINTER; syscall GuiGFXBase 90;
FUNCTION CreatePictureBitMapA(drawhandle : POINTER location 'a0'; pic : POINTER location 'a1'; tags : pTagItem location 'a2') : pBitMap; syscall GuiGFXBase 132;
FUNCTION CreatePictureMaskA(pic : POINTER location 'a0'; mask : PAnsiChar location 'a1'; maskwidth : WORD location 'd0'; tags : pTagItem location 'a2') : BOOLEAN; syscall GuiGFXBase 186;
PROCEDURE DeleteDirectDrawHandle(ddh : POINTER location 'a0'); syscall GuiGFXBase 174;
PROCEDURE DeletePenShareMap(psm : POINTER location 'a0'); syscall GuiGFXBase 96;
PROCEDURE DeletePicture(pic : POINTER location 'a0'); syscall GuiGFXBase 54;
FUNCTION DirectDrawTrueColorA(ddh : POINTER location 'a0'; _array : pULONG location 'a1'; x : WORD location 'd0'; y : WORD location 'd1'; tags : pTagItem location 'a2') : BOOLEAN; syscall GuiGFXBase 180;
FUNCTION DoPictureMethodA(pic : POINTER location 'a0'; method : longword location 'd0'; arguments : pULONG location 'a1') : longword; syscall GuiGFXBase 138;
FUNCTION DrawPictureA(drawhandle : POINTER location 'a0'; pic : POINTER location 'a1'; x : WORD location 'd0'; y : WORD location 'd1'; tags : pTagItem location 'a2') : BOOLEAN; syscall GuiGFXBase 114;
FUNCTION GetPictureAttrsA(pic : POINTER location 'a0'; tags : pTagItem location 'a1') : longword; syscall GuiGFXBase 144;
FUNCTION IsPictureA(filename : PAnsiChar location 'a0'; tags : pTagItem location 'a1') : BOOLEAN; syscall GuiGFXBase 162;
FUNCTION LoadPictureA(filename : PAnsiChar location 'a0'; tags : pTagItem location 'a1') : POINTER; syscall GuiGFXBase 36;
FUNCTION LockPictureA(pic : POINTER location 'a0'; mode : longword location 'd0'; args : pULONG location 'a1') : longword; syscall GuiGFXBase 150;
FUNCTION MakePictureA(_array : POINTER location 'a0'; width : WORD location 'd0'; height : WORD location 'd1'; tags : pTagItem location 'a1') : POINTER; syscall GuiGFXBase 30;
FUNCTION MapPaletteA(drawhandle : POINTER location 'a0'; palette : POINTER location 'a1'; pentab : PAnsiChar location 'a2'; tags : pTagItem location 'a3') : BOOLEAN; syscall GuiGFXBase 120;
FUNCTION MapPenA(drawhandle : POINTER location 'a0'; rgb : longword location 'a1'; tags : pTagItem location 'a2') : LONGINT; syscall GuiGFXBase 126;
FUNCTION ObtainDrawHandleA(psm : POINTER location 'a0'; a1arg : pRastPort location 'a1'; cm : pColorMap location 'a2'; tags : pTagItem location 'a3') : POINTER; syscall GuiGFXBase 102;
FUNCTION ReadPictureA(a0arg : pRastPort location 'a0'; colormap : pColorMap location 'a1'; x : WORD location 'd0'; y : WORD location 'd1'; width : WORD location 'd2'; height : WORD location 'd3'; tags : pTagItem location 'a2') : POINTER; syscall GuiGFXBase 42;
PROCEDURE ReleaseDrawHandle(drawhandle : POINTER location 'a0'); syscall GuiGFXBase 108;
PROCEDURE RemColorHandle(colorhandle : POINTER location 'a0'); syscall GuiGFXBase 84;
PROCEDURE UnLockPicture(pic : POINTER location 'a0'; mode : longword location 'd0'); syscall GuiGFXBase 156;
{
 Functions and procedures with array of PtrUInt go here
}
FUNCTION AddPalette(psm : POINTER; palette : POINTER; const tags : array of PtrUInt) : POINTER;
FUNCTION AddPicture(psm : POINTER; pic : POINTER; const tags : array of PtrUInt) : POINTER;
FUNCTION AddPixelArray(psm : POINTER; _array : POINTER; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;
FUNCTION ClonePicture(pic : POINTER; const tags : array of PtrUInt) : POINTER;
FUNCTION CreateDirectDrawHandle(drawhandle : POINTER; sw : WORD; sh : WORD; dw : WORD; dh : WORD; const tags : array of PtrUInt) : POINTER;
FUNCTION CreatePenShareMap(const tags : array of PtrUInt) : POINTER;
FUNCTION CreatePictureBitMap(drawhandle : POINTER; pic : POINTER; const tags : array of PtrUInt) : pBitMap;
FUNCTION CreatePictureMask(pic : POINTER; mask : PAnsiChar; maskwidth : WORD; const tags : array of PtrUInt) : BOOLEAN;
FUNCTION DirectDrawTrueColor(ddh : POINTER; _array : pULONG; x : WORD; y : WORD; const tags : array of PtrUInt) : BOOLEAN;
FUNCTION DoPictureMethod(pic : POINTER; method : longword; const arguments : array of PtrUInt) : longword;
FUNCTION DrawPicture(drawhandle : POINTER; pic : POINTER; x : WORD; y : WORD; const tags : array of PtrUInt) : BOOLEAN;
FUNCTION GetPictureAttrs(pic : POINTER; const tags : array of PtrUInt) : longword;
FUNCTION IsPicture(filename : PAnsiChar; const tags : array of PtrUInt) : BOOLEAN;
FUNCTION LoadPicture(filename : PAnsiChar; const tags : array of PtrUInt) : POINTER;
FUNCTION LockPicture(pic : POINTER; mode : longword; const args : array of PtrUInt) : longword;
FUNCTION MakePicture(_array : POINTER; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;
FUNCTION MapPalette(drawhandle : POINTER; palette : POINTER; pentab : PAnsiChar; const tags : array of PtrUInt) : BOOLEAN;
FUNCTION MapPen(drawhandle : POINTER; rgb : longword; const tags : array of PtrUInt) : LONGINT;
FUNCTION ObtainDrawHandle(psm : POINTER; a1arg : pRastPort; cm : pColorMap; const tags : array of PtrUInt) : POINTER;
FUNCTION ReadPicture(a0arg : pRastPort; colormap : pColorMap; x : WORD; y : WORD; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;

IMPLEMENTATION

{
 Functions and procedures with array of PtrUInt go here
}
FUNCTION AddPalette(psm : POINTER; palette : POINTER; const tags : array of PtrUInt) : POINTER;
begin
    AddPalette := AddPaletteA(psm , palette , @tags);
end;

FUNCTION AddPicture(psm : POINTER; pic : POINTER; const tags : array of PtrUInt) : POINTER;
begin
    AddPicture := AddPictureA(psm , pic , @tags);
end;

FUNCTION AddPixelArray(psm : POINTER; _array : POINTER; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;
begin
    AddPixelArray := AddPixelArrayA(psm , _array , width , height , @tags);
end;

FUNCTION ClonePicture(pic : POINTER; const tags : array of PtrUInt) : POINTER;
begin
    ClonePicture := ClonePictureA(pic , @tags);
end;

FUNCTION CreateDirectDrawHandle(drawhandle : POINTER; sw : WORD; sh : WORD; dw : WORD; dh : WORD; const tags : array of PtrUInt) : POINTER;
begin
    CreateDirectDrawHandle := CreateDirectDrawHandleA(drawhandle , sw , sh , dw , dh , @tags);
end;

FUNCTION CreatePenShareMap(const tags : array of PtrUInt) : POINTER;
begin
    CreatePenShareMap := CreatePenShareMapA(@tags);
end;

FUNCTION CreatePictureBitMap(drawhandle : POINTER; pic : POINTER; const tags : array of PtrUInt) : pBitMap;
begin
    CreatePictureBitMap := CreatePictureBitMapA(drawhandle , pic , @tags);
end;

FUNCTION CreatePictureMask(pic : POINTER; mask : PAnsiChar; maskwidth : WORD; const tags : array of PtrUInt) : BOOLEAN;
begin
    CreatePictureMask := CreatePictureMaskA(pic , mask , maskwidth , @tags);
end;

FUNCTION DirectDrawTrueColor(ddh : POINTER; _array : pULONG; x : WORD; y : WORD; const tags : array of PtrUInt) : BOOLEAN;
begin
    DirectDrawTrueColor := DirectDrawTrueColorA(ddh , _array , x , y , @tags);
end;

FUNCTION DoPictureMethod(pic : POINTER; method : longword; const arguments : array of PtrUInt) : longword;
begin
    DoPictureMethod := DoPictureMethodA(pic , method , @arguments);
end;

FUNCTION DrawPicture(drawhandle : POINTER; pic : POINTER; x : WORD; y : WORD; const tags : array of PtrUInt) : BOOLEAN;
begin
    DrawPicture := DrawPictureA(drawhandle , pic , x , y , @tags);
end;

FUNCTION GetPictureAttrs(pic : POINTER; const tags : array of PtrUInt) : longword;
begin
    GetPictureAttrs := GetPictureAttrsA(pic , @tags);
end;

FUNCTION IsPicture(filename : PAnsiChar; const tags : array of PtrUInt) : BOOLEAN;
begin
    IsPicture := IsPictureA(filename , @tags);
end;

FUNCTION LoadPicture(filename : PAnsiChar; const tags : array of PtrUInt) : POINTER;
begin
    LoadPicture := LoadPictureA(filename , @tags);
end;

FUNCTION LockPicture(pic : POINTER; mode : longword; const args : array of PtrUInt) : longword;
begin
    LockPicture := LockPictureA(pic , mode , @args);
end;

FUNCTION MakePicture(_array : POINTER; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;
begin
    MakePicture := MakePictureA(_array , width , height , @tags);
end;

FUNCTION MapPalette(drawhandle : POINTER; palette : POINTER; pentab : PAnsiChar; const tags : array of PtrUInt) : BOOLEAN;
begin
    MapPalette := MapPaletteA(drawhandle , palette , pentab , @tags);
end;

FUNCTION MapPen(drawhandle : POINTER; rgb : longword; const tags : array of PtrUInt) : LONGINT;
begin
    MapPen := MapPenA(drawhandle , rgb , @tags);
end;

FUNCTION ObtainDrawHandle(psm : POINTER; a1arg : pRastPort; cm : pColorMap; const tags : array of PtrUInt) : POINTER;
begin
    ObtainDrawHandle := ObtainDrawHandleA(psm , a1arg , cm , @tags);
end;

FUNCTION ReadPicture(a0arg : pRastPort; colormap : pColorMap; x : WORD; y : WORD; width : WORD; height : WORD; const tags : array of PtrUInt) : POINTER;
begin
    ReadPicture := ReadPictureA(a0arg , colormap , x , y , width , height , @tags);
end;

const
    { Change VERSION and LIBVERSION to proper values }
    VERSION : string[2] = '0';
    LIBVERSION : longword = 0;

initialization
  GuiGFXBase := OpenLibrary(GUIGFXNAME,LIBVERSION);
finalization
  if Assigned(GuiGFXBase) then
    CloseLibrary(GuiGFXBase);
END. (* UNIT GUIGFX *)



