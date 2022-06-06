{
    Copyright (c) 2010, 2013, 2015 by Jonas Maebe

    Basic Processor information for LLVM

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

{$i fpcdefs.inc}

Unit llvminfo;

Interface

uses
  globtype;

Type
   { possible supported processors for this target }
   tllvmversion =
      (llvmver_invalid,
       { Xcode versions use snapshots of LLVM and don't correspond to released
         versions of llvm (they don't ship with the llvm utilities either, but
         they do come with Clang, which can be used instead of opt/llc) }
       llvmver_xc_10_0,
       llvmver_xc_10_1,
       llvmver_7_0,
       llvmver_7_1,
       llvmver_8_0,
       llvmver_xc_11,
       llvmver_9_0,
       llvmver_xc_11_4,
       llvmver_10_0,
       llvmver_xc_12,
       llvmver_11_0,
       llvmver_11_1,
       llvmver_xc_12_5,
       llvmver_12_0,
       llvmver_xc_13,
       llvmver_13_0,
       llvmver_xc_13_3,
       llvmver_14_0
      );

type
   tllvmversionflag = (
     llvmflag_memcpy_indiv_align,           { memcpy intrinsic supports separate alignment for source and dest }
     llvmflag_null_pointer_valid,           { supports "null-pointer-is-valid" attribute, which indicates access to nil should not be optimized as undefined behaviour }
     llvmflag_constrained_fptrunc_fpext,    { supports constrained fptrunc and fpext intrinsics }
     llvmflag_constrained_fptoi_itofp,      { supports constrained fptosi/fptoui/uitofp/sitofp instrinsics }
     llvmflag_generic_constrained_si64tofp, { supports sitofp for 64 bit signed integers on all targets }
     llvmflag_null_pointer_valid_new,       { new syntax for the null pointer valid attribute: null_pointer_is_valid }
     llvmflag_array_datalocation,           { arrays debug info supports a dataLocation attribute to specify how to obtain the array data based on the array variable }
     llvmflag_NoDISPFlags,                  { no DI sub program flags, but separate fields }
     llvmflag_NoDISPFlagMainSubprogram,     { MainSubprogram still in DIFlags instead of DISPFlags }
     llvmflag_para_attr_type,               { parameter attributes such as noalias and byval need to repeat the type }
     llvmflag_opaque_ptr_transition         { initial opaque pointer introduction, needs to some elementtype attributes }
   );
   tllvmversionflags = set of tllvmversionflag;

Const
   llvmversionstr : array[tllvmversion] of string[14] = (
     '',
     'Xcode-10.0',
     'Xcode-10.1',
     '7.0',
     '7.1',
     '8.0',
     'Xcode-11.0',
     '9.0',
     'Xcode-11.4',
     '10.0',
     'Xcode-12.0',
     '11.0',
     '11.1',
     'Xcode-12.5',
     '12.0',
     'Xcode-13.0',
     '13.0',
     'Xcode-13.3',
     '14.0'
   );

   llvm_debuginfo_metadata_format : array[tllvmversion] of byte = (
     0,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3,
     3
   );

   llvmversion_properties: array[tllvmversion] of tllvmversionflags =
     (
       { invalid         } [],
       { llvmver_xc_10_0 } [llvmflag_NoDISPFlags],
       { llvmver_xc_10_1 } [llvmflag_NoDISPFlags],
       { llvmver_7_0     } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_NoDISPFlags],
       { llvmver_7_1     } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_NoDISPFlags],
       { llvmver_8_0     } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_NoDISPFlagMainSubprogram],
       { llvmver_xc_11   } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_NoDISPFlagMainSubprogram],
       { llvmver_9_0     } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_constrained_fptrunc_fpext],
       { llvmver_xc_11_4 } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_constrained_fptrunc_fpext],
       { llvmver_10_0    } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp],
       { llvmver_xc_12_0 } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp],
       { llvmver_11_0    } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation],
       { llvmver_11_1    } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation],
       { llvmver_xc_12_5 } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation],
       { llvmver_12_0    } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation,llvmflag_para_attr_type],
       { llvmver_xc_13_0 } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation,llvmflag_para_attr_type],
       { llvmver_13_0    } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation,llvmflag_para_attr_type],
       { llvmver_xc_13_3 } [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation,llvmflag_para_attr_type],
       { llvmver_14_0 }    [llvmflag_memcpy_indiv_align,llvmflag_null_pointer_valid_new,llvmflag_constrained_fptrunc_fpext,llvmflag_constrained_fptoi_itofp,llvmflag_array_datalocation,llvmflag_para_attr_type,llvmflag_opaque_ptr_transition]
     );

   { Supported optimizations, only used for information }
   supported_optimizerswitches = genericlevel1optimizerswitches+
                                 genericlevel2optimizerswitches+
                                 genericlevel3optimizerswitches-
                                 { no need to write info about those }
                                 [cs_opt_level1,cs_opt_level2,cs_opt_level3]+
                                 [cs_opt_loopunroll,cs_opt_stackframe,
				  cs_opt_nodecse,cs_opt_reorder_fields,cs_opt_fastmath];

   level1optimizerswitches = genericlevel1optimizerswitches;
   level2optimizerswitches = genericlevel2optimizerswitches + level1optimizerswitches + [cs_opt_nodecse,cs_opt_stackframe];
   level3optimizerswitches = genericlevel3optimizerswitches + level2optimizerswitches + [];
   level4optimizerswitches = genericlevel4optimizerswitches + level3optimizerswitches + [];

   function llvmversion2enum(const s: string): tllvmversion;

Implementation

  function llvmversion2enum(const s: string): tllvmversion;
    begin
      for result:=succ(low(llvmversionstr)) to high(llvmversionstr) do
        begin
          if s=llvmversionstr[result] then
            exit;
        end;
      result:=llvmver_invalid;
    end;

end.
