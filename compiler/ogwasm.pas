{
    Copyright (c) 2021 by Nikolay Nikolov

    Contains the WebAssembly binary module format reader and writer

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
unit ogwasm;

{$i fpcdefs.inc}

interface

    uses
      { common }
      cclasses,globtype,
      { target }
      systems,cpubase,
      { assembler }
      aasmbase,assemble,aasmcpu,
      { WebAssembly module format definitions }
      wasmbase,
      { output }
      ogbase,
      owbase;

    type
      TWasmObjSymbolExtraData = class;

      { TWasmObjSymbol }

      TWasmObjSymbol = class(TObjSymbol)
        FuncIndex: Integer;
        SymbolIndex: Integer;
        GlobalIndex: Integer;
        TagIndex: Integer;
        AliasOf: string;
        ExtraData: TWasmObjSymbolExtraData;
        constructor create(AList:TFPHashObjectList;const AName:string);override;
        function IsAlias: Boolean;
      end;

      { TWasmObjRelocation }

      TWasmObjRelocation = class(TObjRelocation)
      public
        TypeIndex: Integer;
        Addend: LongInt;
        constructor CreateTypeIndex(ADataOffset:TObjSectionOfs; ATypeIndex: Integer);
      end;

      { TWasmObjSymbolExtraData }

      TWasmObjSymbolExtraData = class(TFPHashObject)
        TypeIdx: Integer;
        ExceptionTagTypeIdx: Integer;
        ImportModule: string;
        ImportName: string;
        ExportName: string;
        GlobalType: TWasmBasicType;
        GlobalIsImmutable: Boolean;
        Locals: array of TWasmBasicType;
        constructor Create(HashObjectList: TFPHashObjectList; const s: TSymStr);
        procedure AddLocal(bastyp: TWasmBasicType);
      end;

      { TWasmObjSection }

      TWasmObjSection = class(TObjSection)
      public
        SegIdx: Integer;
        SegOfs: qword;
        FileSectionOfs: qword;
        function IsCode: Boolean;
        function IsData: Boolean;
      end;

      { TWasmObjData }

      TWasmObjData = class(TObjData)
      private
        FFuncTypes: array of TWasmFuncType;
        FObjSymbolsExtraDataList: TFPHashObjectList;
        FLastFuncName: string;

        function is_smart_section(atype:TAsmSectiontype):boolean;
        function sectionname_gas(atype:TAsmSectiontype;const aname:string;aorder:TAsmSectionOrder):string;
      public
        constructor create(const n:string);override;
        destructor destroy; override;
        function sectionname(atype:TAsmSectiontype;const aname:string;aorder:TAsmSectionOrder):string;override;
        procedure writeReloc(Data:TRelocDataInt;len:aword;p:TObjSymbol;Reloctype:TObjRelocationType);override;
        function AddOrCreateObjSymbolExtraData(const symname:TSymStr): TWasmObjSymbolExtraData;
        function AddFuncType(wft: TWasmFuncType): integer;
        function globalref(asmsym:TAsmSymbol):TObjSymbol;
        function ExceptionTagRef(asmsym:TAsmSymbol):TObjSymbol;
        procedure DeclareGlobalType(gt: tai_globaltype);
        procedure DeclareFuncType(ft: tai_functype);
        procedure DeclareTagType(tt: tai_tagtype);
        procedure DeclareExportName(en: tai_export_name);
        procedure DeclareImportModule(aim: tai_import_module);
        procedure DeclareImportName(ain: tai_import_name);
        procedure DeclareLocal(al: tai_local);
        procedure symbolpairdefine(akind: TSymbolPairKind;const asym, avalue: string);override;
      end;

      { TWasmObjOutput }

      TWasmObjOutput = class(tObjOutput)
      private
        FData: TWasmObjData;
        FWasmRelocationCodeTable: tdynamicarray;
        FWasmRelocationCodeTableEntriesCount: Integer;
        FWasmRelocationDataTable: tdynamicarray;
        FWasmRelocationDataTableEntriesCount: Integer;
        FWasmSymbolTable: tdynamicarray;
        FWasmSymbolTableEntriesCount: Integer;
        FWasmSections: array [TWasmSectionID] of tdynamicarray;
        FWasmCustomSections: array [TWasmCustomSectionType] of tdynamicarray;
        FWasmLinkingSubsections: array [low(TWasmLinkingSubsectionType)..high(TWasmLinkingSubsectionType)] of tdynamicarray;
        procedure WriteUleb(d: tdynamicarray; v: uint64);
        procedure WriteUleb(w: TObjectWriter; v: uint64);
        procedure WriteSleb(d: tdynamicarray; v: int64);
        procedure WriteByte(d: tdynamicarray; b: byte);
        procedure WriteName(d: tdynamicarray; const s: string);
        procedure WriteWasmSection(wsid: TWasmSectionID);
        procedure WriteWasmCustomSection(wcst: TWasmCustomSectionType);
        procedure CopyDynamicArray(src, dest: tdynamicarray; size: QWord);
        procedure WriteZeros(dest: tdynamicarray; size: QWord);
        procedure WriteWasmResultType(dest: tdynamicarray; wrt: TWasmResultType);
        procedure WriteWasmBasicType(dest: tdynamicarray; wbt: TWasmBasicType);
        function IsExternalFunction(sym: TObjSymbol): Boolean;
        function IsExportedFunction(sym: TWasmObjSymbol): Boolean;
        procedure WriteFunctionLocals(dest: tdynamicarray; ed: TWasmObjSymbolExtraData);
        procedure WriteFunctionCode(dest: tdynamicarray; objsym: TObjSymbol);
        procedure WriteSymbolTable;
        procedure WriteRelocationCodeTable(CodeSectionIndex: Integer);
        procedure WriteRelocationDataTable(DataSectionIndex: Integer);
        procedure WriteLinkingSubsection(wlst: TWasmLinkingSubsectionType);
        procedure DoRelocations;
        procedure WriteRelocations;
      protected
        function writeData(Data:TObjData):boolean;override;
      public
        constructor create(AWriter:TObjectWriter);override;
        destructor destroy;override;
      end;

      { TWasmAssembler }

      TWasmAssembler = class(tinternalassembler)
        constructor create(info: pasminfo; smart:boolean);override;
      end;

implementation

    uses
      verbose;

    procedure WriteUleb5(d: tdynamicarray; v: uint64);
      var
        b: byte;
        i: Integer;
      begin
        for i:=1 to 5 do
          begin
            b:=byte(v) and 127;
            v:=v shr 7;
            if i<>5 then
              b:=b or 128;
            d.write(b,1);
          end;
      end;

    procedure WriteUleb5(d: tobjsection; v: uint64);
      var
        b: byte;
        i: Integer;
      begin
        for i:=1 to 5 do
          begin
            b:=byte(v) and 127;
            v:=v shr 7;
            if i<>5 then
              b:=b or 128;
            d.write(b,1);
          end;
      end;

    procedure WriteSleb5(d: tdynamicarray; v: int64);
      var
        b: byte;
        i: Integer;
      begin
        for i:=1 to 5 do
          begin
            b:=byte(v) and 127;
            v:=SarInt64(v,7);
            if i<>5 then
              b:=b or 128;
            d.write(b,1);
          end;
      end;

    procedure WriteSleb5(d: tobjsection; v: int64);
      var
        b: byte;
        i: Integer;
      begin
        for i:=1 to 5 do
          begin
            b:=byte(v) and 127;
            v:=SarInt64(v,7);
            if i<>5 then
              b:=b or 128;
            d.write(b,1);
          end;
      end;

    function ReadUleb(d: tdynamicarray): uint64;
      var
        b: byte;
        shift:integer;
      begin
        b:=0;
        result:=0;
        shift:=0;
        repeat
          d.read(b,1);
          result:=result or (uint64(b and 127) shl shift);
          inc(shift,7);
        until (b and 128)=0;
      end;

    function ReadSleb(d: tdynamicarray): int64;
      var
        b: byte;
        shift:integer;
      begin
        b:=0;
        result:=0;
        shift:=0;
        repeat
          d.read(b,1);
          result:=result or (uint64(b and 127) shl shift);
          inc(shift,7);
        until (b and 128)=0;
        if (b and 64)<>0 then
          result:=result or (high(uint64) shl shift);
      end;

    procedure AddSleb5(d: tdynamicarray; v: int64);
      var
        q: Int64;
        p: LongWord;
      begin
        p:=d.Pos;
        q:=ReadSleb(d);
        q:=q+v;
        d.seek(p);
        WriteSleb5(d,q);
      end;

    procedure AddUleb5(d: tdynamicarray; v: int64);
      var
        q: UInt64;
        p: LongWord;
      begin
        p:=d.Pos;
        q:=ReadUleb(d);
        q:=q+v;
        d.seek(p);
        WriteUleb5(d,q);
      end;

    procedure AddInt32(d: tdynamicarray; v: int32);
      var
        q: int32;
        p: LongWord;
      begin
        p:=d.Pos;

        d.read(q,4);
{$ifdef FPC_BIG_ENDIAN}
        q:=SwapEndian(q);
{$endif FPC_BIG_ENDIAN}
        q:=q+v;
{$ifdef FPC_BIG_ENDIAN}
        q:=SwapEndian(q);
{$endif FPC_BIG_ENDIAN}

        d.seek(p);
        d.write(q,4);
      end;

{****************************************************************************
                             TWasmObjRelocation
****************************************************************************}

    constructor TWasmObjRelocation.CreateTypeIndex(ADataOffset: TObjSectionOfs; ATypeIndex: Integer);
      begin
        DataOffset:=ADataOffset;
        Symbol:=nil;
        OrgSize:=0;
        Group:=nil;
        ObjSection:=nil;
        ftype:=ord(RELOC_TYPE_INDEX_LEB);
        TypeIndex:=ATypeIndex;
      end;

{****************************************************************************
                               TWasmObjSymbol
****************************************************************************}

    constructor TWasmObjSymbol.create(AList: TFPHashObjectList; const AName: string);
      begin
        inherited create(AList,AName);
        FuncIndex:=-1;
        SymbolIndex:=-1;
        GlobalIndex:=-1;
        TagIndex:=-1;
        AliasOf:='';
        ExtraData:=nil;
      end;

    function TWasmObjSymbol.IsAlias: Boolean;
      begin
        result:=AliasOf<>'';
      end;

{****************************************************************************
                              TWasmObjSymbolExtraData
****************************************************************************}

    constructor TWasmObjSymbolExtraData.Create(HashObjectList: TFPHashObjectList; const s: TSymStr);
      begin
        inherited Create(HashObjectList,s);
        TypeIdx:=-1;
        ExceptionTagTypeIdx:=-1;
      end;

    procedure TWasmObjSymbolExtraData.AddLocal(bastyp: TWasmBasicType);
      begin
        SetLength(Locals,Length(Locals)+1);
        Locals[High(Locals)]:=bastyp;
      end;

{****************************************************************************
                              TWasmObjSection
****************************************************************************}

    function TWasmObjSection.IsCode: Boolean;
      const
        CodePrefix = '.text';
      begin
        result:=(Length(Name)>=Length(CodePrefix)) and
          (Copy(Name,1,Length(CodePrefix))=CodePrefix);
      end;

    function TWasmObjSection.IsData: Boolean;
      begin
        result:=not IsCode;
      end;

{****************************************************************************
                                TWasmObjData
****************************************************************************}

    function TWasmObjData.is_smart_section(atype: TAsmSectiontype): boolean;
      begin
        { For bss we need to set some flags that are target dependent,
          it is easier to disable it for smartlinking. It doesn't take up
          filespace }
        result:=not(target_info.system in systems_darwin) and
           create_smartlink_sections and
           (atype<>sec_toc) and
           (atype<>sec_user) and
           { on embedded systems every byte counts, so smartlink bss too }
           ((atype<>sec_bss) or (target_info.system in (systems_embedded+systems_freertos)));
      end;

    function TWasmObjData.sectionname_gas(atype: TAsmSectiontype;
        const aname: string; aorder: TAsmSectionOrder): string;
      const
        secnames : array[TAsmSectiontype] of string[length('__DATA, __datacoal_nt,coalesced')] = ('','',
          '.text',
          '.data',
{ why doesn't .rodata work? (FK) }
{ sometimes we have to create a data.rel.ro instead of .rodata, e.g. for  }
{ vtables (and anything else containing relocations), otherwise those are }
{ not relocated properly on e.g. linux/ppc64. g++ generates there for a   }
{ vtable for a class called Window:                                       }
{ .section .data.rel.ro._ZTV6Window,"awG",@progbits,_ZTV6Window,comdat    }
{ TODO: .data.ro not yet working}
{$if defined(arm) or defined(riscv64) or defined(powerpc)}
          '.rodata',
{$else defined(arm) or defined(riscv64) or defined(powerpc)}
          '.data',
{$endif defined(arm) or defined(riscv64) or defined(powerpc)}
          '.rodata',
          '.bss',
          '.threadvar',
          '.pdata',
          '', { stubs }
          '__DATA,__nl_symbol_ptr',
          '__DATA,__la_symbol_ptr',
          '__DATA,__mod_init_func',
          '__DATA,__mod_term_func',
          '.stab',
          '.stabstr',
          '.idata$2','.idata$4','.idata$5','.idata$6','.idata$7','.edata',
          '.eh_frame',
          '.debug_frame','.debug_info','.debug_line','.debug_abbrev','.debug_aranges','.debug_ranges',
          '.fpc',
          '.toc',
          '.init',
          '.fini',
          '.objc_class',
          '.objc_meta_class',
          '.objc_cat_cls_meth',
          '.objc_cat_inst_meth',
          '.objc_protocol',
          '.objc_string_object',
          '.objc_cls_meth',
          '.objc_inst_meth',
          '.objc_cls_refs',
          '.objc_message_refs',
          '.objc_symbols',
          '.objc_category',
          '.objc_class_vars',
          '.objc_instance_vars',
          '.objc_module_info',
          '.objc_class_names',
          '.objc_meth_var_types',
          '.objc_meth_var_names',
          '.objc_selector_strs',
          '.objc_protocol_ext',
          '.objc_class_ext',
          '.objc_property',
          '.objc_image_info',
          '.objc_cstring_object',
          '.objc_sel_fixup',
          '__DATA,__objc_data',
          '__DATA,__objc_const',
          '.objc_superrefs',
          '__DATA, __datacoal_nt,coalesced',
          '.objc_classlist',
          '.objc_nlclasslist',
          '.objc_catlist',
          '.obcj_nlcatlist',
          '.objc_protolist',
          '.stack',
          '.heap',
          '.gcc_except_table',
          '.ARM.attributes'
        );
      var
        sep     : string[3];
        secname : string;
      begin
        secname:=secnames[atype];

        if (atype=sec_fpc) and (Copy(aname,1,3)='res') then
          begin
            result:=secname+'.'+aname;
            exit;
          end;

        if atype=sec_threadvar then
          begin
            if (target_info.system in (systems_windows+systems_wince)) then
              secname:='.tls'
            else if (target_info.system in systems_linux) then
              secname:='.tbss';
          end;

        { go32v2 stub only loads .text and .data sections, and allocates space for .bss.
          Thus, data which normally goes into .rodata and .rodata_norel sections must
          end up in .data section }
        if (atype in [sec_rodata,sec_rodata_norel]) and
          (target_info.system in [system_i386_go32v2,system_m68k_palmos]) then
          secname:='.data';

        { Windows correctly handles reallocations in readonly sections }
        if (atype=sec_rodata) and
          (target_info.system in systems_all_windows+systems_nativent-[system_i8086_win16]) then
          secname:='.rodata';

        { section type user gives the user full controll on the section name }
        if atype=sec_user then
          secname:=aname;

        if is_smart_section(atype) and (aname<>'') then
          begin
            case aorder of
              secorder_begin :
                sep:='.b_';
              secorder_end :
                sep:='.z_';
              else
                sep:='.n_';
            end;
            result:=secname+sep+aname
          end
        else
          result:=secname;
      end;

    constructor TWasmObjData.create(const n: string);
      begin
        inherited;
        CObjSection:=TWasmObjSection;
        CObjSymbol:=TWasmObjSymbol;
        FObjSymbolsExtraDataList:=TFPHashObjectList.Create;
      end;

    destructor TWasmObjData.destroy;
      var
        i: Integer;
      begin
        FObjSymbolsExtraDataList.Free;
        for i:=low(FFuncTypes) to high(FFuncTypes) do
          begin
            FFuncTypes[i].free;
            FFuncTypes[i]:=nil;
          end;
        inherited destroy;
      end;

    function TWasmObjData.sectionname(atype: TAsmSectiontype;
        const aname: string; aorder: TAsmSectionOrder): string;
      begin
        if (atype=sec_fpc) or (atype=sec_threadvar) then
          atype:=sec_data;
        Result:=sectionname_gas(atype, aname, aorder);
      end;

    procedure TWasmObjData.writeReloc(Data: TRelocDataInt; len: aword;
        p: TObjSymbol; Reloctype: TObjRelocationType);
      const
        leb_zero: array[0..4] of byte=($80,$80,$80,$80,$00);
      var
        objreloc: TWasmObjRelocation;
      begin
        if CurrObjSec=nil then
          internalerror(200403072);
        objreloc:=nil;
        case Reloctype of
          RELOC_FUNCTION_INDEX_LEB:
            begin
              if Data<>0 then
                internalerror(2021092502);
              if len<>5 then
                internalerror(2021092503);
              if not assigned(p) then
                internalerror(2021092504);
              objreloc:=TWasmObjRelocation.CreateSymbol(CurrObjSec.Size,p,Reloctype);
              CurrObjSec.ObjRelocations.Add(objreloc);
              writebytes(leb_zero,5);
            end;
          RELOC_MEMORY_ADDR_LEB,
          RELOC_MEMORY_ADDR_OR_TABLE_INDEX_SLEB:
            begin
              if (Reloctype=RELOC_MEMORY_ADDR_LEB) and (Data<0) then
                internalerror(2021092602);
              if len<>5 then
                internalerror(2021092503);
              if not assigned(p) then
                internalerror(2021092504);
              objreloc:=TWasmObjRelocation.CreateSymbol(CurrObjSec.Size,p,Reloctype);
              objreloc.Addend:=Data;
              CurrObjSec.ObjRelocations.Add(objreloc);
              if RelocType=RELOC_MEMORY_ADDR_LEB then
                WriteUleb5(CurrObjSec,Data)
              else
                WriteSleb5(CurrObjSec,Data);
            end;
          RELOC_ABSOLUTE:
            begin
              if len<>4 then
                internalerror(2021092607);
              if not assigned(p) then
                internalerror(2021092608);
              objreloc:=TWasmObjRelocation.CreateSymbol(CurrObjSec.Size,p,Reloctype);
              objreloc.Addend:=Data;
              CurrObjSec.ObjRelocations.Add(objreloc);
              Data:=NtoLE(Data);
              writebytes(Data,4);
            end;
          RELOC_TYPE_INDEX_LEB:
            begin
              if len<>5 then
                internalerror(2021092612);
              if assigned(p) then
                internalerror(2021092613);
              objreloc:=TWasmObjRelocation.CreateTypeIndex(CurrObjSec.Size,Data);
              CurrObjSec.ObjRelocations.Add(objreloc);
              WriteUleb5(CurrObjSec,Data);
            end;
          RELOC_GLOBAL_INDEX_LEB:
            begin
              if len<>5 then
                internalerror(2021092701);
              if Data<>0 then
                internalerror(2021092702);
              if not assigned(p) then
                internalerror(2021092703);
              objreloc:=TWasmObjRelocation.CreateSymbol(CurrObjSec.Size,p,Reloctype);
              CurrObjSec.ObjRelocations.Add(objreloc);
              WriteUleb5(CurrObjSec,0);
            end;
          RELOC_TAG_INDEX_LEB:
            begin
              if len<>5 then
                internalerror(2021092712);
              if Data<>0 then
                internalerror(2021092713);
              if not assigned(p) then
                internalerror(2021092714);
              objreloc:=TWasmObjRelocation.CreateSymbol(CurrObjSec.Size,p,Reloctype);
              CurrObjSec.ObjRelocations.Add(objreloc);
              WriteSleb5(CurrObjSec,0);
            end;
          else
            internalerror(2021092501);
        end;
      end;

    function TWasmObjData.AddOrCreateObjSymbolExtraData(const symname: TSymStr): TWasmObjSymbolExtraData;
      begin
        result:=TWasmObjSymbolExtraData(FObjSymbolsExtraDataList.Find(symname));
        if not assigned(result) then
          result:=TWasmObjSymbolExtraData.Create(FObjSymbolsExtraDataList,symname);
      end;

    function TWasmObjData.AddFuncType(wft: TWasmFuncType): integer;
      var
        i: Integer;
      begin
        for i:=low(FFuncTypes) to high(FFuncTypes) do
          if wft.Equals(FFuncTypes[i]) then
            exit(i);

        result:=Length(FFuncTypes);
        SetLength(FFuncTypes,result+1);
        FFuncTypes[result]:=TWasmFuncType.Create(wft);
      end;

    function TWasmObjData.globalref(asmsym: TAsmSymbol): TObjSymbol;
      begin
        if assigned(asmsym) then
          begin
            if asmsym.typ<>AT_WASM_GLOBAL then
              internalerror(2021092706);
            result:=symbolref(asmsym);
            result.typ:=AT_WASM_GLOBAL;
          end
        else
          result:=nil;
      end;

    function TWasmObjData.ExceptionTagRef(asmsym: TAsmSymbol): TObjSymbol;
      begin
        if assigned(asmsym) then
          begin
            if asmsym.typ<>AT_WASM_EXCEPTION_TAG then
              internalerror(2021092707);
            result:=symbolref(asmsym);
            result.typ:=AT_WASM_EXCEPTION_TAG;
          end
        else
          result:=nil;
      end;

    procedure TWasmObjData.DeclareGlobalType(gt: tai_globaltype);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(gt.globalname);
        ObjSymExtraData.GlobalType:=gt.gtype;
        ObjSymExtraData.GlobalIsImmutable:=gt.immutable;
      end;

    procedure TWasmObjData.DeclareFuncType(ft: tai_functype);
      var
        i: Integer;
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        FLastFuncName:=ft.funcname;
        i:=AddFuncType(ft.functype);
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(ft.funcname);
        ObjSymExtraData.TypeIdx:=i;
      end;

    procedure TWasmObjData.DeclareTagType(tt: tai_tagtype);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
        ft: TWasmFuncType;
        i: Integer;
      begin
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(tt.tagname);
        ft:=TWasmFuncType.Create([],tt.params);
        i:=AddFuncType(ft);
        ft.free;
        ObjSymExtraData.ExceptionTagTypeIdx:=i;
      end;

    procedure TWasmObjData.DeclareExportName(en: tai_export_name);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(en.intname);
        ObjSymExtraData.ExportName:=en.extname;
      end;

    procedure TWasmObjData.DeclareImportModule(aim: tai_import_module);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(aim.symname);
        ObjSymExtraData.ImportModule:=aim.importmodule;
      end;

    procedure TWasmObjData.DeclareImportName(ain: tai_import_name);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        ObjSymExtraData:=AddOrCreateObjSymbolExtraData(ain.symname);
        ObjSymExtraData.ImportName:=ain.importname;
      end;

    procedure TWasmObjData.DeclareLocal(al: tai_local);
      var
        ObjSymExtraData: TWasmObjSymbolExtraData;
      begin
        ObjSymExtraData:=TWasmObjSymbolExtraData(FObjSymbolsExtraDataList.Find(FLastFuncName));
        ObjSymExtraData.AddLocal(al.bastyp);
      end;

    procedure TWasmObjData.symbolpairdefine(akind: TSymbolPairKind; const asym, avalue: string);
      var
        valsym: TObjSymbol;
        aliassym: TWasmObjSymbol;
      begin
        valsym:=CreateSymbol(avalue);
        aliassym:=TWasmObjSymbol(symboldefine(asym,valsym.bind,valsym.typ));
        aliassym.AliasOf:=valsym.Name;
      end;

{****************************************************************************
                               TWasmObjOutput
****************************************************************************}

    procedure TWasmObjOutput.WriteUleb(d: tdynamicarray; v: uint64);
      var
        b: byte;
      begin
        repeat
          b:=byte(v) and 127;
          v:=v shr 7;
          if v<>0 then
            b:=b or 128;
          d.write(b,1);
        until v=0;
      end;

    procedure TWasmObjOutput.WriteUleb(w: TObjectWriter; v: uint64);
      var
        b: byte;
      begin
        repeat
          b:=byte(v) and 127;
          v:=v shr 7;
          if v<>0 then
            b:=b or 128;
          w.write(b,1);
        until v=0;
      end;

    procedure TWasmObjOutput.WriteSleb(d: tdynamicarray; v: int64);
      var
        b: byte;
        Done: Boolean=false;
      begin
        repeat
          b:=byte(v) and 127;
          v:=SarInt64(v,7);
          if ((v=0) and ((b and 64)=0)) or ((v=-1) and ((b and 64)<>0)) then
            Done:=true
          else
            b:=b or 128;
          d.write(b,1);
        until Done;
      end;

    procedure TWasmObjOutput.WriteByte(d: tdynamicarray; b: byte);
      begin
        d.write(b,1);
      end;

    procedure TWasmObjOutput.WriteName(d: tdynamicarray; const s: string);
      begin
        WriteUleb(d,Length(s));
        d.writestr(s);
      end;

    procedure TWasmObjOutput.WriteWasmSection(wsid: TWasmSectionID);
      var
        b: byte;
      begin
        b:=ord(wsid);
        Writer.write(b,1);
        WriteUleb(Writer,FWasmSections[wsid].size);
        Writer.writearray(FWasmSections[wsid]);
      end;

    procedure TWasmObjOutput.WriteWasmCustomSection(wcst: TWasmCustomSectionType);
      var
        b: byte;
      begin
        b:=0;
        Writer.write(b,1);
        WriteUleb(Writer,FWasmCustomSections[wcst].size);
        Writer.writearray(FWasmCustomSections[wcst]);
      end;

    procedure TWasmObjOutput.CopyDynamicArray(src, dest: tdynamicarray; size: QWord);
      var
        buf: array [0..4095] of byte;
        bs: Integer;
      begin
        while size>0 do
          begin
            if size<SizeOf(buf) then
              bs:=Integer(size)
            else
              bs:=SizeOf(buf);
            src.read(buf,bs);
            dest.write(buf,bs);
            dec(size,bs);
          end;
      end;

    procedure TWasmObjOutput.WriteZeros(dest: tdynamicarray; size: QWord);
      var
        buf : array[0..1023] of byte;
        bs: Integer;
      begin
        fillchar(buf,sizeof(buf),0);
        while size>0 do
          begin
            if size<SizeOf(buf) then
              bs:=Integer(size)
            else
              bs:=SizeOf(buf);
            dest.write(buf,bs);
            dec(size,bs);
          end;
      end;

    procedure TWasmObjOutput.WriteWasmResultType(dest: tdynamicarray; wrt: TWasmResultType);
      var
        i: Integer;
      begin
        WriteUleb(dest,Length(wrt));
        for i:=low(wrt) to high(wrt) do
          WriteWasmBasicType(dest,wrt[i]);
      end;

    procedure TWasmObjOutput.WriteWasmBasicType(dest: tdynamicarray; wbt: TWasmBasicType);
      begin
        WriteByte(dest,encode_wasm_basic_type(wbt));
      end;

    function TWasmObjOutput.IsExternalFunction(sym: TObjSymbol): Boolean;
      var
        ExtraData: TWasmObjSymbolExtraData;
      begin
        if sym.bind=AB_EXTERNAL then
          begin
            ExtraData:=TWasmObjSymbolExtraData(TWasmObjData(sym.ObjData).FObjSymbolsExtraDataList.Find(sym.Name));
            result:=(ExtraData<>nil) and (ExtraData.TypeIdx<>-1);
          end
        else
          result:=false;

      end;

    function TWasmObjOutput.IsExportedFunction(sym: TWasmObjSymbol): Boolean;
      var
        ExtraData: TWasmObjSymbolExtraData;
      begin
        if (sym.typ=AT_FUNCTION) and not sym.IsAlias then
          begin
            ExtraData:=TWasmObjSymbolExtraData(TWasmObjData(sym.ObjData).FObjSymbolsExtraDataList.Find(sym.Name));
            result:=(ExtraData<>nil) and (ExtraData.ExportName<>'');
          end
        else
          result:=false;
      end;

    procedure TWasmObjOutput.WriteFunctionLocals(dest: tdynamicarray; ed: TWasmObjSymbolExtraData);
      var
        i,
        rle_entries,
        cnt: Integer;
        lasttype: TWasmBasicType;
      begin
        if Length(ed.Locals)=0 then
          begin
            WriteUleb(dest,0);
            exit;
          end;

        rle_entries:=1;
        for i:=low(ed.Locals)+1 to high(ed.Locals) do
          if ed.Locals[i]<>ed.Locals[i-1] then
            inc(rle_entries);

        WriteUleb(dest,rle_entries);
        lasttype:=ed.Locals[Low(ed.Locals)];
        cnt:=1;
        for i:=low(ed.Locals)+1 to high(ed.Locals) do
          if ed.Locals[i]=ed.Locals[i-1] then
            inc(cnt)
          else
            begin
              WriteUleb(dest,cnt);
              WriteWasmBasicType(dest,lasttype);
              lasttype:=ed.Locals[i];
              cnt:=1;
            end;
        WriteUleb(dest,cnt);
        WriteWasmBasicType(dest,lasttype);
      end;

    procedure TWasmObjOutput.WriteFunctionCode(dest: tdynamicarray; objsym: TObjSymbol);
      var
        encoded_locals: tdynamicarray;
        ObjSymExtraData: TWasmObjSymbolExtraData;
        codelen: LongWord;
        ObjSection: TWasmObjSection;
        codeexprlen: QWord;
      begin
        ObjSymExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
        ObjSection:=TWasmObjSection(objsym.objsection);
        ObjSection.Data.seek(objsym.address);
        codeexprlen:=objsym.size;

        encoded_locals:=tdynamicarray.Create(64);
        WriteFunctionLocals(encoded_locals,ObjSymExtraData);
        codelen:=encoded_locals.size+codeexprlen+1;
        WriteUleb(dest,codelen);
        encoded_locals.seek(0);
        CopyDynamicArray(encoded_locals,dest,encoded_locals.size);
        ObjSection.FileSectionOfs:=dest.size-objsym.offset;
        CopyDynamicArray(ObjSection.Data,dest,codeexprlen);
        WriteByte(dest,$0B);
        encoded_locals.Free;
      end;

    procedure TWasmObjOutput.WriteSymbolTable;
      begin
        WriteUleb(FWasmLinkingSubsections[WASM_SYMBOL_TABLE],FWasmSymbolTableEntriesCount);
        FWasmSymbolTable.seek(0);
        CopyDynamicArray(FWasmSymbolTable,FWasmLinkingSubsections[WASM_SYMBOL_TABLE],FWasmSymbolTable.size);
      end;

    procedure TWasmObjOutput.WriteRelocationCodeTable(CodeSectionIndex: Integer);
      begin
        WriteUleb(FWasmCustomSections[wcstRelocCode],CodeSectionIndex);
        WriteUleb(FWasmCustomSections[wcstRelocCode],FWasmRelocationCodeTableEntriesCount);
        FWasmRelocationCodeTable.seek(0);
        CopyDynamicArray(FWasmRelocationCodeTable,FWasmCustomSections[wcstRelocCode],FWasmRelocationCodeTable.size);
      end;

    procedure TWasmObjOutput.WriteRelocationDataTable(DataSectionIndex: Integer);
      begin
        WriteUleb(FWasmCustomSections[wcstRelocData],DataSectionIndex);
        WriteUleb(FWasmCustomSections[wcstRelocData],FWasmRelocationDataTableEntriesCount);
        FWasmRelocationDataTable.seek(0);
        CopyDynamicArray(FWasmRelocationDataTable,FWasmCustomSections[wcstRelocData],FWasmRelocationDataTable.size);
      end;

    procedure TWasmObjOutput.WriteLinkingSubsection(wlst: TWasmLinkingSubsectionType);
      begin
        if FWasmLinkingSubsections[wlst].size>0 then
          begin
            WriteByte(FWasmCustomSections[wcstLinking],Ord(wlst));
            WriteUleb(FWasmCustomSections[wcstLinking],FWasmLinkingSubsections[wlst].size);
            FWasmLinkingSubsections[wlst].seek(0);
            CopyDynamicArray(FWasmLinkingSubsections[wlst],FWasmCustomSections[wcstLinking],FWasmLinkingSubsections[wlst].size);
          end;
      end;

    procedure TWasmObjOutput.DoRelocations;
      var
        si, ri: Integer;
        objsec: TWasmObjSection;
        objrel: TWasmObjRelocation;
      begin
        for si:=0 to FData.ObjSectionList.Count-1 do
          begin
            objsec:=TWasmObjSection(FData.ObjSectionList[si]);
            for ri:=0 to objsec.ObjRelocations.Count-1 do
              begin
                objrel:=TWasmObjRelocation(objsec.ObjRelocations[ri]);
                case objrel.typ of
                  RELOC_FUNCTION_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092509);
                      objsec.Data.seek(objrel.DataOffset);
                      WriteUleb5(objsec.Data,TWasmObjSymbol(objrel.symbol).FuncIndex);
                    end;
                  RELOC_MEMORY_ADDR_OR_TABLE_INDEX_SLEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092605);
                      if not (IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) or (objrel.symbol.bind=AB_EXTERNAL)) then
                        begin
                          objsec.Data.seek(objrel.DataOffset);
                          AddSleb5(objsec.Data,objrel.symbol.offset+TWasmObjSection(objrel.symbol.objsection).SegOfs);
                        end;
                    end;
                  RELOC_MEMORY_ADDR_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092606);
                      if IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) then
                        internalerror(2021092628);
                      if objrel.symbol.bind<>AB_EXTERNAL then
                        begin
                          objsec.Data.seek(objrel.DataOffset);
                          AddUleb5(objsec.Data,objrel.symbol.offset+TWasmObjSection(objrel.symbol.objsection).SegOfs);
                        end;
                    end;
                  RELOC_ABSOLUTE:
                    begin
                      if not (IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) or (objrel.symbol.bind=AB_EXTERNAL)) then
                        begin
                          objsec.Data.seek(objrel.DataOffset);
                          AddInt32(objsec.Data,objrel.symbol.offset+TWasmObjSection(objrel.symbol.objsection).SegOfs);
                        end;
                    end;
                  RELOC_TYPE_INDEX_LEB:
                    ;
                  RELOC_GLOBAL_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092509);
                      objsec.Data.seek(objrel.DataOffset);
                      WriteUleb5(objsec.Data,TWasmObjSymbol(objrel.symbol).GlobalIndex);
                    end;
                  RELOC_TAG_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092716);
                      objsec.Data.seek(objrel.DataOffset);
                      WriteSleb5(objsec.Data,TWasmObjSymbol(objrel.symbol).TagIndex);
                    end;
                  else
                    internalerror(2021092510);
                end;
              end;
          end;
      end;

    procedure TWasmObjOutput.WriteRelocations;
      var
        si, ri: Integer;
        objsec: TWasmObjSection;
        objrel: TWasmObjRelocation;
        relout: tdynamicarray;
        relcount: PInteger;
      begin
        for si:=0 to FData.ObjSectionList.Count-1 do
          begin
            objsec:=TWasmObjSection(FData.ObjSectionList[si]);
            if objsec.IsCode then
              begin
                relout:=FWasmRelocationCodeTable;
                relcount:=@FWasmRelocationCodeTableEntriesCount;
              end
            else
              begin
                relout:=FWasmRelocationDataTable;
                relcount:=@FWasmRelocationDataTableEntriesCount;
              end;
            for ri:=0 to objsec.ObjRelocations.Count-1 do
              begin
                objrel:=TWasmObjRelocation(objsec.ObjRelocations[ri]);
                case objrel.typ of
                  RELOC_FUNCTION_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092508);
                      Inc(relcount^);
                      WriteByte(relout,Ord(R_WASM_FUNCTION_INDEX_LEB));
                      WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                      WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                    end;
                  RELOC_MEMORY_ADDR_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092603);
                      Inc(relcount^);
                      if IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) then
                        internalerror(2021092628);
                      WriteByte(relout,Ord(R_WASM_MEMORY_ADDR_LEB));
                      WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                      WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                      WriteSleb(relout,objrel.Addend);  { addend to add to the address }
                    end;
                  RELOC_MEMORY_ADDR_OR_TABLE_INDEX_SLEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092604);
                      Inc(relcount^);
                      if IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) then
                        begin
                          WriteByte(relout,Ord(R_WASM_TABLE_INDEX_SLEB));
                          WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                          WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                        end
                      else
                        begin
                          WriteByte(relout,Ord(R_WASM_MEMORY_ADDR_SLEB));
                          WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                          WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                          WriteSleb(relout,objrel.Addend);  { addend to add to the address }
                        end;
                    end;
                  RELOC_ABSOLUTE:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092604);
                      if IsExternalFunction(objrel.symbol) or (objrel.symbol.typ=AT_FUNCTION) then
                        begin
                          Inc(relcount^);
                          WriteByte(relout,Ord(R_WASM_TABLE_INDEX_I32));
                          WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                          WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                        end
                      else
                        begin
                          Inc(relcount^);
                          WriteByte(relout,Ord(R_WASM_MEMORY_ADDR_I32));
                          WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                          WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                          WriteSleb(relout,objrel.Addend);  { addend to add to the address }
                        end;
                    end;
                  RELOC_TYPE_INDEX_LEB:
                    begin
                      Inc(relcount^);
                      WriteByte(relout,Ord(R_WASM_TYPE_INDEX_LEB));
                      WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                      WriteUleb(relout,objrel.TypeIndex);
                    end;
                  RELOC_GLOBAL_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092704);
                      Inc(relcount^);
                      WriteByte(relout,Ord(R_WASM_GLOBAL_INDEX_LEB));
                      WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                      WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                    end;
                  RELOC_TAG_INDEX_LEB:
                    begin
                      if not assigned(objrel.symbol) then
                        internalerror(2021092717);
                      Inc(relcount^);
                      WriteByte(relout,Ord(R_WASM_TAG_INDEX_LEB));
                      WriteUleb(relout,objrel.DataOffset+objsec.FileSectionOfs);
                      WriteUleb(relout,TWasmObjSymbol(objrel.symbol).SymbolIndex);
                    end;
                  else
                    internalerror(2021092507);
                end;
              end;
          end;
      end;

    function TWasmObjOutput.writeData(Data:TObjData):boolean;
      var
        i: Integer;
        objsec: TWasmObjSection;
        segment_count: Integer = 0;
        cur_seg_ofs: qword = 0;
        types_count,
        imports_count, NextImportFunctionIndex, NextFunctionIndex,
        section_nr, code_section_nr, data_section_nr,
        NextGlobalIndex, NextTagIndex: Integer;
        import_globals_count: Integer = 0;
        globals_count: Integer = 0;
        import_functions_count: Integer = 0;
        export_functions_count: Integer = 0;
        functions_count: Integer = 0;
        import_exception_tags_count: Integer = 0;
        exception_tags_count: Integer = 0;
        objsym, ObjSymAlias: TWasmObjSymbol;
        cust_sec: TWasmCustomSectionType;
      begin
        FData:=TWasmObjData(Data);

        { each custom sections starts with its name }
        for cust_sec in TWasmCustomSectionType do
          WriteName(FWasmCustomSections[cust_sec],WasmCustomSectionName[cust_sec]);

        WriteUleb(FWasmCustomSections[wcstLinking],2);  { linking metadata version }

        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if objsym.typ=AT_WASM_EXCEPTION_TAG then
              if objsym.bind=AB_EXTERNAL then
                Inc(import_exception_tags_count)
              else
                Inc(exception_tags_count);
            if objsym.typ=AT_WASM_GLOBAL then
              if objsym.bind=AB_EXTERNAL then
                Inc(import_globals_count)
              else
                Inc(globals_count);
            if IsExternalFunction(objsym) then
              Inc(import_functions_count);
            if (objsym.typ=AT_FUNCTION) and not objsym.IsAlias then
              Inc(functions_count);
            if IsExportedFunction(objsym) then
              Inc(export_functions_count);
          end;

        types_count:=Length(FData.FFuncTypes);
        WriteUleb(FWasmSections[wsiType],types_count);
        for i:=0 to types_count-1 do
          with FData.FFuncTypes[i] do
            begin
              WriteByte(FWasmSections[wsiType],$60);
              WriteWasmResultType(FWasmSections[wsiType],params);
              WriteWasmResultType(FWasmSections[wsiType],results);
            end;

        for i:=0 to Data.ObjSectionList.Count-1 do
          begin
            objsec:=TWasmObjSection(Data.ObjSectionList[i]);
            if objsec.IsCode then
              objsec.SegIdx:=-1
            else
              begin
                objsec.SegIdx:=segment_count;
                objsec.SegOfs:=cur_seg_ofs;
                Inc(segment_count);
                Inc(cur_seg_ofs,objsec.Size);
              end;
          end;

        if segment_count>0 then
          begin
            WriteUleb(FWasmSections[wsiData],segment_count);
            WriteUleb(FWasmSections[wsiDataCount],segment_count);
            WriteUleb(FWasmLinkingSubsections[WASM_SEGMENT_INFO],segment_count);
            for i:=0 to Data.ObjSectionList.Count-1 do
              begin
                objsec:=TWasmObjSection(Data.ObjSectionList[i]);
                if objsec.IsData then
                  begin
                    WriteName(FWasmLinkingSubsections[WASM_SEGMENT_INFO],objsec.Name);
                    WriteUleb(FWasmLinkingSubsections[WASM_SEGMENT_INFO],BsrQWord(objsec.SecAlign));
                    WriteUleb(FWasmLinkingSubsections[WASM_SEGMENT_INFO],0);  { flags }

                    WriteByte(FWasmSections[wsiData],0);
                    WriteByte(FWasmSections[wsiData],$41);
                    WriteSleb(FWasmSections[wsiData],objsec.SegOfs);
                    WriteByte(FWasmSections[wsiData],$0b);
                    WriteUleb(FWasmSections[wsiData],objsec.Size);
                    objsec.FileSectionOfs:=FWasmSections[wsiData].size;
                    if oso_Data in objsec.SecOptions then
                      begin
                        objsec.Data.seek(0);
                        CopyDynamicArray(objsec.Data,FWasmSections[wsiData],objsec.Size);
                      end
                    else
                      begin
                        WriteZeros(FWasmSections[wsiData],objsec.Size);
                      end;
                  end;
              end;
          end;

        imports_count:=2+import_globals_count+import_functions_count+import_exception_tags_count;
        WriteUleb(FWasmSections[wsiImport],imports_count);
        { import memories }
        WriteName(FWasmSections[wsiImport],'env');
        WriteName(FWasmSections[wsiImport],'__linear_memory');
        WriteByte(FWasmSections[wsiImport],$02);  { mem }
        WriteByte(FWasmSections[wsiImport],$00);  { min }
        WriteUleb(FWasmSections[wsiImport],1);    { 1 page }
        { import globals }
        NextGlobalIndex:=0;
        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if (objsym.bind=AB_EXTERNAL) and (objsym.typ=AT_WASM_GLOBAL) then
              begin
                objsym.GlobalIndex:=NextGlobalIndex;
                Inc(NextGlobalIndex);
                objsym.ExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
                if objsym.ExtraData.ImportModule<>'' then
                  WriteName(FWasmSections[wsiImport],objsym.ExtraData.ImportModule)
                else
                  WriteName(FWasmSections[wsiImport],'env');
                WriteName(FWasmSections[wsiImport],objsym.Name);
                WriteByte(FWasmSections[wsiImport],$03);  { global }
                WriteWasmBasicType(FWasmSections[wsiImport],objsym.ExtraData.GlobalType);
                if objsym.ExtraData.GlobalIsImmutable then
                  WriteByte(FWasmSections[wsiImport],$00)   { const }
                else
                  WriteByte(FWasmSections[wsiImport],$01);  { var }
              end;
          end;
        { import functions }
        NextImportFunctionIndex:=0;
        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if IsExternalFunction(objsym) then
              begin
                objsym.FuncIndex:=NextImportFunctionIndex;
                Inc(NextImportFunctionIndex);
                objsym.ExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
                if objsym.ExtraData.ImportModule<>'' then
                  WriteName(FWasmSections[wsiImport],objsym.ExtraData.ImportModule)
                else
                  WriteName(FWasmSections[wsiImport],'env');
                WriteName(FWasmSections[wsiImport],objsym.Name);
                WriteByte(FWasmSections[wsiImport],$00);  { func }
                WriteUleb(FWasmSections[wsiImport],TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name)).TypeIdx);
              end;
          end;
        { import tables }
        WriteName(FWasmSections[wsiImport],'env');
        WriteName(FWasmSections[wsiImport],'__indirect_function_table');
        WriteByte(FWasmSections[wsiImport],$01);  { table }
        WriteByte(FWasmSections[wsiImport],$70);  { funcref }
        WriteByte(FWasmSections[wsiImport],$00);  { min }
        WriteUleb(FWasmSections[wsiImport],1);    { 1 }
        { import tags }
        NextTagIndex:=0;
        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if (objsym.typ=AT_WASM_EXCEPTION_TAG) and (objsym.bind=AB_EXTERNAL) then
              begin
                objsym.TagIndex:=NextTagIndex;
                Inc(NextTagIndex);
                objsym.ExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
                if objsym.ExtraData.ImportModule<>'' then
                  WriteName(FWasmSections[wsiImport],objsym.ExtraData.ImportModule)
                else
                  WriteName(FWasmSections[wsiImport],'env');
                WriteName(FWasmSections[wsiImport],objsym.Name);
                WriteByte(FWasmSections[wsiImport],$04);  { tag }
                WriteByte(FWasmSections[wsiImport],$00);  { exception }
                WriteUleb(FWasmSections[wsiImport],objsym.ExtraData.ExceptionTagTypeIdx);
              end;
          end;

        WriteUleb(FWasmSections[wsiFunction],functions_count);
        NextFunctionIndex:=NextImportFunctionIndex;
        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if (objsym.typ=AT_FUNCTION) and not objsym.IsAlias then
              begin
                objsym.FuncIndex:=NextFunctionIndex;
                Inc(NextFunctionIndex);
                WriteUleb(FWasmSections[wsiFunction],TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name)).TypeIdx);
              end;
          end;

        if exception_tags_count>0 then
          begin
            WriteUleb(FWasmSections[wsiTag],exception_tags_count);
            for i:=0 to Data.ObjSymbolList.Count-1 do
              begin
                objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
                if (objsym.typ=AT_WASM_EXCEPTION_TAG) and (objsym.bind<>AB_EXTERNAL) then
                  begin
                    objsym.TagIndex:=NextTagIndex;
                    Inc(NextTagIndex);
                    objsym.ExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
                    WriteByte(FWasmSections[wsiTag],$00);  { exception }
                    WriteUleb(FWasmSections[wsiTag],objsym.ExtraData.ExceptionTagTypeIdx);
                  end;
              end;
          end;

        if globals_count>0 then
          begin
            WriteUleb(FWasmSections[wsiGlobal],globals_count);
            for i:=0 to Data.ObjSymbolList.Count-1 do
              begin
                objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
                if (objsym.typ=AT_WASM_GLOBAL) and (objsym.bind<>AB_EXTERNAL) then
                  begin
                    objsym.GlobalIndex:=NextGlobalIndex;
                    Inc(NextGlobalIndex);
                    objsym.ExtraData:=TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name));
                    WriteWasmBasicType(FWasmSections[wsiGlobal],objsym.ExtraData.GlobalType);
                    if objsym.ExtraData.GlobalIsImmutable then
                      WriteByte(FWasmSections[wsiGlobal],$00)   { const }
                    else
                      WriteByte(FWasmSections[wsiGlobal],$01);  { var }
                    { init expr }
                    case objsym.ExtraData.GlobalType of
                      wbt_i32:
                        begin
                          WriteByte(FWasmSections[wsiGlobal],$41);  { i32.const }
                          WriteByte(FWasmSections[wsiGlobal],0);    { 0 (in signed LEB128 format) }
                          WriteByte(FWasmSections[wsiGlobal],$0B);  { end }
                        end;
                      wbt_i64:
                        begin
                          WriteByte(FWasmSections[wsiGlobal],$42);  { i64.const }
                          WriteByte(FWasmSections[wsiGlobal],0);    { 0 (in signed LEB128 format) }
                          WriteByte(FWasmSections[wsiGlobal],$0B);  { end }
                        end;
                      wbt_f32:
                        begin
                          WriteByte(FWasmSections[wsiGlobal],$43);  { f32.const }
                          WriteByte(FWasmSections[wsiGlobal],$00);  { 0 (in little endian IEEE single precision floating point format) }
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$0B);  { end }
                        end;
                      wbt_f64:
                        begin
                          WriteByte(FWasmSections[wsiGlobal],$44);  { f64.const }
                          WriteByte(FWasmSections[wsiGlobal],$00);  { 0 (in little endian IEEE double precision floating point format) }
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$00);
                          WriteByte(FWasmSections[wsiGlobal],$0B);  { end }
                        end;
                    end;
                  end;
              end;
          end;

        if export_functions_count>0 then
          begin
            WriteUleb(FWasmSections[wsiExport],export_functions_count);
            for i:=0 to Data.ObjSymbolList.Count-1 do
              begin
                objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
                if IsExportedFunction(objsym) then
                  begin
                    WriteName(FWasmSections[wsiExport],TWasmObjSymbolExtraData(FData.FObjSymbolsExtraDataList.Find(objsym.Name)).ExportName);
                    WriteByte(FWasmSections[wsiExport],0);  { func }
                    WriteUleb(FWasmSections[wsiExport],objsym.FuncIndex);
                  end;
              end;
          end;

        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if objsym.typ=AT_WASM_EXCEPTION_TAG then
              begin
                objsym.SymbolIndex:=FWasmSymbolTableEntriesCount;
                Inc(FWasmSymbolTableEntriesCount);
                WriteByte(FWasmSymbolTable,Ord(SYMTAB_EVENT));
                if objsym.bind=AB_GLOBAL then
                  WriteUleb(FWasmSymbolTable,0)
                else if objsym.bind=AB_LOCAL then
                  WriteUleb(FWasmSymbolTable,WASM_SYM_BINDING_LOCAL)
                else if objsym.bind=AB_EXTERNAL then
                  WriteUleb(FWasmSymbolTable,WASM_SYM_UNDEFINED)
                else if objsym.bind=AB_WEAK then
                  WriteUleb(FWasmSymbolTable,WASM_SYM_BINDING_WEAK)
                else
                  internalerror(2021092715);
                WriteUleb(FWasmSymbolTable,objsym.TagIndex);
                if objsym.bind<>AB_EXTERNAL then
                  WriteName(FWasmSymbolTable,objsym.Name);
              end
            else if objsym.typ=AT_WASM_GLOBAL then
              begin
                objsym.SymbolIndex:=FWasmSymbolTableEntriesCount;
                Inc(FWasmSymbolTableEntriesCount);
                WriteByte(FWasmSymbolTable,Ord(SYMTAB_GLOBAL));
                if objsym.bind=AB_EXTERNAL then
                  begin
                    WriteUleb(FWasmSymbolTable,WASM_SYM_UNDEFINED);
                    WriteUleb(FWasmSymbolTable,objsym.GlobalIndex);
                  end
                else
                  {not implemented yet}
                  internalerror(2021092705);
              end
            else if IsExternalFunction(objsym) then
              begin
                objsym.SymbolIndex:=FWasmSymbolTableEntriesCount;
                Inc(FWasmSymbolTableEntriesCount);
                WriteByte(FWasmSymbolTable,Ord(SYMTAB_FUNCTION));
                if objsym.ExtraData.ImportModule<>'' then
                  begin
                    WriteUleb(FWasmSymbolTable,WASM_SYM_UNDEFINED or WASM_SYM_EXPLICIT_NAME);
                    WriteUleb(FWasmSymbolTable,objsym.FuncIndex);
                    WriteName(FWasmSymbolTable,objsym.Name);
                  end
                else
                  begin
                    WriteUleb(FWasmSymbolTable,WASM_SYM_UNDEFINED);
                    WriteUleb(FWasmSymbolTable,objsym.FuncIndex);
                  end;
              end
            else if objsym.typ=AT_FUNCTION then
              begin
                objsym.SymbolIndex:=FWasmSymbolTableEntriesCount;
                Inc(FWasmSymbolTableEntriesCount);
                WriteByte(FWasmSymbolTable,Ord(SYMTAB_FUNCTION));
                if objsym.IsAlias then
                  begin
                    ObjSymAlias:=TWasmObjSymbol(Data.ObjSymbolList.Find(objsym.AliasOf));
                    ObjSym.FuncIndex:=ObjSymAlias.FuncIndex;
                    WriteUleb(FWasmSymbolTable,WASM_SYM_EXPLICIT_NAME or WASM_SYM_NO_STRIP);
                    WriteUleb(FWasmSymbolTable,ObjSymAlias.FuncIndex);
                  end
                else
                  begin
                    if IsExportedFunction(objsym) then
                      WriteUleb(FWasmSymbolTable,WASM_SYM_EXPORTED)
                    else
                      WriteUleb(FWasmSymbolTable,0);
                    WriteUleb(FWasmSymbolTable,objsym.FuncIndex);
                  end;
                WriteName(FWasmSymbolTable,objsym.Name);
              end
            else if (objsym.typ in [AT_DATA,AT_TLS]) or ((objsym.typ=AT_NONE) and (objsym.bind=AB_EXTERNAL)) then
              begin
                objsym.SymbolIndex:=FWasmSymbolTableEntriesCount;
                Inc(FWasmSymbolTableEntriesCount);
                WriteByte(FWasmSymbolTable,Ord(SYMTAB_DATA));
                if objsym.bind=AB_GLOBAL then
                  WriteUleb(FWasmSymbolTable,0)
                else if objsym.bind=AB_LOCAL then
                  WriteUleb(FWasmSymbolTable,WASM_SYM_BINDING_LOCAL)
                else if objsym.bind=AB_EXTERNAL then
                  WriteUleb(FWasmSymbolTable,WASM_SYM_UNDEFINED)
                else
                  internalerror(2021092506);
                WriteName(FWasmSymbolTable,objsym.Name);
                if objsym.bind<>AB_EXTERNAL then
                  begin
                    WriteUleb(FWasmSymbolTable,TWasmObjSection(objsym.objsection).SegIdx);
                    WriteUleb(FWasmSymbolTable,objsym.offset);
                    WriteUleb(FWasmSymbolTable,objsym.size);
                  end;
              end;
          end;

        DoRelocations;

        WriteUleb(FWasmSections[wsiCode],functions_count);
        for i:=0 to Data.ObjSymbolList.Count-1 do
          begin
            objsym:=TWasmObjSymbol(Data.ObjSymbolList[i]);
            if (objsym.typ=AT_FUNCTION) and not objsym.IsAlias then
              WriteFunctionCode(FWasmSections[wsiCode],objsym);
          end;

        WriteRelocations;

        WriteSymbolTable;
        WriteLinkingSubsection(WASM_SYMBOL_TABLE);
        if segment_count>0 then
          WriteLinkingSubsection(WASM_SEGMENT_INFO);

        Writer.write(WasmModuleMagic,SizeOf(WasmModuleMagic));
        Writer.write(WasmVersion,SizeOf(WasmVersion));

        code_section_nr:=-1;
        data_section_nr:=-1;
        section_nr:=0;

        WriteWasmSection(wsiType);
        Inc(section_nr);
        WriteWasmSection(wsiImport);
        Inc(section_nr);
        WriteWasmSection(wsiFunction);
        Inc(section_nr);
        if exception_tags_count>0 then
          begin
            WriteWasmSection(wsiTag);
            Inc(section_nr);
          end;
        if globals_count>0 then
          begin
            WriteWasmSection(wsiGlobal);
            Inc(section_nr);
          end;
        if export_functions_count>0 then
          begin
            WriteWasmSection(wsiExport);
            Inc(section_nr);
          end;
        if segment_count>0 then
          begin
            WriteWasmSection(wsiDataCount);
            Inc(section_nr);
          end;
        WriteWasmSection(wsiCode);
        code_section_nr:=section_nr;
        Inc(section_nr);
        if segment_count>0 then
          begin
            WriteWasmSection(wsiData);
            data_section_nr:=section_nr;
            Inc(section_nr);
          end;

        WriteRelocationCodeTable(code_section_nr);
        if segment_count>0 then
          WriteRelocationDataTable(data_section_nr);

        WriteWasmCustomSection(wcstLinking);
        Inc(section_nr);
        WriteWasmCustomSection(wcstRelocCode);
        Inc(section_nr);
        if segment_count>0 then
          begin
            WriteWasmCustomSection(wcstRelocData);
            Inc(section_nr);
          end;

        result:=true;
      end;

    constructor TWasmObjOutput.create(AWriter: TObjectWriter);
      var
        i: TWasmSectionID;
        j: TWasmCustomSectionType;
        k: TWasmLinkingSubsectionType;
      begin
        inherited;
        cobjdata:=TWasmObjData;
        for i in TWasmSectionID do
          FWasmSections[i] := tdynamicarray.create(SectionDataMaxGrow);
        for j in TWasmCustomSectionType do
          FWasmCustomSections[j] := tdynamicarray.create(SectionDataMaxGrow);
        for k:=low(TWasmLinkingSubsectionType) to high(TWasmLinkingSubsectionType) do
          FWasmLinkingSubsections[k] := tdynamicarray.create(SectionDataMaxGrow);
        FWasmSymbolTable:=tdynamicarray.create(SectionDataMaxGrow);
        FWasmSymbolTableEntriesCount:=0;
        FWasmRelocationCodeTable:=tdynamicarray.create(SectionDataMaxGrow);
        FWasmRelocationCodeTableEntriesCount:=0;
        FWasmRelocationDataTable:=tdynamicarray.create(SectionDataMaxGrow);
        FWasmRelocationDataTableEntriesCount:=0;
      end;

    destructor TWasmObjOutput.destroy;
      var
        i: TWasmSectionID;
        j: TWasmCustomSectionType;
        k: TWasmLinkingSubsectionType;
      begin
        for i in TWasmSectionID do
          FWasmSections[i].Free;
        for j in TWasmCustomSectionType do
          FWasmCustomSections[j].Free;
        for k:=low(TWasmLinkingSubsectionType) to high(TWasmLinkingSubsectionType) do
          FWasmLinkingSubsections[k].Free;
        FWasmSymbolTable.Free;
        FWasmRelocationCodeTable.Free;
        FWasmRelocationDataTable.Free;
        inherited destroy;
      end;

{****************************************************************************
                               TWasmAssembler
****************************************************************************}

    constructor TWasmAssembler.Create(info: pasminfo; smart:boolean);
      begin
        inherited;
        CObjOutput:=TWasmObjOutput;
      end;

{*****************************************************************************
                                  Initialize
*****************************************************************************}
{$ifdef wasm32}
    const
       as_wasm32_wasm_info : tasminfo =
          (
            id     : as_wasm32_wasm;
            idtxt  : 'OMF';
            asmbin : '';
            asmcmd : '';
            supported_targets : [system_wasm32_embedded,system_wasm32_wasi];
            flags : [af_outputbinary,af_smartlink_sections];
            labelprefix : '..@';
            labelmaxlen : -1;
            comment : '; ';
            dollarsign: '$';
          );
{$endif wasm32}

initialization
{$ifdef wasm32}
  RegisterAssembler(as_wasm32_wasm_info,TWasmAssembler);
{$endif wasm32}
end.
