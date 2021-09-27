{
    Copyright (c) 2021 by Nikolay Nikolov

    WebAssembly version of some node tree helper routines

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
unit nwasmutil;

{$i fpcdefs.inc}

interface

  uses
    ngenutil;

  type

    { twasmnodeutils }

    twasmnodeutils = class(tnodeutils)
    public
      class procedure InsertObjectInfo; override;
    end;

implementation

  uses
    globtype,globals,
    cpubase,
    aasmdata,aasmcpu,
    hlcgobj,hlcgcpu,
    symdef,symtype,symconst,
    fmodule;

  { twasmnodeutils }

  class procedure twasmnodeutils.InsertObjectInfo;

      procedure WriteImportDll(list: TAsmList; proc: tprocdef);
        begin
          thlcgwasm(hlcg).g_procdef(list,proc);
          list.Concat(tai_import_module.create(proc.mangledname,proc.import_dll^));
          list.Concat(tai_import_name.create(proc.mangledname,proc.import_name^));
        end;

    var
      i    : integer;
      def  : tdef;
      proc : tprocdef;
      list : TAsmList;
      cur_unit: tused_unit;
    begin
      inherited;

      list:=current_asmdata.asmlists[al_start];

      list.Concat(tai_globaltype.create(STACK_POINTER_SYM,wbt_i32));

      if ts_wasm_native_exceptions in current_settings.targetswitches then
        list.Concat(tai_tagtype.create('__FPC_exception', []));

      for i:=0 to current_module.deflist.Count-1 do
        begin
          def:=tdef(current_module.deflist[i]);
          { since commit 48986 deflist might have NIL entries }
          if assigned(def) and (def.typ=procdef) then
            begin
              proc := tprocdef(def);
              if po_external in proc.procoptions then
                if po_has_importdll in proc.procoptions then
                  WriteImportDll(list,proc)
                else
                  thlcgwasm(hlcg).g_procdef(list,proc);
            end;
         end;
      cur_unit:=tused_unit(usedunits.First);
      while assigned(cur_unit) do
        begin
          if (cur_unit.u.moduleflags * [mf_init,mf_finalize])<>[] then
            begin
              if mf_init in cur_unit.u.moduleflags then
                list.Concat(tai_functype.create(make_mangledname('INIT$',cur_unit.u.globalsymtable,''),TWasmFuncType.Create([],[])));
              if mf_finalize in cur_unit.u.moduleflags then
                list.Concat(tai_functype.create(make_mangledname('FINALIZE$',cur_unit.u.globalsymtable,''),TWasmFuncType.Create([],[])));
            end;
          for i:=0 to cur_unit.u.deflist.Count-1 do
            begin
              def:=tdef(cur_unit.u.deflist[i]);
              if assigned(def) and (tdef(def).typ = procdef) then
                begin
                  proc := tprocdef(def);
                  if (po_external in proc.procoptions) and (po_has_importdll in proc.procoptions) then
                    WriteImportDll(list,proc)
                  else if (not proc.owner.iscurrentunit or (po_external in proc.procoptions)) and
                     ((proc.paras.Count=0) or (proc.has_paraloc_info in [callerside,callbothsides])) then
                    thlcgwasm(hlcg).g_procdef(list,proc);
                end;
            end;
          cur_unit:=tused_unit(cur_unit.Next);
        end;
    end;

begin
  cnodeutils:=twasmnodeutils;
end.
