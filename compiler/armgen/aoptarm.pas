{
    Copyright (c) 1998-2020 by Jonas Maebe and Florian Klaempfl, members of the Free Pascal
    Development Team

    This unit implements an ARM optimizer object used commonly for ARM and AAarch64

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

Unit aoptarm;

{$i fpcdefs.inc}

{ $define DEBUG_PREREGSCHEDULER}
{$ifdef EXTDEBUG}
{$define DEBUG_AOPTCPU}
{$endif EXTDEBUG}

Interface

uses
  cgbase, cgutils, globtype, cpubase, aasmtai, aasmcpu,aopt, aoptobj;

Type
  { while ARM and AAarch64 look not very similar at a first glance,
    several optimizations can be shared between both }
  TARMAsmOptimizer = class(TAsmOptimizer)
    procedure DebugMsg(const s : string; p : tai);

    function RemoveSuperfluousMove(const p: tai; movp: tai; const optimizer: string): boolean;
    function RedundantMovProcess(var p: tai; var hp1: tai): boolean;
    function GetNextInstructionUsingReg(Current: tai; out Next: tai; const reg: TRegister): Boolean;
{$ifdef AARCH64}
    function USxtOp2Op(var p, hp1: tai; shiftmode: tshiftmode): Boolean;
{$endif AARCH64}
    function OptPreSBFXUBFX(var p: tai): Boolean;

    function OptPass1UXTB(var p: tai): Boolean;
    function OptPass1UXTH(var p: tai): Boolean;
    function OptPass1SXTB(var p: tai): Boolean;
    function OptPass1SXTH(var p: tai): Boolean;

    function OptPass1LDR(var p: tai): Boolean; virtual;
    function OptPass1STR(var p: tai): Boolean; virtual;
    function OptPass1And(var p: tai): Boolean; virtual;

    function OptPass2Bitwise(var p: tai): Boolean;
    function OptPass2TST(var p: tai): Boolean;

    { Common code that tries to merge constant writes to sequential memory }
    function TryConstMerge(var p: tai; hp1: tai): Boolean;

  protected
    function DoXTArithOp(var p: tai; hp1: tai): Boolean;
  End;

  function MatchInstruction(const instr: tai; const op: TCommonAsmOps; const cond: TAsmConds; const postfix: TOpPostfixes): boolean;
  function MatchInstruction(const instr: tai; const op: TAsmOp; const cond: TAsmConds; const postfix: TOpPostfixes): boolean;
{$ifdef AARCH64}
  function MatchInstruction(const instr: tai; const ops : array of TAsmOp; const postfix: TOpPostfixes): boolean;
{$endif AARCH64}
  function MatchInstruction(const instr: tai; const op: TAsmOp; const postfix: TOpPostfixes): boolean;

  function RefsEqual(const r1, r2: treference): boolean;

  function MatchOperand(const oper: TOper; const reg: TRegister): boolean; inline;
  function MatchOperand(const oper1: TOper; const oper2: TOper): boolean; inline;
  function MatchOperand(const oper: TOper; const a: TCGInt): boolean; inline;

Implementation

  uses
    cutils,verbose,globals,aoptutils,
    systems,
    cpuinfo,
    cgobj,procinfo,
    aasmbase,aasmdata,itcpugas;


{$ifdef DEBUG_AOPTCPU}
  const
    SPeepholeOptimization: shortstring = 'Peephole Optimization: ';

  procedure TARMAsmOptimizer.DebugMsg(const s: string;p : tai);
    begin
      asml.insertbefore(tai_comment.Create(strpnew(s)), p);
    end;
{$else DEBUG_AOPTCPU}
  { Empty strings help the optimizer to remove string concatenations that won't
    ever appear to the user on release builds. [Kit] }
  const
    SPeepholeOptimization = '';

  procedure TARMAsmOptimizer.DebugMsg(const s: string;p : tai);inline;
    begin
    end;
{$endif DEBUG_AOPTCPU}

  function MatchInstruction(const instr: tai; const op: TCommonAsmOps; const cond: TAsmConds; const postfix: TOpPostfixes): boolean;
    begin
      result :=
        (instr.typ = ait_instruction) and
        ((op = []) or ((taicpu(instr).opcode<=LastCommonAsmOp) and (taicpu(instr).opcode in op))) and
        ((cond = []) or (taicpu(instr).condition in cond)) and
        ((postfix = []) or (taicpu(instr).oppostfix in postfix));
    end;


  function MatchInstruction(const instr: tai; const op: TAsmOp; const cond: TAsmConds; const postfix: TOpPostfixes): boolean;
    begin
      result :=
        (instr.typ = ait_instruction) and
        (taicpu(instr).opcode = op) and
        ((cond = []) or (taicpu(instr).condition in cond)) and
        ((postfix = []) or (taicpu(instr).oppostfix in postfix));
    end;


{$ifdef AARCH64}
  function MatchInstruction(const instr: tai; const ops : array of TAsmOp; const postfix: TOpPostfixes): boolean;
  var
    op : TAsmOp;
  begin
    result:=false;
    if instr.typ <> ait_instruction then
      exit;
    for op in ops do
      begin
        if (taicpu(instr).opcode = op) and
           ((postfix = []) or (taicpu(instr).oppostfix in postfix)) then
          begin
            result:=true;
            exit;
          end;
      end;
    end;
{$endif AARCH64}

  function MatchInstruction(const instr: tai; const op: TAsmOp; const postfix: TOpPostfixes): boolean;
    begin
      result :=
        (instr.typ = ait_instruction) and
        (taicpu(instr).opcode = op) and
        ((postfix = []) or (taicpu(instr).oppostfix in postfix));
    end;


  function MatchOperand(const oper: TOper; const reg: TRegister): boolean; inline;
    begin
      result := (oper.typ = top_reg) and (oper.reg = reg);
    end;


  function RefsEqual(const r1, r2: treference): boolean;
    begin
      refsequal :=
        (r1.offset = r2.offset) and
        (r1.base = r2.base) and
        (r1.index = r2.index) and (r1.scalefactor = r2.scalefactor) and
        (r1.symbol=r2.symbol) and (r1.refaddr = r2.refaddr) and
        (r1.relsymbol = r2.relsymbol) and
{$ifdef ARM}
        (r1.signindex = r2.signindex) and
{$endif ARM}
        (r1.shiftimm = r2.shiftimm) and
        (r1.addressmode = r2.addressmode) and
        (r1.shiftmode = r2.shiftmode) and
        (r1.volatility=[]) and
        (r2.volatility=[]);
    end;


  function MatchOperand(const oper1: TOper; const oper2: TOper): boolean; inline;
    begin
      result := oper1.typ = oper2.typ;

      if result then
        case oper1.typ of
          top_const:
            Result:=oper1.val = oper2.val;
          top_reg:
            Result:=oper1.reg = oper2.reg;
          top_conditioncode:
            Result:=oper1.cc = oper2.cc;
          top_realconst:
            Result:=oper1.val_real = oper2.val_real;
          top_ref:
            Result:=RefsEqual(oper1.ref^, oper2.ref^);
          else Result:=false;
        end
    end;


  function MatchOperand(const oper: TOper; const a: TCGInt): boolean; inline;
    begin
      result := (oper.typ = top_const) and (oper.val = a);
    end;

{$ifdef AARCH64}
  function TARMAsmOptimizer.USxtOp2Op(var p,hp1: tai; shiftmode: tshiftmode): Boolean;
    var
      so: tshifterop;
      opoffset: Integer;
    begin
      Result:=false;
      if ((MatchInstruction(hp1, [A_ADD,A_SUB], [C_None], [PF_None,PF_S]) and
        (taicpu(hp1).ops=3) and
         MatchOperand(taicpu(hp1).oper[2]^, taicpu(p).oper[0]^.reg) and
         not(MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg))) or
         (MatchInstruction(hp1, [A_CMP,A_CMN], [C_None], [PF_None]) and
         (taicpu(hp1).ops=2) and
         MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg))
        ) and
        RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
        { reg1 might not be modified inbetween }
        not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
        begin
          DebugMsg('Peephole '+gas_op2str[taicpu(p).opcode]+gas_op2str[taicpu(hp1).opcode]+'2'+gas_op2str[taicpu(hp1).opcode]+' done', p);
          AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
          if MatchInstruction(hp1, [A_CMP,A_CMN], [C_None], [PF_None]) then
            opoffset:=0
          else
            opoffset:=1;
          taicpu(hp1).loadReg(opoffset+1,taicpu(p).oper[1]^.reg);
          if not(shiftmode in [SM_SXTX,SM_UXTX,SM_LSL]) then
            setsubreg(taicpu(hp1).oper[opoffset+1]^.reg,R_SUBD);
          taicpu(hp1).ops:=opoffset+3;
          shifterop_reset(so);
          so.shiftmode:=shiftmode;
          so.shiftimm:=0;
          taicpu(hp1).loadshifterop(opoffset+2,so);
          result:=RemoveCurrentP(p);
        end;
    end;
{$endif AARCH64}


  function TARMAsmOptimizer.GetNextInstructionUsingReg(Current: tai;
    Out Next: tai; const reg: TRegister): Boolean;
    var
      gniResult: Boolean;
    begin
      Next:=Current;
      Result := False;
      repeat

        gniResult:=GetNextInstruction(Next,Next);
        if gniResult and RegInInstruction(reg,Next) then
          { Found something }
          Exit(True);

      until not gniResult or
        not(cs_opt_level3 in current_settings.optimizerswitches) or
        (Next.typ<>ait_instruction) or
        is_calljmp(taicpu(Next).opcode)
{$ifdef ARM}
        or RegModifiedByInstruction(NR_PC,Next)
{$endif ARM}
        ;
    end;


  function TARMAsmOptimizer.RemoveSuperfluousMove(const p: tai; movp: tai; const optimizer: string):boolean;
    var
      alloc,
      dealloc : tai_regalloc;
      hp1 : tai;
    begin
      Result:=false;
      if MatchInstruction(movp, A_MOV, [taicpu(p).condition], [PF_None]) and
        { We can't optimize if there is a shiftop }
        (taicpu(movp).ops=2) and
        MatchOperand(taicpu(movp).oper[1]^, taicpu(p).oper[0]^.reg) and
        { don't mess with moves to fp }
        (taicpu(movp).oper[0]^.reg<>current_procinfo.framepointer) and
        { the destination register of the mov might not be used beween p and movp }
        not(RegUsedBetween(taicpu(movp).oper[0]^.reg,p,movp)) and
{$ifdef ARM}
        { PC should be changed only by moves }
        (taicpu(movp).oper[0]^.reg<>NR_PC) and
        { cb[n]z are thumb instructions which require specific registers, with no wide forms }
        (taicpu(p).opcode<>A_CBZ) and
        (taicpu(p).opcode<>A_CBNZ) and
        { There is a special requirement for MUL and MLA, oper[0] and oper[1] are not allowed to be the same }
        not (
          (taicpu(p).opcode in [A_MLA, A_MUL]) and
          (taicpu(p).oper[1]^.reg = taicpu(movp).oper[0]^.reg) and
          (current_settings.cputype < cpu_armv6)
        ) and
{$endif ARM}
        { Take care to only do this for instructions which REALLY load to the first register.
          Otherwise
            str reg0, [reg1]
            mov reg2, reg0
          will be optimized to
            str reg2, [reg1]
        }
        RegLoadedWithNewValue(taicpu(p).oper[0]^.reg, p) then
        begin
          dealloc:=FindRegDeAlloc(taicpu(p).oper[0]^.reg,tai(movp.Next));
          if assigned(dealloc) then
            begin
              DebugMsg('Peephole '+optimizer+' removed superfluous mov', movp);
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

              AllocRegBetween(taicpu(movp).oper[0]^.reg,p,movp,UsedRegs);

              { finally get rid of the mov }
              taicpu(p).loadreg(0,taicpu(movp).oper[0]^.reg);
              { Remove preindexing and postindexing for LDR in some cases.
                For example:
                  ldr	reg2,[reg1, xxx]!
                  mov reg1,reg2
                must be translated to:
                  ldr	reg1,[reg1, xxx]

                Preindexing must be removed there, since the same register is used as the base and as the target.
                Such case is not allowed for ARM CPU and produces crash. }
              if (taicpu(p).opcode = A_LDR) and (taicpu(p).oper[1]^.typ = top_ref)
                and (taicpu(movp).oper[0]^.reg = taicpu(p).oper[1]^.ref^.base)
              then
                taicpu(p).oper[1]^.ref^.addressmode:=AM_OFFSET;
              asml.remove(movp);
              movp.free;
            end;
        end;
    end;


  function TARMAsmOptimizer.RedundantMovProcess(var p: tai; var hp1: tai):boolean;
    var
      I: Integer;
      current_hp, next_hp: tai;
      LDRChange: Boolean;
    begin
      Result:=false;
      {
        change
        mov r1, r0
        add r1, r1, #1
        to
        add r1, r0, #1

        Todo: Make it work for mov+cmp too

        CAUTION! If this one is successful p might not be a mov instruction anymore!
      }
      if (taicpu(p).ops = 2) and
         (taicpu(p).oper[1]^.typ = top_reg) and
         (taicpu(p).oppostfix = PF_NONE) then
        begin

          if
            MatchInstruction(hp1, [A_ADD, A_ADC,
{$ifdef ARM}
                                   A_RSB, A_RSC,
{$endif ARM}
                                   A_SUB, A_SBC,
                                   A_AND, A_BIC, A_EOR, A_ORR, A_MOV, A_MVN],
                             [taicpu(p).condition], []) and
            { MOV and MVN might only have 2 ops }
            (taicpu(hp1).ops >= 2) and
            MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[0]^.reg) and
            (taicpu(hp1).oper[1]^.typ = top_reg) and
            (
              (taicpu(hp1).ops = 2) or
              (taicpu(hp1).oper[2]^.typ in [top_reg, top_const, top_shifterop])
            ) and
{$ifdef AARCH64}
            (taicpu(p).oper[1]^.reg<>NR_SP) and
            { in this case you have to transform it to movk or the like }
            (getsupreg(taicpu(p).oper[1]^.reg)<>RS_XZR) and
{$endif AARCH64}
            not(RegUsedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              { When we get here we still don't know if the registers match }
              for I:=1 to 2 do
                {
                  If the first loop was successful p will be replaced with hp1.
                  The checks will still be ok, because all required information
                  will also be in hp1 then.
                }
                if (taicpu(hp1).ops > I) and
                   MatchOperand(taicpu(p).oper[0]^, taicpu(hp1).oper[I]^.reg)
{$ifdef ARM}
                   { prevent certain combinations on thumb(2), this is only a safe approximation }
                   and (not(GenerateThumbCode or GenerateThumb2Code) or
                    ((getsupreg(taicpu(p).oper[1]^.reg)<>RS_R13) and
                     (getsupreg(taicpu(p).oper[1]^.reg)<>RS_R15)))
{$endif ARM}

                then
                  begin
                    DebugMsg('Peephole RedundantMovProcess done', hp1);
                    taicpu(hp1).oper[I]^.reg := taicpu(p).oper[1]^.reg;
                    if p<>hp1 then
                      begin
                        asml.remove(p);
                        p.free;
                        p:=hp1;
                        Result:=true;
                      end;
                  end;

              if Result then Exit;
            end
          { Change:                   Change:
              mov     r1, r0            mov     r1, r0
              ...                       ...
              ldr/str r2, [r1, etc.]    mov     r2, r1
            To:                       To:
              ldr/str r2, [r0, etc.]    mov     r2, r0
          }
          else if (taicpu(p).condition = C_None) and (taicpu(p).oper[1]^.typ = top_reg)
{$ifdef ARM}
            and not (getsupreg(taicpu(p).oper[0]^.reg) in [RS_PC, RS_R14, RS_STACK_POINTER_REG])
            and (getsupreg(taicpu(p).oper[1]^.reg) <> RS_PC)
            { Thumb does not support references with base and index one being SP }
            and (not(GenerateThumbCode) or (getsupreg(taicpu(p).oper[1]^.reg) <> RS_STACK_POINTER_REG))
{$endif ARM}
{$ifdef AARCH64}
            and (getsupreg(taicpu(p).oper[0]^.reg) <> RS_STACK_POINTER_REG)
{$endif AARCH64}
            then
            begin
              current_hp := p;
              TransferUsedRegs(TmpUsedRegs);

              { Search local instruction block }
              while GetNextInstruction(current_hp, next_hp) and (next_hp <> BlockEnd) and (next_hp.typ = ait_instruction) do
                begin
                  UpdateUsedRegs(TmpUsedRegs, tai(current_hp.Next));
                  LDRChange := False;

                  if (taicpu(next_hp).opcode in [A_LDR,A_STR]) and (taicpu(next_hp).ops = 2)
{$ifdef AARCH64}
                    { If r0 is the zero register, then this sequence of instructions will cause
                      an access violation, but that's better than an assembler error caused by
                      changing r0 to xzr inside the reference (Where it's illegal). [Kit] }
                    and (getsupreg(taicpu(p).oper[1]^.reg) <> RS_XZR)
{$endif AARCH64}
                    then
                    begin

                      { Change the registers from r1 to r0 }
                      if (taicpu(next_hp).oper[1]^.ref^.base = taicpu(p).oper[0]^.reg) and
{$ifdef ARM}
                        { This optimisation conflicts with something and raises
                          an access violation - needs further investigation. [Kit] }
                        (taicpu(next_hp).opcode <> A_LDR) and
{$endif ARM}
                        { Don't mess around with the base register if the
                          reference is pre- or post-indexed }
                        (taicpu(next_hp).oper[1]^.ref^.addressmode = AM_OFFSET) then
                        begin
                          taicpu(next_hp).oper[1]^.ref^.base := taicpu(p).oper[1]^.reg;
                          LDRChange := True;
                        end;

                      if taicpu(next_hp).oper[1]^.ref^.index = taicpu(p).oper[0]^.reg then
                        begin
                          taicpu(next_hp).oper[1]^.ref^.index := taicpu(p).oper[1]^.reg;
                          LDRChange := True;
                        end;

                      if LDRChange then
                        DebugMsg('Peephole Optimization: ' + std_regname(taicpu(p).oper[0]^.reg) + ' = ' + std_regname(taicpu(p).oper[1]^.reg) + ' (MovLdr2Ldr 1)', next_hp);

                      { Drop out if we're dealing with pre-indexed references }
                      if (taicpu(next_hp).oper[1]^.ref^.addressmode = AM_PREINDEXED) and
                        (
                          RegInRef(taicpu(p).oper[0]^.reg, taicpu(next_hp).oper[1]^.ref^) or
                          RegInRef(taicpu(p).oper[1]^.reg, taicpu(next_hp).oper[1]^.ref^)
                        ) then
                        begin
                          { Remember to update register allocations }
                          if LDRChange then
                            AllocRegBetween(taicpu(p).oper[1]^.reg, p, next_hp, UsedRegs);

                          Break;
                        end;

                      { The register being stored can be potentially changed (as long as it's not the stack pointer) }
                      if (taicpu(next_hp).opcode = A_STR) and (getsupreg(taicpu(p).oper[1]^.reg) <> RS_STACK_POINTER_REG) and
                        MatchOperand(taicpu(next_hp).oper[0]^, taicpu(p).oper[0]^.reg) then
                        begin
                          DebugMsg('Peephole Optimization: ' + std_regname(taicpu(p).oper[0]^.reg) + ' = ' + std_regname(taicpu(p).oper[1]^.reg) + ' (MovLdr2Ldr 2)', next_hp);
                          taicpu(next_hp).oper[0]^.reg := taicpu(p).oper[1]^.reg;
                          LDRChange := True;
                        end;

                      if LDRChange and (getsupreg(taicpu(p).oper[1]^.reg) <> RS_STACK_POINTER_REG) then
                        begin
                          AllocRegBetween(taicpu(p).oper[1]^.reg, p, next_hp, UsedRegs);
                          if (taicpu(p).oppostfix = PF_None) and
                            (
                              (
                                (taicpu(next_hp).opcode = A_LDR) and
                                MatchOperand(taicpu(next_hp).oper[0]^, taicpu(p).oper[0]^.reg)
                              ) or
                              not RegUsedAfterInstruction(taicpu(p).oper[0]^.reg, next_hp, TmpUsedRegs)
                            ) and
                            { Double-check to see if the old registers were actually
                              changed (e.g. if the super registers matched, but not
                              the sizes, they won't be changed). }
                            (
                              (taicpu(next_hp).opcode = A_LDR) or
                              not RegInOp(taicpu(p).oper[0]^.reg, taicpu(next_hp).oper[0]^)
                            ) and
                            not RegInRef(taicpu(p).oper[0]^.reg, taicpu(next_hp).oper[1]^.ref^) then
                            begin
                              DebugMsg('Peephole Optimization: RedundantMovProcess 2a done', p);
                              RemoveCurrentP(p);
                              Result := True;
                              Exit;
                            end;
                        end;
                    end
                  else if (taicpu(next_hp).opcode = A_MOV) and (taicpu(next_hp).oppostfix = PF_None) and
                    (taicpu(next_hp).ops = 2) then
                    begin
                      if MatchOperand(taicpu(next_hp).oper[0]^, taicpu(p).oper[0]^.reg) then
                        begin
                          { mov r0,r1; mov r1,r1 - remove second MOV here so
                            so "RedundantMovProcess 2b" doesn't get erroneously
                            applied }
                          if MatchOperand(taicpu(next_hp).oper[0]^, taicpu(next_hp).oper[1]^.reg) then
                            begin
                              DebugMsg(SPeepholeOptimization + 'Mov2None 2a done', next_hp);

                              if (next_hp = hp1) then
                                { Don't let hp1 become a dangling pointer }
                                hp1 := nil;

                              asml.Remove(next_hp);
                              next_hp.Free;
                              Continue;
                            end;

                          { Found another mov that writes entirely to the register }
                          if RegUsedBetween(taicpu(p).oper[0]^.reg, p, next_hp) then
                            begin
                              { Register was used beforehand }
                              if MatchOperand(taicpu(next_hp).oper[1]^, taicpu(p).oper[1]^.reg) then
                                begin
                                  { This MOV is exactly the same as the first one.
                                    Since none of the registers have changed value
                                    at this point, we can remove it. }
                                  DebugMsg(SPeepholeOptimization + 'RedundantMovProcess 3a done', next_hp);

                                  if (next_hp = hp1) then
                                    { Don't let hp1 become a dangling pointer }
                                    hp1 := nil;

                                  asml.Remove(next_hp);
                                  next_hp.Free;

                                  { We still have the original p, so we can continue optimising;
                                   if it was -O2 or below, this instruction appeared immediately
                                   after the first MOV, so we're technically not looking more
                                   than one instruction ahead after it's removed! [Kit] }
                                  Continue;
                                end
                              else
                                { Register changes value - drop out }
                                Break;
                            end;

                          { We can delete the first MOV (only if the second MOV is unconditional) }
{$ifdef ARM}
                          if (taicpu(p).oppostfix = PF_None) and
                            (taicpu(next_hp).condition = C_None) then
{$endif ARM}
                            begin
                              DebugMsg('Peephole Optimization: RedundantMovProcess 2b done', p);
                              RemoveCurrentP(p);
                              Result := True;
                            end;
                          Exit;
                        end
                      else if MatchOperand(taicpu(next_hp).oper[1]^, taicpu(p).oper[0]^.reg) then
                        begin
                          if MatchOperand(taicpu(next_hp).oper[0]^, taicpu(p).oper[1]^.reg)
                            { Be careful - if the entire register is not used, removing this
                              instruction will leave the unused part uninitialised }
{$ifdef AARCH64}
                            and (getsubreg(taicpu(p).oper[1]^.reg) = R_SUBQ)
{$endif AARCH64}
                            then
                            begin
                              { Instruction will become mov r1,r1 }
                              DebugMsg(SPeepholeOptimization + 'Mov2None 2 done', next_hp);

                              { Allocate r1 between the instructions; not doing
                                so may cause problems when removing superfluous
                                MOVs later (i38055) }
                              AllocRegBetween(taicpu(p).oper[1]^.reg, p, next_hp, UsedRegs);

                              if (next_hp = hp1) then
                                { Don't let hp1 become a dangling pointer }
                                hp1 := nil;

                              asml.Remove(next_hp);
                              next_hp.Free;
                              Continue;
                            end;

                          { Change the old register (checking the first operand again
                            forces it to be left alone if the full register is not
                            used, lest mov w1,w1 gets optimised out by mistake. [Kit] }
{$ifdef AARCH64}
                          if not MatchOperand(taicpu(next_hp).oper[0]^, taicpu(p).oper[1]^.reg) then
{$endif AARCH64}
                            begin
                              DebugMsg(SPeepholeOptimization + std_regname(taicpu(p).oper[0]^.reg) + ' = ' + std_regname(taicpu(p).oper[1]^.reg) + ' (MovMov2Mov 2)', next_hp);
                              taicpu(next_hp).oper[1]^.reg := taicpu(p).oper[1]^.reg;
                              AllocRegBetween(taicpu(p).oper[1]^.reg, p, next_hp, UsedRegs);

                              { If this was the only reference to the old register,
                                then we can remove the original MOV now }

                              if (taicpu(p).oppostfix = PF_None) and
                                { A bit of a hack - sometimes registers aren't tracked properly, so do not
                                  remove if the register was apparently not allocated when its value is
                                  first set at the MOV command (this is especially true for the stack
                                  register). [Kit] }
                                (getsupreg(taicpu(p).oper[1]^.reg) <> RS_STACK_POINTER_REG) and
                                RegInUsedRegs(taicpu(p).oper[0]^.reg, UsedRegs) and
                                not RegUsedAfterInstruction(taicpu(p).oper[0]^.reg, next_hp, TmpUsedRegs) then
                                begin
                                  DebugMsg(SPeepholeOptimization + 'RedundantMovProcess 2c done', p);
                                  RemoveCurrentP(p);
                                  Result := True;
                                  Exit;
                                end;
                            end;
                        end;
                    end;

                  { On low optimisation settions, don't search more than one instruction ahead }
                  if not(cs_opt_level3 in current_settings.optimizerswitches) or
                    { Stop at procedure calls and jumps }
                    is_calljmp(taicpu(next_hp).opcode) or
                    { If the read register has changed value, or the MOV
                      destination register has been used, drop out }
                    RegInInstruction(taicpu(p).oper[0]^.reg, next_hp) or
                    RegModifiedByInstruction(taicpu(p).oper[1]^.reg, next_hp) then
                    Break;

                  current_hp := next_hp;
                end;
            end;
        end;
    end;


  function TARMAsmOptimizer.DoXTArithOp(var p: tai; hp1: tai): Boolean;
    var
      hp2: tai;
      ConstLimit: TCGInt;
      ValidPostFixes: TOpPostFixes;
      FirstCode, SecondCode, ThirdCode, FourthCode: TAsmOp;
    begin
      Result := False;
      { Change:
          uxtb/h reg1,reg1
          (operation on reg1 with immediate operand where the upper 24/56
          bits don't affect the state of the first 8 bits )
          uxtb/h reg1,reg1

        Remove first uxtb/h
      }
      case taicpu(p).opcode of
        A_UXTB,
        A_SXTB:
          begin
            ConstLimit := $FF;
            ValidPostFixes := [PF_B];
            FirstCode := A_UXTB;
            SecondCode := A_SXTB;
            ThirdCode := A_UXTB; { Used to indicate no other valid codes }
            FourthCode := A_SXTB;
          end;
        A_UXTH,
        A_SXTH:
          begin
            ConstLimit := $FFFF;
            ValidPostFixes := [PF_B, PF_H];
            FirstCode := A_UXTH;
            SecondCode := A_SXTH;
            ThirdCode := A_UXTB;
            FourthCode := A_SXTB;
          end;
        else
          InternalError(2024051401);
      end;

{$ifndef AARCH64}
      { Regular ARM doesn't have the multi-instruction MatchInstruction available }
      if (hp1.typ = ait_instruction) and (taicpu(hp1).oppostfix = PF_None) then
        case taicpu(hp1).opcode of
          A_ADD, A_SUB, A_MUL, A_LSL, A_AND, A_ORR, A_EOR, A_BIC, A_ORN:
{$endif AARCH64}

      if
        (taicpu(p).oper[1]^.reg = taicpu(p).oper[0]^.reg) and
{$ifdef AARCH64}
        MatchInstruction(hp1, [A_ADD, A_SUB, A_MUL, A_LSL, A_AND, A_ORR, A_EOR, A_BIC, A_ORN, A_EON], [PF_None]) and
{$endif AARCH64}
        (taicpu(hp1).condition = C_None) and
        (taicpu(hp1).ops = 3) and
        (taicpu(hp1).oper[0]^.reg = taicpu(p).oper[0]^.reg) and
        (taicpu(hp1).oper[1]^.reg = taicpu(p).oper[0]^.reg) and
        (taicpu(hp1).oper[2]^.typ = top_const) and
        (
          (
            { If the AND immediate is 8-bit, then this essentially performs
              the functionality of the second UXTB and so its presence is
              not required }
            (taicpu(hp1).opcode = A_AND) and
            (taicpu(hp1).oper[2]^.val >= 0) and
            (taicpu(hp1).oper[2]^.val <= ConstLimit)
          ) or
          (
            GetNextInstructionUsingReg(hp1,hp2,taicpu(p).oper[0]^.reg) and
            (hp2.typ = ait_instruction) and
            (taicpu(hp2).ops = 2) and
            (taicpu(hp2).condition = C_None) and
            (
              (
                (taicpu(hp2).opcode in [FirstCode, SecondCode, ThirdCode, FourthCode]) and
                (taicpu(hp2).oppostfix = PF_None) and
                (taicpu(hp2).oper[1]^.reg = taicpu(p).oper[0]^.reg)
                { Destination is allowed to be different in this case, but
                  only if the source is no longer in use (it being the same as
                  the source is covered by RegEndOfLife as well) }
              ) or
              (
                { STRB essentially fills the same role as the second UXTB
                  as long as the register is deallocated afterwards }
                MatchInstruction(hp2, A_STR, [C_None], ValidPostFixes) and
                (taicpu(hp2).oper[0]^.reg = taicpu(p).oper[0]^.reg) and
                not RegInOp(taicpu(p).oper[0]^.reg, taicpu(hp2).oper[1]^)
              )
            ) and
            RegEndOfLife(taicpu(p).oper[0]^.reg, taicpu(hp2))
          )
        ) then
        begin
          DebugMsg(SPeepholeOptimization + 'S/Uxtb/hArithUxtb/h2ArithS/Uxtb/h done', p);
          Result := RemoveCurrentP(p);

          { Simplify bitwise constants if able }
{$ifdef AARCH64}
          if (taicpu(hp1).opcode in [A_AND, A_ORR, A_EOR, A_BIC, A_ORN, A_EON]) and
            is_shifter_const(taicpu(hp1).oper[2]^.val and ConstLimit, OS_32) then
{$else AARCH64}
          if (
              (ConstLimit = $FF) or
              (taicpu(hp1).oper[2]^.val <= $100)
            ) and
            (taicpu(hp1).opcode in [A_AND, A_ORR, A_EOR, A_BIC, A_ORN]) then
{$endif AARCH64}
            taicpu(hp1).oper[2]^.val := taicpu(hp1).oper[2]^.val and ConstLimit;
        end;
{$ifndef AARCH64}
          else
            ;
        end;
{$endif not AARCH64}
    end;


  function TARMAsmOptimizer.OptPass1UXTB(var p : tai) : Boolean;
    var
      hp1, hp2: tai;
      so: tshifterop;
    begin
      Result:=false;
      if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        (taicpu(p).oppostfix = PF_None) and
        (taicpu(p).ops = 2) then
        begin
          if (taicpu(p).condition = C_None) then
            begin
              {
                change
                uxtb reg2,reg1
                strb reg2,[...]
                dealloc reg2
                to
                strb reg1,[...]
              }
              if MatchInstruction(hp1, A_STR, [C_None], [PF_B]) and
                assigned(FindRegDealloc(taicpu(p).oper[0]^.reg,tai(hp1.Next))) and
                { the reference in strb might not use reg2 }
                not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxtbStrb2Strb done', p);
                  taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              {
                change
                uxtb reg2,reg1
                uxth reg3,reg2
                dealloc reg2
                to
                uxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_UXTH, [C_None], [PF_None]) and
                (taicpu(hp1).ops = 2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxtbUxth2Uxtb done', p);
                  AllocRegBetween(taicpu(hp1).oper[0]^.reg,p,hp1,UsedRegs);
                  taicpu(p).loadReg(0,taicpu(hp1).oper[0]^.reg);
                  asml.remove(hp1);
                  hp1.free;
                  result:=true;
                end
              {
                change
                uxtb reg2,reg1
                uxtb reg3,reg2
                dealloc reg2
                to
                uxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_UXTB, [C_None], [PF_None]) and
                (taicpu(hp1).ops = 2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxtbUxtb2Uxtb done', p);
                  AllocRegBetween(taicpu(hp1).oper[0]^.reg,p,hp1,UsedRegs);
                  taicpu(p).loadReg(0,taicpu(hp1).oper[0]^.reg);
                  asml.remove(hp1);
                  hp1.free;
                  result:=true;
                end
              {
                change
                uxtb reg2,reg1
                and reg3,reg2,#0x*FF
                dealloc reg2
                to
                uxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_AND, [C_None], [PF_None]) and
                (taicpu(hp1).ops=3) and
                (taicpu(hp1).oper[2]^.typ=top_const) and
                ((taicpu(hp1).oper[2]^.val and $FF)=$FF) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxtbAndImm2Uxtb done', p);
                  taicpu(hp1).opcode:=A_UXTB;
                  taicpu(hp1).ops:=2;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              else if DoXTArithOp(p, hp1) then
                Result:=true
{$ifdef AARCH64}
              else if USxtOp2Op(p,hp1,SM_UXTB) then
                Result:=true
{$endif AARCH64}
            end;

          { Condition doesn't have to be C_None }
          if not Result and
            RemoveSuperfluousMove(p, hp1, 'UxtbMov2Uxtb') then
            Result:=true;
        end;
    end;


  function TARMAsmOptimizer.OptPass1UXTH(var p : tai) : Boolean;
    var
      hp1: tai;
      so: tshifterop;
    begin
      Result:=false;
      if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        (taicpu(p).oppostfix = PF_None) and
        (taicpu(p).ops = 2) then
        begin
          if (taicpu(p).condition = C_None) then
            begin
              {
                change
                uxth reg2,reg1
                strh reg2,[...]
                dealloc reg2
                to
                strh reg1,[...]
              }
              if MatchInstruction(hp1, A_STR, [C_None], [PF_H]) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { the reference in strb might not use reg2 }
                not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UXTHStrh2Strh done', p);
                  taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              {
                change
                uxth reg2,reg1
                uxth reg3,reg2
                dealloc reg2
                to
                uxth reg3,reg1
              }
              else if MatchInstruction(hp1, A_UXTH, [C_None], [PF_None]) and
                (taicpu(hp1).ops=2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxthUxth2Uxth done', p);
                  AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
                  taicpu(hp1).opcode:=A_UXTH;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              {
                change
                uxth reg2,reg1
                and reg3,reg2,#65535
                dealloc reg2
                to
                uxth reg3,reg1
              }
              else if MatchInstruction(hp1, A_AND, [C_None], [PF_None]) and
                (taicpu(hp1).ops=3) and
                (taicpu(hp1).oper[2]^.typ=top_const) and
                ((taicpu(hp1).oper[2]^.val and $FFFF)=$FFFF) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole UxthAndImm2Uxth done', p);
                  taicpu(hp1).opcode:=A_UXTH;
                  taicpu(hp1).ops:=2;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              else if DoXTArithOp(p, hp1) then
                Result:=true
{$ifdef AARCH64}
              else if USxtOp2Op(p,hp1,SM_UXTH) then
                Result:=true
{$endif AARCH64}
            end;

          { Condition doesn't have to be C_None }
          if not Result and
            RemoveSuperfluousMove(p, hp1, 'UxthMov2Data') then
            Result:=true;
        end;
    end;


  function TARMAsmOptimizer.OptPass1SXTB(var p : tai) : Boolean;
    var
      hp1, hp2: tai;
      so: tshifterop;
    begin
      Result:=false;
      if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        (taicpu(p).oppostfix = PF_None) and
        (taicpu(p).ops = 2) then
        begin
          if (taicpu(p).condition = C_None) then
            begin
              {
                change
                sxtb reg2,reg1
                strb reg2,[...]
                dealloc reg2
                to
                strb reg1,[...]
              }
              if MatchInstruction(hp1, A_STR, [C_None], [PF_B]) and
                assigned(FindRegDealloc(taicpu(p).oper[0]^.reg,tai(hp1.Next))) and
                { the reference in strb might not use reg2 }
                not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxtbStrb2Strb done', p);
                  taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              {
                change
                sxtb reg2,reg1
                sxth reg3,reg2
                dealloc reg2
                to
                sxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_SXTH, [C_None], [PF_None]) and
                (taicpu(hp1).ops = 2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxtbSxth2Sxtb done', p);
                  AllocRegBetween(taicpu(hp1).oper[0]^.reg,p,hp1,UsedRegs);
                  taicpu(p).loadReg(0,taicpu(hp1).oper[0]^.reg);
                  asml.remove(hp1);
                  hp1.free;
                  result:=true;
                end
              {
                change
                sxtb reg2,reg1
                sxtb reg3,reg2
                dealloc reg2
                to
                uxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_SXTB, [C_None], [PF_None]) and
                (taicpu(hp1).ops = 2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxtbSxtb2Sxtb done', p);
                  AllocRegBetween(taicpu(hp1).oper[0]^.reg,p,hp1,UsedRegs);
                  taicpu(p).loadReg(0,taicpu(hp1).oper[0]^.reg);
                  asml.remove(hp1);
                  hp1.free;
                  result:=true;
                end
              {
                change
                sxtb reg2,reg1
                and reg3,reg2,#0x*FF
                dealloc reg2
                to
                uxtb reg3,reg1
              }
              else if MatchInstruction(hp1, A_AND, [C_None], [PF_None]) and
                (taicpu(hp1).ops=3) and
                (taicpu(hp1).oper[2]^.typ=top_const) and
                ((taicpu(hp1).oper[2]^.val and $FF)=$FF) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxtbAndImm2Uxtb done', p);
                  taicpu(hp1).opcode:=A_UXTB;
                  taicpu(hp1).ops:=2;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              else if DoXTArithOp(p, hp1) then
                Result:=true
{$ifdef AARCH64}
              else if USxtOp2Op(p,hp1,SM_SXTB) then
                Result:=true
{$endif AARCH64}
            end;

          { Condition doesn't have to be C_None }
          if not Result and
            RemoveSuperfluousMove(p, hp1, 'SxtbMov2Sxtb') then
            Result:=true;
        end;
    end;


  function TARMAsmOptimizer.OptPass1SXTH(var p : tai) : Boolean;
    var
      hp1: tai;
      so: tshifterop;
    begin
      Result:=false;
      if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
        (taicpu(p).oppostfix = PF_None) and
        (taicpu(p).ops = 2) then
        begin
          if (taicpu(p).condition = C_None) then
            begin
              {
                change
                sxth reg2,reg1
                strh reg2,[...]
                dealloc reg2
                to
                strh reg1,[...]
              }
              if MatchInstruction(p, taicpu(p).opcode, [C_None], [PF_None]) and
                (taicpu(p).ops=2) and
                MatchInstruction(hp1, A_STR, [C_None], [PF_H]) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { the reference in strb might not use reg2 }
                not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxthStrh2Strh done', p);
                  taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              {
                change
                sxth reg2,reg1
                sxth reg3,reg2
                dealloc reg2
                to
                sxth reg3,reg1
              }
              else if MatchInstruction(p, A_SXTH, [C_None], [PF_None]) and
                (taicpu(p).ops=2) and
                MatchInstruction(hp1, A_SXTH, [C_None], [PF_None]) and
                (taicpu(hp1).ops=2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxthSxth2Sxth done', p);
                  AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
                  taicpu(hp1).opcode:=A_SXTH;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
{$ifdef AARCH64}
              {
                change
                sxth reg2,reg1
                sxtw reg3,reg2
                dealloc reg2
                to
                sxth reg3,reg1
              }
              else if MatchInstruction(p, A_SXTH, [C_None], [PF_None]) and
                (taicpu(p).ops=2) and
                MatchInstruction(hp1, A_SXTW, [C_None], [PF_None]) and
                (taicpu(hp1).ops=2) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxthSxtw2Sxth done', p);
                  AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
                  taicpu(hp1).opcode:=A_SXTH;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
{$endif AARCH64}
              {
                change
                sxth reg2,reg1
                and reg3,reg2,#65535
                dealloc reg2
                to
                uxth reg3,reg1
              }
              else if MatchInstruction(p, A_SXTH, [C_None], [PF_None]) and
                (taicpu(p).ops=2) and
                MatchInstruction(hp1, A_AND, [C_None], [PF_None]) and
                (taicpu(hp1).ops=3) and
                (taicpu(hp1).oper[2]^.typ=top_const) and
                ((taicpu(hp1).oper[2]^.val and $FFFF)=$FFFF) and
                MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
                RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
                { reg1 might not be modified inbetween }
                not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole SxthAndImm2Uxth done', p);
                  taicpu(hp1).opcode:=A_UXTH;
                  taicpu(hp1).ops:=2;
                  taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                  result:=RemoveCurrentP(p);
                end
              else if DoXTArithOp(p, hp1) then
                Result:=true
{$ifdef AARCH64}
              else if USxtOp2Op(p,hp1,SM_SXTH) then
                Result:=true
{$endif AARCH64}
            end;

          { Condition doesn't have to be C_None }
          if not Result and
            RemoveSuperfluousMove(p, hp1, 'SxthMov2Sxth') then
            Result:=true;
        end;
    end;


  function TARMAsmOptimizer.OptPreSBFXUBFX(var p: tai): Boolean;
    begin
      Result := False;
      { Convert:
          s/ubfx reg1,reg2,#0,#64 (or #32 for 32-bit registers)
        To:
          mov    reg1,reg2
      }
      if (taicpu(p).oper[2]^.val = 0) and
{$ifdef AARCH64}
        (
          (
            (getsubreg(taicpu(p).oper[0]^.reg) = R_SUBQ) and
            (taicpu(p).oper[3]^.val = 64)
          ) or
          (
            (getsubreg(taicpu(p).oper[0]^.reg) = R_SUBD) and
            (taicpu(p).oper[3]^.val = 32)
          )
        )
{$else AARCH64}
        (taicpu(p).oper[3]^.val = 32)
{$endif AARCH64}
        then
        begin
          DebugMsg(SPeepholeOptimization + 'SBFX or UBFX -> MOV (full bitfield extract)', p);
          taicpu(p).opcode := A_MOV;
          taicpu(p).ops := 2;
          taicpu(p).clearop(2);
          taicpu(p).clearop(3);

          Result := True;
          Exit;
        end;
    end;


  function TARMAsmOptimizer.OptPass1LDR(var p : tai) : Boolean;
    var
      hp1: tai;
      Reference: TReference;
      NewOp: TAsmOp;
    begin
      Result := False;
      if (taicpu(p).ops <> 2) or (taicpu(p).condition <> C_None) then
        Exit;

      Reference := taicpu(p).oper[1]^.ref^;
      if (Reference.addressmode = AM_OFFSET) and
        not RegInRef(taicpu(p).oper[0]^.reg, Reference) and
        { Delay calling GetNextInstruction for as long as possible }
        GetNextInstruction(p, hp1) and
        (hp1.typ = ait_instruction) and
        (taicpu(hp1).condition = C_None) and
        (taicpu(hp1).oppostfix = taicpu(p).oppostfix) then
        begin
          if (taicpu(hp1).opcode = A_STR) and
            RefsEqual(taicpu(hp1).oper[1]^.ref^, Reference) and
            (getregtype(taicpu(p).oper[0]^.reg) = getregtype(taicpu(hp1).oper[0]^.reg)) then
            begin
              { With:
                  ldr reg1,[ref]
                  str reg2,[ref]

                If reg1 = reg2, Remove str
              }
              if taicpu(p).oper[0]^.reg = taicpu(hp1).oper[0]^.reg then
                begin
                  DebugMsg(SPeepholeOptimization + 'Removed redundant store instruction (load/store -> load/nop)', hp1);
                  RemoveInstruction(hp1);
                  Result := True;
                  Exit;
                end;
            end
          else if (taicpu(hp1).opcode = A_LDR) and
            RefsEqual(taicpu(hp1).oper[1]^.ref^, Reference) then
            begin
              { With:
                  ldr reg1,[ref]
                  ldr reg2,[ref]

                If reg1 = reg2, delete the second ldr
                If reg1 <> reg2, changing the 2nd ldr to a mov might introduce
                  a dependency, but it will likely open up new optimisations, so
                  do it for now and handle any new dependencies later.
              }
              if taicpu(p).oper[0]^.reg = taicpu(hp1).oper[0]^.reg then
                begin
                  DebugMsg(SPeepholeOptimization + 'Removed duplicate load instruction (load/load -> load/nop)', hp1);
                  RemoveInstruction(hp1);
                  Result := True;
                  Exit;
                end
              else if
                (getregtype(taicpu(p).oper[0]^.reg) = R_INTREGISTER) and
                (getregtype(taicpu(hp1).oper[0]^.reg) = R_INTREGISTER) and
                (getsubreg(taicpu(p).oper[0]^.reg) = getsubreg(taicpu(hp1).oper[0]^.reg)) then
                begin
                  DebugMsg(SPeepholeOptimization + 'Changed second ldr' + oppostfix2str[taicpu(hp1).oppostfix] + ' to mov (load/load -> load/move)', hp1);
                  taicpu(hp1).opcode := A_MOV;
                  taicpu(hp1).oppostfix := PF_None;
                  taicpu(hp1).loadreg(1, taicpu(p).oper[0]^.reg);
                  AllocRegBetween(taicpu(p).oper[0]^.reg, p, hp1, UsedRegs);
                  Result := True;
                  Exit;
                end;
            end;
        end;
    end;


    function TARMAsmOptimizer.OptPass1STR(var p : tai) : Boolean;
      var
        hp1: tai;
        Reference: TReference;
        SizeMismatch: Boolean;
        SrcReg, DstReg: TRegister;
        NewOp: TAsmOp;
      begin
        Result := False;
        if (taicpu(p).ops <> 2) or (taicpu(p).condition <> C_None) then
          Exit;

        Reference := taicpu(p).oper[1]^.ref^;
        if (Reference.addressmode = AM_OFFSET) and
          not RegInRef(taicpu(p).oper[0]^.reg, Reference) and
          { Delay calling GetNextInstruction for as long as possible }
          GetNextInstruction(p, hp1) and
          (hp1.typ = ait_instruction) and
          (taicpu(hp1).condition = C_None) and
          (taicpu(hp1).oppostfix = taicpu(p).oppostfix) and
          (taicpu(hp1).ops>0) and (taicpu(hp1).oper[0]^.typ=top_reg) then
          begin
            { Saves constant dereferencing and makes it easier to change the size if necessary }
            SrcReg := taicpu(p).oper[0]^.reg;
            DstReg := taicpu(hp1).oper[0]^.reg;

            if (taicpu(hp1).opcode = A_LDR) and
              RefsEqual(taicpu(hp1).oper[1]^.ref^, Reference) and
              (taicpu(hp1).oper[1]^.ref^.volatility=[]) and
              (
                (taicpu(hp1).oppostfix = taicpu(p).oppostfix) or
                ((taicpu(p).oppostfix = PF_B) and (taicpu(hp1).oppostfix = PF_SB)) or
                ((taicpu(p).oppostfix = PF_H) and (taicpu(hp1).oppostfix = PF_SH))
{$ifdef AARCH64}
                or ((taicpu(p).oppostfix = PF_W) and (taicpu(hp1).oppostfix = PF_SW))
{$endif AARCH64}
              ) then
              begin
                { With:
                    str reg1,[ref]
                    ldr reg2,[ref]

                  If reg1 = reg2, Remove ldr.
                  If reg1 <> reg2, replace ldr with "mov reg2,reg1"
                }

                if (SrcReg = DstReg) and
                  { e.g. the ldrb in strb/ldrb is not a null operation as it clears the upper 24 bits }
                  (taicpu(p).oppostfix=PF_None) then
                  begin
                    DebugMsg(SPeepholeOptimization + 'Removed redundant load instruction (store/load -> store/nop)', hp1);
                    RemoveInstruction(hp1);
                    Result := True;
                    Exit;
                  end
                else if (getregtype(SrcReg) = R_INTREGISTER) and
                  (getregtype(DstReg) = R_INTREGISTER) and
                  (getsubreg(SrcReg) = getsubreg(DstReg)) then
                  begin
                    NewOp:=A_NONE;
                    if taicpu(hp1).oppostfix=PF_None then
                      NewOp:=A_MOV
                    else 
{$ifdef ARM}
                      if (current_settings.cputype < cpu_armv6) then
                        begin
                          { The zero- and sign-extension operations were only
                            introduced under ARMv6 }
                          case taicpu(hp1).oppostfix of
                            PF_B:
                              begin
                                { The if-block afterwards will set the middle operand to the correct register }
                                taicpu(hp1).allocate_oper(3);
                                taicpu(hp1).ops := 3;
                                taicpu(hp1).loadconst(2, $FF);
                                NewOp := A_AND;
                              end;
                            PF_H:
                              { ARMv5 and under doesn't have a concise way of storing the immediate $FFFF, so leave alone };
                            PF_SB,
                            PF_SH:
                              { Do nothing - can't easily encode sign-extensions };
                            else
                              InternalError(2021043002);
                          end;
                        end
                      else
{$endif ARM}
                        case taicpu(hp1).oppostfix of
                          PF_B:
                            NewOp := A_UXTB;
                          PF_SB:
                            NewOp := A_SXTB;
                          PF_H:
                            NewOp := A_UXTH;
                          PF_SH:
                            NewOp := A_SXTH;
{$ifdef AARCH64}
                          PF_SW:
                            NewOp := A_SXTW;
                          PF_W:
                            NewOp := A_MOV;
{$endif AARCH64}
                        else
                          InternalError(2021043001);
                        end;
                    if (NewOp<>A_None) then
                      begin
                        DebugMsg(SPeepholeOptimization + 'Changed ldr' + oppostfix2str[taicpu(hp1).oppostfix] + ' to ' + gas_op2str[NewOp] + ' (store/load -> store/move)', hp1);

                        taicpu(hp1).oppostfix := PF_None;
                        taicpu(hp1).opcode := NewOp;
                        taicpu(hp1).loadreg(1, SrcReg);
                        AllocRegBetween(SrcReg, p, hp1, UsedRegs);
                        Result := True;
                        Exit;
                      end;
                end
              end
            else if (taicpu(hp1).opcode = A_STR) and
              RefsEqual(taicpu(hp1).oper[1]^.ref^, Reference) then
              begin
                { With:
                    str reg1,[ref]
                    str reg2,[ref]

                  If reg1 <> reg2, delete the first str
                  IF reg1 = reg2, delete the second str
                }
                if (SrcReg = DstReg) and (taicpu(hp1).oper[1]^.ref^.volatility=[]) then
                  begin
                    DebugMsg(SPeepholeOptimization + 'Removed duplicate store instruction (store/store -> store/nop)', hp1);
                    RemoveInstruction(hp1);
                    Result := True;
                    Exit;
                  end
                else if
                  { Registers same byte size? }
                  (tcgsize2size[reg_cgsize(SrcReg)] = tcgsize2size[reg_cgsize(DstReg)]) and
                  (taicpu(p).oper[1]^.ref^.volatility=[])  then
                  begin
                    DebugMsg(SPeepholeOptimization + 'Removed dominated store instruction (store/store -> nop/store)', p);
                    RemoveCurrentP(p, hp1);
                    Result := True;
                    Exit;
                  end;
              end;
          end;
      end;


  function TARMAsmOptimizer.OptPass1And(var p : tai) : Boolean;
    var
      hp1, hp2: tai;
      i: longint;
    begin
      Result:=false;
      {
        optimize
        and reg2,reg1,const1
        ...
      }
      if (taicpu(p).ops>2) and
         (taicpu(p).oper[1]^.typ = top_reg) and
         (taicpu(p).oper[2]^.typ = top_const) then
        begin
          {
            change
            and reg2,reg1,const1
            ...
            and reg3,reg2,const2
            to
            and reg3,reg1,(const1 and const2)
          }
          if GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
          MatchInstruction(hp1, A_AND, [taicpu(p).condition], [PF_None]) and
          RegEndOfLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
          MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
          (taicpu(hp1).oper[2]^.typ = top_const)
{$ifdef AARCH64}
          and ((((getsubreg(taicpu(p).oper[0]^.reg)=R_SUBQ) and is_shifter_const(taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val,OS_64)) or
               ((getsubreg(taicpu(p).oper[0]^.reg)=R_SUBL) and is_shifter_const(taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val,OS_32))
          ) or
          ((taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val)=0))
{$endif AARCH64}
          then
            begin
              if not(RegUsedBetween(taicpu(hp1).oper[0]^.reg,p,hp1)) then
                begin
                  DebugMsg('Peephole AndAnd2And done', p);
                  AllocRegBetween(taicpu(hp1).oper[0]^.reg,p,hp1,UsedRegs);
                  if (taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val)=0 then
                    begin
                      DebugMsg('Peephole AndAnd2Mov0 1 done', p);
                      taicpu(p).opcode:=A_MOV;
                      taicpu(p).ops:=2;
                      taicpu(p).loadConst(1,0);
                      taicpu(p).oppostfix:=taicpu(hp1).oppostfix;
                    end
                  else
                    begin
                      DebugMsg('Peephole AndAnd2And 1 done', p);
                      taicpu(p).loadConst(2,taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val);
                      taicpu(p).oppostfix:=taicpu(hp1).oppostfix;
                      taicpu(p).loadReg(0,taicpu(hp1).oper[0]^.reg);
                    end;
                  asml.remove(hp1);
                  hp1.free;
                  Result:=true;
                  exit;
                end
              else if not(RegUsedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
                begin
                  if (taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val)=0 then
                    begin
                      DebugMsg('Peephole AndAnd2Mov0 2 done', hp1);
                      taicpu(hp1).opcode:=A_MOV;
                      taicpu(hp1).loadConst(1,0);
                      taicpu(hp1).ops:=2;
                      taicpu(hp1).oppostfix:=taicpu(p).oppostfix;
                    end
                  else
                    begin
                      DebugMsg('Peephole AndAnd2And 2 done', hp1);
                      AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
                      taicpu(hp1).loadConst(2,taicpu(p).oper[2]^.val and taicpu(hp1).oper[2]^.val);
                      taicpu(hp1).oppostfix:=taicpu(p).oppostfix;
                      taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
                    end;
                  GetNextInstruction(p, hp1);
                  RemoveCurrentP(p);
                  p:=hp1;
                  Result:=true;
                  exit;
                end;
            end
          {
            change
            and reg2,reg1,$xxxxxxFF
            strb reg2,[...]
            dealloc reg2
            to
            strb reg1,[...]
          }
          else if ((taicpu(p).oper[2]^.val and $FF) = $FF) and
            MatchInstruction(p, A_AND, [C_None], [PF_None]) and
            GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
            MatchInstruction(hp1, A_STR, [C_None], [PF_B]) and
            assigned(FindRegDealloc(taicpu(p).oper[0]^.reg,tai(hp1.Next))) and
            { the reference in strb might not use reg2 }
            not(RegInRef(taicpu(p).oper[0]^.reg,taicpu(hp1).oper[1]^.ref^)) and
            { reg1 might not be modified inbetween }
            not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              DebugMsg('Peephole AndStrb2Strb done', p);
{$ifdef AARCH64}
              taicpu(hp1).loadReg(0,newreg(R_INTREGISTER,getsupreg(taicpu(p).oper[1]^.reg),R_SUBD));
{$else AARCH64}
              taicpu(hp1).loadReg(0,taicpu(p).oper[1]^.reg);
{$endif AARCH64}
              AllocRegBetween(taicpu(p).oper[1]^.reg,p,hp1,UsedRegs);
              RemoveCurrentP(p);
              result:=true;
              exit;
            end
          {
            change
            and reg2,reg1,255
            uxtb/uxth reg3,reg2
            dealloc reg2
            to
            and reg3,reg1,x
          }
          else if MatchInstruction(p, A_AND, [C_None], [PF_None]) and
            GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
            ((((taicpu(p).oper[2]^.val and $ffffff00)=0) and MatchInstruction(hp1, A_UXTB, [C_None], [PF_None])) or
             (((taicpu(p).oper[2]^.val and $ffff0000)=0) and MatchInstruction(hp1, A_UXTH, [C_None], [PF_None]))) and
            (taicpu(hp1).ops = 2) and
            RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
            MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
            { reg1 might not be modified inbetween }
            not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              DebugMsg('Peephole AndUxt2And done', p);
              taicpu(hp1).opcode:=A_AND;
              taicpu(hp1).ops:=3;
              taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
              taicpu(hp1).loadconst(2,taicpu(p).oper[2]^.val);
              GetNextInstruction(p,hp1);
              asml.remove(p);
              p.Free;
              p:=hp1;
              result:=true;
              exit;
            end
          else if ((taicpu(p).oper[2]^.val and $ffffff80)=0) and
            MatchInstruction(p, A_AND, [C_None], [PF_None]) and
            GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
            MatchInstruction(hp1, [A_SXTB,A_SXTH], [C_None], [PF_None]) and
            (taicpu(hp1).ops = 2) and
            RegEndofLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) and
            MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
            { reg1 might not be modified inbetween }
            not(RegModifiedBetween(taicpu(p).oper[1]^.reg,p,hp1)) then
            begin
              DebugMsg('Peephole AndSxt2And done', p);
              taicpu(hp1).opcode:=A_AND;
              taicpu(hp1).ops:=3;
              taicpu(hp1).loadReg(1,taicpu(p).oper[1]^.reg);
              setsubreg(taicpu(hp1).oper[1]^.reg,getsubreg(taicpu(hp1).oper[0]^.reg));
              taicpu(hp1).loadconst(2,taicpu(p).oper[2]^.val);
              GetNextInstruction(p,hp1);
              asml.remove(p);
              p.Free;
              p:=hp1;
              result:=true;
              exit;
            end
          {
            from
            and reg1,reg0,2^n-1
            mov reg2,reg1, lsl imm1
            (mov reg3,reg2, lsr/asr imm1)
            remove either the and or the lsl/xsr sequence if possible
          }

          else if (taicpu(p).oper[2]^.val < high(int64)) and 
	    cutils.ispowerof2(taicpu(p).oper[2]^.val+1,i) and
            GetNextInstructionUsingReg(p,hp1,taicpu(p).oper[0]^.reg) and
            MatchInstruction(hp1, A_MOV, [taicpu(p).condition], [PF_None]) and
            (taicpu(hp1).ops=3) and
            MatchOperand(taicpu(hp1).oper[1]^, taicpu(p).oper[0]^.reg) and
            (taicpu(hp1).oper[2]^.typ = top_shifterop) and
{$ifdef ARM}
            (taicpu(hp1).oper[2]^.shifterop^.rs = NR_NO) and
{$endif ARM}
            (taicpu(hp1).oper[2]^.shifterop^.shiftmode=SM_LSL) and
            RegEndOfLife(taicpu(p).oper[0]^.reg,taicpu(hp1)) then
            begin
              {
                and reg1,reg0,2^n-1
                mov reg2,reg1, lsl imm1
                mov reg3,reg2, lsr/asr imm1
                =>
                and reg1,reg0,2^n-1
                if lsr and 2^n-1>=imm1 or asr and 2^n-1>imm1
              }
              if GetNextInstructionUsingReg(hp1,hp2,taicpu(p).oper[0]^.reg) and
                MatchInstruction(hp2, A_MOV, [taicpu(p).condition], [PF_None]) and
                (taicpu(hp2).ops=3) and
                MatchOperand(taicpu(hp2).oper[1]^, taicpu(hp1).oper[0]^.reg) and
                (taicpu(hp2).oper[2]^.typ = top_shifterop) and
{$ifdef ARM}
                (taicpu(hp2).oper[2]^.shifterop^.rs = NR_NO) and
{$endif ARM}
                (taicpu(hp2).oper[2]^.shifterop^.shiftmode in [SM_ASR,SM_LSR]) and
                (taicpu(hp1).oper[2]^.shifterop^.shiftimm=taicpu(hp2).oper[2]^.shifterop^.shiftimm) and
                RegEndOfLife(taicpu(hp1).oper[0]^.reg,taicpu(hp2)) and
                ((i<32-taicpu(hp1).oper[2]^.shifterop^.shiftimm) or
                ((i=32-taicpu(hp1).oper[2]^.shifterop^.shiftimm) and
                 (taicpu(hp2).oper[2]^.shifterop^.shiftmode=SM_LSR))) then
                begin
                  DebugMsg('Peephole AndLslXsr2And done', p);
                  taicpu(p).oper[0]^.reg:=taicpu(hp2).oper[0]^.reg;
                  asml.Remove(hp1);
                  asml.Remove(hp2);
                  hp1.free;
                  hp2.free;
                  result:=true;
                  exit;
                end
              {
                and reg1,reg0,2^n-1
                mov reg2,reg1, lsl imm1
                =>
                mov reg2,reg0, lsl imm1
                if imm1>i
              }
              else if (i>32-taicpu(hp1).oper[2]^.shifterop^.shiftimm) and
                      not(RegModifiedBetween(taicpu(p).oper[1]^.reg, p, hp1)) then
                begin
                  DebugMsg('Peephole AndLsl2Lsl done', p);
                  taicpu(hp1).oper[1]^.reg:=taicpu(p).oper[1]^.reg;
                  GetNextInstruction(p, hp1);
                  asml.Remove(p);
                  p.free;
                  p:=hp1;
                  result:=true;
                  exit;
                end
            end;
        end;

      {
        change
        and reg1, ...
        mov reg2, reg1
        to
        and reg2, ...
      }
      if GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
         (taicpu(p).ops>=3) and
         RemoveSuperfluousMove(p, hp1, 'DataMov2Data') then
        Result:=true;
    end;


  function TARMAsmOptimizer.OptPass2Bitwise(var p: tai): Boolean;
    var
      hp1, hp2: tai;
      WorkingReg: TRegister;
    begin
      Result := False;
      {
        change
        and/bic  reg1, ...
        ...
        cmp      reg1, #0
        b<ne/eq> @Lbl
        to
        ands/bics reg1, ...

        Also:

        and/bic  reg1, ...
        ...
        cmp      reg1, #0
        (reg1 end of life)
        b<ne/eq> @Lbl
        to
        tst  reg1, ...
        or
        bics xzr, reg1, ... under AArch64

        For ARM, also include OR, EOR and ORN
      }
      if (taicpu(p).condition = C_None) and
        (taicpu(p).ops>=3) and
        GetNextInstructionUsingReg(p, hp1, taicpu(p).oper[0]^.reg) and
        MatchInstruction(hp1, A_CMP, [C_None], [PF_None]) and
        MatchOperand(taicpu(hp1).oper[1]^, 0) and
{$ifdef AARCH64}
        (SuperRegistersEqual(taicpu(hp1).oper[0]^.reg, taicpu(p).oper[0]^.reg)) and
        (
          (getsubreg(taicpu(hp1).oper[0]^.reg) = getsubreg(taicpu(p).oper[0]^.reg))
          or
          (
            (taicpu(p).oper[2]^.typ = top_const) and
            (taicpu(p).oper[2]^.val >= 0) and
            (taicpu(p).oper[2]^.val <= $FFFFFFFF)
          )
        ) and
{$else AARCH64}
        (taicpu(hp1).oper[0]^.reg = taicpu(p).oper[0]^.reg) and
{$endif AARCH64}

        not RegModifiedBetween(NR_DEFAULTFLAGS, p, hp1) and
        GetNextInstruction(hp1, hp2) then
        begin
          if MatchInstruction(hp2, [A_B, A_CMP, A_CMN, A_TST{$ifndef AARCH64}, A_TEQ{$endif not AARCH64}], [C_EQ, C_NE], [PF_None]) then
            begin
              AllocRegBetween(NR_DEFAULTFLAGS, p, hp1, UsedRegs);

              WorkingReg := taicpu(p).oper[0]^.reg;

              if
{$ifndef AARCH64}
                (taicpu(p).opcode = A_AND) and
{$endif AARCH64}
                RegEndOfLife(WorkingReg, taicpu(hp1)) then
                begin
{$ifdef AARCH64}
                  if (taicpu(p).opcode <> A_AND) then
                    begin
                      setsupreg(taicpu(p).oper[0]^.reg, RS_XZR);
                      taicpu(p).oppostfix := PF_S;
                      DebugMsg(SPeepholeOptimization + 'BIC; CMP -> BICS ' + gas_regname(taicpu(p).oper[0]^.reg), p);
                    end
                  else
{$endif AARCH64}
                    begin
                      taicpu(p).opcode := A_TST;
                      taicpu(p).oppostfix := PF_None;
                      taicpu(p).loadreg(0, taicpu(p).oper[1]^.reg);
                      taicpu(p).loadoper(1, taicpu(p).oper[2]^);
                      if (taicpu(p).ops = 4) then
                        begin
                          { Make sure any shifter operator is also transferred }
                          taicpu(p).loadshifterop(2, taicpu(p).oper[3]^.shifterop^);
                          taicpu(p).ops := 3;
                        end
                      else
                        taicpu(p).ops := 2;

                      DebugMsg(SPeepholeOptimization + 'AND; CMP -> TST', p);
                    end;
                end
              else
                begin
                  taicpu(p).oppostfix := PF_S;
{$ifdef AARCH64}
                  DebugMsg(SPeepholeOptimization + 'AND/BIC; CMP -> ANDS/BICS', p);
{$else AARCH64}
                  DebugMsg(SPeepholeOptimization + 'Bitwise; CMP -> Bitwise+S', p);
{$endif AARCH64}
                end;

              RemoveInstruction(hp1);

              { If a temporary register was used for and/cmp before, we might be
                able to deallocate the register so it can be used for other
                optimisations later }
              if (taicpu(p).opcode = A_TST) and TryRemoveRegAlloc(WorkingReg, p, p) then
                ExcludeRegFromUsedRegs(WorkingReg, UsedRegs);

              Result := True;
              Exit;
            end
          else if
            (hp2.typ = ait_label) or
            { Conditional comparison instructions have already been covered }
            RegModifiedByInstruction(NR_DEFAULTFLAGS, hp2) then
            begin
              { The comparison is a null operation }
              if RegEndOfLife(taicpu(p).oper[0]^.reg, taicpu(hp1)) then
                begin
                  DebugMsg(SPeepholeOptimization + 'Bitwise; CMP -> nop', p);
                  RemoveInstruction(hp1);
                  RemoveCurrentP(p);
                end
              else
                begin
                  DebugMsg(SPeepholeOptimization + 'CMP/BIC -> nop', hp1);
                  RemoveInstruction(hp1);
                end;
              Result := True;
              Exit;
            end;
        end;
    end;


  function TARMAsmOptimizer.OptPass2TST(var p: tai): Boolean;
    var
      hp1, hp2: tai;
    begin
      Result := False;
      if
{$ifndef AARCH64}
        (taicpu(p).condition = C_None) and
{$endif AARCH64}
        GetNextInstruction(p, hp1) and
        MatchInstruction(hp1, A_B, [C_EQ, C_NE], [PF_None]) and
        GetNextInstructionUsingReg(hp1, hp2, taicpu(p).oper[0]^.reg) then
        begin
          case taicpu(hp2).opcode of
            A_AND:
              { Change:
                 tst  r1,##
                 (r2 not in use, or r2 = r1)
                 b.c  .Lbl
                 ...
                 and  r2,r1,##

               Optimise to:
                 ands r2,r1,##
                 b.c  .Lbl
                 ...
              }
              if (taicpu(hp2).oppostfix in [PF_None, PF_S]) and
{$ifndef AARCH64}
                (taicpu(hp2).condition = C_None) and
{$endif AARCH64}
                (taicpu(hp2).ops = taicpu(p).ops + 1) and
                  not RegInUsedRegs(taicpu(hp2).oper[0]^.reg, UsedRegs) and
                  MatchOperand(taicpu(hp2).oper[1]^, taicpu(p).oper[0]^.reg) and
                  MatchOperand(taicpu(hp2).oper[2]^, taicpu(p).oper[1]^) and
                  (
                    (taicpu(hp2).ops = 3) or
                    MatchOperand(taicpu(hp2).oper[3]^, taicpu(p).oper[2]^)
                  ) and
                  (
                    not (cs_opt_level3 in current_settings.optimizerswitches) or
                    (
                      { Make sure the target register isn't used in between }
                      not RegUsedBetween(taicpu(hp2).oper[0]^.reg, hp1, hp2) and
                      (
                        { If the second operand is a register, make sure it isn't modified in between }
                        (taicpu(p).oper[1]^.typ <> top_reg) or
                        not RegModifiedBetween(taicpu(p).oper[1]^.reg, hp1, hp2)
                      )
                    )
                  ) then
                  begin
                    AllocRegBetween(taicpu(hp2).oper[0]^.reg, p, hp2, UsedRegs);

                    if (taicpu(hp2).oppostfix = PF_S) then
                      AllocRegBetween(NR_DEFAULTFLAGS, p, hp2, UsedRegs);

                    DebugMsg(SPeepholeOptimization + 'TST; B.c; AND -> ANDS; B.c (TstBcAnd2AndsBc)', p);
                    taicpu(hp2).oppostfix := PF_S;

                    Asml.Remove(hp2);
                    Asml.InsertAfter(hp2, p);

                    RemoveCurrentP(p, hp2);
                    Result := True;

                    Exit;
                  end;
            A_TST:
              { Change:
                 tst  r1,##
                 b.c  .Lbl
                 ... (flags not modified)
                 tst  r1,##

                Remove second tst
              }
              if
{$ifndef AARCH64}
                (taicpu(hp2).condition = C_None) and
{$endif AARCH64}
                (taicpu(hp2).ops = taicpu(p).ops) and
                MatchOperand(taicpu(hp2).oper[0]^, taicpu(p).oper[0]^.reg) and
                MatchOperand(taicpu(hp2).oper[1]^, taicpu(p).oper[1]^) and
                (
                  (taicpu(hp2).ops = 2) or
                  MatchOperand(taicpu(hp2).oper[2]^, taicpu(p).oper[2]^)
                ) and
                (
                  not (cs_opt_level3 in current_settings.optimizerswitches) or
                  (
                    { Make sure the flags aren't modified in between }
                    not RegModifiedBetween(NR_DEFAULTFLAGS, hp1, hp2) and
                    (
                      { If the second operand is a register, make sure it isn't modified in between }
                      (taicpu(p).oper[1]^.typ <> top_reg) or
                      not RegModifiedBetween(taicpu(p).oper[1]^.reg, hp1, hp2)
                    )
                  )
                ) then
                begin
                  DebugMsg(SPeepholeOptimization + 'TST; B.c; TST -> TST; B.c (TstBcTst2TstBc)', p);

                  AllocRegBetween(NR_DEFAULTFLAGS, hp1, hp2, UsedRegs);
                  RemoveInstruction(hp2);
                  Result := True;
                  Exit;
                end;
            else
              ;
          end;
        end;
    end;


  function TARMAsmOptimizer.TryConstMerge(var p: tai; hp1: tai): Boolean;
    const
{$ifdef ARM}
      LO_16_WRITE: TAsmOp = A_MOVW;
      HI_16_WRITE: TAsmOp = A_MOVT;
{$endif ARM}
{$ifdef AARCH64}
      LO_16_WRITE: TAsmOp = A_MOVZ;
      HI_16_WRITE: TAsmOp = A_MOVK;
{$endif AARCH64}
    var
      hp2, hp2_second, hp3, hp3_second, p_second, hp1_second: tai;
      ThisReg: TRegister;
      ThisRef: TReference;
      so: TShifterOp;

      procedure SearchAhead;
        begin
          { If p.opcode = A_STR, then ThisReg will be NR_NO }
          if
{$ifdef ARM}
            Assigned(hp1) and
{$endif ARM}
{$ifdef AARCH64}
            (
              (
                MatchInstruction(p, A_MOVZ, []) and
                Assigned(hp1)
              ) or
              (
                MatchInstruction(p, A_STR, []) and
                SetAndTest(p, hp1)
              )
            ) and
{$endif AARCH64}
            (
              (
                (ThisReg <> NR_NO) and
                (
{$ifdef AARCH64}
                  (
                    (getsubreg(ThisReg) = R_SUBD) and
                    MatchInstruction(hp1, A_MOVK, []) and
                    (taicpu(hp1).oper[0]^.reg = ThisReg) and
                    GetNextInstruction(hp1, hp2) and
                    MatchInstruction(hp2, A_STR, []) and
                    (taicpu(hp2).oper[0]^.reg = ThisReg) and
                    GetNextInstruction(hp2, p_second)
                  ) or
{$endif AARCH64}
                  (
                    MatchInstruction(hp1, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, []) and
                    (taicpu(hp1).oper[0]^.reg = ThisReg) and
                    GetNextInstruction(hp1, p_second)
                  )
                )
              ) or (
                { Just search one ahead if ThisReg is NR_NO }
                (ThisReg = NR_NO) and
                GetNextInstruction(hp1, p_second)
              )
            ) and
            (
              (
{$ifdef ARM}
                (
                  MatchInstruction(p_second, A_MOV, [taicpu(p).condition], []) or
                  MatchInstruction(p_second, A_MOVW, [taicpu(p).condition], [])
                ) and
{$endif ARM}
{$ifdef AARCH64}
                MatchInstruction(p_second, A_MOVZ, []) and
{$endif AARCH64}
                { Don't use ThisReg because it may be NR_NO }
                GetNextInstruction(p_second, hp1_second) and
                (
{$ifdef AARCH64}
                  (
                    MatchInstruction(hp1_second, A_MOVK, []) and
                    GetNextInstruction(hp1_second, hp2_second) and
                    MatchInstruction(hp2_second, A_STR, [PF_None])
                  ) or
{$endif AARCH64}
                  MatchInstruction(hp1_second, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [])
                )
              )
{$ifdef AARCH64}
              or (
                MatchInstruction(p_second, A_STR, []) and
                (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) and
                { Negate the result because we're setting hp1_second to nil }
                not SetAndTest(nil, hp1_second)
              )
{$endif AARCH64}
            ) then
            TryConstMerge(p_second, hp1_second);
        end;

    begin
      Result := False;
{$ifdef ARM}
      { We need a Cortex-A ARM processor that supports MOVW and MOVT }
      if not (CPUARM_HAS_EXTENDED_CONSTANTS in cpu_capabilities[current_settings.cputype]) then
        Exit;
{$endif ARM}

      ThisReg := NR_NO; { Safe initialisation }

      case taicpu(p).opcode of
{$ifdef ARM}
        A_MOV,
        A_MOVW:
          if (taicpu(p).opcode <> A_MOV) or (taicpu(p).oper[1]^.typ = top_const) then
{$endif ARM}
{$ifdef AARCH64}
        A_MOVZ:
{$endif AARCH64}
          begin
            ThisReg := taicpu(p).oper[0]^.reg;
            if Assigned(hp1){$ifdef ARM} and (taicpu(hp1).condition = taicpu(p).condition){$endif ARM} then
              case taicpu(hp1).opcode of
                A_STR:
                  if {$ifdef ARM}(taicpu(hp1).ops = 2) and {$endif ARM}SuperRegistersEqual(taicpu(hp1).oper[0]^.reg, ThisReg) then
                    begin
                      ThisRef := taicpu(hp1).oper[1]^.ref^;

                      if (ThisRef.addressmode = AM_OFFSET) and
                        (ThisRef.index = NR_NO) and
                        { Only permit writes to the stack, since we can guarantee alignment with that }
                        (
                          (ThisRef.base = NR_STACK_POINTER_REG) or
                          (ThisRef.base = current_procinfo.framepointer)
                        ) then
                        begin
                          case taicpu(hp1).oppostfix of
                            PF_B:
                              {
                                With sequences such as:
                                  movz  w0,x
                                  strb  w0,[sp, #ofs]
                                  movz  w0,y
                                  strb  w0,[sp, #ofs+1]

                                Merge the constants to:
                                  movz  w0,x + (y shl 8)
                                  strh  w0,[sp, #ofs]

                                Only use the stack pointer or frame pointer and an even offset though
                                to guarantee alignment
                              }
                              if ((ThisRef.offset mod 2) = 0) and
                                GetNextInstruction(hp1, p_second) and
                                (p_second.typ = ait_instruction)
{$ifdef ARM}
                                and (taicpu(p_second).condition = taicpu(p).condition)
{$endif ARM}
                                then
                                begin
                                  case taicpu(p_second).opcode of
{$ifdef ARM}
                                    A_MOV,
                                    A_MOVW:
                                      if (taicpu(p_second).oppostfix = PF_None) and
                                        ((taicpu(p_second).opcode <> A_MOV) or (taicpu(p_second).oper[1]^.typ = top_const)) then
{$endif ARM}
{$ifdef AARCH64}
                                    A_MOVZ:
{$endif AARCH64}
                                      begin
                                        if SuperRegistersEqual(taicpu(p_second).oper[0]^.reg, ThisReg) and
                                          GetNextInstruction(p_second, hp1_second) and
                                          MatchInstruction(hp1_second, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [PF_B]) and
                                          SuperRegistersEqual(taicpu(hp1_second).oper[0]^.reg, ThisReg) then
                                          begin
                                            { Is the second storage location exactly one byte ahead? }
                                            Inc(ThisRef.offset);
                                            if RefsEqual(taicpu(hp1_second).oper[1]^.ref^, ThisRef) and
                                              { The final safety check... make sure the register used
                                                to store the constant isn't used afterwards }
                                              RegEndOfLife(ThisReg, taicpu(hp1_second)) then
                                              begin

                                                { See if we can merge 4 bytes at once (this benefits ARM mostly, but provides a speed boost for AArch64 too) }
                                                if GetNextInstruction(hp1_second, hp2) and
                                                  (
{$ifdef ARM}
                                                    MatchInstruction(hp2, A_MOVW, [taicpu(p).condition], []) or
{$endif ARM}
                                                    (
                                                      MatchInstruction(hp2, LO_16_WRITE{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [])
{$ifdef ARM}
                                                      and (taicpu(hp2).oper[1]^.typ = top_const)
{$endif ARM}
                                                    )
                                                  ) and
                                                  SuperRegistersEqual(taicpu(hp2).oper[0]^.reg, ThisReg) and
                                                  GetNextInstruction(hp2, hp2_second) and
                                                  MatchInstruction(hp2_second, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [PF_B]) and
                                                  SuperRegistersEqual(taicpu(hp2_second).oper[0]^.reg, ThisReg) and
                                                  GetNextInstruction(hp2_second, hp3) and
                                                  (
{$ifdef ARM}
                                                    MatchInstruction(hp3, A_MOVW, [taicpu(p).condition], []) or
{$endif ARM}
                                                    (
                                                      MatchInstruction(hp3, LO_16_WRITE{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [])
{$ifdef ARM}
                                                      and (taicpu(hp3).oper[1]^.typ = top_const)
{$endif ARM}
                                                    )
                                                  ) and
                                                  SuperRegistersEqual(taicpu(hp3).oper[0]^.reg, ThisReg) and
                                                  GetNextInstruction(hp3, hp3_second) and
                                                  MatchInstruction(hp3_second, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [PF_B]) and
                                                  SuperRegistersEqual(taicpu(hp3_second).oper[0]^.reg, ThisReg) then
                                                  begin
                                                    Inc(ThisRef.offset);
                                                    if RefsEqual(taicpu(hp2_second).oper[1]^.ref^, ThisRef) then
                                                      begin
                                                        Inc(ThisRef.offset);
                                                        if RefsEqual(taicpu(hp3_second).oper[1]^.ref^, ThisRef) then
                                                          begin
                                                            { Merge the constants }
                                                            DebugMsg(SPeepholeOptimization + 'Merged four byte-writes to memory into a single word-write (MovzStrbMovzStrbMovzStrbMovzStrb2MovzMovkStr)', p);
{$ifdef ARM}
                                                            taicpu(p).opcode := A_MOVW;
{$endif ARM}
                                                            taicpu(p).oper[1]^.val := (taicpu(p).oper[1]^.val and $FF) or ((taicpu(p_second).oper[1]^.val and $FF) shl 8);

                                                            taicpu(hp2).opcode := HI_16_WRITE;
                                                            taicpu(hp2).oper[1]^.val := (taicpu(hp2).oper[1]^.val and $FF) or ((taicpu(hp3).oper[1]^.val and $FF) shl 8);

                                                            so.shiftimm := 16;
                                                            so.shiftmode := SM_LSL;
                                                            taicpu(hp2).loadshifterop(2, so);
                                                            taicpu(hp2).ops := 3;

                                                            taicpu(hp1).oppostfix := PF_None;

                                                            AsmL.Remove(hp2);
                                                            AsmL.InsertAfter(hp2, p);

                                                            RemoveInstruction(p_second);
                                                            RemoveInstruction(hp1_second);
                                                            RemoveInstruction(hp2_second);
                                                            RemoveInstruction(hp3);
                                                            RemoveInstruction(hp3_second);
                                                            Result := True;
{$ifdef AARCH64}
                                                            { Searching ahead only benefits AArch64 here }
                                                            hp1 := hp2; { Since hp2 now appears immediately after p }
                                                            SearchAhead;
{$endif AARCH64}
                                                            Exit;
                                                          end;
                                                        { Reset the offset so the range check below is correct }
                                                        Dec(ThisRef.offset);
                                                      end;
                                                    Dec(ThisRef.offset);
                                                  end;
{$ifdef ARM}
                                                { Be careful.  strb and str support offsets between -4095 and +4095, but
                                                  strh only supports offsets between -255 and +255.  However, we might be
                                                  able to bypass this if there are four bytes in a row (for AArch64, just
                                                  use SearchAhead below }
                                                if { Remember we added 1 to the offset }
                                                  (ThisRef.offset >= -254) and (ThisRef.offset <= 256) then
{$endif ARM}
                                                  begin

                                                    { Merge the constants and remove the second pair of instructions }
                                                    DebugMsg(SPeepholeOptimization + 'Merged two byte-writes to memory into a single half-write (MovzStrbMovzStrb2MovzStrh)', p);
{$ifdef ARM}
                                                    taicpu(p).opcode := A_MOVW;
{$endif ARM}
                                                    taicpu(p).oper[1]^.val := (taicpu(p).oper[1]^.val and $FF) or ((taicpu(p_second).oper[1]^.val and $FF) shl 8);
                                                    taicpu(hp1).oppostfix := PF_H;
                                                    RemoveInstruction(p_second);
                                                    RemoveInstruction(hp1_second);
                                                    Result := True;
                                                  end;
                                              end;
                                          end;
                                      end;
{$ifdef AARCH64}
                                    A_STR:
                                      { Sometimes, the second mov might not be present as we're writing the
                                        zero register to the next address - that is:
                                          movz  w0,x
                                          strb  w0,[sp, #ofs]
                                          strb  wzr,[sp, #ofs+1]

                                        Which becomes:
                                          movz  w0,x
                                          strh  w0,[sp, #ofs]
                                      }
                                      if RegEndOfLife(ThisReg, taicpu(hp1)) and
                                        (taicpu(p_second).oppostfix = PF_B) and
                                        (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) then
                                        begin
                                          { Is the second storage location exactly one byte ahead? }
                                          Inc(ThisRef.offset);
                                          if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                            begin
                                              { Merge the constants and remove the second pair of instructions }
                                              DebugMsg(SPeepholeOptimization + 'Merged a byte-write and a zero-register byte-write to memory into a single half-write (MovzStrbStrb2MovzStrh 1)', p);
                                              taicpu(p).oper[1]^.val := taicpu(p).oper[1]^.val and $FF; { In case there's some extraneous bits }
                                              taicpu(hp1).oppostfix := PF_H;
                                              RemoveInstruction(p_second);
                                              Result := True;
                                            end;
                                        end;
{$endif AARCH64}
                                    else
                                      ;
                                  end;

                                  { Search ahead to see if more bytes are written individually,
                                    because then we may be able to merge 4 bytes into a full
                                    word write in a single pass }
                                  if Result then
                                    begin
                                      SearchAhead;
                                      Exit;
                                    end;
                                end;
                            PF_H:
                              {
                                With sequences such as:
                                  movz  w0,x
                                  strh  w0,[sp, #ofs]
                                  movz  w0,y
                                  strh  w0,[sp, #ofs+2]

                                Merge the constants to:
                                  movz  w0,x
                                  movk  w0,y,lsl #16
                                  str   w0,[sp, #ofs]

                                Only use the stack pointer or frame pointer and an offset
                                that's a multiple of 4 though to guarantee alignment
                              }
                              if ((ThisRef.offset mod 4) = 0) and
                                GetNextInstruction(hp1, p_second) and
                                (p_second.typ = ait_instruction)
{$ifdef ARM}
                                and (taicpu(p_second).condition = taicpu(p).condition)
{$endif ARM}
                                then
                                begin
                                  case taicpu(p_second).opcode of
{$ifdef ARM}
                                    A_MOV,
                                    A_MOVW:
                                      if (taicpu(p).oppostfix = PF_None) and
                                        ((taicpu(p).opcode <> A_MOV) or (taicpu(p).oper[1]^.typ = top_const)) then
{$endif ARM}
{$ifdef AARCH64}
                                    A_MOVZ:
{$endif AARCH64}
                                      begin
                                        if SuperRegistersEqual(taicpu(p_second).oper[0]^.reg, ThisReg) and
                                          GetNextInstruction(p_second, hp1_second) and
                                          MatchInstruction(hp1_second, A_STR{$ifdef ARM}, [taicpu(p).condition]{$endif ARM}, [PF_H]) and
                                          SuperRegistersEqual(taicpu(hp1_second).oper[0]^.reg, ThisReg) then
                                          begin
                                            { Is the second storage location exactly one byte ahead? }
                                            Inc(ThisRef.offset, 2);
                                            if RefsEqual(taicpu(hp1_second).oper[1]^.ref^, ThisRef) and
                                              { The final safety check... make sure the register used
                                                to store the constant isn't used afterwards }
                                              RegEndOfLife(ThisReg, taicpu(hp1_second)) then
                                              begin
                                                { Merge the constants }
                                                DebugMsg(SPeepholeOptimization + 'Merged two half-writes to memory into a single word-write (MovzStrhMovzStrh2MovzMovkStr)', p);

                                                { Repurpose the second MOVZ instruction into a MOVK instruction }
                                                if taicpu(p_second).oper[1]^.val = 0 then
                                                  begin
                                                    { Or just remove it if it's not needed }
                                                    RemoveInstruction(p_second);
{$ifdef ARM}
                                                    { If within the range 0..255, MOV suffices (256 can also be encoded this way) }
                                                    if (taicpu(p).oper[1]^.val < 0) or (taicpu(p).oper[1]^.val > 256) then
                                                      taicpu(p).opcode := A_MOVW;
{$endif ARM}
                                                    taicpu(hp1).oppostfix := PF_None;
                                                  end
                                                else
                                                  begin
                                                    asml.Remove(p_second);
                                                    asml.InsertAfter(p_second, p);
{$ifdef ARM}
                                                    taicpu(p).opcode := A_MOVW;
{$endif ARM}
                                                    taicpu(p_second).opcode := HI_16_WRITE;
{$ifdef AARCH64}
                                                    so.shiftmode := SM_LSL;
                                                    so.shiftimm := 16;

                                                    taicpu(p_second).ops := 3;
                                                    taicpu(p_second).loadshifterop(2, so);

                                                    { Make doubly sure we're only using the 32-bit register, otherwise STR could write 64 bits }
                                                    setsubreg(ThisReg, R_SUBD);
                                                    taicpu(p).oper[0]^.reg := ThisReg;
                                                    taicpu(p_second).oper[0]^.reg := ThisReg;
                                                    taicpu(hp1).oper[0]^.reg := ThisReg;
{$endif AARCH64}
                                                    taicpu(hp1).oppostfix := PF_None;
{$ifdef AARCH64}
                                                    hp1 := p_second; { Since p_second now appears immediately after p }
                                                    p_second := hp1;
{$endif AARCH64}
                                                    { TODO: Confirm that the A_MOVZ / A_MOVK combination is the most efficient }
                                                  end;

                                                RemoveInstruction(hp1_second);
                                                Result := True;
                                              end;
                                          end;
                                      end;
{$ifdef AARCH64}
                                    A_STR:
                                      { Sometimes, the second mov might not be present as we're writing the
                                        zero register to the next address - that is:
                                          movz  w0,x
                                          strh  w0,[sp, #ofs]
                                          strh  wzr,[sp, #ofs+1]

                                        Which becomes:
                                          movz  w0,x
                                          str   w0,[sp, #ofs]
                                      }
                                      if RegEndOfLife(ThisReg, taicpu(hp1)) and
                                        (taicpu(p_second).oppostfix = PF_H) and
                                        (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) then
                                        begin
                                          { Is the second storage location exactly one byte ahead? }
                                          Inc(ThisRef.offset, 2);
                                          if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                            begin
                                              { Merge the constants and remove the second pair of instructions }
                                              DebugMsg(SPeepholeOptimization + 'Merged a half-write and a zero-register half-write to memory into a single word-write (MovzStrhStrh2MovzStr)', p);

                                              { Make doubly sure we're only using the 32-bit register, otherwise STR could write 64 bits }
                                              setsubreg(ThisReg, R_SUBD);
                                              taicpu(p).oper[0]^.reg := ThisReg;
                                              taicpu(hp1).oper[0]^.reg := ThisReg;

                                              taicpu(hp1).oppostfix := PF_None;
                                              RemoveInstruction(p_second);
                                              Result := True;
                                            end;
                                        end;
{$endif AARCH64}
                                    else
                                      ;
                                  end;
{$ifdef AARCH64}
                                  { Search ahead to see if more half-words are written
                                    individually, because then we may be able to merge
                                    4 words into a full extended write in a single pass }
                                  if Result then
                                    begin
                                      SearchAhead;
                                      Exit;
                                    end;
{$endif AARCH64}
                                end;
                            else
                              ;
                          end;
                        end;
                    end;
{$ifdef AARCH64}
                A_MOVK:
                  if (getsubreg(ThisReg) = R_SUBD) and
                    Assigned(hp1) and
                    (taicpu(hp1).oper[0]^.reg = ThisReg) and
                    (taicpu(hp1).ops = 3) and
                    (taicpu(hp1).oper[2]^.shifterop^.shiftmode = SM_LSL) and
                    (taicpu(hp1).oper[2]^.shifterop^.shiftimm = 16) and
                    GetNextInstruction(hp1, hp2) and
                    MatchInstruction(hp2, A_STR, [PF_None]) and
                    (taicpu(hp2).oper[0]^.reg = ThisReg) then
                    begin
                      {
                        With sequences such as:
                          movz  w0,x
                          movk  w0,y,lsl #16
                          str   w0,[sp, #ofs]
                          movz  w0,z
                          movk  w0,q,lsl #16
                          str   w0,[sp, #ofs+4]

                        Merge the constants to:
                          movz  x0,x
                          movk  x0,y,lsl #16
                          movk  x0,z,lsl #32
                          movk  x0,q,lsl #48
                          str   x0,[sp, #ofs]

                        Only use the stack pointer or frame pointer and an offset
                        that's a multiple of 8 though to guarantee alignment
                      }
                      ThisRef := taicpu(hp2).oper[1]^.ref^;
                      if ((ThisRef.offset mod 8) = 0) and
                        GetNextInstruction(hp2, p_second) and
                        (p_second.typ = ait_instruction) then
                        case taicpu(p_second).opcode of
                          A_MOVZ:
                            if (
                                (taicpu(p_second).oper[0]^.reg = ThisReg) or
                                (
                                  RegEndOfLife(ThisReg, taicpu(hp2)) and
                                  (getsubreg(taicpu(p_second).oper[0]^.reg) = R_SUBD)
                                )
                              ) and GetNextInstruction(p_second, hp1_second) then
                              begin
                                case taicpu(hp1_second).opcode of
                                  A_MOVK:
                                    if (taicpu(p_second).oper[1]^.val <= $FFFF) and
                                      (taicpu(hp1_second).oper[0]^.reg = taicpu(p_second).oper[0]^.reg) and
                                      (taicpu(hp1_second).ops = 3) and
                                      (taicpu(hp1_second).oper[2]^.shifterop^.shiftmode = SM_LSL) and
                                      (taicpu(hp1_second).oper[2]^.shifterop^.shiftimm = 16) and
                                      GetNextInstruction(hp1_second, hp2_second) and
                                      MatchInstruction(hp2_second, A_STR, [PF_None]) and
                                      (taicpu(hp1_second).oper[0]^.reg = taicpu(p_second).oper[0]^.reg) then
                                      begin
                                        Inc(ThisRef.offset, 4);
                                        if RefsEqual(taicpu(hp2_second).oper[1]^.ref^, ThisRef) and
                                          { The final safety check... make sure the register used
                                            to store the constant isn't used afterwards }
                                          RegEndOfLife(taicpu(p_second).oper[0]^.reg, taicpu(hp2_second)) then
                                          begin
                                            DebugMsg(SPeepholeOptimization + 'Merged two word-writes to memory into a single extended-write (MovzMovkStrMovzMovkStr2MovzMovkMovkMovkStr)', p);

                                            { Extend register to 64-bit and repurpose second MOVZ to a MOVK with lsl 32 }
                                            setsubreg(ThisReg, R_SUBQ);

                                            taicpu(p).oper[0]^.reg := ThisReg;
                                            taicpu(hp1).oper[0]^.reg := ThisReg;

                                            { If the 3rd word is zero, we can remove the instruction entirely }
                                            if taicpu(p_second).oper[1]^.val = 0 then
                                              RemoveInstruction(p_second)
                                            else
                                              begin
                                                taicpu(p_second).oper[0]^.reg := ThisReg;
                                                so.shiftimm := 32;
                                                so.shiftmode := SM_LSL;
                                                taicpu(p_second).opcode := A_MOVK;
                                                taicpu(p_second).ops := 3;
                                                taicpu(p_second).loadshifterop(2, so);
                                                AsmL.Remove(p_second);
                                                AsmL.InsertBefore(p_second, hp2);
                                              end;

                                            taicpu(hp1_second).oper[0]^.reg := ThisReg;
                                            taicpu(hp1_second).oper[2]^.shifterop^.shiftimm := 48;
                                            taicpu(hp2).oper[0]^.reg := ThisReg;

                                            AsmL.Remove(hp1_second);
                                            AsmL.InsertBefore(hp1_second, hp2);

                                            RemoveInstruction(hp2_second);
                                            Result := True;
                                          end;
                                      end;
                                  else
                                    ;
                                end;
                              end;
                          A_STR:
                            { Sometimes, the second mov might not be present as we're writing the
                              zero register to the next address - that is:
                                movz  w0,x
                                movk  w0,y,lsl #16
                                str   w0,[sp, #ofs]
                                str   wzr,[sp, #ofs+4]

                              Which becomes:
                                movz  x0,x
                                movk  x0,y,lsl #16
                                str   x0,[sp, #ofs]
                            }
                            begin
                              { Sometimes, the second mov might not be present as we're writing the
                                zero register to the next address - that is:
                                  movz  w0,x
                                  strh  w0,[sp, #ofs]
                                  strh  wzr,[sp, #ofs+1]

                                Which becomes:
                                  movz  w0,x
                                  str   w0,[sp, #ofs]
                              }
                              { Don't need to check end-of-life because the upper 32 bits are zero
                                and the overall value isn't being modified }
                              if (taicpu(p_second).oppostfix = PF_None) and
                                (taicpu(p_second).oper[0]^.reg = NR_WZR) then
                                begin
                                  { Is the second storage location exactly one byte ahead? }
                                  Inc(ThisRef.offset, 4);
                                  if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                    begin
                                      { Merge the constants and remove the second pair of instructions }
                                      DebugMsg(SPeepholeOptimization + 'Merged a word-write and a zero-register word-write to memory into a single extended-write (MovzStrStr2MovzStr)', p);

                                      setsubreg(taicpu(p).oper[0]^.reg, R_SUBQ);
                                      setsubreg(taicpu(hp1).oper[0]^.reg, R_SUBQ);
                                      setsubreg(taicpu(hp2).oper[0]^.reg, R_SUBQ);
                                      RemoveInstruction(p_second);
                                      Result := True;
                                    end;
                                end;
                            end
                          else
                            ;
                        end;
                    end;
{$endif AARCH64}
                else
                  ;
              end;
          end;
{$ifdef AARCH64}
        A_STR:
          { hp1 is probably nil }
          if getsupreg(taicpu(p).oper[0]^.reg) = RS_WZR then
            begin
              ThisRef := taicpu(p).oper[1]^.ref^;
              if (ThisRef.addressmode = AM_OFFSET) and
                (ThisRef.index = NR_NO) and
                { Only permit writes to the stack, since we can guarantee alignment with that }
                (
                  (ThisRef.base = NR_STACK_POINTER_REG) or
                  (ThisRef.base = current_procinfo.framepointer)
                ) then
                begin

                  case taicpu(p).oppostfix of
                    PF_B:
                      {
                        With sequences such as:
                          strb  wzr,[sp, #ofs]
                          movz  w0,x
                          strb  w0,[sp, #ofs+1]

                        Merge the constants to:
                          movz  w0,x shl 8
                          strh  w0,[sp, #ofs]

                        Only use the stack pointer or frame pointer and an even offset though
                        to guarantee alignment
                      }
                      if ((ThisRef.offset mod 2) = 0) and
                        GetNextInstruction(p, p_second) and
                        (p_second.typ = ait_instruction) then
                        begin

                          case taicpu(p_second).opcode of
                            A_MOVZ:
                              begin
                                ThisReg := taicpu(p_second).oper[0]^.reg;
                                if GetNextInstruction(p_second, hp1_second) and
                                  MatchInstruction(hp1_second, A_STR, [PF_B]) and
                                  SuperRegistersEqual(taicpu(hp1_second).oper[0]^.reg, ThisReg) then
                                  begin
                                    { Is the second storage location exactly one byte ahead? }
                                    Inc(ThisRef.offset);
                                    if RefsEqual(taicpu(hp1_second).oper[1]^.ref^, ThisRef) and
                                      { The final safety check... make sure the register used
                                        to store the constant isn't used afterwards }
                                      RegEndOfLife(ThisReg, taicpu(hp1_second)) then
                                      begin
                                        { Merge the constants by repurposing the 2nd move, changing the register in the first STR and removing the second STR }
                                        DebugMsg(SPeepholeOptimization + 'Merged a zero-register byte-write and a byte-write to memory into a single half-write (MovzStrbStrb2MovzStrh 2)', p);
                                        taicpu(p_second).oper[1]^.val := (taicpu(p_second).oper[1]^.val and $FF) shl 8;

                                        taicpu(hp1_second).oppostfix := PF_H;
                                        Dec(taicpu(hp1_second).oper[1]^.ref^.offset, 1);

                                        RemoveCurrentP(p, p_second);
                                        Result := True;

                                        hp1 := hp1_second; { So SearchAhead works properly below }
                                      end;
                                  end;
                              end;
                            A_STR:
                              { Change:
                                  strb  wzr,[sp, #ofs]
                                  strb  wzr,[sp, #ofs+1]

                                To:
                                  strh  wzr,[sp, #ofs]
                              }
                              if (taicpu(p_second).oppostfix = PF_B) and
                                (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) then
                                begin
                                  { Is the second storage location exactly one byte ahead? }
                                  Inc(ThisRef.offset);
                                  if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                    begin
                                      DebugMsg(SPeepholeOptimization + 'Merged two zero-register byte-writes to memory into a single zero-register half-write (StrbStrb2Strh)', p);
                                      taicpu(p).oppostfix := PF_H;
                                      RemoveInstruction(p_second);
                                      if hp1 = p_second then { Make sure hp1 deson't become a dangling pointer }
                                        GetNextInstruction(p, hp1);
                                      Result := True;
                                    end;
                                end;
                            else
                              ;
                          end;

                          { Search ahead to see if more bytes are written individually,
                            because then we may be able to merge 4 bytes into a full
                            word write in a single pass }
                          if Result then
                            begin
                              SearchAhead;
                              Exit;
                            end;
                        end;
                    PF_H:
                      {
                        With sequences such as:
                          strh  wzr,[sp, #ofs]
                          movz  w0,x
                          strh  w0,[sp, #ofs+2]

                        Merge the constants to:
                          movz  w0,#0
                          movk  w0,x,lsl #16
                          str   w0,[sp, #ofs]

                        Only use the stack pointer or frame pointer and an offset
                        that's a multiple of 4 though to guarantee alignment
                      }
                      if ((ThisRef.offset mod 4) = 0) and
                        GetNextInstruction(p, p_second) and
                        (p_second.typ = ait_instruction) then
                        begin
                          case taicpu(p_second).opcode of
                            A_MOVZ:
                              begin
                                ThisReg := taicpu(p_second).oper[0]^.reg;
                                if GetNextInstruction(p_second, hp1_second) and
                                  MatchInstruction(hp1_second, A_STR, [PF_H]) and
                                  SuperRegistersEqual(taicpu(hp1_second).oper[0]^.reg, ThisReg) then
                                  begin
                                    { Is the second storage location exactly two bytes ahead? }
                                    Inc(ThisRef.offset, 2);
                                    if RefsEqual(taicpu(hp1_second).oper[1]^.ref^, ThisRef) and
                                      { The final safety check... make sure the register used
                                        to store the constant isn't used afterwards }
                                      RegEndOfLife(ThisReg, taicpu(hp1_second)) then
                                      begin

                                        { Merge the constants }
                                        DebugMsg(SPeepholeOptimization + 'Merged a zero-register half-write and a half-write to memory into a single word-write (StrhMovzStrh2MovzMovkStr)', p);

                                        { Repurpose the first STR to a MOVZ instruction }
                                        taicpu(p).opcode := A_MOVZ;
                                        taicpu(p).oppostfix := PF_None;
                                        taicpu(p).oper[0]^.reg := ThisReg;
                                        taicpu(p).loadconst(1, 0);

                                        so.shiftmode := SM_LSL;
                                        so.shiftimm := 16;

                                        taicpu(p_second).opcode := A_MOVK;
                                        taicpu(p_second).ops := 3;
                                        taicpu(p_second).loadshifterop(2, so);

                                        { Make doubly sure we're only using the 32-bit register, otherwise STR could write 64 bits }
                                        setsubreg(ThisReg, R_SUBD);
                                        taicpu(p).oper[0]^.reg := ThisReg;
                                        taicpu(p_second).oper[0]^.reg := ThisReg;
                                        taicpu(hp1_second).oper[0]^.reg := ThisReg;

                                        { TODO: Confirm that the A_MOVZ / A_MOVK combination is the most efficient }

                                        taicpu(hp1_second).oppostfix := PF_None;
                                        Dec(taicpu(hp1_second).oper[1]^.ref^.offset, 2);
                                        Result := True;
                                      end;
                                  end;
                              end;
                            A_STR:
                              { Change:
                                  strh  wzr,[sp, #ofs]
                                  strh  wzr,[sp, #ofs+2]

                                To:
                                  str   wzr,[sp, #ofs]
                              }
                              if (taicpu(p_second).oppostfix = PF_H) and
                                (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) then
                                begin
                                  { Is the second storage location exactly one byte ahead? }
                                  Inc(ThisRef.offset, 2);
                                  if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                    begin
                                      DebugMsg(SPeepholeOptimization + 'Merged two zero-register half-writes to memory into a single zero-register word-write (StrhStrh2Str)', p);

                                      { Make doubly sure we're only using the 32-bit register, otherwise STR could write 64 bits }
                                      taicpu(p).oper[0]^.reg := NR_WZR;

                                      taicpu(p).oppostfix := PF_None;
                                      RemoveInstruction(p_second);
                                      if hp1 = p_second then { Make sure hp1 deson't become a dangling pointer }
                                        GetNextInstruction(p, hp1);
                                      Result := True;
                                    end;
                                end;
                            else
                              ;
                          end;
                        end;
                    PF_None:
                      {
                        With sequences such as:
                          str   wzr,[sp, #ofs]
                          movz  w0,x
                          movk  w0,y,lsl #16
                          str   w0,[sp, #ofs+4]

                        Merge the constants to:
                          movz  x0,#0
                          movk  x0,x,lsl #32
                          movk  x0,y,lsl #48
                          str   x0,[sp, #ofs]

                        Only use the stack pointer or frame pointer and an offset
                        that's a multiple of 8 though to guarantee alignment
                      }
                      if ((ThisRef.offset mod 8) = 0) and
                        GetNextInstruction(p, p_second) and
                        (p_second.typ = ait_instruction) then
                        begin
                          case taicpu(p_second).opcode of
                            A_MOVZ:
                              begin
                                ThisReg := taicpu(p_second).oper[0]^.reg;
                                if GetNextInstruction(p_second, hp1_second) and
                                  MatchInstruction(hp1_second, A_MOVK, []) and
                                  GetNextInstruction(hp1_second, hp2_second) and
                                  MatchInstruction(hp2_second, A_STR, [PF_None]) and
                                  (taicpu(hp2_second).oper[0]^.reg = ThisReg) then
                                  begin
                                    { Is the second storage location exactly four bytes ahead? }
                                    Inc(ThisRef.offset, 4);
                                    if RefsEqual(taicpu(hp2_second).oper[1]^.ref^, ThisRef) and
                                      { The final safety check... make sure the register used
                                        to store the constant isn't used afterwards }
                                      RegEndOfLife(ThisReg, taicpu(hp1_second)) then
                                      begin
                                        { Merge the constants }
                                        DebugMsg(SPeepholeOptimization + 'Merged a zero-register word-write and a word-write to memory into a single extended-write (StrMovzMovkStr2MovzMovkMovkStr)', p);

                                        setsubreg(ThisReg, R_SUBQ);

                                        { Repurpose the first STR to a MOVZ instruction }
                                        taicpu(p).opcode := A_MOVZ;
                                        taicpu(p).oppostfix := PF_None;
                                        taicpu(p).oper[0]^.reg := ThisReg;
                                        taicpu(p).loadconst(1, 0);

                                        { If the 3rd word is zero, we can remove the instruction entirely }
                                        if taicpu(p_second).oper[1]^.val = 0 then
                                          begin
                                            RemoveInstruction(p_second);
                                            if hp1 = p_second then { Make sure hp1 deson't become a dangling pointer }
                                              GetNextInstruction(p, hp1);
                                          end
                                        else
                                          begin
                                            so.shiftmode := SM_LSL;
                                            so.shiftimm := 32;
                                            taicpu(p_second).opcode := A_MOVK;
                                            taicpu(p_second).ops := 3;
                                            taicpu(p_second).loadshifterop(2, so);
                                            taicpu(p_second).oper[0]^.reg := ThisReg;
                                          end;

                                        taicpu(p).oper[0]^.reg := ThisReg;
                                        taicpu(hp1_second).oper[0]^.reg := ThisReg;
                                        taicpu(hp1_second).oper[2]^.shifterop^.shiftimm := 48;

                                        { TODO: Confirm that the A_MOVZ / A_MOVK / A_MOVK combination is the most efficient }

                                        taicpu(hp2_second).oppostfix := PF_None;
                                        Dec(taicpu(hp2_second).oper[1]^.ref^.offset, 4);
                                        taicpu(hp2_second).oper[0]^.reg := ThisReg; { Remember to change the register to its 64-bit counterpart }
                                        Result := True;
                                      end;
                                  end;
                              end;
                            A_STR:
                              { Change:
                                  str   wzr,[sp, #ofs]
                                  str   wzr,[sp, #ofs+4]

                                To:
                                  str   xzr,[sp, #ofs]
                              }
                              if (taicpu(p_second).oppostfix = PF_None) and
                                (getsupreg(taicpu(p_second).oper[0]^.reg) = RS_WZR) then
                                begin
                                  { Is the second storage location exactly one byte ahead? }
                                  Inc(ThisRef.offset, 4);
                                  if RefsEqual(taicpu(p_second).oper[1]^.ref^, ThisRef) then
                                    begin
                                      DebugMsg(SPeepholeOptimization + 'Merged two zero-register word-writes to memory into a single zero-register extended-write (StrStr2Str)', p);
                                      taicpu(p).oper[0]^.reg := NR_XZR;
                                      RemoveInstruction(p_second);
                                      if hp1 = p_second then { Make sure hp1 deson't become a dangling pointer }
                                        GetNextInstruction(p, hp1);
                                      Result := True;
                                    end;
                                end;
                            else
                              ;
                          end;
                        end;
                    else
                      ;
                  end;
                end;
            end;
{$endif AARCH64}
        else
          ;
      end;
    end;

end.

