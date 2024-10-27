{ This file is part of fpterm - a terminal emulator, written in Free Pascal

  Copyright (C) 2021, 2024 Nikolay Nikolov <nickysn@users.sourceforge.net>

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1335, USA.
}

{$IFNDEF FPC_DOTTEDUNITS}
unit unix98pty;
{$ENDIF FPC_DOTTEDUNITS}

interface

uses
{$IFDEF FPC_DOTTEDUNITS}
  System.CTypes;
{$ELSE FPC_DOTTEDUNITS}
  ctypes;
{$ENDIF FPC_DOTTEDUNITS}

function fpposix_openpt(flags: cint): cint; external 'c' name 'posix_openpt';
function fpgrantpt(fd: cint): cint; external 'c' name 'grantpt';
function fpunlockpt(fd: cint): cint; external 'c' name 'unlockpt';
function fpptsname(fd: cint): PAnsiChar; external 'c' name 'ptsname';

implementation

end.

