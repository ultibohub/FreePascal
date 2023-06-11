{
    Copyright (c) 1998-2009 by Florian Klaempfl and David Zhang

    This unit implements the register allocator for MIPS(EL)

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

unit rgcpu;

{$i fpcdefs.inc}

  interface

    uses
      aasmbase,aasmsym,aasmcpu,aasmtai,aasmdata,
      cgbase,cgutils,
      cpubase,
      rgobj;

    type
      trgcpu=class(trgobj)
        function get_spill_subreg(r : tregister) : tsubregister;override;
        procedure do_spill_read(list: TAsmList; pos: tai; const spilltemp: treference; tempreg: tregister; orgsupreg: tsuperregister); override;
        procedure do_spill_written(list: TAsmList; pos: tai; const spilltemp: treference; tempreg: tregister; orgsupreg: tsuperregister); override;
        function do_spill_replace(list: TAsmList; instr: tai_cpu_abstract_sym; orgreg: tsuperregister; const spilltemp: treference): boolean; override;
      end;

      trgintcpu=class(trgcpu)
        procedure add_cpu_interferences(p:tai);override;
      end;

implementation

    uses
      globtype,
      verbose,cutils,
      cgobj;


    function trgcpu.get_spill_subreg(r : tregister) : tsubregister;
      begin
        if getregtype(r)=R_FPUREGISTER then
          result:=getsubreg(r)
        else
          result:=defaultsub;
      end;


    procedure trgcpu.do_spill_read(list: TAsmList; pos: tai; const spilltemp: treference; tempreg: tregister; orgsupreg: tsuperregister);
      var
        helpins  : tai;
        tmpref   : treference;
        helplist : tasmlist;
        hreg     : tregister;
      begin
        if abs(spilltemp.offset)>32767 then
          begin
            helplist:=tasmlist.create;

            if getregtype(tempreg)=R_INTREGISTER then
              hreg:=tempreg
            else
              hreg:=cg.getintregister(helplist,OS_ADDR);

            helplist.concat(taicpu.op_reg_const(A_LUI,hreg,spilltemp.offset shr 16));
            helplist.concat(taicpu.op_reg_reg_const(A_ORI,hreg,hreg,spilltemp.offset and $FFFF));
            helplist.concat(taicpu.op_reg_reg_reg(A_ADDU,hreg,hreg,spilltemp.base));

            reference_reset_base(tmpref,hreg,0,spilltemp.temppos,sizeof(aint),[]);

            helpins:=spilling_create_load(tmpref,tempreg);
            helplist.concat(helpins);
            list.insertlistafter(pos,helplist);
            helplist.free;
          end
        else
          inherited;
      end;


    procedure trgcpu.do_spill_written(list: TAsmList; pos: tai; const spilltemp: treference; tempreg: tregister; orgsupreg: tsuperregister);
      var
        tmpref   : treference;
        helplist : tasmlist;
        hreg     : tregister;
      begin
        if abs(spilltemp.offset)>32767 then
          begin
            helplist:=tasmlist.create;

            if getregtype(tempreg)=R_INTREGISTER then
              hreg:=getregisterinline(helplist,[R_SUBWHOLE])
            else
              hreg:=cg.getintregister(helplist,OS_ADDR);

            helplist.concat(taicpu.op_reg_const(A_LUI,hreg,spilltemp.offset shr 16));
            helplist.concat(taicpu.op_reg_reg_const(A_ORI,hreg,hreg,spilltemp.offset and $FFFF));
            helplist.concat(taicpu.op_reg_reg_reg(A_ADDU,hreg,hreg,spilltemp.base));

            reference_reset_base(tmpref,hreg,0,spilltemp.temppos,sizeof(aint),[]);

            helplist.concat(spilling_create_store(tempreg,tmpref));
            if getregtype(tempreg)=R_INTREGISTER then
              ungetregisterinline(helplist,hreg);

            list.insertlistafter(pos,helplist);
            helplist.free;
          end
        else
          inherited;
    end;


    function trgcpu.do_spill_replace(list: TAsmList; instr: tai_cpu_abstract_sym; orgreg: tsuperregister; const spilltemp: treference): boolean;
      begin
        result:=false;
        { Replace 'move  orgreg,src' with 'sw  src,spilltemp'
              and 'move  dst,orgreg' with 'lw  dst,spilltemp' }

        if (not (instr.opcode in [A_MOVE,A_MOV_S,A_MOV_D,A_MTC1])) or (abs(spilltemp.offset)>32767) then
          exit;
        if (instr.ops<>2) or
           (instr.oper[0]^.typ<>top_reg) or
           (instr.oper[1]^.typ<>top_reg) then
          InternalError(2013061001);
        if (getregtype(instr.oper[0]^.reg)<>regtype) or
           (getregtype(instr.oper[1]^.reg)<>regtype) then
          begin
            if (instr.opcode=A_MTC1) then
              begin
                { TODO: MTC1 src,orgreg  ==>  SW    src,0/4(spilltemp) (endian-dependent!!) }
                if (regtype=R_FPUREGISTER) then
                  exit;
              end
            else
              InternalError(2013061003);
          end;
        if (getregtype(instr.oper[1]^.reg)=regtype) and  (get_alias(getsupreg(instr.oper[1]^.reg))=orgreg) then
          begin
            case instr.opcode of
              A_MOVE:  instr.opcode:=A_LW;
              A_MOV_S: instr.opcode:=A_LWC1;
              A_MOV_D: instr.opcode:=A_LDC1;
            else
              InternalError(2013061004);
            end;
          end
        else if (getregtype(instr.oper[0]^.reg)=regtype) and  (get_alias(getsupreg(instr.oper[0]^.reg))=orgreg) then
          begin
            case instr.opcode of
              A_MOVE:  instr.opcode:=A_SW;
              A_MOV_S: instr.opcode:=A_SWC1;
              A_MOV_D: instr.opcode:=A_SDC1;
              A_MTC1:
                begin
                  if (getregtype(instr.oper[0]^.reg)<>R_INTREGISTER) then
                    InternalError(2013061006);
                  instr.opcode:=A_LWC1;
                end
            else
              InternalError(2013061005);
            end;
            instr.oper[0]^:=instr.oper[1]^;
          end
        else
          InternalError(2013061002);
        instr.oper[1]^.typ:=top_ref;
        new(instr.oper[1]^.ref);
        instr.oper[1]^.ref^:=spilltemp;
        result:=true;
      end;


    procedure trgintcpu.add_cpu_interferences(p: tai);
      var
        supreg: tsuperregister;
      begin
        if p.typ<>ait_instruction then
          exit;
        if (taicpu(p).ops>=1) and (taicpu(p).oper[0]^.typ=top_reg) and
          (getregtype(taicpu(p).oper[0]^.reg)=regtype) and
          (taicpu(p).spilling_get_operation_type(0) in [operand_write,operand_readwrite]) then
          begin
            { prevent merging registers with frame/stack pointer, $zero and $at
              if an instruction writes to the register }
            supreg:=getsupreg(taicpu(p).oper[0]^.reg);
            add_edge(supreg,RS_STACK_POINTER_REG);
            add_edge(supreg,RS_FRAME_POINTER_REG);
            add_edge(supreg,RS_R0);
            add_edge(supreg,RS_R1);
          end;
      end;


end.
