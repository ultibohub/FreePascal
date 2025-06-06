{
    Copyright (c) 1998-2020 by the Free Pascal team

    This unit implements the llvm-mc ("llvm machine code playground")
    assembler writer for WebAssembly

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

unit agllvmmc;

{$i fpcdefs.inc}

interface

  uses
    systems,cgutils,
    globtype,globals,
    symbase,symdef,symtype,symconst,symcpu,
    aasmbase,aasmtai,aasmdata,aasmcpu,
    assemble,aggas;

  type

    { TLLVMMachineCodePlaygroundAssembler }

    TLLVMMachineCodePlaygroundAssembler=class(TGNUassembler)
    protected
      FLLVMMajorVersion: Integer;
      function sectionname(atype:TAsmSectiontype;const aname:string;aorder:TAsmSectionOrder):string;override;
    public
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
      procedure WriteFuncTypeDirective(hp:tai_functype);override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV10 }

    TLLVMMachineCodePlaygroundAssemblerV10=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV11 }

    TLLVMMachineCodePlaygroundAssemblerV11=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV12 }

    TLLVMMachineCodePlaygroundAssemblerV12=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV13 }

    TLLVMMachineCodePlaygroundAssemblerV13=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV14 }

    TLLVMMachineCodePlaygroundAssemblerV14=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV15 }

    TLLVMMachineCodePlaygroundAssemblerV15=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV16 }

    TLLVMMachineCodePlaygroundAssemblerV16=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV17 }

    TLLVMMachineCodePlaygroundAssemblerV17=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TLLVMMachineCodePlaygroundAssemblerV18 }

    TLLVMMachineCodePlaygroundAssemblerV18=class(TLLVMMachineCodePlaygroundAssembler)
      constructor CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean); override;
    end;

    { TWASM32InstrWriter }

    TWASM32InstrWriter = class(TCPUInstrWriter)
    protected
      FLLVMMajorVersion: Integer;
    public
      procedure WriteInstruction(hp : tai);override;
    end;

implementation

  uses
    cutils,
    cgbase,
    fmodule,finput,
    itcpugas,
    cpubase,
    hlcgobj,hlcgcpu,
    verbose;

  { TLLVMMachineCodePlaygroundAssemblerV10 }

  constructor TLLVMMachineCodePlaygroundAssemblerV10.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=10;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV11 }

  constructor TLLVMMachineCodePlaygroundAssemblerV11.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=11;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV12 }

  constructor TLLVMMachineCodePlaygroundAssemblerV12.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=12;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV13 }

  constructor TLLVMMachineCodePlaygroundAssemblerV13.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=13;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV14 }

  constructor TLLVMMachineCodePlaygroundAssemblerV14.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=14;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV15 }

  constructor TLLVMMachineCodePlaygroundAssemblerV15.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=15;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV16 }

  constructor TLLVMMachineCodePlaygroundAssemblerV16.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=16;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV17 }

  constructor TLLVMMachineCodePlaygroundAssemblerV17.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=17;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;

  { TLLVMMachineCodePlaygroundAssemblerV18 }

  constructor TLLVMMachineCodePlaygroundAssemblerV18.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      FLLVMMajorVersion:=18;
      inherited CreateWithWriter(info, wr, freewriter, smart);
    end;


  { TLLVMMachineCodePlaygroundAssembler }


  function TLLVMMachineCodePlaygroundAssembler.sectionname(atype: TAsmSectiontype; const aname: string; aorder: TAsmSectionOrder): string;
    begin
      if (atype=sec_fpc) or
         ((atype=sec_threadvar) and not (ts_wasm_threads in current_settings.targetswitches)) then
        atype:=sec_data;
      if atype=sec_threadvar then
        Result:=inherited sectionname(atype, aname, aorder)+',"T",@'
      else
        Result:=inherited sectionname(atype, aname, aorder)+',"",@';
    end;


  constructor TLLVMMachineCodePlaygroundAssembler.CreateWithWriter(info: pasminfo; wr: TExternalAssemblerOutputFile; freewriter, smart: boolean);
    begin
      inherited;
      InstrWriter:=TWASM32InstrWriter.create(self);
      TWASM32InstrWriter(InstrWriter).FLLVMMajorVersion:=FLLVMMajorVersion;
    end;


  procedure TLLVMMachineCodePlaygroundAssembler.WriteFuncTypeDirective(hp: tai_functype);
    begin
      if not hp.is_forward or (FLLVMMajorVersion>=13) then
        begin
          writer.AsmWrite(#9'.functype'#9);
          writer.AsmWrite(hp.funcname);
          writer.AsmWrite(' ');
          WriteFuncType(hp.functype);
          writer.AsmLn;
        end;
    end;


  { TWASM32InstrWriter }


  procedure TWASM32InstrWriter.WriteInstruction(hp: tai);

    function getreferencestring(var ref : treference) : ansistring;
      begin
        if ref.refaddr=addr_got_tls then
          begin
            if not assigned(ref.symbol) then
              internalerror(2022071401);
            if ref.base<>NR_NO then
              internalerror(2022071402);
            if ref.index<>NR_NO then
              internalerror(2022071403);
            if ref.offset<>0 then
              internalerror(2022071404);
            result:=ref.symbol.name+'@GOT@TLS';
          end
        else if assigned(ref.symbol) then
          begin
            // global symbol or field -> full type and name
            // ref.base can be <> NR_NO in case an instance field is loaded.
            // This register is not part of this instruction, it will have
            // been placed on the stack by the previous one.
            result:=ref.symbol.name;
            if ref.base<>NR_NO then
              result:=result+'+'+std_regname(ref.base);
            if ref.index<>NR_NO then
              result:=result+'+'+std_regname(ref.index);
            if ref.offset>0 then
              result:=result+'+'+tostr(ref.offset)
            else if ref.offset<0 then
              result:=result+tostr(ref.offset);
          end
        else
          begin
            // local symbol -> stack slot, stored in offset
            result:='';
            if (ref.base<>NR_STACK_POINTER_REG) and (ref.base<>NR_NO) then
              result:=std_regname(ref.base);
            if ref.index<>NR_NO then
              if result<>'' then
                result:=result+'+'+std_regname(ref.index)
              else
                result:=std_regname(ref.index);
            if ref.offset>0 then
              begin
                if result<>'' then
                  result:=result+'+'+tostr(ref.offset)
                else
                  result:=tostr(ref.offset);
              end
            else if ref.offset<0 then
              result:=result+tostr(ref.offset);
            if result='' then
              result:='0';
          end;
      end;

    function constfloat(rawfloat: int64; fraction_bits, exponent_bits, exponent_bias: Integer): ansistring;
      var
        sign: boolean;
        fraction: int64;
        exponent, fraction_hexdigits: integer;
      begin
        fraction_hexdigits := (fraction_bits + 3) div 4;
        sign:=(rawfloat shr (fraction_bits+exponent_bits))<>0;
        fraction:=rawfloat and ((int64(1) shl fraction_bits)-1);
        exponent:=(rawfloat shr fraction_bits) and ((1 shl exponent_bits)-1);
        if sign then
          result:='-'
        else
          result:='';
        if (exponent=(1 shl exponent_bits)-1) then
          begin
            if fraction=0 then
              result:=result+'infinity'
            else
              begin
                result:=result+'nan';
{$ifndef CPUMIPS}
                if fraction<>(int64(1) shl (fraction_bits-1)) then
{$else CPUMIPS}
                { Legacy mips fpu has a different representation of 'standard' nan }
                { Signalling bit is clear to signify non-signalling }
                { Standard non-signalling NaN thus has all other bits set }
                if fraction<>((int64(1) shl (fraction_bits-1))-1) then
{$endif CPUMIPS}
                  result:=result+'(0x'+HexStr(fraction,fraction_hexdigits)+')';
              end;
          end
        else if (exponent=0) then
	  begin
            if  (fraction=0) then
              result:=result+'0x0.0p'+tostr(-exponent_bias)
            else
             result:=result+'0x0.'+HexStr(fraction shl (fraction_hexdigits*4-fraction_bits),fraction_hexdigits)+'p'+tostr(-exponent_bias+1)
          end
        else
          result:=result+'0x1.'+HexStr(fraction shl (fraction_hexdigits*4-fraction_bits),fraction_hexdigits)+'p'+tostr(exponent-exponent_bias);
      end;

    function constsingle(s: single): ansistring;
      type
        tsingleval = record
          case byte of
            1: (s: single);
            2: (i: longword);
        end;
      begin
        result:=constfloat(tsingleval(s).i,23,8,127);
      end;

    function constdouble(d: double): ansistring;
      type
        tdoubleval = record
          case byte of
            1: (d: double);
            2: (i: int64);
        end;
      begin
        result:=constfloat(tdoubleval(d).i,52,11,1023);
      end;

    function getopstr(const o:toper) : ansistring;
      var
        d: double;
        s: single;
      begin
        case o.typ of
          top_reg:
            // should have been translated into a memory location by the
            // register allocator)
            if (cs_no_regalloc in current_settings.globalswitches) then
              getopstr:=std_regname(o.reg)
            else
              internalerror(2010122803);
          top_const:
            str(o.val,result);
          top_ref:
            getopstr:=getreferencestring(o.ref^);
          top_single:
            begin
              result:=constsingle(o.sval);
            end;
          top_double:
            begin
              result:=constdouble(o.dval);
            end;
          {top_string:
            begin
              result:=constastr(o.pcval,o.pcvallen);
            end;
          top_wstring:
            begin
              result:=constwstr(o.pwstrval^.data,getlengthwidestring(o.pwstrval));
            end}
          else
            internalerror(2010122802);
        end;
      end;

    var
      cpu : taicpu;
      i   : integer;
      writer: TExternalAssemblerOutputFile;
    begin
      writer:=owner.writer;
      cpu := taicpu(hp);
      writer.AsmWrite(#9#9);
      if FLLVMMajorVersion<=11 then
        case cpu.opcode of
          a_memory_atomic_wait32:
            writer.AsmWrite('i32.atomic.wait');
          a_memory_atomic_wait64:
            writer.AsmWrite('i64.atomic.wait');
          a_memory_atomic_notify:
            writer.AsmWrite('atomic.notify');
          else
            writer.AsmWrite(gas_op2str[cpu.opcode]);
        end
      else
        writer.AsmWrite(gas_op2str[cpu.opcode]);

      if cpu.ops<>0 then
        begin
          for i:=0 to cpu.ops-1 do
            if not ((cpu.opcode=a_call) and (i=1) and (cpu.oper[i]^.typ=top_functype)) then
              begin
                writer.AsmWrite(#9);
                if cpu.oper[i]^.typ=top_functype then
                  owner.WriteFuncType(cpu.oper[i]^.functype)
                else
                  writer.AsmWrite(getopstr(cpu.oper[i]^));
              end;
        end;
      writer.AsmLn;
    end;


  const
    as_wasm32_llvm_mc_v11_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v11;
         idtxt  : 'LLVM-MC-11';
         asmbin : 'llvm-mc-11';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    as_wasm32_llvm_mc_v12_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v12;
         idtxt  : 'LLVM-MC-12';
         asmbin : 'llvm-mc-12';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v13 introduces a WebAssembly type checker. Unfortunately, it is
      broken and produces spurious errors for valid code, such as:

        system.wat:390742:3: error: 19 superfluous return values

      We try to disable it with the '--no-type-check' option. However, this
      still doesn't work, due to a different LLVM-MC bug, causing a different
      kind of spurious errors:

        system.wat:396083:3: error: empty stack while popping i32

      This means that LLVM-MC v13 is unusable as an external assembler. }
    as_wasm32_llvm_mc_v13_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v13;
         idtxt  : 'LLVM-MC-13';
         asmbin : 'llvm-mc-13';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v14 still contains a buggy WebAssembly type checker that cannot be
      disabled completely.

      This means that LLVM-MC v14 is unusable as an external assembler. }
    as_wasm32_llvm_mc_v14_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v14;
         idtxt  : 'LLVM-MC-14';
         asmbin : 'llvm-mc-14';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v15 fixes the bug that causes '--no-type-check' not to disable the
      still broken WebAssembly type checker.

      This makes LLVM-MC v15 usable as an external assembler. The type checker
      is still broken, of course, producing the same spurious errors, but at
      least, we can now safely disable it. }
    as_wasm32_llvm_mc_v15_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v15;
         idtxt  : 'LLVM-MC-15';
         asmbin : 'llvm-mc-15';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v16 is usable as an external assembler. The type checker is still
      broken, producing the same spurious errors, but we at least, we can now
      safely disable it. }
    as_wasm32_llvm_mc_v16_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v16;
         idtxt  : 'LLVM-MC-16';
         asmbin : 'llvm-mc-16';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v17 features an interesting development. The type checker is still
      broken, but now produces fewer and different spurious errors, like this:

      system.wat:56092:3: error: br: insufficient values on the type stack

      So, we still disable the type checker, making LLVM-MC v17 usable as an
      external assembler. The type checker is still useless, though. }
    as_wasm32_llvm_mc_v17_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc_v17;
         idtxt  : 'LLVM-MC-17';
         asmbin : 'llvm-mc-17';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );
    { LLVM-MC v18 contains the same bugs as v17, so we still need to disable the
      type checker. So far LLVM has shipped 6 major LLVM versions with a broken
      WebAssembly type checker. }
    as_wasm32_llvm_mc_v18_info : tasminfo =
       (
         id     : as_wasm32_llvm_mc;
         idtxt  : 'LLVM-MC';
         asmbin : 'llvm-mc';
         asmcmd : '--assemble --arch=wasm32 -mattr=+sign-ext,+exception-handling,+bulk-memory,+atomics,+reference-types --filetype=obj --no-type-check -o $OBJ $EXTRAOPT $ASM';
         supported_targets : [system_wasm32_embedded,system_wasm32_wasip1,system_wasm32_wasip1threads,system_wasm32_wasip2];
         flags : [af_smartlink_sections];
         labelprefix : '.L';
         labelmaxlen : -1;
         comment : '# ';
         dollarsign : '$';
       );

initialization
  RegisterAssembler(as_wasm32_llvm_mc_v11_info,TLLVMMachineCodePlaygroundAssemblerV11);
  RegisterAssembler(as_wasm32_llvm_mc_v12_info,TLLVMMachineCodePlaygroundAssemblerV12);
  RegisterAssembler(as_wasm32_llvm_mc_v13_info,TLLVMMachineCodePlaygroundAssemblerV13);
  RegisterAssembler(as_wasm32_llvm_mc_v14_info,TLLVMMachineCodePlaygroundAssemblerV14);
  RegisterAssembler(as_wasm32_llvm_mc_v15_info,TLLVMMachineCodePlaygroundAssemblerV15);
  RegisterAssembler(as_wasm32_llvm_mc_v16_info,TLLVMMachineCodePlaygroundAssemblerV16);
  RegisterAssembler(as_wasm32_llvm_mc_v17_info,TLLVMMachineCodePlaygroundAssemblerV17);
  RegisterAssembler(as_wasm32_llvm_mc_v18_info,TLLVMMachineCodePlaygroundAssemblerV18);
end.

