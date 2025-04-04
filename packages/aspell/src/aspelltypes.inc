    type
      PAspellCanHaveError  = Pointer;
      PAspellConfig  = Pointer;
      PAspellDictInfoEnumeration  = Pointer;
      PAspellDictInfoList  = Pointer;
      PAspellDocumentChecker  = Pointer;
      PAspellFilter  = Pointer;
      PAspellKeyInfoEnumeration  = Pointer;
      PAspellModuleInfoEnumeration  = Pointer;
      PAspellModuleInfoList  = Pointer;
      PAspellMutableContainer  = Pointer;
      PAspellSpeller  = Pointer;
      PAspellStringEnumeration  = Pointer;
      PAspellStringList  = Pointer;
      PAspellStringMap  = Pointer;
      PAspellStringPairEnumeration  = Pointer;
      PAspellWordList  = Pointer;

  {****************************** type id ****************************** }

   type
     PAspellTypeId = ^AspellTypeId;
     AspellTypeId = record
         case longint of
            0 : ( num : cuint );
            1 : ( str : array[0..3] of AnsiChar );
         end;

    {****************************** key info ****************************** }

       PAspellKeyInfoType = ^AspellKeyInfoType;
       AspellKeyInfoType = (AspellKeyInfoString,AspellKeyInfoInt,
         AspellKeyInfoBool,AspellKeyInfoList
         );

    { A brief description of the key or NULL if internal value.  }

       PAspellKeyInfo = ^AspellKeyInfo;
       AspellKeyInfo = record
            name : PAnsiChar;
            _type : AspellKeyInfoType;
            def : PAnsiChar;
            desc : PAnsiChar;
            flags : cint;
            other_data : cint;
         end;

    {****************************** error ****************************** }

       PAspellErrorInfo = ^AspellErrorInfo;
       AspellErrorInfo = record
            isa : PAspellErrorInfo;
            mesg : PAnsiChar;
            num_parms : cuint;
            parms : array[0..2] of PAnsiChar;
         end;

       PAspellError = ^AspellError;
       AspellError = record
            mesg : PAnsiChar;
            err : PAspellErrorInfo;
         end;

    {****************************** token ****************************** }

       PAspellToken = ^AspellToken;
       AspellToken = record
            offset : cuint;
            len : cuint;
         end;

    {*************************** module/dict *************************** }

       PAspellModuleInfo = ^AspellModuleInfo;
       AspellModuleInfo = record
            name : PAnsiChar;
            order_num : double;
            lib_dir : PAnsiChar;
            dict_dirs : PAspellStringList;
            dict_exts : PAspellStringList;
         end;

    { The Name to identify this dictionary by.  }

    { The language code to identify this dictionary.
       * A two letter UPPER-CASE ISO 639 language code
       * and an optional two letter ISO 3166 country
       * code after a dash or underscore.  }

    { Any extra information to distinguish this
       * variety of dictionary from other dictionaries
       * which may have the same language and size.  }

    { A two AnsiChar digit code describing the size of
       * the dictionary: 10=tiny, 20=really small,
       * 30=small, 40=med-small, 50=med, 60=med-large,
       * 70=large, 80=huge, 90=insane.  Please check
       * the README in aspell-lang-200?????.tar.bz2 or
       * see SCOWL (http://wordlist.sourceforge.net)
       * for an example of how these sizes are used.  }

       PAspellDictInfo = ^AspellDictInfo;
       AspellDictInfo = record
            name : PAnsiChar;
            code : PAnsiChar;
            jargon : PAnsiChar;
            size : cint;
            size_str : PAnsiChar;
            module : PAspellModuleInfo;
         end;

  {**************************** string pair **************************** }

       PAspellStringPair = ^AspellStringPair;
       AspellStringPair = record
            first : PAnsiChar;
            second : PAnsiChar;
         end;

