{
    Copyright (c) 1998-2004 by Jonas Maebe

    This unit calls the optimization procedures to optimize the assembler
    code for WebAssembly

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

unit aoptcpu;

{$i fpcdefs.inc}

interface

uses cpubase, aasmtai, aopt;

type
  TCpuAsmOptimizer = class(TAsmOptimizer)
  end;

implementation

uses
  globals,
  globtype,
  aasmcpu;

begin
  casmoptimizer := TCpuAsmOptimizer;
end.

