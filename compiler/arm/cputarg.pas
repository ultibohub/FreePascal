{
    Copyright (c) 2001-2002 by Peter Vreman

    Includes the arm dependent target units

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}
unit cputarg;

{$i fpcdefs.inc}

interface


implementation

    uses
      systems { prevent a syntax error when nothing is included }

{**************************************
             Targets
**************************************}

    {$ifndef NOTARGETANDROID}
      ,t_android
    {$endif}
    {$ifndef NOTARGETLINUX}
      ,t_linux
    {$endif}
    {$ifndef NOTARGETWINCE}
      ,t_win
    {$endif}
    {$ifndef NOTARGETGBA}
      ,t_gba
    {$endif}
    {$ifndef NOTARGETPALMOS}
      ,t_palmos
    {$endif}
    {$ifndef NOTARGETNDS}
      ,t_nds
    {$endif}
    {$ifndef NOTARGETEMBEDDED}
      ,t_embed
    {$endif}
    {$ifndef NOTARGETSYMBIAN}
      ,t_symbian
    {$endif}
    {$ifndef NOTARGETBSD}
      ,t_bsd
    {$endif}
    {$ifndef NOTARGETDARWIN}
      ,t_darwin
    {$endif}
    {$ifndef NOTARGETAROS}
      ,t_aros
    {$endif}
    {$ifndef NOTARGETULTIBO}
      ,t_ultibo
    {$endif}

{**************************************
             Assemblers
**************************************}

    {$ifndef NOAGARMGAS}
      ,agarmgas
    {$endif}

      ,ogcoff
      ,ogelf
      ,cpuelf

{**************************************
        Assembler Readers
**************************************}

  {$ifndef NoRaarmgas}
       ,raarmgas
  {$endif NoRaarmgas}

{**************************************
             Debuginfo
**************************************}

  {$ifndef NoDbgStabs}
      ,dbgstabs
  {$endif NoDbgStabs}
  {$ifndef NoDbgDwarf}
      ,dbgdwarf
  {$endif NoDbgDwarf}
      ;

end.
