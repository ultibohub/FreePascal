{
    Copyright (c) 1998-2020 by Florian Klaempfl and Nikolay Nikolov

    Generate WebAssembly code for type converting nodes

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

 ****************************************************************************}
unit nwasmcnv;

{$i fpcdefs.inc}

interface

    uses
      node,ncnv,ncgcnv;

    type

       { twasmtypeconvnode }

       twasmtypeconvnode = class(tcgtypeconvnode)
       protected
         function first_int_to_real: tnode; override;
         procedure second_int_to_real;override;
         procedure second_int_to_bool;override;
         procedure second_ansistring_to_pchar;override;
         procedure second_class_to_intf;override;
       public
         function target_specific_explicit_typeconv: boolean;override;
       end;

implementation

   uses
      verbose,globals,globtype,aasmdata,
      defutil,defcmp,fmodule,cpubase,
      cgbase,cgutils,pass_1,pass_2,
      aasmbase,aasmcpu,
      symdef,symconst,
      tgobj,
      hlcgobj,hlcgcpu;


{ twasmtypeconvnode }

    function twasmtypeconvnode.first_int_to_real: tnode;
      begin
        first_int_to_real:=nil;
        if left.resultdef.size<4 then
          begin
            inserttypeconv(left,s32inttype);
            firstpass(left);
          end;
        expectloc:=LOC_FPUREGISTER;
      end;


    procedure twasmtypeconvnode.second_int_to_real;
      var
        op: TAsmOp;
      begin
        case tfloatdef(resultdef).floattype of
          s32real:
            begin
              if is_64bitint(left.resultdef) or
                is_currency(left.resultdef) then
                begin
                  if is_signed(left.resultdef) then
                    op:=a_f32_convert_i64_s
                  else
                    op:=a_f32_convert_i64_u;
                end
              else
                { other integers are supposed to be 32 bit }
                begin
                  if is_signed(left.resultdef) then
                    op:=a_f32_convert_i32_s
                  else
                    op:=a_f32_convert_i32_u;
                end;
            end;
          s64real:
            begin
              if is_64bitint(left.resultdef) or
                is_currency(left.resultdef) then
                begin
                  if is_signed(left.resultdef) then
                    op:=a_f64_convert_i64_s
                  else
                    op:=a_f64_convert_i64_u;
                end
              else
                { other integers are supposed to be 32 bit }
                begin
                  if is_signed(left.resultdef) then
                    op:=a_f64_convert_i32_s
                  else
                    op:=a_f64_convert_i32_u;
                end;
            end;
          else
            internalerror(2021010501);
        end;

        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
        current_asmdata.CurrAsmList.concat(taicpu.op_none(op));
        location_reset(location,LOC_FPUREGISTER,def_cgsize(resultdef));
        location.register := hlcg.getfpuregister(current_asmdata.CurrAsmList,resultdef);
        thlcgwasm(hlcg).a_load_stack_loc(current_asmdata.CurrAsmList,resultdef,location);
      end;


    procedure twasmtypeconvnode.second_int_to_bool;
      begin
        secondpass(left);
        if codegenerror then
          exit;
        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);
        thlcgwasm(hlcg).a_load_const_stack(current_asmdata.CurrAsmList,left.resultdef,0,R_INTREGISTER);
        thlcgwasm(hlcg).a_cmp_stack_stack(current_asmdata.CurrAsmList,left.resultdef,OC_NE);
        if is_cbool(resultdef) then
          begin
            if is_64bit(resultdef) then
              current_asmdata.CurrAsmList.Concat(taicpu.op_functype(a_if,TWasmFuncType.Create([],[wbt_i64])))
            else
              current_asmdata.CurrAsmList.Concat(taicpu.op_functype(a_if,TWasmFuncType.Create([],[wbt_i32])));
            thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);
            if is_64bit(resultdef) then
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i64_const, -1) )
            else if is_32bit(resultdef) then
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i32_const, -1) )
            else if is_16bit(resultdef) then
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i32_const, 65535) )
            else if is_8bit(resultdef) then
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i32_const, 255) )
            else
              internalerror(2021100101);
            thlcgwasm(hlcg).incstack(current_asmdata.CurrAsmList,1);
            current_asmdata.CurrAsmList.Concat( taicpu.op_none(a_else) );
            thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);
            if is_64bit(resultdef) then
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i64_const, 0) )
            else
              current_asmdata.CurrAsmList.Concat( taicpu.op_const(a_i32_const, 0) );
            thlcgwasm(hlcg).incstack(current_asmdata.CurrAsmList,1);
            current_asmdata.CurrAsmList.concat(taicpu.op_none(a_end_if));
          end
        else
          thlcgwasm(hlcg).resize_stack_int_val(current_asmdata.CurrAsmList,u32inttype,resultdef,false);
        location_reset(location,LOC_REGISTER,def_cgsize(resultdef));
        location.register := hlcg.getintregister(current_asmdata.CurrAsmList,resultdef);
        thlcgwasm(hlcg).a_load_stack_loc(current_asmdata.CurrAsmList,resultdef,location);
      end;


    procedure twasmtypeconvnode.second_ansistring_to_pchar;
      var
        hr : treference;
      begin
        thlcgwasm(hlcg).a_cmp_const_loc_stack(current_asmdata.CurrAsmList,left.resultdef,OC_NE,0,left.location);

        current_asmdata.CurrAsmList.Concat(taicpu.op_functype(a_if,TWasmFuncType.Create([],[wbt_i32])));
        thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);

        thlcgwasm(hlcg).a_load_loc_stack(current_asmdata.CurrAsmList,left.resultdef,left.location);

        current_asmdata.CurrAsmList.Concat(taicpu.op_none(a_else));
        thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);

        { FPC_EMPTYCHAR is a widechar -> 2 bytes }
        reference_reset(hr,2,[]);
        hr.symbol:=current_asmdata.RefAsmSymbol('FPC_EMPTYCHAR',AT_DATA);
        current_module.add_extern_asmsym('FPC_EMPTYCHAR',AB_EXTERNAL,AT_DATA);
        thlcgwasm(hlcg).a_loadaddr_ref_stack(current_asmdata.CurrAsmList,cwidechartype,resultdef,hr);

        current_asmdata.CurrAsmList.Concat( taicpu.op_none(a_end_if) );

        location_reset(location,LOC_REGISTER,def_cgsize(resultdef));
        location.register:=hlcg.getaddressregister(current_asmdata.CurrAsmList,resultdef);
        thlcgwasm(hlcg).a_load_stack_loc(current_asmdata.CurrAsmList,resultdef,location);
      end;


    procedure twasmtypeconvnode.second_class_to_intf;
      var
        hd : tobjectdef;
        ImplIntf : TImplementedInterface;
      begin
        location_reset(location,LOC_REGISTER,def_cgsize(resultdef));
        case left.location.loc of
           LOC_CREFERENCE,
           LOC_REFERENCE:
             begin
                location.register:=hlcg.getaddressregister(current_asmdata.CurrAsmList,resultdef);
                hlcg.a_load_ref_reg(current_asmdata.CurrAsmList,left.resultdef,resultdef,left.location.reference,location.register);
                location_freetemp(current_asmdata.CurrAsmList,left.location);
             end;
           LOC_CREGISTER:
             begin
                location.register:=hlcg.getaddressregister(current_asmdata.CurrAsmList,resultdef);
                hlcg.a_load_reg_reg(current_asmdata.CurrAsmList,left.resultdef,resultdef,left.location.register,location.register);
             end;
           LOC_REGISTER:
             begin
               location.register:=left.location.register;
               hlcg.g_ptrtypecast_reg(current_asmdata.CurrAsmList,left.resultdef,resultdef,location.register);
             end;
           LOC_CONSTANT:
             begin
                location.register:=hlcg.getaddressregister(current_asmdata.CurrAsmList,resultdef);
                hlcg.a_load_const_reg(current_asmdata.CurrAsmList,resultdef,left.location.value,location.register);
             end
           else
             internalerror(121120001);
        end;
        hd:=tobjectdef(left.resultdef);
        while assigned(hd) do
          begin
            ImplIntf:=find_implemented_interface(hd,tobjectdef(resultdef));
            if assigned(ImplIntf) then
              begin
                case ImplIntf.IType of
                  etStandard:
                    begin
                      thlcgwasm(hlcg).a_cmp_const_reg_stack(current_asmdata.CurrAsmList,resultdef,OC_NE,0,location.register);

                      current_asmdata.CurrAsmList.concat(taicpu.op_none(a_if));
                      thlcgwasm(hlcg).decstack(current_asmdata.CurrAsmList,1);

                      hlcg.a_op_const_reg(current_asmdata.CurrAsmList,OP_ADD,resultdef,ImplIntf.ioffset,location.register);

                      current_asmdata.CurrAsmList.concat(taicpu.op_none(a_end_if));
                      break;
                    end;
                  else
                    internalerror(200802163);
                end;
              end;
            hd:=hd.childof;
          end;
        if hd=nil then
          internalerror(2002081301);
      end;


    function twasmtypeconvnode.target_specific_explicit_typeconv: boolean;
      begin
        result:=false;
        if is_pointer(left.resultdef) and
           is_pointer(resultdef) and
           not tpointerdef(left.resultdef).compatible_with_pointerdef_size(tpointerdef(resultdef)) then
          CGMessage2(type_e_illegal_type_conversion,left.resultdef.typename,resultdef.typename);
      end;

begin
  ctypeconvnode:=twasmtypeconvnode;
end.
