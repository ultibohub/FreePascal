{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2003 by the Free Pascal development team

    Basic canvas definitions.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$mode objfpc}
{$IFNDEF FPC_DOTTEDUNITS}
unit freetypehdyn;
{$ENDIF FPC_DOTTEDUNITS}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses System.SysUtils, System.DynLibs;
{$ELSE FPC_DOTTEDUNITS}
uses sysutils, dynlibs;
{$ENDIF FPC_DOTTEDUNITS}

{$DEFINE DYNAMIC}

{$i libfreetype.inc}


initialization
  //InitializeFreetype(FreeTypeDLL); - do not load DLL in initialization, it is loaded when needed in ftfont.InitEngine

finalization
  ReleaseFreetype;
end.
