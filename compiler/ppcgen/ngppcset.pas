{
    Copyright (c) 1998-2002 by Florian Klaempfl and Carl Eric Codere

    Generate PowerPC32/64 assembler for in set/case nodes

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
unit ngppcset;

{$i fpcdefs.inc}

interface

    uses
       node,nset,ncgset,cpubase,cgbase,cgobj,aasmbase,aasmtai,aasmdata,globtype;

    type
       tgppccasenode = class(tcgcasenode)
         protected
           procedure optimizevalues(var max_linear_list : int64; var max_dist : qword);override;
           function  has_jumptable : boolean;override;
           procedure genjumptable(hp : pcaselabel;min_,max_ : int64);override;
           procedure genlinearlist(hp : pcaselabel); override;
       end;


implementation

    uses
      systems,
      verbose,globals,constexp,
      symconst,symdef,defutil,
      paramgr,
      cpuinfo,
      pass_2,cgcpu,
      ncon,
      tgobj,ncgutil,rgobj,aasmcpu,
      procinfo,
      cgutils;

{*****************************************************************************
                            TCGCASENODE
*****************************************************************************}


    procedure tgppccasenode.optimizevalues(var max_linear_list : int64; var max_dist : qword);
    begin
      max_linear_list := 10;
    end;
    

    function tgppccasenode.has_jumptable : boolean;
      begin
        has_jumptable:=true;
      end;


    procedure tgppccasenode.genjumptable(hp : pcaselabel;min_,max_ : int64);
      var
        table : tasmlabel;
        last : TConstExprInt;
        indexreg : tregister;
        href : treference;

        procedure genitem(list:TAsmList;t : pcaselabel);
          var
            i : TConstExprInt;
          begin
            if assigned(t^.less) then
              genitem(list,t^.less);
            { fill possible hole }
            i:=last+1;
            while i<=t^._low-1 do
              begin
                list.concat(Tai_const.Create_rel_sym(aitconst_32bit,table,elselabel));
                i:=i+1;
              end;
            i:=t^._low;
            while i<=t^._high do
              begin
                list.concat(Tai_const.Create_rel_sym(aitconst_32bit,table,blocklabel(t^.blockid)));
                i:=i+1;
              end;
            last:=t^._high;
            if assigned(t^.greater) then
              genitem(list,t^.greater);
          end;

      begin
        last:=min_;
        { make it a 32bit register }
        // allocate base and index registers register
        indexreg:= cg.makeregsize(current_asmdata.CurrAsmList, hregister, OS_INT);
        { indexreg := hregister; }
        cg.a_load_reg_reg(current_asmdata.CurrAsmList, def_cgsize(opsize), OS_INT, hregister, indexreg);
        { a <= x <= b <-> unsigned(x-a) <= (b-a) }
        cg.a_op_const_reg(current_asmdata.CurrAsmList,OP_SUB,OS_INT,aint(min_),indexreg);
        if not(jumptable_no_range) then
          begin
             { case expr greater than max_ => goto elselabel }
             cg.a_cmp_const_reg_label(current_asmdata.CurrAsmList,OS_INT,OC_A,aint(max_)-aint(min_),indexreg,elselabel);
          end;
        current_asmdata.getjumplabel(table);
        { create reference, indexreg := indexreg * sizeof(jtentry) (= 4) }
        cg.a_op_const_reg(current_asmdata.CurrAsmList, OP_MUL, OS_INT, 4, indexreg);
        reference_reset_symbol(href, table, 0, 4, []);

        hregister:=cg.getaddressregister(current_asmdata.CurrAsmList);
        cg.a_loadaddr_ref_reg(current_asmdata.CurrAsmList,href,hregister);
        reference_reset_base(href,hregister,0,href.temppos,4,[]);
        href.index:=indexreg;
        indexreg:=cg.getaddressregister(current_asmdata.CurrAsmList);
        { load table entry }
        cg.a_load_ref_reg(current_asmdata.CurrAsmList,OS_S32,OS_ADDR,href,indexreg);
        { add table base }
        cg.a_op_reg_reg(current_asmdata.CurrAsmList,OP_ADD,OS_ADDR,hregister,indexreg);
        { jump }
        current_asmdata.CurrAsmList.concat(taicpu.op_reg(A_MTCTR, indexreg));
        current_asmdata.CurrAsmList.concat(taicpu.op_none(A_BCTR));

        { generate jump table }
        current_asmdata.CurrAsmList.concat(Tai_label.Create(table));
        genitem(current_asmdata.CurrAsmList,hp);
      end;


    procedure tgppccasenode.genlinearlist(hp : pcaselabel);

      var
         first, lastrange : boolean;
         last : TConstExprInt;

      procedure genitem(t : pcaselabel);

          procedure gensub(value:longint);
          var
            tmpreg: tregister;
          begin
            value := -value;
            if (value >= low(smallint)) and
               (value <= high(smallint)) then
              current_asmdata.CurrAsmList.concat(taicpu.op_reg_reg_const(A_ADDIC_,hregister,
                hregister,value))
            else
              begin
                tmpreg := cg.getintregister(current_asmdata.CurrAsmList,OS_INT);
                 cg.a_load_const_reg(current_asmdata.CurrAsmList,OS_INT,value,tmpreg);
                current_asmdata.CurrAsmList.concat(taicpu.op_reg_reg_reg(A_ADD_,hregister,
                  hregister,tmpreg));
              end;
          end;

        begin
           if (get_min_value(left.resultdef) >= int64(low(smallint))) and
              (get_max_value(left.resultdef) <= int64(high(word))) then
             begin
               genlinearcmplist(hp);
               exit;
             end;
           if assigned(t^.less) then
             genitem(t^.less);
           { need we to test the first value }
           if first and (t^._low>get_min_value(left.resultdef)) then
             begin
               cg.a_cmp_const_reg_label(current_asmdata.CurrAsmList,OS_INT,jmp_lt,aword(t^._low.svalue),hregister,elselabel);
             end;
           if t^._low=t^._high then
             begin
                if t^._low-last=0 then
                  cg.a_cmp_const_reg_label(current_asmdata.CurrAsmList,OS_INT,OC_EQ,0,hregister,blocklabel(t^.blockid))
                else
                  gensub(longint(int64(t^._low-last)));
                tcgppc(cg).a_jmp_cond(current_asmdata.CurrAsmList,OC_EQ,blocklabel(t^.blockid));
                last:=t^._low;
                lastrange := false;
             end
           else
             begin
                { it begins with the smallest label, if the value }
                { is even smaller then jump immediately to the    }
                { ELSE-label                                }
                if first then
                  begin
                     { have we to adjust the first value ? }
                     if (t^._low>get_min_value(left.resultdef)) or (get_min_value(left.resultdef)<>0) then
                       gensub(longint(int64(t^._low)));
                  end
                else
                  begin
                    { if there is no unused label between the last and the }
                    { present label then the lower limit can be checked    }
                    { immediately. else check the range in between:       }
                    gensub(longint(int64(t^._low-last)));
                    if ((t^._low-last) <> 1) or
                       (not lastrange) then
                      tcgppc(cg).a_jmp_cond(current_asmdata.CurrAsmList,jmp_lt,elselabel);
                  end;
                gensub(longint(int64(t^._high-t^._low)));
                tcgppc(cg).a_jmp_cond(current_asmdata.CurrAsmList,jmp_le,blocklabel(t^.blockid));
                last:=t^._high;
                lastrange := true;
             end;
           first:=false;
           if assigned(t^.greater) then
             genitem(t^.greater);
        end;

      begin
         { do we need to generate cmps? }
         if (with_sign and (min_label<0)) or
            (def_cgsize(opsize) in [OS_32,OS_64,OS_S64]) then
           genlinearcmplist(hp)
         else
           begin
              last:=0;
              lastrange:=false;
              first:=true;
              genitem(hp);
              cg.a_jmp_always(current_asmdata.CurrAsmList,elselabel);
           end;
      end;


begin
   ccasenode:=tgppccasenode;
end.
