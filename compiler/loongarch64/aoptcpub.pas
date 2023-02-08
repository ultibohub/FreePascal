{
   Copyright (c) 1998-2002 by Jonas Maebe, member of the Free Pascal
   Development Team

   This unit contains several types and constants necessary for the
   optimizer to work on the LoongArch64 architecture

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
unit aoptcpub; { Assembler OPTimizer CPU specific Base }

{$I fpcdefs.inc}

interface

{ TODO }

uses
  aasmcpu, AOptBase, cpubase;

type

  { type of a normal instruction }
  TInstr = Taicpu;
  PInstr = ^TInstr;

  { ************************************************************************* }
  { **************************** TCondRegs ********************************** }
  { ************************************************************************* }
  { Info about the conditional registers                                      }
  TCondRegs = object
    constructor Init;
    destructor Done;
  end;

  { ************************************************************************* }
  { **************************** TAoptBaseCpu ******************************* }
  { ************************************************************************* }

  TAoptBaseCpu = class(TAoptBase)
  end;

  { ************************************************************************* }
  { ******************************* Constants ******************************* }
  { ************************************************************************* }
const

  { the maximum number of things (registers, memory, ...) a single instruction }
  { changes                                                                    }

  MaxCh = 3;

  {Oper index of operand that contains the source (reference) with a load }
  {instruction                                                            }

  LoadSrc = 1;

  {Oper index of operand that contains the destination (register) with a load }
  {instruction                                                                }

  LoadDst = 0;

  {Oper index of operand that contains the source (register) with a store }
  {instruction                                                            }

  StoreSrc = 0;

  {Oper index of operand that contains the destination (reference) with a load }
  {instruction                                                                 }

  StoreDst = 1;

  aopt_uncondjmp = A_B;
  aopt_condjmp = A_BXX;

implementation

{ ************************************************************************* }
{ **************************** TCondRegs ********************************** }
{ ************************************************************************* }

constructor TCondRegs.init;
begin
end;

destructor TCondRegs.Done;
{$IFDEF inl}inline;
{$ENDIF inl}
begin
end;

end.
