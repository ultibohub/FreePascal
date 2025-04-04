{
    Copyright (c) 1998-2002 by Florian Klaempfl

    Contains the base types for the Risc-V32

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
{ This Unit contains the base types for the Risc-V32
}
unit cpubase;

{$i fpcdefs.inc}

interface

uses
  strings,globtype,
  cutils,cclasses,aasmbase,cpuinfo,cgbase;

{*****************************************************************************
                                Assembler Opcodes
*****************************************************************************}

    type
      TAsmOp=(A_None,
        { Pseudo instructions }
        A_NOP,A_CALL,A_LA,A_LLA,A_LGA,A_LI,A_MV,A_NOT,A_NEG,A_NEGW,
        A_SEXT_B,A_SEXT_H,A_ZEXT_B,A_ZEXT_H,A_SEQZ,A_SNEG,A_SLTZ,A_SGTZ,
        A_FMV_S,A_FABS_S,A_FNEG_S,A_FMV_D,A_FABS_D,A_FNEG_D,A_FNEG_Q,
        A_BEQZ,A_BNEZ,A_BLEZ,A_BGEZ,A_BLTZ,A_BGTZ,A_BGT,A_BLE,
        A_BGTU,A_BLEU,A_J,A_JR,A_RET,A_TAIL,

        { normal opcodes }
        A_LUI,A_AUIPC,A_JAL,A_JALR,
        A_Bxx,A_LB,A_LH,A_LW,A_LBU,A_LHU,
        A_SB,A_SH,A_SW,
        A_ADDI,A_SLTI,A_SLTIU,
        A_XORI,A_ORI,A_ANDI,
        A_SLLI,A_SRLI,A_SRAI,
        A_ADD,A_SUB,A_SLL,A_SLT,A_SLTU,
        A_XOR,A_SRL,A_SRA,A_OR,A_AND,
        A_FENCE,A_FENCE_I,
        A_ECALL,A_EBREAK,
        A_CSRRW,A_CSRRS,A_CSRRC,A_CSRRWI,A_CSRRSI,A_CSRRCI,

{$ifdef RISCV64}
        { 64-bit }
        A_ADDIW,A_SLLIW,A_SRLIW,A_SRAIW,
        A_ADDW,A_SLLW,A_SRLW,A_SUBW,A_SRAW,
        A_LD,A_SD,A_LWU,A_SEXT_W,A_ZEXT_W,
{$endif RISCV64}

        { M-extension }
        A_MUL,A_MULH,A_MULHSU,A_MULHU,
        A_DIV,A_DIVU,A_REM,A_REMU,

{$ifdef RISCV64}
        { 64-bit }
        A_MULW,
        A_DIVW,A_DIVUW,A_REMW,A_REMUW,
{$endif RISCV64}

        { A-extension }
        A_LR_W,A_SC_W,A_AMOSWAP_W,A_AMOADD_W,A_AMOXOR_W,A_AMOAND_W,
        A_AMOOR_W,A_AMOMIN_W,A_AMOMAX_W,A_AMOMINU_W,A_AMOMAXU_W,

{$ifdef RISCV64}
        { 64-bit }
        A_LR_D,A_SC_D,A_AMOSWAP_D,A_AMOADD_D,A_AMOXOR_D,A_AMOAND_D,
        A_AMOOR_D,A_AMOMIN_D,A_AMOMAX_D,A_AMOMINU_D,A_AMOMAXU_D,
{$endif RISCV64}

        { B-extension }
        A_ADD_UW,A_ANDN,A_CLMUL,A_CLMULH,A_CLMULR,A_CLZ,
{$ifdef RISCV64}
        A_CLZW,
{$endif RISCV64}
        A_CPOP,
{$ifdef RISCV64}
        A_CPOPW,
{$endif RISCV64}
        A_CTZ,
{$ifdef RISCV64}
        A_CTZW,
{$endif RISCV64}
        A_MAX,A_MAXU,A_MIN,A_MINU,A_ORC_B,A_ORN,A_REV8,A_ROL,
{$ifdef RISCV64}
        A_ROLW,
{$endif RISCV64}
        A_ROR,A_RORI,
{$ifdef RISCV64}
        A_RORIW,
        A_RORW,
{$endif RISCV64}
        A_BCLR,A_BCLRI,A_BEXT,A_BEXTI,A_BINV,A_BINVI,A_BSET,A_SETI,{ A_SEXT_B,A_SEXT_H, }
        A_SH1ADD,
{$ifdef RISCV64}
        A_SH1ADD_UW,
{$endif RISCV64}
        A_SH2ADD,
{$ifdef RISCV64}
        A_SH2ADD_UW,
{$endif RISCV64}
        A_SH3ADD,
{$ifdef RISCV64}
        A_SH3ADD_UW,
        A_SLLI_UW,
{$endif RISCV64}
        A_XNOR,
        { A_ZEXT_H, }

        { F-extension }
        A_FLW,A_FSW,
        A_FMADD_S,A_FMSUB_S,A_FNMSUB_S,A_FNMADD_S,
        A_FADD_S,A_FSUB_S,A_FMUL_S,A_FDIV_S,
        A_FSQRT_S,A_FSGNJ_S,A_FSGNJN_S,A_FSGNJX_S,
        A_FMIN_S,A_FMAX_S,
        A_FMV_X_S,A_FMV_X_W,
        A_FEQ_S,A_FLT_S,A_FLE_S,A_FCLASS_S,
        A_FCVT_W_S,A_FCVT_WU_S,A_FCVT_S_W,A_FCVT_S_WU,
        A_FMV_S_X,A_FMV_W_X,
        A_FRCSR,A_FRRM,A_FRFLAGS,A_FSCSR,A_FSRM,
        A_FSFLAGS,A_FSRMI,A_FSFLAGSI,

{$ifdef RISCV64}
        { 64-bit }
        A_FCVT_L_S,A_FCVT_LU_S,
        A_FCVT_S_L,A_FCVT_S_LU,
{$endif RISCV64}

        { D-extension }
        A_FLD,A_FSD,
        A_FMADD_D,A_FMSUB_D,A_FNMSUB_D,A_FNMADD_D,
        A_FADD_D,A_FSUB_D,A_FMUL_D,A_FDIV_D,
        A_FSQRT_D,A_FSGNJ_D,A_FSGNJN_D,A_FSGNJX_D,
        A_FMIN_D,A_FMAX_D,
        A_FEQ_D,A_FLT_D,A_FLE_D,A_FCLASS_D,
        A_FCVT_D_S,A_FCVT_S_D,
        A_FCVT_W_D,A_FCVT_WU_D,A_FCVT_D_W,A_FCVT_D_WU,

{$ifdef RISCV64}
        { 64-bit }
        A_FCVT_L_D,A_FCVT_LU_D,A_FMV_X_D,
        A_FCVT_D_L,A_FCVT_D_LU,A_FMV_D_X,
{$endif RISCV64}

        { Q-extension }
        A_FLQ,A_FSQ,
//        A_FMADD_D,A_FMSUB_D,A_FNMSUB_D,A_FNMADD_D,
//        A_FADD_D,A_FSUB_D,A_FMUL_D,A_FDIV_D,
//        A_FSQRT_D,A_FSGNJ_D,A_FSGNJN_D,A_FSGNJX_D,
        A_FMIN_Q,A_FMAX_Q,
//        A_FEQ_D,A_FLT_D,A_FLE_D,A_FCLASS_D,
//        A_FCVT_D_S,A_FCVT_S_D,
//        A_FCVT_W_D,A_FCVT_WU_D,A_FCVT_D_W,A_FCVT_D_WU,

        { Machine mode }
        A_MRET,A_HRET,A_SRET,A_URET,
        A_WFI,

        { Supervisor }
        A_SFENCE_VM,

        { pseudo instructions for accessiong control and status registers }
        A_RDINSTRET,A_RDINSTRETH,A_RDCYCLE,A_RDCYCLEH,A_RDTIME,A_RDTIMEH,A_CSRR,A_CSRW,A_CSRS,A_CSRC,A_CSRWI,
        A_CSRSI,A_CSRCI
      );

      { This should define the array of instructions as string }
      op2strtable=array[tasmop] of string[8];

    Const
      { First value of opcode enumeration }
      firstop = low(tasmop);
      { Last value of opcode enumeration  }
      lastop  = high(tasmop);

      { Last value of opcode for TCommonAsmOps set below  }
      LastCommonAsmOp = A_MRET;

    Type
      TCommonAsmOps = Set of A_None .. LastCommonAsmOp;

{*****************************************************************************
                                  Registers
*****************************************************************************}

{$ifdef riscv32}
    type
      { Number of registers used for indexing in tables }
      tregisterindex=0..{$i rrv32nor.inc}-1;

    const
      maxvarregs = 32-6; { 32 int registers - r0 - stackpointer - r2 - 3 scratch registers }
      maxfpuvarregs = 28; { 32 fpuregisters - some scratch registers (minimally 2) }
      { Available Superregisters }
      {$i rrv32sup.inc}

      { No Subregisters }
      R_SUBWHOLE=R_SUBNONE;

      { Available Registers }
      {$i rrv32con.inc}

      { Integer Super registers first and last }
      first_int_imreg = $20;

      { Float Super register first and last }
      first_fpu_imreg     = $20;

      { MM Super register first and last }
      first_mm_imreg     = $20;

{ TODO: Calculate bsstart}
      regnumber_count_bsstart = 64;

      regnumber_table : array[tregisterindex] of tregister = (
        {$i rrv32num.inc}
      );

      regstabs_table : array[tregisterindex] of shortint = (
        {$i rrv32sta.inc}
      );

      regdwarf_table : array[tregisterindex] of shortint = (
        {$i rrv32dwa.inc}
      );
{$endif riscv32}

{$ifdef riscv64}
    type
      { Number of registers used for indexing in tables }
      tregisterindex=0..{$i rrv64nor.inc}-1;

    const
      maxvarregs = 32-6; { 32 int registers - r0 - stackpointer - r2 - 3 scratch registers }
      maxfpuvarregs = 28; { 32 fpuregisters - some scratch registers (minimally 2) }
      { Available Superregisters }
      {$i rrv64sup.inc}

      { No Subregisters }
      R_SUBWHOLE=R_SUBNONE;

      { Available Registers }
      {$i rrv64con.inc}

      { Integer Super registers first and last }
      first_int_imreg = $20;

      { Float Super register first and last }
      first_fpu_imreg     = $20;

      { MM Super register first and last }
      first_mm_imreg     = $20;

{ TODO: Calculate bsstart}
      regnumber_count_bsstart = 64;

      regnumber_table : array[tregisterindex] of tregister = (
        {$i rrv64num.inc}
      );

      regstabs_table : array[tregisterindex] of shortint = (
        {$i rrv64sta.inc}
      );

      regdwarf_table : array[tregisterindex] of shortint = (
        {$i rrv64dwa.inc}
      );
{$endif riscv32}

{*****************************************************************************
                                Conditions
*****************************************************************************}

    type
      TAsmCond = (C_None { unconditional jumps },
        C_LT,C_LTU,C_GE,C_GEU,C_NE,C_EQ);

      TAsmConds = set of TAsmCond;

    const
      cond2str: Array[TAsmCond] of string[4] = ({cf_none}'',
        { conditions when not using ctr decrement etc}
        'lt','ltu','ge','geu','ne','eq');

      uppercond2str: Array[TAsmCond] of string[4] = ({cf_none}'',
        { conditions when not using ctr decrement etc}
        'LT','LTU','GE','GEU','NE','EQ');


{*****************************************************************************
                                   Flags
*****************************************************************************}

    type
      TResFlagsEnum = (F_EQ,F_NE,F_LT,F_LTU,F_GE,F_GEU);

{*****************************************************************************
                                Reference
*****************************************************************************}

{*****************************************************************************
                                Operands
*****************************************************************************}
    type
      TMemoryOrderingFlag = (moRl, moAq);
      TMemoryOrdering = set of TMemoryOrderingFlag;

      TFenceFlag = (ffI, ffO, ffR, ffW);
      TFenceFlags = set of TFenceFlag;

      TRoundingMode = (RM_Default,
                       RM_RNE,
                       RM_RTZ,
                       RM_RDN,
                       RM_RUP,
                       RM_RMM);

    const
      roundingmode2str : array[TRoundingMode] of string[3] = ('',
        'rne','rtz','rdn','rup','rmm');



{*****************************************************************************
                                 Constants
*****************************************************************************}

    const
      max_operands = 5;

  {*****************************************************************************
                            Default generic sizes
  *****************************************************************************}

  {# Defines the default address size for a processor, }
{$ifdef RISCV64}
  OS_ADDR = OS_64;
  {# the natural int size for a processor,
     has to match osuinttype/ossinttype as initialized in psystem }
  OS_INT = OS_64;
  OS_SINT = OS_S64;
{$endif RISCV64}
{$ifdef RISCV32}
  OS_ADDR = OS_32;
  {# the natural int size for a processor,
     has to match osuinttype/ossinttype as initialized in psystem }
  OS_INT = OS_32;
  OS_SINT = OS_S32;
{$endif RISCV64}
  {# the maximum float size for a processor,           }
  OS_FLOAT = OS_F64;
  {# the size of a vector register for a processor     }
  OS_VECTOR = OS_M128;

{*****************************************************************************
                               GDB Information
*****************************************************************************}

{$ifdef riscv32}
      stab_regindex : array[tregisterindex] of shortint = (
        {$i rrv32sta.inc}
      );
{$endif riscv32}

{$ifdef riscv64}
      stab_regindex : array[tregisterindex] of shortint = (
        {$i rrv64sta.inc}
      );
{$endif riscv64}

{*****************************************************************************
                          Generic Register names
*****************************************************************************}

      {# Stack pointer register }
      NR_STACK_POINTER_REG = NR_X2;
      RS_STACK_POINTER_REG = RS_X2;
      {# Frame pointer register }
      NR_FRAME_POINTER_REG = NR_X8;
      RS_FRAME_POINTER_REG = RS_X8;

      NR_PIC_OFFSET_REG = NR_X3;
      { Return address of a function }
      NR_RETURN_ADDRESS_REG = NR_X1;
      RS_RETURN_ADDRESS_REG = RS_X1;
      { Results are returned in this register (32-bit values) }
      NR_FUNCTION_RETURN_REG = NR_X10;
      RS_FUNCTION_RETURN_REG = RS_X10;
      { Low part of 64bit return value }
      NR_FUNCTION_RETURN64_LOW_REG = NR_X10;
      RS_FUNCTION_RETURN64_LOW_REG = RS_X10;
      { High part of 64bit return value }
      NR_FUNCTION_RETURN64_HIGH_REG = NR_X11;
      RS_FUNCTION_RETURN64_HIGH_REG = RS_X11;
      { The value returned from a function is available in this register }
      NR_FUNCTION_RESULT_REG = NR_FUNCTION_RETURN_REG;
      RS_FUNCTION_RESULT_REG = RS_FUNCTION_RETURN_REG;
      { The lowh part of 64bit value returned from a function }
      NR_FUNCTION_RESULT64_LOW_REG = NR_FUNCTION_RETURN64_LOW_REG;
      RS_FUNCTION_RESULT64_LOW_REG = RS_FUNCTION_RETURN64_LOW_REG;
      { The high part of 64bit value returned from a function }
      NR_FUNCTION_RESULT64_HIGH_REG = NR_FUNCTION_RETURN64_HIGH_REG;
      RS_FUNCTION_RESULT64_HIGH_REG = RS_FUNCTION_RETURN64_HIGH_REG;

      NR_FPU_RESULT_REG = NR_F10;
      NR_MM_RESULT_REG = NR_NO;

      NR_DEFAULTFLAGS = NR_NO;
      RS_DEFAULTFLAGS = RS_NO;


{*****************************************************************************
                       GCC /ABI linking information
*****************************************************************************}

      {# Registers which must be saved when calling a routine declared as
         cppdecl, cdecl, stdcall, safecall, palmossyscall. The registers
         saved should be the ones as defined in the target ABI and / or GCC.

         This value can be deduced from CALLED_USED_REGISTERS array in the
         GCC source.
      }
      saved_standard_registers : array[0..12] of tsuperregister = (
        RS_X2,
        RS_X8,RS_X9,
        RS_X18,RS_X19,
        RS_X20,RS_X21,RS_X22,RS_X23,RS_X24,RS_X25,RS_X26,RS_X27
      );

      { this is only for the generic code which is not used for this architecture }
      saved_address_registers : array[0..0] of tsuperregister = (RS_INVALID);
      saved_mm_registers : array[0..0] of tsuperregister = (RS_INVALID);

      {# Required parameter alignment when calling a routine declared as
         stdcall and cdecl. The alignment value should be the one defined
         by GCC or the target ABI.

         The value of this constant is equal to the constant
         PARM_BOUNDARY / BITS_PER_UNIT in the GCC source.
      }
{$ifdef RISCV64}	  
      std_param_align = 8;
{$endif RISCV64}
{$ifdef RISCV32}
      std_param_align = 4;
{$endif RISCV32}


{*****************************************************************************
                            CPU Dependent Constants
*****************************************************************************}

      maxfpuregs = 8;

{*****************************************************************************
                                  Helpers
*****************************************************************************}

    function is_imm12(value: tcgint): boolean;
    function is_lui_imm(value: tcgint): boolean;

    function is_calljmp(o:tasmop):boolean;

    function cgsize2subreg(regtype: tregistertype; s:Tcgsize):Tsubregister;
    { Returns the tcgsize corresponding with the size of reg.}
    function reg_cgsize(const reg: tregister) : tcgsize;

    function findreg_by_number(r:Tregister):tregisterindex;
    function std_regnum_search(const s:string):Tregister;
    function std_regname(r:Tregister):string;

    function inverse_cond(const c: TAsmCond): Tasmcond; {$ifdef USEINLINE}inline;{$endif USEINLINE}
    function dwarf_reg(r:tregister):shortint;
    function dwarf_reg_no_error(r:tregister):shortint;
    function eh_return_data_regno(nr: longint): longint;

    function conditions_equal(const c1,c2: TAsmCond): boolean;

    { Checks if Subset is a subset of c (e.g. "less than" is a subset of "less than or equal" }
    function condition_in(const Subset, c: TAsmCond): Boolean;

    function is_extra_reg(const s : string) : tregister;

implementation

    uses
      rgbase,verbose;

{$ifdef riscv32}
    const
      std_regname_table : TRegNameTable = (
        {$i rrv32std.inc}
      );

      regnumber_index : array[tregisterindex] of tregisterindex = (
        {$i rrv32rni.inc}
      );

      std_regname_index : array[tregisterindex] of tregisterindex = (
        {$i rrv32sri.inc}
      );
{$endif riscv32}

{$ifdef riscv64}
    const
      std_regname_table : TRegNameTable = (
        {$i rrv64std.inc}
      );

      regnumber_index : array[tregisterindex] of tregisterindex = (
        {$i rrv64rni.inc}
      );

      std_regname_index : array[tregisterindex] of tregisterindex = (
        {$i rrv64sri.inc}
      );
{$endif riscv64}

{*****************************************************************************
                                  Helpers
*****************************************************************************}

    function is_imm12(value: tcgint): boolean;
      begin
        result:=(value >= -2048) and (value <= 2047);
      end;


    function is_lui_imm(value: tcgint): boolean;
      begin
        result:=SarInt64((value and $FFFFF000) shl 32, 32) = value;
      end;


    function is_calljmp(o:tasmop):boolean;
      begin
       is_calljmp:=false;
        case o of
          A_BEQZ,A_BNEZ,A_BLEZ,A_BGEZ,A_BLTZ,A_BGTZ,A_BGT,A_BLE,
          A_BGTU,A_BLEU,A_J,A_JR,
          A_JAL,A_JALR,A_Bxx,A_CALL:
            is_calljmp:=true;
          else
            ;
        end;
      end;


    function inverse_cond(const c: TAsmCond): Tasmcond; {$ifdef USEINLINE}inline;{$endif USEINLINE}
      const
        inv_condflags:array[TAsmCond] of TAsmCond=(C_None,
          C_GE,C_GEU,C_LT,C_LTU,C_EQ,C_NE);
      begin
        result := inv_condflags[c];
      end;


    function reg_cgsize(const reg: tregister): tcgsize;
      begin
        case getregtype(reg) of
          R_INTREGISTER :
            result:=OS_INT;
          R_MMREGISTER:
            result:=OS_M128;
          R_FPUREGISTER:
            result:=OS_F64;
          else
            internalerror(200303181);
        end;
      end;


    function cgsize2subreg(regtype: tregistertype; s:Tcgsize):Tsubregister;
      begin
        cgsize2subreg:=R_SUBWHOLE;
      end;


    function findreg_by_number(r:Tregister):tregisterindex;
      begin
        result:=rgBase.findreg_by_number_table(r,regnumber_index);
      end;


    function std_regnum_search(const s:string):Tregister;
      begin
        result:=regnumber_table[findreg_by_name_table(s,std_regname_table,std_regname_index)];
      end;


    function std_regname(r:Tregister):string;
      var
        p : tregisterindex;
      begin
        p:=findreg_by_number_table(r,regnumber_index);
        if p<>0 then
          result:=std_regname_table[p]
        else
          result:=generic_regname(r);
      end;


    function dwarf_reg(r:tregister):shortint;
      begin
        result:=regdwarf_table[findreg_by_number(r)];
        if result=-1 then
          internalerror(200603251);
      end;

    function dwarf_reg_no_error(r:tregister):shortint;
      begin
        result:=regdwarf_table[findreg_by_number(r)];
      end;

    function eh_return_data_regno(nr: longint): longint;
      begin
        if (nr>=0) and (nr<4) then
          result:=nr+10
        else
          result:=-1;
      end;

    function conditions_equal(const c1, c2: TAsmCond): boolean;
      begin
        result:=c1=c2;
      end;


    { Checks if Subset is a subset of c (e.g. "less than" is a subset of "less than or equal" }
    function condition_in(const Subset, c: TAsmCond): Boolean;
      begin
        Result := (c = C_None) or conditions_equal(Subset, c);

        if not Result then
          case Subset of
            C_EQ:
              Result := (c in [C_GE, C_GEU]);
            else
              Result := False;
          end;
      end;


    function is_extra_reg(const s: string): tregister;
      type
        treg2str = record
          name : string[4];
          reg : tregister;
        end;

      const
        extraregs : array[0..32] of treg2str = (
          (name: 'A0'; reg : NR_X10),
          (name: 'A1'; reg : NR_X11),
          (name: 'A2'; reg : NR_X12),
          (name: 'A3'; reg : NR_X13),
          (name: 'A4'; reg : NR_X14),
          (name: 'A5'; reg : NR_X15),
          (name: 'A6'; reg : NR_X16),
          (name: 'A7'; reg : NR_X17),
          (name: 'ZERO'; reg : NR_X0),
          (name: 'RA'; reg : NR_X1),
          (name: 'SP'; reg : NR_X2),
          (name: 'GP'; reg : NR_X3),
          (name: 'TP'; reg : NR_X4),
          (name: 'T0'; reg : NR_X5),
          (name: 'T1'; reg : NR_X6),
          (name: 'T2'; reg : NR_X7),
          (name: 'S0'; reg : NR_X8),
          (name: 'FP'; reg : NR_X8),
          (name: 'S1'; reg : NR_X9),
          (name: 'S2'; reg : NR_X18),
          (name: 'S3'; reg : NR_X19),
          (name: 'S4'; reg : NR_X20),
          (name: 'S5'; reg : NR_X21),
          (name: 'S6'; reg : NR_X22),
          (name: 'S7'; reg : NR_X23),
          (name: 'S8'; reg : NR_X24),
          (name: 'S9'; reg : NR_X25),
          (name: 'S10';reg : NR_X26),
          (name: 'S11';reg : NR_X27),
          (name: 'T3'; reg : NR_X28),
          (name: 'T4'; reg : NR_X29),
          (name: 'T5'; reg : NR_X30),
          (name: 'T6'; reg : NR_X31)
          );

      var
        i : longint;
    begin
      result:=NR_NO;
      { reg found?
        possible aliases are always 2 to 4 chars
      }
      if not (length(s) in [2..4]) then
        exit;
      for i:=low(extraregs) to high(extraregs) do
        begin
          if s=extraregs[i].name then
            begin
              result:=extraregs[i].reg;
              exit;
            end;
        end;
    end;

end.
