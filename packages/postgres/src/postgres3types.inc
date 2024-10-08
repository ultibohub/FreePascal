{
  Contains the types needed for use with Postgres protocol v3
}

Type
  size_t    = sizeint;
  psize_t   = ^size_t;
  TFILE     = Longint;
  PFIle     = ^TFILE;
  POid      = ^Oid;
  Oid       = dword;

const
   ERROR_MSG_LENGTH = 4096;
   CMDSTATUS_LEN = 40;

   PG_DIAG_SEVERITY = Ord('S');
   PG_DIAG_SEVERITY_NONLOCALIZED = Ord('V');
   PG_DIAG_SQLSTATE = Ord('C');
   PG_DIAG_MESSAGE_PRIMARY = Ord('M');
   PG_DIAG_MESSAGE_DETAIL = Ord('D');
   PG_DIAG_MESSAGE_HINT = Ord('H');
   PG_DIAG_STATEMENT_POSITION = Ord('P');
   PG_DIAG_INTERNAL_POSITION = Ord('p');
   PG_DIAG_INTERNAL_QUERY = Ord('q');
   PG_DIAG_CONTEXT = Ord('W');
   PG_DIAG_SCHEMA_NAME = Ord('s');
   PG_DIAG_TABLE_NAME = Ord('t');
   PG_DIAG_COLUMN_NAME = Ord('c');
   PG_DIAG_DATATYPE_NAME = Ord('d');
   PG_DIAG_CONSTRAINT_NAME = Ord('n');
   PG_DIAG_SOURCE_FILE = Ord('F');
   PG_DIAG_SOURCE_LINE = Ord('L');
   PG_DIAG_SOURCE_FUNCTION = Ord('R');

Type
  TSockAddr = Array [1..112] of byte;
  TPGresAttDesc = record
       name : PAnsiChar;
       adtid : Oid;
       adtsize : integer;
    end;
  PPGresAttDesc= ^TPGresAttDesc;
  PPPGresAttDesc= ^PPGresAttDesc;
  TPGresAttValue = record
       len : longint;
       value : PAnsiChar;
    end;
  PPGresAttValue= ^TPGresAttValue;
  PPPGresAttValue= ^PPGresAttValue;

  PExecStatusType = ^TExecStatusType;
  TExecStatusType = (PGRES_EMPTY_QUERY := 0,PGRES_COMMAND_OK,
       PGRES_TUPLES_OK,PGRES_COPY_OUT,PGRES_COPY_IN,
       PGRES_BAD_RESPONSE,PGRES_NONFATAL_ERROR,
       PGRES_FATAL_ERROR);


  TPGlobjfuncs = record
        fn_lo_open   : Oid;
        fn_lo_close  : Oid;
        fn_lo_creat  : Oid;
        fn_lo_unlink : Oid;
        fn_lo_lseek  : Oid;
        fn_lo_tell   : Oid;
        fn_lo_read   : Oid;
        fn_lo_write  : Oid;
    end;
  PPGlobjfuncs= ^TPGlobjfuncs;

  PConnStatusType = ^TConnStatusType;
  TConnStatusType = (CONNECTION_OK,CONNECTION_BAD,CONNECTION_STARTED,
       CONNECTION_MADE,CONNECTION_AWAITING_RESPONSE,
       CONNECTION_AUTH_OK,CONNECTION_SETENV,
       CONNECTION_SSL_STARTUP,CONNECTION_NEEDED);

   TPGconn = record
        pghost : PAnsiChar;
        pgtty : PAnsiChar;
        pgport : PAnsiChar;
        pgoptions : PAnsiChar;
        dbName : PAnsiChar;
        status : TConnStatusType;
        errorMessage : array[0..(ERROR_MSG_LENGTH)-1] of AnsiChar;
        Pfin : PFILE;
        Pfout : PFILE;
        Pfdebug : PFILE;
        sock : longint;
        laddr : TSockAddr;
        raddr : TSockAddr;
        salt : array[0..(2)-1] of AnsiChar;
        asyncNotifyWaiting : longint;
        notifyList : PDllist;
        pguser : PAnsiChar;
        pgpass : PAnsiChar;
        lobjfuncs : PPGlobjfuncs;
    end;
  PPGconn= ^TPGconn;

  TPGresult = record
        ntups : longint;
        numAttributes : longint;
        attDescs : PPGresAttDesc;
        tuples : PPPGresAttValue;
        tupArrSize : longint;
        resultStatus : TExecStatusType;
        cmdStatus : array[0..(CMDSTATUS_LEN)-1] of AnsiChar;
        binary : longint;
        conn : PPGconn;
    end;
  PPGresult= ^TPGresult;





  PPostgresPollingStatusType = ^PostgresPollingStatusType;
  PostgresPollingStatusType = (PGRES_POLLING_FAILED := 0,PGRES_POLLING_READING,
       PGRES_POLLING_WRITING,PGRES_POLLING_OK,
       PGRES_POLLING_ACTIVE);


  PPGTransactionStatusType = ^PGTransactionStatusType;
  PGTransactionStatusType = (PQTRANS_IDLE,PQTRANS_ACTIVE,PQTRANS_INTRANS,
       PQTRANS_INERROR,PQTRANS_UNKNOWN);

  PPGVerbosity = ^PGVerbosity;
  PGVerbosity = (PQERRORS_TERSE,PQERRORS_DEFAULT,PQERRORS_VERBOSE);

  PpgNotify = ^pgNotify;
  pgNotify = record
          relname : PAnsiChar;
          be_pid : longint;
          extra : PAnsiChar;
    end;

{ Function types for notice-handling callbacks  }
  PQnoticeReceiver = procedure (arg:pointer; res:PPGresult);cdecl;
  PQnoticeProcessor = procedure (arg:pointer; message:PAnsiChar);cdecl;
{ Print options for PQprint()  }
  Ppqbool = ^pqbool;
  pqbool = AnsiChar;

  P_PQprintOpt = ^_PQprintOpt;
  _PQprintOpt = record
          header : pqbool;
          align : pqbool;
          standard : pqbool;
          html3 : pqbool;
          expanded : pqbool;
          pager : pqbool;
          fieldSep : PAnsiChar;
          tableOpt : PAnsiChar;
          caption : PAnsiChar;
          fieldName : ^PAnsiChar;
    end;
  PQprintOpt = _PQprintOpt;
  PPQprintOpt = ^PQprintOpt;

  { ----------------
   * Structure for the conninfo parameter definitions returned by PQconndefaults
   *
   * All fields except "val" point at static strings which must not be altered.
   * "val" is either NULL or a malloc'd current-value string.  PQconninfoFree()
   * will release both the val strings and the PQconninfoOption array itself.
   * ----------------
    }

     P_PQconninfoOption = ^_PQconninfoOption;
     _PQconninfoOption = record
          keyword : PAnsiChar;
          envvar : PAnsiChar;
          compiled : PAnsiChar;
          val : PAnsiChar;
          _label : PAnsiChar;
          dispchar : PAnsiChar;
          dispsize : longint;
       end;
     PQconninfoOption = _PQconninfoOption;
     PPQconninfoOption = ^PQconninfoOption;
  { ----------------
   * PQArgBlock -- structure for PQfn() arguments
   * ----------------
    }
  { can't use void (dec compiler barfs)   }

     PPQArgBlock = ^PQArgBlock;
     PQArgBlock = record
          len : longint;
          isint : longint;
          u : record
              case longint of
                 0 : ( ptr : Plongint );
                 1 : ( integer : longint );
              end;
       end;

