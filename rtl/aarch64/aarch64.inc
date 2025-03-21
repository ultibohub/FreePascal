{

    This file is part of the Free Pascal run time library.
    Copyright (c) 2014 by Jonas Maebe, member of
    the Free Pascal development team.

    Processor dependent implementation for the system unit for
    AArch64

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$IFNDEF LINUX}
    {$DEFINE USE_DCBZ}
{$ENDIF LINUX}

{****************************************************************************
                           AArch64 specific stuff
****************************************************************************}
const
  fpu_ioe = 1 shl 8;
  fpu_dze = 1 shl 9;
  fpu_ofe = 1 shl 10;
  fpu_ufe = 1 shl 11;
  fpu_ixe = 1 shl 12;
  fpu_ide = 1 shl 15;
  fpu_exception_mask = fpu_ioe or fpu_dze or fpu_ofe or fpu_ufe or fpu_ixe or fpu_ide;
  fpu_exception_mask_to_status_mask_shift = 8;

function getfpcr: qword; nostackframe; assembler;
  asm
    mrs x0,fpcr
  end;


procedure setfpcr(val: qword);
  begin
    asm
      ldr x0,val
      msr fpcr,x0
{$if not defined(darwin) or defined(ios) or defined(watchos) or defined(tvos)}
      // read back the fpcr because on several (non-macOS) platforms it's raz
      mrs x0,fpcr
      str x0, val
{$endif}
    end;
    DefaultFPUControlWord:=val;
  end;


function getfpsr: qword; nostackframe; assembler;
  asm
    mrs x0,fpsr
  end;


function GetNativeFPUControlWord: TNativeFPUControlWord;
  begin
    result:=getfpcr;
  end;


procedure SetNativeFPUControlWord(const cw: TNativeFPUControlWord);
  begin
    setfpcr(cw);
  end;


procedure setfpsr(val: qword); nostackframe; assembler;
  asm
    msr fpsr, x0
  end;


const
  FPSR_IOC = 1;
  FPSR_DZC = 1 shl 1;
  FPSR_OFC = 1 shl 2;
  FPSR_UFC = 1 shl 3;
  FPSR_IXC = 1 shl 4;
  FPSR_IDC = 1 shl 7;
  FPSR_EXCEPTIONS = FPSR_IOC or FPSR_DZC or FPSR_OFC or FPSR_UFC or FPSR_IXC or FPSR_IDC;


procedure RaisePendingExceptions;
  var
    fpsr : qword;
    f: TFPUException;
  begin
    fpsr:=getfpsr;
    if (fpsr and FPSR_DZC) <> 0 then
      float_raise(exZeroDivide);
    if (fpsr and FPSR_OFC) <> 0 then
      float_raise(exOverflow);
    if (fpsr and FPSR_UFC) <> 0 then
      float_raise(exUnderflow);
    if (fpsr and FPSR_IOC) <> 0 then
      float_raise(exInvalidOp);
    if (fpsr and FPSR_IXC) <> 0 then
      float_raise(exPrecision);
    if (fpsr and FPSR_IDC) <> 0 then
      float_raise(exDenormalized);
    { now the soft float exceptions }
    for f in softfloat_exception_flags do
      float_raise(f);
  end;


{ as so far no AArch64 flavour which supports hard floating point exceptions, we use solely
  the softfloat_exception_mask for masking as the masking flags are RAZ and WI if floating point
  exceptions are not supported }
procedure fpc_throwfpuexception;[public,alias:'FPC_THROWFPUEXCEPTION'];
  var
    fpsr : qword;
    f: TFPUException;
  begin
    { at this point, we know already, that an exception will be risen }
    fpsr:=getfpsr;

    { check, if the exception is masked }
    if ((fpsr and FPSR_DZC) <> 0) and (exZeroDivide in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_DZC);
    if ((fpsr and FPSR_OFC) <> 0) and (exOverflow in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_OFC);
    if ((fpsr and FPSR_UFC) <> 0) and (exUnderflow in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_UFC);
    if ((fpsr and FPSR_IOC) <> 0) and (exInvalidOp in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_IOC);
    if ((fpsr and FPSR_IXC) <> 0) and (exPrecision in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_IXC);
    if ((fpsr and FPSR_IDC) <> 0) and (exDenormalized in softfloat_exception_mask) then
      fpsr:=fpsr and not(FPSR_IDC);
    setfpsr(fpsr);
    if (fpsr and FPSR_EXCEPTIONS)<>0 then
      RaisePendingExceptions;
  end;


{$define FPC_SYSTEM_HAS_SYSINITFPU}
procedure SysInitFPU;
  begin
    softfloat_rounding_mode:=rmNearest;
    { 0 is rmNearest }
    setfpcr(getfpcr and $ff3fffff);
    { clear all "exception happened" flags we care about}
    setfpsr(getfpsr and not(fpu_exception_mask shr fpu_exception_mask_to_status_mask_shift));
    { enable invalid operations, overflow and division by zero exceptions. }
    setfpcr(((getfpcr and not(fpu_exception_mask)) or fpu_dze or fpu_ofe or fpu_ioe));
    softfloat_exception_mask:=[float_flag_underflow,float_flag_inexact,float_flag_denormal];
    softfloat_exception_flags:=[];
  end;


{$define FPC_SYSTEM_HAS_SYSRESETFPU}
Procedure SysResetFPU;{$ifdef SYSTEMINLINE}inline;{$endif}
begin
  softfloat_exception_flags:=[];
  { clear all "exception happened" flags we care about}
  setfpsr(getfpsr and not(fpu_exception_mask shr fpu_exception_mask_to_status_mask_shift));
end;


{****************************************************************************
                                Move / Fill
****************************************************************************}


{****************************************************************************
                                 String
****************************************************************************}

{$define FPC_SYSTEM_HAS_GET_CALLER_ADDR}
function get_caller_addr(framebp:pointer;addr:pointer=nil):pointer;assembler; nostackframe;
  asm
    cbz x0, .Lcaller_addr_invalid
{$ifdef cpullvm}
    movn w1, #0
    cmp x0, x1
    csel x0, xzr, x0, ls
    b.ls .Lcaller_addr_invalid
{$endif cpullvm}
    ldur x0, [x0, #8]
   .Lcaller_addr_invalid:
  end;

{$define FPC_SYSTEM_HAS_GET_CALLER_FRAME}
function get_caller_frame(framebp:pointer;addr:pointer=nil):pointer;assembler; nostackframe;
  asm
    cbz x0, .Lcaller_addr_invalid
    ldur x0, [x0]
   .Lcaller_addr_invalid:
  end;


{$define FPC_SYSTEM_HAS_SPTR}
Function Sptr : Pointer;assembler; nostackframe;
  asm
    mov x0, sp
  end;


{****************************************************************************
                                 Str()
****************************************************************************}

{ int_str: generic implementation is used for now }


{****************************************************************************
                             Multithreading
****************************************************************************}

{ perform a thread-safe inc/dec }

{$define FPC_SYSTEM_HAS_DECLOCKED_LONGINT}
function declocked(var l : longint) : boolean;assembler;nostackframe;
  { input:  address of l in x0                                      }
  { output: boolean indicating whether l is zero after decrementing }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    w1,#-1
    ldadd  w1,w2,[x0]
    adds   w2,w2,w1
    cset   w0,eq
  {$else CPUAARCH64_HAS_LSE}
  .LDecLockedLoop:
    ldxr   w1,[x0]
    subs   w1,w1,#1
    stxr   w2,w1,[x0]
    cbnz   w2,.LDecLockedLoop
    cset   w0, eq
  {$endif CPUAARCH64_HAS_LSE}
  end;

{$define FPC_SYSTEM_HAS_INCLOCKED_LONGINT}
procedure inclocked(var l : longint);assembler;nostackframe;
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    w1,#1
    ldadd  w1,w2,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LIncLockedLoop:
    ldxr   w1,[x0]
    add    w1,w1,#1
    stxr   w2,w1,[x0]
    cbnz   w2,.LIncLockedLoop
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$define FPC_SYSTEM_HAS_DECLOCKED_INT64}
function declocked(var l : int64) : boolean;assembler;nostackframe;
  { input:  address of l in x0                                      }
  { output: boolean indicating whether l is zero after decrementing }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    x1,#-1
    ldadd  x1,x2,[x0]
    adds   x2,x2,x1
    cset   w0,eq
   {$else CPUAARCH64_HAS_LSE}
  .LDecLockedLoop:
    ldxr   x1,[x0]
    subs   x1,x1,#1
    stxr   w2,x1,[x0]
    cbnz   w2,.LDecLockedLoop
    cset   w0, eq
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$define FPC_SYSTEM_HAS_INCLOCKED_INT64}
procedure inclocked(var l : int64);assembler;nostackframe;
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    x1,#1
    ldadd  x1,x2,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LIncLockedLoop:
    ldxr   x1,[x0]
    add    x1,x1,#1
    stxr   w2,x1,[x0]
    cbnz   w2,.LIncLockedLoop
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedDecrement (var Target: longint) : longint; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_DEC_32}
function fpc_atomic_dec_32 (var Target: longint) : longint; assembler; nostackframe;
{$endif VER3_2}
  { input:  address of target in x0 }
  { output: target-1 in x0          }
  { side-effect: target := target-1 }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    w1,#-1
    ldadd  w1,w2,[x0]
    add    w0,w2,w1
  {$else CPUAARCH64_HAS_LSE}
  .LInterDecLockedLoop:
    ldxr   w1,[x0]
    subs   w1,w1,#1
    stxr   w2,w1,[x0]
    cbnz   w2,.LInterDecLockedLoop
    mov    w0,w1
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedIncrement (var Target: longint) : longint; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_INC_32}
function fpc_atomic_inc_32 (var Target: longint) : longint; assembler; nostackframe;
{$endif VER3_2}
  { input:  address of target in x0 }
  { output: target+1 in x0          }
  { side-effect: target := target+1 }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    w1,#1
    ldadd  w1,w2,[x0]
    add    w0,w2,w1
  {$else CPUAARCH64_HAS_LSE}
  .LInterIncLockedLoop:
    ldxr   w1,[x0]
    add    w1,w1,#1
    stxr   w2,w1,[x0]
    cbnz   w2,.LInterIncLockedLoop
    mov    w0,w1
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedExchange (var Target: longint;Source : longint) : longint; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_XCHG_32}
function fpc_atomic_xchg_32 (var Target: longint;Source : longint) : longint; assembler; nostackframe;
{$endif VER3_2}
  { input:  address of target in x0, source in w1 }
  { output: target in x0                          }
  { side-effect: target := source                 }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    swp    w1,w0,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LInterLockedXchgLoop:
    ldxr   w2,[x0]
    stxr   w3,w1,[x0]
    cbnz   w3,.LInterLockedXchgLoop
    mov    w0,w2
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedExchangeAdd (var Target: longint;Source : longint) : longint; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_ADD_32}
function fpc_atomic_add_32 (var Target: longint;Value : longint) : longint; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    ldadd    w1,w0,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LInterLockedXchgAddLoop:
    ldxr   w2,[x0]
    add    w4,w2,w1
    stxr   w3,w4,[x0]
    cbnz   w3,.LInterLockedXchgAddLoop
    mov    w0,w2
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterlockedCompareExchange(var Target: longint; NewValue: longint; Comperand: longint): longint; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_CMP_XCHG_32}
function fpc_atomic_cmp_xchg_32(var Target: longint; NewValue: longint; Comparand: longint): longint; assembler; nostackframe;
{$endif VER3_2}
  { input:  address of target in x0, newvalue in w1, comparand in w2 }
  { output: value stored in target before entry of the function      }
  { side-effect: NewValue stored in target if (target = comparand)   }
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    cas    w2,w1,[x0]
    mov    w0,w2
  {$else CPUAARCH64_HAS_LSE}
  .LInterlockedCompareExchangeLoop:
    ldxr   w3,[x0]
    cmp    w3,w2
    csel   w4,w1,w3,eq
    stxr   w5,w4,[x0]
    cbnz   w5,.LInterlockedCompareExchangeLoop
    mov    w0,w3
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedDecrement64 (var Target: int64) : int64; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_DEC_64}
function fpc_atomic_dec_64 (var Target: int64) : int64; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    x1,#-1
    ldadd  x1,x2,[x0]
    add    x0,x2,x1
  {$else CPUAARCH64_HAS_LSE}
  .LInterDecLockedLoop:
    ldxr   x1,[x0]
    sub    x1,x1,#1
    stxr   w2,x1,[x0]
    cbnz   w2,.LInterDecLockedLoop
    mov    x0,x1
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedIncrement64 (var Target: int64) : int64; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_INC_64}
function fpc_atomic_inc_64 (var Target: int64) : int64; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    mov    x1,#1
    ldadd  x1,x2,[x0]
    add    x0,x2,x1
  {$else CPUAARCH64_HAS_LSE}
  .LInterIncLockedLoop:
    ldxr   x1,[x0]
    add    x1,x1,#1
    stxr   w2,x1,[x0]
    cbnz   w2,.LInterIncLockedLoop
    mov    x0,x1
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedExchange64 (var Target: int64;Source : int64) : int64; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_XCHG_64}
function fpc_atomic_xchg_64 (var Target: int64;Source : int64) : int64; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    swp    x1,x0,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LInterLockedXchgLoop:
    ldxr   x2,[x0]
    stxr   w3,x1,[x0]
    cbnz   w3,.LInterLockedXchgLoop
    mov    x0,x2
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedExchangeAdd64 (var Target: int64;Source : int64) : int64; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_ADD_64}
function fpc_atomic_add_64 (var Target: int64;Value : int64) : int64; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    ldadd    x1,x0,[x0]
  {$else CPUAARCH64_HAS_LSE}
  .LInterLockedXchgAddLoop:
    ldxr   x2,[x0]
    add    x4,x2,x1
    stxr   w3,x4,[x0]
    cbnz   w3,.LInterLockedXchgAddLoop
    mov    x0,x2
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifdef VER3_2}
function InterLockedCompareExchange64(var Target: int64; NewValue, Comperand : int64): int64; assembler; nostackframe;
{$else VER3_2}
{$define FPC_SYSTEM_HAS_ATOMIC_CMP_XCHG_64}
function fpc_atomic_cmp_xchg_64 (var Target: int64; NewValue, Comparand : int64) : int64; [public, alias: 'FPC_ATOMIC_CMP_XCHG_64']; assembler; nostackframe;
{$endif VER3_2}
  asm
  {$ifdef CPUAARCH64_HAS_LSE}
    cas    x2,x1,[x0]
    mov    x0,x2
  {$else CPUAARCH64_HAS_LSE}
  .LInterlockedCompareExchangeLoop:
    ldxr   x3,[x0]
    cmp    x3,x2
    csel   x4,x1,x3,eq
    stxr   w5,x4,[x0]
    cbnz   w5,.LInterlockedCompareExchangeLoop
    mov    x0,x3
  {$endif CPUAARCH64_HAS_LSE}
  end;


{$ifndef FPC_SYSTEM_HAS_MEM_BARRIER}
{$define FPC_SYSTEM_HAS_MEM_BARRIER}
procedure ReadBarrier;assembler;nostackframe;{$ifdef SYSTEMINLINE}inline;{$endif}
  asm
    // { dmb ishld }
    dmb #9
  end;

procedure ReadDependencyBarrier;{$ifdef SYSTEMINLINE}inline;{$endif}
begin
  { reads imply barrier on earlier reads depended on }
end;

procedure ReadWriteBarrier;assembler;nostackframe;{$ifdef SYSTEMINLINE}inline;{$endif}
asm
  // { dmb ish }
  dmb #11
end;

procedure WriteBarrier;assembler;nostackframe;{$ifdef SYSTEMINLINE}inline;{$endif}
asm
  // { dmb ishst }
  dmb #10
end;

{$endif}


{****************************************************************************
                          Math Routines
****************************************************************************}

{$define FPC_SYSTEM_HAS_SWAPENDIAN}

function SwapEndian(const AValue: SmallInt): SmallInt; assembler; nostackframe;
asm
  rev16 w0, w0
end;


function SwapEndian(const AValue: Word): Word; assembler; nostackframe;
asm
  rev16 w0, w0
end;


function SwapEndian(const AValue: LongInt): LongInt; assembler; nostackframe;
asm
  rev32 x0, x0
end;


function SwapEndian(const AValue: DWord): DWord; assembler; nostackframe;
asm
  rev32 x0, x0
end;


function SwapEndian(const AValue: Int64): Int64; assembler; nostackframe;
asm
  rev x0, x0
end;


function SwapEndian(const AValue: QWord): QWord; assembler; nostackframe;
asm
  rev x0, x0
end;

{$define FPC_SYSTEM_HAS_UMUL64X64_128}
function UMul64x64_128(a,b: uint64; out rHi: uint64): uint64; assembler; nostackframe;
asm
  umulh x3,x0,x1
  mul x0,x0,x1
  str x3,[x2]
end;
