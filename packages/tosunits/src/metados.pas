{
    Copyright (c) 2016 by Free Pascal development team

    XBIOS interface unit for Atari TOS (MetaDOS functions)

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$PACKRECORDS 2}
{$MODESWITCH OUT+}
{$IFNDEF FPC_DOTTEDUNITS}
unit metados;
{$ENDIF FPC_DOTTEDUNITS}

interface

type
{* Available from MetaDOS version 2.30 *}
  PMETAINFO2 = ^TMETAINFO2;
  TMETAINFO2 = record
    version: word;
    magic: longint;
    log2phys: Pointer;
  end;

{* Structure used by Metainit() *}
  PMETAINFO = ^TMETAINFO;
  TMETAINFO = record
    drivemap:   LongInt;
    version:    PAnsiChar;
    reserved:   LongInt;
    info:  PMETAINFO2; {* Available from MetaDOS version 2.30 *}
  end;

  PMETA_DRVINFO = ^TMETA_DRVINFO;
  TMETA_DRVINFO = record
    name: PAnsiChar;
    reserved:   array[0..2] of LongInt;
  end;


procedure xbios_Metainit(out buffer: TMETAINFO); syscall 14 48;
function xbios_Metaopen(drive: smallint; out buffer: TMETA_DRVINFO): LongInt; syscall 14 49;
function xbios_Metaclose(drive: smallint): LongInt; syscall 14 50;
function xbios_Metaread(drive: smallint; buffer: Pointer; blockno: LongInt; count: smallint): LongInt; syscall 14 51;
function xbios_Metawrite(drive: smallint; buffer: Pointer; blockno: LongInt; count: smallint): LongInt; syscall 14 52;
function xbios_Metaseek(drive: smallint; dummy, offset: longint): LongInt; syscall 14 53;
function xbios_Metastatus(drive: smallint; buffer: Pointer): LongInt; syscall 14 54;
function xbios_Metaioctl(drive: smallint; magic: LongInt; opcode: smallint; buffer: Pointer): LongInt; syscall 14 55;

implementation

end.
