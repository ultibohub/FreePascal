{
    Copyright (c) 2008 by Florian Klaempfl

    This unit contains the AVR GAS instruction tables

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
unit itcpugas;

{$i fpcdefs.inc}

interface

  uses
    cpubase,cgbase;


  const
    { Standard opcode string table (for each tasmop enumeration). The
      opcode strings should conform to the names as defined by the
      processor manufacturer.
    }
    gas_op2str : op2strtable = ('',
        'add','adc','adiw','sub','subi','sbc','sbci','sbrc','sbrs','sbiw','and','andi',
        'or','ori','eor','com','neg','sbr','cbr','inc','dec','tst',
        'mul','muls','mulsu','fmul','fmuls','fmulsu','rjmp','ijmp',
        'eijmp','jmp','rcall','icall','eicall','call','ret','reti','cpse',
        'cp','cpc','cpi','sbic','sbis','br','mov','movw','ldi','lds','ld','ldd',
        'sts','st','std','lpm','elpm','spm','in','out','push','pop',
        'lsl','lsr','rol','ror','asr','swap','bset','bclr','sbi','cbi',
        'sec','seh','sei','sen','ser','ses','set','sev','sez',
        'clc','clh','cli','cln','clr','cls','clt','clv','clz',
        'bst','bld','break','nop','sleep','wdr','xch',
        'des');

    function gas_regnum_search(const s:string):Tregister;
    function gas_regname(r:Tregister):string;


implementation

    uses
      cutils,verbose,rgbase;

    const
      gas_regname_table : TRegNameTable = (
        {$i ravrstd.inc}
      );

      gas_regname_index : TRegisterIndexTable = (
        {$i ravrsri.inc}
      );


    function gas_regnum_search(const s:string):Tregister;
      begin
        result:=regnumber_table[findreg_by_name_table(s,gas_regname_table,gas_regname_index)];
      end;


    function gas_regname(r:Tregister):string;
      var
        p : tregisterindex;
      begin
        p:=findreg_by_number(r);
        if p<>0 then
          result:=gas_regname_table[p]
        else
          result:=generic_regname(r);
      end;

end.
