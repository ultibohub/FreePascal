{
    This file is part of the Free Pascal Sinclair QL support package.
    Copyright (c) 2021 by Karoly Balogh

    Interface to SMS only OS functions used by the Sinclair QL RTL

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$PACKRECORDS 2}

{$IFNDEF FPC_DOTTEDUNITS}
unit sms;
{$ENDIF FPC_DOTTEDUNITS}


interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  SinclairApi.Qdos;
{$ELSE FPC_DOTTEDUNITS}
uses
  qdos;
{$ENDIF FPC_DOTTEDUNITS}


{ Variable/type includes before function declarations }
{$i sms_sysvars.inc}

{ the functions declared in smsfuncs.inc are implemented in the system unit. They're included
  here via externals, do avoid double implementation of assembler wrappers. for this reason,
  smsfuncs.inc in packages/qlunits must be kept identical to the one in rtl/sinclairql (KB). }

{$i smsfuncs.inc}


implementation


end.
