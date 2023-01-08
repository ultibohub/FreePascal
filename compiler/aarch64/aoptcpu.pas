{
    Copyright (c) 1998-2002 by Jonas Maebe, member of the Free Pascal
    Development Team

    This unit implements the ARM64 optimizer object

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

Unit aoptcpu;

{$i fpcdefs.inc}

{$ifdef EXTDEBUG}
{$define DEBUG_AOPTCPU}
{$endif EXTDEBUG}

Interface

    uses
      globtype, globals,
      cutils,
      cgbase, cpubase, aasmtai, aasmcpu,
      aopt, aoptcpub, aoptarm;

    Type
      TCpuAsmOptimizer = class(TARMAsmOptimizer)
        { uses the same constructor as TAopObj }
        function PrePeepHoleOptsCpu(var p: tai): boolean; override;
        function PeepHoleOptPass1Cpu(var p: tai): boolean; override;
        function PeepHoleOptPass2Cpu(var p: tai): boolean; override;
        function PostPeepHoleOptsCpu(var p: tai): boolean; override;
        function RegLoadedWithNewValue(reg: tregister; hp: tai): boolean;override;
        function InstructionLoadsFromReg(const reg: TRegister; const hp: tai): boolean;override;
        function LookForPostindexedPattern(var p : tai) : boolean;
      public
        { With these routines, there's optimisation code that's general for all ARM platforms }
        function OptPass1LDR(var p: tai): Boolean; override;
        function OptPass1STR(var p: tai): Boolean; override;
      private
        function RemoveSuperfluousFMov(const p: tai; movp: tai; const optimizer: string): boolean;
        function OptPass1Shift(var p: tai): boolean;
        function OptPostCMP(var p: tai): boolean;
        function OptPostAnd(var p: tai): Boolean;
        function OptPass1Data(var p: tai): boolean;
        function OptPass1FData(var p: tai): Boolean;
        function OptPass1STP(var p: tai): boolean;
        function OptPass1Mov(var p: tai): boolean;
        function OptPass1MOVZ(var p: tai): boolean;
        function OptPass1FMov(var p: tai): Boolean;
        function OptPass1SXTW(var p: tai): Boolean;

        function OptPass2LDRSTR(var p: tai): boolean;
      End;

Implementation

  uses
    aasmbase,
    aoptutils,
    cgutils,
    verbose;

{$ifdef DEBUG_AOPTCPU}
    const
      SPeepholeOptimization: shortstring = 'Peephole Optimization: ';
{$else DEBUG_AOPTCPU}
    { Empty strings help the optimizer to remove string concatenations that won't
      ever appear to the user on release builds. [Kit] }
    const
      SPeepholeOptimization = '';
{$endif DEBUG_AOPTCPU}

  function CanBeCond(p : tai) : boolean;
    begin
      result:=(p.typ=ait_instruction) and (taicpu(p).condition=C_None);
    end;


  function TCpuAsmOptimizer.RegLoadedWithNewValue(reg: tregister; hp: tai): boolean;
    var
      p: taicpu;
    begin
      Result := false;
      if not ((assigned(hp)) and (hp.typ = ait_instruction)) then
        exit;

      p := taicpu(hp);
      case p.opcode of
        { These operations do not write into a register at all

          LDR/STR with post/pre-indexed operations do not need special treatment
          because post-/preindexed does not mean that a register
          is loaded with a new value, it is only modified }
        A_STR, A_CMP, A_CMN, A_TST, A_B, A_BL, A_MSR, A_FCMP:
          exit;
        else
          ;
      end;

      if p.ops=0 then
        exit;

      case p.oper[0]^.typ of
        top_reg:
          Result := SuperRegistersEqual(p.oper[0]^.reg,reg);
        top_ref:
          Result :=
            (taicpu(p).oper[0]^.ref^.addressmode in [AM_PREINDEXED,AM_POSTINDEXED]) and
            (taicpu(p).oper[0]^.ref^.base = reg);
        else
          ;
      end;
    end;


  function TCpuAsmOptimizer.InstructionLoadsFromReg(const reg: TRegister; const hp: tai): boolean;
    var
      p: taicpu;
      i: longint;
    begin
      instructionLoadsFromReg := false;
      if not (assigned(hp) and (hp.typ = ait_instruction)) then
        exit;
      p:=taicpu(hp);

      i:=1;

      { Start on oper[0]? }
      if taicpu(hp).spilling_get_operation_type(0) in [operand_read, operand_readwrite] then
        i:=0;

      while(i<p.ops) do
        begin
          case p.oper[I]^.typ of
            top_reg:
              Result := (p.oper[I]^.reg = reg);
            top_ref:
              Result :=
                (p.oper[I]^.ref^.base = reg) or
                (p.oper[I]^.ref^.index = reg);
            else
              ;
          end;
          { Bailout if we found something }
          if Result then
            exit;
          Inc(I);
        end;
    end;

  {
    optimize
      ldr/str regX,[reg1]
      ...
      add/sub reg1,reg1,regY/const

      into

      ldr/str regX,[reg1], regY/const
  }
  function TCpuAsmOptimizer.LookForPostindexedPattern(var p: tai) : boolean;
    var
      hp1 : tai;
    begin
      Result:=false;
      if (taicpu(p).oper[1]^.typ = top_ref) and
        (taicpu(p).oper[1]^.ref^.addressmode=AM_OFFSET) and
        (taicpu(p).oper[1]^.ref^.index=NR_NO) and
        (taicpu(p).oper[1]^.ref^.offset=0) and
        GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[1]^.ref^.base) and
        { we cannot check NR_DEFAULTFLAGS for modification yet so don't allow a condition }
        MatchInstruction(hp1, [A_ADD, A_SUB], [PF_None]) and
        (taicpu(hp1).oper[0]^.reg=taicpu(p).oper[1]^.ref^.base) and
        (taicpu(hp1).oper[1]^.reg=taicpu(p).oper[1]^.ref^.base) and
        (
         { valid offset? }
         (taicpu(hp1).oper[2]^.typ=top_const) and
         (taicpu(hp1).oper[2]^.val>=-256) and
         (abs(taicpu(hp1).oper[2]^.val)<256)
        ) and
        { don't apply the optimization if the base register is loaded }
        (getsupreg(taicpu(p).oper[0]^.reg)<>getsupreg(taicpu(p).oper[1]^.ref^.base)) and
        not(RegModifiedBetween(taicpu(hp1).oper[0]^.reg,p,hp1)) and
        not(RegModifiedBetween(taicpu(hp1).oper[2]^.reg,p,hp1)) then
        begin
          if taicpu(p).opcode = A_LDR then
            DebugMsg(SPeepholeOptimization + 'LdrAdd/Sub2Ldr Postindex done', p)
          else
            DebugMsg(SPeepholeOptimization + 'StrAdd/Sub2Str Postindex done', p);

          taicpu(p).oper[1]^.ref^.addressmode:=AM_POSTINDEXED;
          if taicpu(hp1).opcode=A_ADD then
            taicpu(p).oper[1]^.ref^.offset:=taicpu(hp1).oper[2]^.val
          else
            taicpu(p).oper[1]^.ref^.offset:=-taicpu(hp1).oper[2]^.val;
          asml.Remove(hp1);
          hp1.Free;
          Result:=true;
        end;
    end;


  function TCpuAsmOptimizer.RemoveSuperfluousFMov(const p: tai; movp: tai; const optimizer: string):boolean;
    var
      alloc,
      dealloc : tai_regalloc;
      hp1 : tai;
    begin
      Result:=false;
      if ((MatchInstruction(movp, A_FMOV, [taicpu(p).condition], [taicpu(p).oppostfix]) and
           ((getregtype(taicpu(movp).oper[0]^.reg)=R_MMREGISTER) { or (taicpu(p).opcode in [A_LDUR])})
          ) { or
          (((taicpu(p).oppostfix in [PF_F64F32,PF_F64S16,PF_F64S32,PF_F64U16,PF_F64U32]) or (getsubreg(taicpu(p).oper[0]^.reg)=R_SUBFD)) and MatchInstruction(movp, A_VMOV, [taicpu(p).condition], [PF_F64])) or
          (((taicpu(p).oppostfix in [PF_F32F64,PF_F32S16,PF_F32S32,PF_F32U16,PF_F32U32]) or (getsubreg(taicpu(p).oper[0]^.reg)=R_SUBFS)) and MatchInstruction(movp, A_VMOV, [taicpu(p).condition], [PF_F32])) }
         ) and
         (taicpu(movp).ops=2) and
         MatchOperand(taicpu(movp).oper[1]^, taicpu(p).oper[0]^.reg) and
         { the destination register of the mov might not be used beween p and movp }
         not(RegUsedBetween(taicpu(movp).oper[0]^.reg,p,movp)) and
         { Take care to only do this for instructions which REALLY load to the first register.
           Otherwise
             str reg0, [reg1]
             fmov reg2, reg0
           will be optimized to
             str reg2, [reg1]
         }
         RegLoadedWithNewValue(taicpu(p).oper[0]^.reg, p) then
        begin
          dealloc:=FindRegDeAlloc(taicpu(p).oper[0]^.reg,tai(movp.Next));
          if assigned(dealloc) then
            begin
              DebugMsg(SPeepholeOptimization + optimizer+' removed superfluous vmov', movp);
              result:=true;

              { taicpu(p).oper[0]^.reg is not used anymore, try to find its allocation
                and remove it if possible }
              asml.Remove(dealloc);
              alloc:=FindRegAllocBackward(taicpu(p).oper[0]^.reg,tai(p.previous));
              if assigned(alloc) then
                begin
                  asml.Remove(alloc);
                  alloc.free;
                  dealloc.free;
                end
              else
                asml.InsertAfter(dealloc,p);

              { try to move the allocation of the target register }
              GetLastInstruction(movp,hp1);
              alloc:=FindRegAlloc(taicpu(movp).oper[0]^.reg,tai(hp1.Next));
              if assigned(alloc) then
                begin
                  asml.Remove(alloc);
                  asml.InsertBefore(alloc,p);
                  { adjust used regs }
                  IncludeRegInUsedRegs(taicpu(movp).oper[0]^.reg,UsedRegs);
                end;

              { change
                  vldr reg0,[reg1]
                  vmov reg2,reg0
                into
                  ldr reg2,[reg1]

                if reg2 is an int register
              if (taicpu(p).opcode=A_VLDR) and (getregtype(taicpu(movp).oper[0]^.reg)=R_INTREGISTER) then
                taicpu(p).opcode:=A_LDR;
              }

              { finally get rid of the mov }
              taicpu(p).loadreg(0,taicpu(movp).oper[0]^.reg);
              asml.remove(movp);
              movp.free;
            end;
        end;
    end;


  function TCpuAsmOptimizer.OptPass1LDR(var p: tai): Boolean;
    var
      hp1: tai;
    begin
      Result := False;
      if inherited OptPass1LDR(p) or
        LookForPostindexedPattern(p) then
        Exit(True)
      else if (taicpu(p).oppostfix in [PF_B,PF_SB,PF_H,PF_SH,PF_None]) and
        GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
        RemoveSuperfluousMove(p, hp1, 'Ldr<Postfix>Mov2Ldr<Postfix>') then
        Exit(true);
    end;


  function TCpuAsmOptimizer.OptPass1STR(var p: tai): Boolean;
    begin
      Result := False;
      if inherited OptPass1STR(p) or
        LookForPostindexedPattern(p) then
        Exit(True);
    end;


  function TCpuAsmOptimizer.OptPass1Shift(var p : tai): boolean;
    var
      hp1,hp2: tai;
      I2, I: Integer;
      shifterop: tshifterop;
    begin
      Result:=false;
      { This folds shifterops into following instructions
        <shiftop> r0, r1, #imm
        <op> r2, r3, r0

        to

        <op> r2, r3, r1, <shiftop> #imm
      }
      { do not handle ROR yet, only part of the instructions below support ROR as shifter operand }
      if MatchInstruction(p,[A_LSL, A_LSR, A_ASR{, A_ROR}],[PF_None]) and
         MatchOpType(taicpu(p),top_reg,top_reg,top_const) and
         GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
         MatchInstruction(hp1, [A_ADD, A_AND, A_BIC, A_CMP, A_CMN,
                                A_EON, A_EOR, A_NEG, A_ORN, A_ORR,
                                A_SUB, A_TST], [PF_None]) and
         RegEndOfLife(taicpu(p).oper[0]^.reg, taicpu(hp1)) and
         (taicpu(hp1).ops >= 2) and
         { Currently we can't fold into another shifterop }
         (taicpu(hp1).oper[taicpu(hp1).ops-1]^.typ = top_reg) and
         { SP does not work completely with shifted registers, as I didn't find the exact rules,
           we do not operate on SP }
         (taicpu(hp1).oper[0]^.reg<>NR_SP) and
         (taicpu(hp1).oper[1]^.reg<>NR_SP) and
         (taicpu(hp1).oper[taicpu(hp1).ops-1]^.reg<>NR_SP) and
         { reg1 might not be modified inbetween }
         not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) and
         (
           { Only ONE of the two src operands is allowed to match }
           MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[taicpu(hp1).ops-2]^) xor
           MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[taicpu(hp1).ops-1]^)
         ) and
         { for SUB, the last operand must match, there is no RSB on AArch64 }
         ((taicpu(hp1).opcode<>A_SUB) or
          MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[taicpu(hp1).ops-1]^)) then
        begin
          { for the two operand instructions, start also at the second operand as they are not always commutative
            (depends on the flags tested laster on) and thus the operands cannot swapped }
          I2:=1;
          for I:=I2 to taicpu(hp1).ops-1 do
            if MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[I]^.reg) then
              begin
                { If the parameter matched on the second op from the RIGHT
                  we have to switch the parameters, this will not happen for CMP
                  were we're only evaluating the most right parameter
                }
                shifterop_reset(shifterop);
                case taicpu(p).opcode of
                  A_LSL:
                    shifterop.shiftmode:=SM_LSL;
                  A_ROR:
                    shifterop.shiftmode:=SM_ROR;
                  A_LSR:
                    shifterop.shiftmode:=SM_LSR;
                  A_ASR:
                    shifterop.shiftmode:=SM_ASR;
                  else
                    InternalError(2019090401);
                end;
                shifterop.shiftimm:=taicpu(p).oper[2]^.val;

                if I <> taicpu(hp1).ops-1 then
                  begin
                    if taicpu(hp1).ops = 3 then
                      hp2:=taicpu.op_reg_reg_reg_shifterop(taicpu(hp1).opcode,
                           taicpu(hp1).oper[0]^.reg, taicpu(hp1).oper[2]^.reg,
                           taicpu(p).oper[1]^.reg, shifterop)
                    else
                      hp2:=taicpu.op_reg_reg_shifterop(taicpu(hp1).opcode,
                           taicpu(hp1).oper[0]^.reg, taicpu(p).oper[1]^.reg,
                           shifterop);
                  end
                else
                  if taicpu(hp1).ops = 3 then
                    hp2:=taicpu.op_reg_reg_reg_shifterop(taicpu(hp1).opcode,
                         taicpu(hp1).oper[0]^.reg, taicpu(hp1).oper[1]^.reg,
                         taicpu(p).oper[1]^.reg,shifterop)
                  else
                    hp2:=taicpu.op_reg_reg_shifterop(taicpu(hp1).opcode,
                         taicpu(hp1).oper[0]^.reg, taicpu(p).oper[1]^.reg,
                         shifterop);

                { Make sure the register used in the shifting is tracked all
                  the way through, otherwise it may become deallocated while
                  it's still live and cause incorrect optimisations later }
                if (taicpu(hp1).oper[0]^.reg <> taicpu(p).oper[1]^.reg) then
                  begin
                    TransferUsedRegs(TmpUsedRegs);
                    UpdateUsedRegs(TmpUsedRegs, tai(p.Next));
                    ALlocRegBetween(taicpu(p).oper[1]^.reg, p, hp1, TmpUsedRegs);
                  end;

                taicpu(hp2).fileinfo:=taicpu(hp1).fileinfo;
                asml.insertbefore(hp2, hp1);

                RemoveInstruction(hp1);
                RemoveCurrentp(p);

                DebugMsg(SPeepholeOptimization + 'FoldShiftProcess done', hp2);
                Result:=true;
                break;
              end;
        end
      else if MatchInstruction(p,[A_LSL, A_LSR, A_ASR,A_ROR],[PF_None]) and
        GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
        RemoveSuperfluousMove(p, hp1, 'ShiftMov2Shift') then
        Result:=true;
    end;


  function TCpuAsmOptimizer.OptPass1Data(var p : tai): boolean;
    var
      hp1: tai;
    begin
      Result := GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
        RemoveSuperfluousMove(p, hp1, 'DataMov2Data');
    end;


  function TCpuAsmOptimizer.OptPass1FData(var p: tai): Boolean;
    var
      hp1: tai;
    begin
      Result := GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
        RemoveSuperfluousFMov(p, hp1, 'FOpFMov2FOp');
    end;


  function TCpuAsmOptimizer.OptPass1STP(var p : tai): boolean;
    var
      hp1, hp2, hp3, hp4: tai;
    begin
      Result:=false;
      {
        change

	stp	x29,x30,[sp, #-16]!
	mov	x29,sp
	bl	abc
	ldp	x29,x30,[sp], #16
	ret

        into

        b         abc
      }
      if MatchInstruction(p, A_STP, [C_None], [PF_None]) and
        MatchOpType(taicpu(p),top_reg,top_reg,top_ref) and
        (taicpu(p).oper[0]^.reg = NR_X29) and
        (taicpu(p).oper[1]^.reg = NR_X30) and
        (taicpu(p).oper[2]^.ref^.base=NR_STACK_POINTER_REG) and
        (taicpu(p).oper[2]^.ref^.index=NR_NO) and
        (taicpu(p).oper[2]^.ref^.offset=-16) and
        (taicpu(p).oper[2]^.ref^.addressmode=AM_PREINDEXED) and

        GetNextInstruction(p, hp1) and
        MatchInstruction(hp1, A_MOV, [C_None], [PF_NONE]) and
        MatchOperand(taicpu(hp1).oper[0]^,taicpu(p).oper[0]^) and
        (taicpu(hp1).oper[1]^.typ = top_reg) and
        (taicpu(hp1).oper[1]^.reg = NR_STACK_POINTER_REG) and

        GetNextInstruction(hp1, hp2) and
        SkipEntryExitMarker(hp2, hp2) and
        MatchInstruction(hp2, A_BL, [C_None], [PF_NONE]) and
        (taicpu(hp2).oper[0]^.typ = top_ref) and

        GetNextInstruction(hp2, hp3) and
        SkipEntryExitMarker(hp3, hp3) and
        MatchInstruction(hp3, A_LDP, [C_None], [PF_NONE]) and
        MatchOpType(taicpu(hp3),top_reg,top_reg,top_ref) and
        (taicpu(hp3).oper[0]^.reg = NR_X29) and
        (taicpu(hp3).oper[1]^.reg = NR_X30) and
        (taicpu(hp3).oper[2]^.ref^.base=NR_STACK_POINTER_REG) and
        (taicpu(hp3).oper[2]^.ref^.index=NR_NO) and
        (taicpu(hp3).oper[2]^.ref^.offset=16) and
        (taicpu(hp3).oper[2]^.ref^.addressmode=AM_POSTINDEXED) and

        GetNextInstruction(hp3, hp4) and
        MatchInstruction(hp4, A_RET, [C_None], [PF_None]) and
        (taicpu(hp4).ops = 0) then
        begin
          asml.Remove(p);
          asml.Remove(hp1);
          asml.Remove(hp3);
          asml.Remove(hp4);
          taicpu(hp2).opcode:=A_B;
          p.free;
          hp1.free;
          hp3.free;
          hp4.free;
          p:=hp2;
          DebugMsg(SPeepholeOptimization + 'Bl2B done', p);
          Result:=true;
        end;
    end;


  function TCpuAsmOptimizer.OptPass1Mov(var p : tai): boolean;
    var
      hp1: tai;
      so: tshifterop;
    begin
     Result:=false;
     if MatchOperand(taicpu(p).oper[0]^,taicpu(p).oper[1]^) and
       (taicpu(p).oppostfix=PF_None) then
       begin
         RemoveCurrentP(p);
         DebugMsg(SPeepholeOptimization + 'Mov2None done', p);
         Result:=true;
       end


     else if (taicpu(p).ops=2) and
       (getsubreg(taicpu(p).oper[0]^.reg)=R_SUBD) and
       GetNextInstruction(p, hp1) and
       { Faster to get it out of the way than go through MatchInstruction }
       (hp1.typ=ait_instruction) and
       (taicpu(hp1).ops=3) and
       MatchInstruction(hp1,[A_ADD,A_SUB],[taicpu(p).condition], [PF_None,PF_S]) and
       (getsubreg(taicpu(hp1).oper[2]^.reg)=R_SUBQ) and
       (getsupreg(taicpu(p).oper[0]^.reg)=getsupreg(taicpu(hp1).oper[2]^.reg)) and
       RegEndOfLife(taicpu(hp1).oper[2]^.reg,taicpu(hp1)) then
       begin
         DebugMsg(SPeepholeOptimization + 'MovOp2AddUtxw 1 done', p);
         shifterop_reset(so);
         so.shiftmode:=SM_UXTW;
         taicpu(hp1).ops:=4;
         taicpu(hp1).loadreg(2,taicpu(p).oper[1]^.reg);
         taicpu(hp1).loadshifterop(3,so);
         RemoveCurrentP(p);
         Result:=true;
         exit;
       end
     {
       optimize
       mov rX, yyyy
       ....
     }
     else if GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) then
       begin
         if RemoveSuperfluousMove(p, hp1, 'MovMov2Mov') then
           Result:=true
         else if (taicpu(p).ops = 2) and
           (tai(hp1).typ = ait_instruction) and
           RedundantMovProcess(p,hp1) then
           Result:=true
       end;
    end;


  function TCpuAsmOptimizer.OptPass1MOVZ(var p: tai): boolean;
    var
      hp1: tai;
      ZeroReg: TRegister;
    begin
      Result := False;
      hp1 := nil;
      if (taicpu(p).oppostfix = PF_None) and (taicpu(p).condition = C_None) then
        begin
          if
            { Check next instruction first so hp1 gets set to something, then
              if it remains nil, we know for sure that there's no valid next
              instruction. }
            not GetNextInstruction(p, hp1) or
            { MOVZ and MOVK/MOVN instructions undergo macro-fusion. }
            not MatchInstruction(hp1, [A_MOVK, A_MOVN], [C_None], [PF_None]) or
            (taicpu(hp1).oper[0]^.reg <> taicpu(p).oper[0]^.reg) then
            begin
              if (taicpu(p).oper[1]^.val = 0) then
                begin
                  { Change;
                      movz reg,#0
                      (no movk or movn)
                    To:
                      mov  reg,xzr (or wzr)

                    Easier to perform other optimisations with registers
                  }
                  DebugMsg(SPeepholeOptimization + 'Movz0ToMovZeroReg', p);

                  { Make sure the zero register is the correct size }
                  ZeroReg := taicpu(p).oper[0]^.reg;
                  setsupreg(ZeroReg, RS_XZR);

                  taicpu(p).opcode := A_MOV;
                  taicpu(p).loadreg(1, ZeroReg);
                  Result := True;
                  Exit;
                end;
            end;
          {
             remove the second Movz from

             movz reg,...
             movz reg,...
          }
          if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
            MatchInstruction(hp1,A_MOVZ,[C_None],[PF_none]) and
            MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[0]^) then
            begin
              DebugMsg(SPeepholeOptimization + 'MovzMovz2Movz', p);
              RemoveCurrentP(p);
              Result:=true;
              exit;
            end;
        end;
    end;


  function TCpuAsmOptimizer.OptPass1FMov(var p: tai): Boolean;
    var
      hp1: tai;
      alloc, dealloc: tai_regalloc;
    begin
      {
        change
        fmov reg0,reg1
        fmov reg1,reg0
        into
        fmov reg0,reg1
      }
      Result := False;
      while GetNextInstruction(p, hp1) and
        MatchInstruction(hp1, A_FMOV, [taicpu(p).condition], [taicpu(p).oppostfix]) and
        MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[1]^) and
        MatchOperand(taicpu(p).oper[1]^, taicpu(hp1).oper[0]^) do
        begin
          asml.Remove(hp1);
          hp1.free;
          DebugMsg(SPeepholeOptimization + 'FMovFMov2FMov 1 done', p);
          Result:=true;
        end;

      { change
          fmov reg0,const
          fmov reg1,reg0
          dealloc reg0
          into
          fmov reg1,const
      }
      if MatchOpType(taicpu(p),top_reg,top_realconst) and
        GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        (not RegModifiedBetween(taicpu(p).oper[1]^.reg, p, hp1)) and
        MatchInstruction(hp1,A_FMOV,[taicpu(p).condition],[taicpu(p).oppostfix]) and
        MatchOpType(taicpu(hp1),top_reg,top_reg) and
        MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[1]^.reg) and
        (not RegModifiedByInstruction(taicpu(p).oper[0]^.reg, hp1)) and
        assigned(FindRegDeAlloc(taicpu(p).oper[0]^.reg,tai(hp1.Next)))
        then
        begin
          DebugMsg('Peephole FMovFMov2FMov 2 done', p);

          taicpu(hp1).loadrealconst(1,taicpu(p).oper[1]^.val_real);

          alloc:=FindRegAllocBackward(taicpu(p).oper[0]^.reg,tai(p.Previous));
          dealloc:=FindRegDeAlloc(taicpu(p).oper[0]^.reg,tai(hp1.Next));

          if assigned(alloc) and assigned(dealloc) then
            begin
              asml.Remove(alloc);
              alloc.Free;
              asml.Remove(dealloc);
              dealloc.Free;
            end;

          { p will be removed, update used register as we continue
            with the next instruction after p }

          result:=RemoveCurrentP(p);
        end;

      { not enabled as apparently not happening
      if MatchOpType(taicpu(p),top_reg,top_reg) and
        GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        MatchInstruction(hp1, [A_FSUB,A_FADD,A_FNEG,A_FMUL,A_FSQRT,A_FDIV,A_FABS], [PF_None]) and
        (MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[1]^) or
         ((taicpu(hp1).ops=3) and MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[2]^))
        ) and
        RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
        not(RegUsedBetween(taicpu(p).oper[0]^.reg,p,hp1)) then
        begin
          DebugMsg(SPeepholeOptimization + 'FMovFOp2FOp done', hp1);
          AllocRegBetween(taicpu(hp1).oper[1]^.reg,p,hp1,UsedRegs);
          if MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[1]^) then
            taicpu(hp1).oper[1]^.reg:=taicpu(p).oper[1]^.reg;
          if (taicpu(hp1).ops=3) and MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[2]^) then
            taicpu(hp1).oper[2]^.reg:=taicpu(p).oper[1]^.reg;
          RemoveCurrentP(p);
          Result:=true;
          exit;
        end;
      }
    end;


  function TCpuAsmOptimizer.OptPass1SXTW(var p : tai) : Boolean;
    var
      hp1: tai;
      GetNextInstructionUsingReg_hp1: Boolean;
    begin
      Result:=false;
      if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) then
        begin
          {
            change
            sxtw reg2,reg1
            str reg2,[...]
            dealloc reg2
            to
            str reg1,[...]
          }
          if MatchInstruction(p, taicpu(p).opcode, [C_None], [PF_None]) and
            (taicpu(p).ops=2) and
            MatchInstruction(hp1, A_STR, [C_None], [PF_None]) and
            (getsubreg(taicpu(hp1).oper[0]^.reg)=R_SUBD) and
            RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
            { the reference in strb might not use reg2 }
            not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
            { reg1 might not be modified inbetween }
            not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              DebugMsg('Peephole SXTHStr2Str done', p);
              taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
              result:=RemoveCurrentP(p);
            end
          {
            change
            sxtw reg2,reg1
            sxtw reg3,reg2
            dealloc reg2
            to
            sxtw reg3,reg1
          }
          else if MatchInstruction(p, A_SXTW, [C_None], [PF_None]) and
            (taicpu(p).ops=2) and
            MatchInstruction(hp1, A_SXTW, [C_None], [PF_None]) and
            (taicpu(hp1).ops=2) and
            MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
            RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
            { reg1 might not be modified inbetween }
            not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              DebugMsg('Peephole SxtwSxtw2Sxtw done', p);
              AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
              taicpu(hp1).opcode:=A_SXTW;
              taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
              result:=RemoveCurrentP(p);
            end
          else if USxtOp2Op(p,hp1,SM_SXTW) then
            Result:=true
          else if RemoveSuperfluousMove(p, hp1, 'SxtwMov2Data') then
            Result:=true;
        end;
    end;


  function TCpuAsmOptimizer.OptPass2LDRSTR(var p: tai): boolean;
    var
      hp1, hp1_last: tai;
      ThisRegister: TRegister;
      OffsetVal, ValidOffset, MinOffset, MaxOffset: asizeint;
      TargetOpcode: TAsmOp;
    begin
      Result := False;
      ThisRegister := taicpu(p).oper[0]^.reg;

      case taicpu(p).opcode of
        A_LDR:
          TargetOpcode := A_LDP;
        A_STR:
          TargetOpcode := A_STP;
        else
          InternalError(2020081501);
      end;

      { reg appearing in ref invalidates these optimisations }
      if (TargetOpcode = A_STP) or not RegInRef(ThisRegister, taicpu(p).oper[1]^.ref^) then
        begin
          { LDP/STP has a smaller permitted offset range than LDR/STR.

            TODO: For a group of out-of-range LDR/STR instructions, can
            we declare a temporary register equal to the offset base
            address, modify the STR instructions to use that register
            and then convert them to STP instructions?  Note that STR
            generally takes 2 cycles (on top of the memory latency),
            while LDP/STP takes 3.
          }

          if (getsubreg(ThisRegister) = R_SUBQ) then
            begin
              ValidOffset := 8;
              MinOffset := -512;
              MaxOffset := 504;
            end
          else
            begin
              ValidOffset := 4;
              MinOffset := -256;
              MaxOffset := 252;
            end;

          hp1_last := p;

          { Look for nearby LDR/STR instructions }
          if (taicpu(p).oppostfix = PF_NONE) and
            (taicpu(p).oper[1]^.ref^.addressmode = AM_OFFSET) then
            { If SkipGetNext is True, GextNextInstruction isn't called }
            while GetNextInstruction(hp1_last, hp1) do
              begin
                if (hp1.typ <> ait_instruction) then
                  Break;

                if (taicpu(hp1).opcode = taicpu(p).opcode) then
                  begin
                    if (taicpu(hp1).oppostfix = PF_NONE) and
                      { Registers need to be the same size }
                      (getsubreg(ThisRegister) = getsubreg(taicpu(hp1).oper[0]^.reg)) and
                      (
                        (TargetOpcode = A_STP) or
                        { LDP x0, x0, [sp, #imm] is undefined behaviour, even
                          though such an LDR pair should have been optimised
                          out by now. STP is okay }
                        (ThisRegister <> taicpu(hp1).oper[0]^.reg)
                      ) and
                      (taicpu(hp1).oper[1]^.ref^.addressmode = AM_OFFSET) and
                      (taicpu(p).oper[1]^.ref^.base = taicpu(hp1).oper[1]^.ref^.base) and
                      (taicpu(p).oper[1]^.ref^.index = taicpu(hp1).oper[1]^.ref^.index) and
                      { Make sure the address registers haven't changed }
                      not RegModifiedBetween(taicpu(hp1).oper[1]^.ref^.base, p, hp1) and
                      (
                        (taicpu(hp1).oper[1]^.ref^.index = NR_NO) or
                        not RegModifiedBetween(taicpu(hp1).oper[1]^.ref^.index, p, hp1)
                      ) and
                      { Don't need to check "RegInRef" because the base registers are identical,
                        and the first one was checked already. [Kit] }
                      (((TargetOpcode=A_LDP) and not RegUsedBetween(taicpu(hp1).oper[0]^.reg, p, hp1)) or
                       ((TargetOpcode=A_STP) and not RegModifiedBetween(taicpu(hp1).oper[0]^.reg, p, hp1))) then
                      begin
                        { Can we convert these two LDR/STR instructions into a
                          single LDR/STP? }

                        OffsetVal := taicpu(hp1).oper[1]^.ref^.offset - taicpu(p).oper[1]^.ref^.offset;
                        if (OffsetVal = ValidOffset) then
                          begin
                            if  (taicpu(p).oper[1]^.ref^.offset >= MinOffset) and (taicpu(hp1).oper[1]^.ref^.offset <= MaxOffset) then
                              begin
                                { Convert:
                                    LDR/STR reg0, [reg2, #ofs]
                                    ...
                                    LDR/STR reg1. [reg2, #ofs + 8] // 4 if registers are 32-bit
                                  To:
                                    LDP/STP reg0, reg1, [reg2, #ofs]
                                }
                                taicpu(p).opcode := TargetOpcode;
                                if TargetOpcode = A_STP then
                                  DebugMsg(SPeepholeOptimization + 'StrStr2Stp', p)
                                else
                                  DebugMsg(SPeepholeOptimization + 'LdrLdr2Ldp', p);
                                taicpu(p).ops := 3;
                                taicpu(p).loadref(2, taicpu(p).oper[1]^.ref^);
                                taicpu(p).loadreg(1, taicpu(hp1).oper[0]^.reg);

                                asml.Remove(hp1);
                                hp1.Free;
                                Result := True;
                                Exit;
                              end;
                          end
                        else if (OffsetVal = -ValidOffset) then
                          begin
                            if (taicpu(hp1).oper[1]^.ref^.offset >= MinOffset) and (taicpu(p).oper[1]^.ref^.offset <= MaxOffset) then
                              begin
                                { Convert:
                                    LDR/STR reg0, [reg2, #ofs + 8] // 4 if registers are 32-bit
                                    ...
                                    LDR/STR reg1. [reg2, #ofs]
                                  To:
                                    LDP/STP reg1, reg0, [reg2, #ofs]
                                }
                                taicpu(p).opcode := TargetOpcode;
                                if TargetOpcode = A_STP then
                                  DebugMsg(SPeepholeOptimization + 'StrStr2Stp (reverse)', p)
                                else
                                  DebugMsg(SPeepholeOptimization + 'LdrLdr2Ldp (reverse)', p);
                                taicpu(p).ops := 3;
                                taicpu(p).loadref(2, taicpu(hp1).oper[1]^.ref^);
                                taicpu(p).loadreg(1, taicpu(p).oper[0]^.reg);
                                taicpu(p).loadreg(0, taicpu(hp1).oper[0]^.reg);

                                asml.Remove(hp1);
                                hp1.Free;
                                Result := True;
                                Exit;
                              end;
                          end;
                      end;
                  end
                else
                  Break;

                { Don't continue looking for LDR/STR pairs if the address register
                  gets modified }
                if RegModifiedByInstruction(taicpu(p).oper[1]^.ref^.base, hp1) then
                  Break;

                hp1_last := hp1;
              end;
        end;
    end;


  function TCpuAsmOptimizer.OptPostAnd(var p: tai): Boolean;
    var
      hp1, hp2: tai;
      hp3: taicpu;
      bitval : cardinal;
    begin
      Result:=false;
      {
        and reg1,reg0,<const=power of 2>
        cmp reg1,#0
        <reg1 end of life>
        b.e/b.ne label

        into

        tb(n)z reg0,<power of 2>,label
      }
      if MatchOpType(taicpu(p),top_reg,top_reg,top_const) and
        (PopCnt(QWord(taicpu(p).oper[2]^.val))=1) and
        GetNextInstruction(p,hp1) and
        MatchInstruction(hp1,A_CMP,[PF_None]) and
        MatchOpType(taicpu(hp1),top_reg,top_const) and
        (taicpu(hp1).oper[1]^.val=0) and
        MatchOperand(taicpu(p).oper[0]^,taicpu(hp1).oper[0]^) and
        RegEndOfLife(taicpu(p).oper[0]^.reg, taicpu(hp1)) and
        GetNextInstruction(hp1,hp2) and
        MatchInstruction(hp2,A_B,[PF_None]) and
        (taicpu(hp2).condition in [C_EQ,C_NE]) then
        begin
           bitval:=BsfQWord(qword(taicpu(p).oper[2]^.val));
           case taicpu(hp2).condition of
            C_NE:
              hp3:=taicpu.op_reg_const_ref(A_TBNZ,taicpu(p).oper[1]^.reg,bitval,taicpu(hp2).oper[0]^.ref^);
            C_EQ:
              hp3:=taicpu.op_reg_const_ref(A_TBZ,taicpu(p).oper[1]^.reg,bitval,taicpu(hp2).oper[0]^.ref^);
            else
              Internalerror(2021100201);
          end;
          taicpu(hp3).fileinfo:=taicpu(hp1).fileinfo;
          asml.insertbefore(hp3, hp1);

          RemoveInstruction(hp1);
          RemoveInstruction(hp2);
          RemoveCurrentP(p);
          DebugMsg(SPeepholeOptimization + 'AndCmpB.E/NE2Tbnz/Tbz done', p);
          Result:=true;
        end;
    end;


  function TCpuAsmOptimizer.OptPostCMP(var p : tai): boolean;
    var
     hp1,hp2: tai;
    begin
      Result:=false;
      {
         cmp reg0,#0
         b.e/b.ne label

         into

         cb(n)z reg0,label
      }
      if MatchOpType(taicpu(p),top_reg,top_const) and
        (taicpu(p).oper[0]^.reg<>NR_SP) and
        (taicpu(p).oper[1]^.val=0) and
        GetNextInstruction(p,hp1) and
        MatchInstruction(hp1,A_B,[PF_None]) and
        (taicpu(hp1).condition in [C_EQ,C_NE]) then
        begin
          case taicpu(hp1).condition of
            C_NE:
              hp2:=taicpu.op_reg_sym_ofs(A_CBNZ,taicpu(p).oper[0]^.reg,taicpu(hp1).oper[0]^.ref^.symbol,taicpu(hp1).oper[0]^.ref^.offset);
            C_EQ:
              hp2:=taicpu.op_reg_sym_ofs(A_CBZ,taicpu(p).oper[0]^.reg,taicpu(hp1).oper[0]^.ref^.symbol,taicpu(hp1).oper[0]^.ref^.offset);
            else
              Internalerror(2019090801);
          end;
          taicpu(hp2).fileinfo:=taicpu(hp1).fileinfo;
          asml.insertbefore(hp2, hp1);

          asml.remove(p);
          asml.remove(hp1);
          p.free;
          hp1.free;
          p:=hp2;
          DebugMsg(SPeepholeOptimization + 'CMPB.E/NE2CBNZ/CBZ done', p);
          Result:=true;
        end;
    end;


  function TCpuAsmOptimizer.PrePeepHoleOptsCpu(var p: tai): boolean;
    begin
      result := false;
      if p.typ=ait_instruction then
        begin
          case taicpu(p).opcode of
            A_SBFX,
            A_UBFX:
              Result:=OptPreSBFXUBFX(p);
            else
              ;
          end;
        end;
    end;


  function TCpuAsmOptimizer.PeepHoleOptPass1Cpu(var p: tai): boolean;
    begin
      result := false;
      if p.typ=ait_instruction then
        begin
          case taicpu(p).opcode of
            A_LDR:
              Result:=OptPass1LDR(p);
            A_STR:
              Result:=OptPass1STR(p);
            A_MOV:
              Result:=OptPass1Mov(p);
            A_MOVZ:
              Result:=OptPass1MOVZ(p);
            A_STP:
              Result:=OptPass1STP(p);
            A_LSR,
            A_ROR,
            A_ASR,
            A_LSL:
              Result:=OptPass1Shift(p);
            A_AND:
              Result:=OptPass1And(p);
            A_NEG,
            A_CSEL,
            A_ADD,
            A_ADC,
            A_SUB,
            A_SBC,
            A_BIC,
            A_EOR,
            A_ORR,
            A_MUL:
              Result:=OptPass1Data(p);
            A_UXTB:
              Result:=OptPass1UXTB(p);
            A_UXTH:
              Result:=OptPass1UXTH(p);
            A_SXTB:
              Result:=OptPass1SXTB(p);
            A_SXTH:
              Result:=OptPass1SXTH(p);
            A_SXTW:
              Result:=OptPass1SXTW(p);
//            A_VLDR,
            A_FMADD,
            A_FMSUB,
            A_FNMADD,
            A_FNMSUB,
            A_FNMUL,
            A_FADD,
            A_FMUL,
            A_FDIV,
            A_FSUB,
            A_FSQRT,
            A_FNEG,
            A_FCVT,
            A_FABS:
              Result:=OptPass1FData(p);
            A_FMOV:
              Result:=OptPass1FMov(p);
            else
              ;
          end;
        end;
    end;


  function TCpuAsmOptimizer.PeepHoleOptPass2Cpu(var p: tai): boolean;
    begin
      result := false;
      if p.typ=ait_instruction then
        begin
          case taicpu(p).opcode of
            A_LDR,
            A_STR:
              Result:=OptPass2LDRSTR(p);
            else
              ;
          end;
        end;
    end;


  function TCpuAsmOptimizer.PostPeepHoleOptsCpu(var p: tai): boolean;
    begin
      result := false;
      if p.typ=ait_instruction then
        begin
          case taicpu(p).opcode of
            A_CMP:
              Result:=OptPostCMP(p);
            A_AND:
              Result:=OptPostAnd(p);
            else
              ;
          end;
        end;
    end;

begin
  casmoptimizer:=TCpuAsmOptimizer;
End.

