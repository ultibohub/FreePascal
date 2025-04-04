{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2006-2007 by David Zhang

    Processor dependent implementation for the system unit for MIPS

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{****************************************************************************
                           MIPS specific stuff
****************************************************************************}
{$if not defined(FPUNONE) and not defined(FPUSOFT)}
function get_fsr : dword;assembler;nostackframe;[public, alias: 'FPC_GETFSR'];
  asm
    cfc1 $2,$31
  end;


procedure set_fsr(fsr : dword);[public, alias: 'FPC_SETFSR'];
  begin
    DefaultFPUControlWord:=fsr;
    asm
      lw $4,fsr
      ctc1 $4,$31
    end;
  end;


function GetNativeFPUControlWord: TNativeFPUControlWord; {$if defined(SYSTEMINLINE)}inline;{$endif}
  begin
    result:=get_fsr;
  end;


procedure SetNativeFPUControlWord(const cw: TNativeFPUControlWord); {$if defined(SYSTEMINLINE)}inline;{$endif}
  begin
    set_fsr(cw);
  end;


function get_got_z : pointer;assembler;nostackframe;[public, alias: 'FPC_GETGOT_Z'];
  asm
    move $2,$28
  end;

const
  { FPU enable exception bits for FCSR register }
  fpu_enable_inexact   =  $80;
  fpu_enable_underflow = $100;
  fpu_enable_overflow  = $200;
  fpu_enable_div_zero  = $400;
  fpu_enable_invalid   = $800;
  fpu_enable_mask      = $F80;
  default_fpu_enable = fpu_enable_div_zero or fpu_enable_invalid;

  fpu_flags_mask = $7C;
  fpu_cause_mask = $3F000;

  { FPU rounding mask and values }
  fpu_rounding_mask    = $3;
  fpu_rounding_nearest = 0;
  fpu_rounding_towards_zero = 1;
  fpu_rounding_plus_inf = 2;
  fpu_rounding_minus_inf = 3;

  fpu_all_bits = fpu_enable_mask or fpu_flags_mask or fpu_cause_mask or fpu_rounding_mask;

{$endif}


{$if defined(FPUMIPS2) or defined(FPUMIPS3)}
{$define FPC_SYSTEM_HAS_SYSINITFPU}
procedure SysInitFPU;
  begin
    set_fsr(get_fsr and (not fpu_all_bits) or (default_fpu_enable or fpu_rounding_nearest));
    softfloat_exception_mask:=[float_flag_inexact,float_flag_denormal];
    softfloat_exception_flags:=[];
  end;
{$endif FPUMIPS2 or FPUMIPS3}


{$ifndef INTERNAL_BACKTRACE}
{$define FPC_SYSTEM_HAS_GET_FRAME}
function get_frame:pointer;assembler;nostackframe;
  asm
    { we need to use the information of the .pdr section to do this properly:
       0 proc. start adress
       4 regmask
       8 reg. offset
      12 fmask
      16 foffset
      20 frame size
      24 stack reg
      28 link reg

      Further, we need to know the pc
    }
    // lw $2,0($sp)
    move $2,$30
  end;
{$endif INTERNAL_BACKTRACE}


{ Try to find previous $fp,$ra register pair
  reset both to nil if failure }
{$define FPC_SYSTEM_HAS_GET_CALLER_STACKINFO}
procedure get_caller_stackinfo(var framebp : pointer; var addr : codepointer);
const
  instr_size = 4;
  MAX_INSTRUCTIONS = 64000;
type
  instr_p = pdword;
  reg_p = ppointer;
var
  instr,stackpos : dword;
  i,LocalSize : longint;
  ra_offset, s8_offset : longint;
  current_ra : pointer;
begin
  { Here we need to use GDB approach,
    starting at addr
    go back to lower $ra values until we find a
    position with ADDIU $sp,$sp,-LocalSize
  }
  if addr=nil then
    begin
	  framebp:=nil;
	  exit;
	end;
  Try
    current_ra:=addr;
    ra_offset:=-1;
    s8_offset:=-1;
    i:=0;
    LocalSize:=0;
    repeat
      inc(i);
      dec(current_ra,4);
      instr:=instr_p(current_ra)^;
      if (instr shr 16 = $27bd) then
        begin
          { we found the instruction,
            local size is the lo part }
          LocalSize:=smallint(instr and $ffff);
          break;
        end;
    until i> MAX_INSTRUCTIONS;
    if LocalSize <> 0 then
      begin
        repeat
          inc(current_ra,4);
          instr:=instr_p(current_ra)^;
          if (instr shr 16 = $afbf) then
            ra_offset:=smallint(instr and $ffff)
          else if (instr shr 16 = $afbe) then
            s8_offset:=smallint(instr and $ffff);
        until (current_ra >= addr)
          or ((ra_offset<>-1) and (s8_offset<>-1));
        if ra_offset<>-1 then
          begin
            stackpos:=dword(framebp+LocalSize+ra_offset);
            addr:=reg_p(stackpos)^;
          end
        else
          addr:=nil;
        if s8_offset<>-1 then
          begin
            stackpos:=dword(framebp+LocalSize+s8_offset);
            framebp:=reg_p(stackpos)^;
          end
        else
          framebp:=nil;
      end;
  Except
    framebp:=nil;
    addr:=nil;
  end;
end;

{$define FPC_SYSTEM_HAS_GET_PC_ADDR}
function get_pc_addr : pointer;assembler;nostackframe;
asm
  move $2,$31
end;

{$define FPC_SYSTEM_HAS_GET_CALLER_ADDR}
function get_caller_addr(framebp:pointer;addr:pointer=nil):pointer;
begin
  get_caller_stackinfo(framebp,addr);
  get_caller_addr:=addr;
end;

{$define FPC_SYSTEM_HAS_GET_CALLER_FRAME}
function get_caller_frame(framebp:pointer;addr:pointer=nil):pointer;
begin
  get_caller_stackinfo(framebp,addr);
  get_caller_frame:=framebp;
end;

{$define FPC_SYSTEM_HAS_SPTR}
function Sptr:Pointer;assembler;nostackframe;
  asm
    move $2,$sp
  end;

{$ifndef FPC_SYSTEM_HAS_FILLCHAR}
{$define FPC_SYSTEM_HAS_FILLCHAR}
procedure FillChar(var x;count:SizeInt;value:byte);assembler;nostackframe;
// x=$a0, count=$a1, value=$a2
// $t0 and $t1 used as temps
  asm
    // correctness of this routine depends on instructions in delay slots!!
    slti   $t1, $a1, 8
    bne    $t1, $0, .Lless8
    andi   $a2, 0xff

    beq    $a2, $0, .L1         // if value is zero, expansion can be skipped
    sll    $t1, $a2, 8
    or     $a2, $t1
    sll    $t1, $a2, 16
    or     $a2, $t1
.L1:
    subu   $t1, $0, $a0         // negate
    andi   $t1, 3               // misalignment 0..3
    beq    $t1, $0, .L2
    subu   $a1, $t1             // decrease count (if branching, this is no-op because $t1=0)
{$ifdef ENDIAN_BIG}
    swl    $a2, 0($a0)
{$else ENDIAN_BIG}
    swr    $a2, 0($a0)
{$endif ENDIAN_BIG}
    addu   $a0, $t1             // add misalignment to address, making it dword-aligned
.L2:
    andi   $t1, $a1, 7          // $t1=count mod 8
    beq    $t1, $a1, .L3        // (count and 7)=count => (count and (not 7))=0
    subu   $t0, $a1, $t1        // $t0=count div 8
    addu   $t0, $a0             // $t0=last loop address
    move   $a1, $t1
.Lloop8:                        // do 2 dwords per iteration
    addiu  $a0, 8
    sw     $a2, -8($a0)
    bne    $a0, $t0, .Lloop8
    sw     $a2, -4($a0)
.L3:
    andi   $t1, $a1, 4          // handle a single dword separately
    beq    $t1, $0, .Lless8
    subu   $a1, $t1
    sw     $a2, 0($a0)
    addiu  $a0, 4

.Lless8:
    ble    $a1, $0, .Lexit
    addu   $t0, $a1, $a0
.L4:
    addiu  $a0, 1
    bne    $a0, $t0, .L4
    sb     $a2, -1($a0)
.Lexit:
  end;
{$endif FPC_SYSTEM_HAS_FILLCHAR}


{$ifdef USE_MIPS_STK2_ASM}
{$ifndef FPC_SYSTEM_HAS_MOVE}
(* Disabled for now
{$define FPC_SYSTEM_HAS_MOVE}
procedure Move(const source;var dest;count:longint);[public, alias: 'FPC_MOVE'];assembler;
  asm
{
  Registers:
    $7 temp. to do copying
    $8 inc/decrement
    $9/l0/l1/l2 qword move
}

    sw  $4,0($23)
    sw  $5,-4($23)
    sw  $6,-8($23)
    sw  $7,-12($23)
    sw  $8,-16($23)
    sw  $9,-20($23)
    sw  $10,-24($23)
    sw  $11,-28($23)
    sw  $12,-32($23)
    sw  $13,-36($23)
    sw  $14,-40($23)
    addiu  $23,$23,-44


    // count <= 0 ?
    ble $6,$0,.Lmoveexit
    nop

    // source = dest ?
    beq $4,$5,.Lmoveexit
    nop

    // possible overlap?
    bgt $4,$5,.Lnopossibleoverlap
    nop
    // source < dest ....
    addu $7,$6,$4
    // overlap?
    // source+count < dest ?
    blt $7,$5,.Lnopossibleoverlap
    nop

  .Lcopybackward:
    // check alignment of source and dest
    or $2,$4,$5

    // move src and dest to the end of the blocks
    // assuming 16 byte block size
    addiu $3,$6,-1
    addu $4,$4,$3
    addu $5,$5,$3

    b .Lmovebytewise
    li $3,-1

.Lnopossibleoverlap:

    // check alignment of source and dest
    or $2,$4,$5

    // everything 16 byte aligned ?
    andi $13,$2,15

    beq $13,$0,.Lmovetwordwise
    // load direction in delay slot
    li $3,16


    andi $13,$2,7
    beq $13,$0,.Lmoveqwordwise
    li $3,8

    andi $13,$2,3
    beq $13,$0,.Lmovedwordwise
    li $3,4

    andi $13,$2,1
    beq $13,$0,.Lmovewordwise
    li $3,2
    b .Lmovebytewise
    li $3,1

.Lmovetwordwise:
    srl $13,$6,4
    sll $14,$13,4
    beq $14,$0,.Lmoveqwordwise_shift
    nop

.Lmovetwordwise_loop:
    lw $9,0($4)
    lw $10,4($4)
    addiu $13,$13,-1
    lw $11,8($4)
    lw $12,12($4)
    addu $4,$4,$3
    sw $9,0($5)
    sw $10,4($5)
    sw $11,8($5)
    sw $12,12($5)
    addu $5,$5,$3
    bne $13,$0,.Lmovetwordwise_loop
    nop
    subu $6,$6,$14
    beq $6,$0,.Lmoveexit
    nop

.Lmoveqwordwise_shift:
    sra $3,$3,1

.Lmoveqwordwise:
    srl $13,$6,3
    sll $14,$13,3
    beq $14,$0,.Lmovedwordwise_shift
    nop

  .Lmoveqwordwise_loop:
    lw $9,0($4)
    lw $10,4($4)
    addiu $13,$13,-1
    addu $4,$3,$4
    sw $9,0($5)
    sw $10,4($5)
    addu $5,$3,$5
    bne $13,$0,.Lmoveqwordwise_loop
    nop

    subu $6,$6,$14
    beq $6,$0,.Lmoveexit
    nop

  .Lmovedwordwise_shift:
    sra $3,$3,1

  .Lmovedwordwise:
    srl $13,$6,2
    sll $14,$13,2
    beq $14,$0,.Lmovewordwise_shift
    nop

  .Lmovedwordwise_loop:
    lw $9,0($4)
    addiu $13,$13,-1
    addu $4,$4,$3
    sw $9,0($5)
    addu $5,$5,$3
    bne $13,$0,.Lmovedwordwise_loop
    nop

    subu $6,$6,$14
    beq $6,$0,.Lmoveexit
    nop

  .Lmovewordwise_shift:
    sra $3,$3,1
  .Lmovewordwise:
    srl $13,$6,1
    sll $14,$13,1
    beq $14,$0, .Lmovebytewise_shift
    nop

  .Lmovewordwise_loop:
    lhu $9,0($4)
    addiu $13,$13,-1
    addu $4,$4,$3
    sh $9,0($5)
    addu $5,$5,$3
    bne $13,$0,.Lmovewordwise_loop
    nop

    subu $6,$6,$14
    beq $6,$0, .Lmoveexit
    nop

  .Lmovebytewise_shift:
    sra $3,$3,1
  .Lmovebytewise:
    beq $6,$0, .Lmoveexit
    nop

    lbu $9,0($4)
    addiu $6,$6,-1
    addu $4,$4,$3
    sb $9,0($5)
    addu $5,$5,$3
    bne $6,$0,.Lmovebytewise
    nop
  .Lmoveexit:

  addiu  $23,$23,44
  lw  $4,0($23)
  lw  $5,-4($23)
  lw  $6,-8($23)
  lw  $7,-12($23)
  lw  $8,-16($23)
  lw  $9,-20($23)
  lw  $10,-24($23)
  lw  $11,-28($23)
  lw  $12,-32($23)
  lw  $13,-36($23)
  lw  $14,-40($23)

  end;
*)
{$endif FPC_SYSTEM_HAS_MOVE}
{$endif def USE_MIPS_STK2_ASM}

{$define FPC_SYSTEM_HAS_DECLOCKED_LONGINT}
function declocked(var l: longint) : boolean; inline;
begin
  Result:=InterLockedDecrement(l) = 0;
end;


{$define FPC_SYSTEM_HAS_INCLOCKED_LONGINT}
procedure inclocked(var l: longint); inline;
begin
  InterLockedIncrement(l);
end;

{$IFDEF VER3_2}
function InterLockedDecrement (var Target: longint) : longint;
{$ELSE VER3_2}
{$DEFINE FPC_SYSTEM_HAS_ATOMIC_DEC_32}
function fpc_atomic_dec_32 (var Target: longint) : longint;
{$ENDIF VER3_2}
{$IFDEF CPUMIPS1}
begin
    Target:= Target - 1;
    Result:=Target;
{$ELSE}
assembler; nostackframe;
asm
  sync
.L1:
  ll    $v0,($a0)
  addiu $v1,$v0,-1
  move  $v0,$v1        // must return value after decrement
  sc    $v1,($a0)
  beq   $v1,$0,.L1
  nop
  sync
{$ENDIF}
end;

{$IFDEF VER3_2}
function InterLockedIncrement (var Target: longint) : longint;
{$ELSE VER3_2}
{$DEFINE FPC_SYSTEM_HAS_ATOMIC_INC_32}
function fpc_atomic_inc_32 (var Target: longint) : longint;
{$ENDIF VER3_2}
{$IFDEF CPUMIPS1}
begin
    Target:= Target + 1;
    Result:=Target;
{$ELSE}
assembler; nostackframe;
asm
  sync
.L1:
  ll    $v0,($a0)
  addiu $v1,$v0,1
  move  $v0,$v1         // must return value after increment
  sc    $v1,($a0)
  beq   $v1,$0,.L1
  nop
  sync
{$ENDIF}
end;

{$IFDEF VER3_2}
function InterLockedExchange (var Target: longint;Source : longint) : longint;
{$ELSE VER3_2}
{$DEFINE FPC_SYSTEM_HAS_ATOMIC_XCHG_32}
function fpc_atomic_xchg_32 (var Target: longint;Source : longint) : longint;
{$ENDIF VER3_2}
{$IFDEF CPUMIPS1}
begin
    Result:=Target;
    Target:=Source;
{$ELSE}
assembler; nostackframe;
asm
  sync
.L1:
  ll    $v0,($a0)
  move  $v1,$a1
  sc    $v1,($a0)
  beq   $v1,$0,.L1
  nop
  sync
{$ENDIF}
end;

{$IFDEF VER3_2}
function InterLockedExchangeAdd (var Target: longint;Source : longint) : longint;
{$ELSE VER3_2}
{$DEFINE FPC_SYSTEM_HAS_ATOMIC_ADD_32}
function fpc_atomic_add_32 (var Target: longint;Value : longint) : longint;
{$ENDIF VER3_2}
{$IFDEF CPUMIPS1}
begin
    Result:=Target;
{$IFDEF VER3_2}
    Target:= Target + Source;
{$ELSE VER3_2}
    Target:= Target + Value;
{$ENDIF VER3_2}
{$ELSE}
assembler; nostackframe;
asm
  sync
.L1:
  ll    $v0,($a0)
  addu  $v1,$v0,$a1
  sc    $v1,($a0)
  beq   $v1,$0,.L1
  nop
  sync
{$ENDIF}
end;

{$IFDEF VER3_2}
function InterlockedCompareExchange(var Target: longint; NewValue: longint; Comperand: longint): longint;
{$ELSE VER3_2}
{$DEFINE FPC_SYSTEM_HAS_ATOMIC_CMP_XCHG_32}
function fpc_atomic_cmp_xchg_32 (var Target: longint; NewValue: longint; Comparand: longint) : longint; [public,alias:'FPC_ATOMIC_CMP_XCHG_32'];
{$ENDIF VER3_2}
{$IFDEF CPUMIPS1}
begin
    Result:= Target;
{$IFDEF VER3_2}
    if Target = Comperand then
{$ELSE VER3_2}
    if Target = Comparand then
{$ENDIF VER3_2}
      Target:= NewValue;
{$ELSE}
assembler; nostackframe;
asm
  sync
.L1:
  ll    $v0,($a0)
  bne   $v0,$a2,.L2
  nop
  move  $v1,$a1
  sc    $v1,($a0)
  beq   $v1,$0,.L1
  nop
  sync
.L2:
{$ENDIF}
end;

{$ifndef FPC_SYSTEM_HAS_SAR_QWORD}
{$ifdef ENDIAN_BIG}
{$define FPC_SYSTEM_HAS_SAR_QWORD}
function fpc_SarInt64(Const AValue : Int64;const Shift : Byte): Int64; [Public,Alias:'FPC_SARINT64']; compilerproc; assembler; nostackframe;
asm
{ $a0=high(AValue) $a1=low(AValue), result: $v0:$v1 }
    andi   $a2,$a2,63
    sltiu  $t0,$a2,32
    beq    $t0,$0,.L1
    nop

    srlv   $v1,$a1,$a2
    srav   $v0,$a0,$a2
    beq    $a2,$0,.Lexit
    nop
    subu   $t0,$0,$a2
    sllv   $t0,$a0,$t0
    or     $v1,$v1,$t0
    b      .Lexit
    nop
.L1:
    sra    $v0,$a0,31
    srav   $v1,$a0,$a2
.Lexit:
end;
{$endif ENDIAN_BIG}
{$endif FPC_SYSTEM_HAS_SAR_QWORD}
