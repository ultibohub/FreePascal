{
    This file is part of the Free Pascal run time library.

    A file in Amiga system run time library.
    Copyright (c) 1998-2003 by Nils Sjoholm
    member of the Amiga RTL development team.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{
    History:

    Added the defines use_amiga_smartlink and
    use_auto_openlib. Implemented autoopening
    of the library.
    13 Jan 2003.

    Changed cardinal > longword.
    09 Feb 2003.

    nils.sjoholm@mailbox.swipnet.se Nils Sjoholm
}
{$PACKRECORDS 2}

{$IFNDEF FPC_DOTTEDUNITS}
UNIT colorwheel;
{$ENDIF FPC_DOTTEDUNITS}

INTERFACE
{$IFDEF FPC_DOTTEDUNITS}
USES Amiga.Core.Exec, Amiga.Core.Utility;
{$ELSE FPC_DOTTEDUNITS}
USES exec, utility;
{$ENDIF FPC_DOTTEDUNITS}

Type
{ For use with the WHEEL_HSB tag }
 pColorWheelHSB = ^tColorWheelHSB;
 tColorWheelHSB = record
    cw_Hue,
    cw_Saturation,
    cw_Brightness  : ULONG;
 end;

{ For use with the WHEEL_RGB tag }
 pColorWheelRGB = ^tColorWheelRGB;
 tColorWheelRGB = record
    cw_Red,
    cw_Green,
    cw_Blue  : ULONG;
 end;


{***************************************************************************}

const
    WHEEL_Dummy          = (TAG_USER+$04000000);
    WHEEL_Hue            = (WHEEL_Dummy+1) ;  { set/get Hue              }
    WHEEL_Saturation     = (WHEEL_Dummy+2) ;  { set/get Saturation        }
    WHEEL_Brightness     = (WHEEL_Dummy+3) ;  { set/get Brightness        }
    WHEEL_HSB            = (WHEEL_Dummy+4) ;  { set/get ColorWheelHSB     }
    WHEEL_Red            = (WHEEL_Dummy+5) ;  { set/get Red               }
    WHEEL_Green          = (WHEEL_Dummy+6) ;  { set/get Green     }
    WHEEL_Blue           = (WHEEL_Dummy+7) ;  { set/get Blue              }
    WHEEL_RGB            = (WHEEL_Dummy+8) ;  { set/get ColorWheelRGB     }
    WHEEL_Screen         = (WHEEL_Dummy+9) ;  { init screen/environment    }
    WHEEL_Abbrv          = (WHEEL_Dummy+10);  { "GCBMRY" if English       }
    WHEEL_Donation       = (WHEEL_Dummy+11);  { colors donated by app     }
    WHEEL_BevelBox       = (WHEEL_Dummy+12);  { inside a bevel box        }
    WHEEL_GradientSlider = (WHEEL_Dummy+13);  { attached gradient slider  }
    WHEEL_MaxPens        = (WHEEL_Dummy+14);  { max # of pens to allocate }


{***************************************************************************}

{--- functions in V39 or higher (Release 3) ---}

VAR ColorWheelBase : pLibrary = nil;

const
    COLORWHEELNAME : PAnsiChar = 'colorwheel.library';

PROCEDURE ConvertHSBToRGB(hsb : pColorWheelHSB location 'a0'; rgb : pColorWheelRGB location 'a1'); syscall ColorWheelBase 030;
PROCEDURE ConvertRGBToHSB(rgb : pColorWheelRGB location 'a0'; hsb : pColorWheelHSB location 'a1'); syscall ColorWheelBase 036;

IMPLEMENTATION

const
    { Change VERSION and LIBVERSION to proper values }
    VERSION : string[2] = '0';
    LIBVERSION : longword = 0;

initialization
  ColorWheelBase := OpenLibrary(COLORWHEELNAME,LIBVERSION);
finalization
  if Assigned(ColorWheelBase) then
    CloseLibrary(ColorWheelBase);
END. (* UNIT COLORWHEEL *)



