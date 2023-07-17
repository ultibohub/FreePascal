{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2016 by Free Pascal development team

    comodities.library functions

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$PACKRECORDS C}
unit commodities;

interface

uses
  exec, inputevent, keymap;

type
  CxObj = LongInt;
  PCxObj = ^CxObj;
  CxMsg = LongInt;
  PCXMsg = ^CxMsg;

  PNewBroker = ^TNewBroker;
  TNewBroker = record
    nb_Version: Shortint; // NB_VERSION see below
    nb_Name: STRPTR;
    nb_Title: STRPTR;
    nb_Descr: STRPTR;
    nb_Unique: SmallInt;  // see below NBU_*
    nb_Flags: SmallInt;   // see below COF_*
    nb_Pri: Shortint;
    nb_Port: PMsgPort;
    nb_ReservedChannel: SmallInt;
  end;

const
  // nb_Version
  NB_VERSION = 5; // Version of NewBroker structure
  // nb_Unique
  NBU_DUPLICATE = 0;
  NBU_UNIQUE    = 1 shl 0; // will not allow duplicates
  NBU_NOTIFY    = 1 shl 1; // sends CXM_UNIQUE to existing broker
  // nb_Flags }
  COF_SHOW_HIDE = 1 shl 2;
  COF_ACTIVE    = 1 shl 1; // Object is active - undocumented in AmigaOS
  // buffer sizes
  CBD_NAMELEN   =  24; // length of nb_Name
  CBD_TITLELEN  =  40; // length of nb_Title
  CBD_DESCRLEN  =  40; // length of nb_Descr

  // Return Values of CxBroker()
  CBERR_OK      =  0; // No error
  CBERR_SYSERR  =  1; // System error , no memory, etc
  CBERR_DUP     =  2; // uniqueness violation
  CBERR_VERSION =  3; // didn't understand nb_VERSION

  // Return Values of CxObjError()
  COERR_ISNULL      = 1 shl 0; // you called CxError(NULL)
  COERR_NULLATTACH  = 1 shl 1; // someone attached NULL to my list
  COERR_BADFILTER   = 1 shl 2; // a bad filter description was given
  COERR_BADTYPE     = 1 shl 3; // unmatched type-specific operation

  CXM_IEVENT  = 1 shl 5;
  CXM_COMMAND = 1 shl 6;

  // ID values
  CXCMD_DISABLE   = 15; // please disable yourself
  CXCMD_ENABLE    = 17; // please enable yourself
  CXCMD_APPEAR    = 19; // open your window, if you can
  CXCMD_DISAPPEAR = 21; // go dormant
  CXCMD_KILL      = 23; // go away for good
  CXCMD_UNIQUE    = 25; // someone tried to create a broker with your name.  Suggest you Appear.
  CXCMD_LIST_CHG  = 27; // Used by Exchange program. Someone has changed the broker list

  // Commodities Object Types
  CX_INVALID    = 0; // not a valid object (probably null)
  CX_FILTER     = 1; // input event messages only
  CX_TYPEFILTER = 2; // filter on message type
  CX_SEND       = 3; // sends a message
  CX_SIGNAL     = 4; // sends a signal
  CX_TRANSLATE  = 5; // translates IE into chain
  CX_BROKER     = 6; // application representative
  CX_DEBUG      = 7; // dumps kprintf to serial port
  CX_CUSTOM     = 8; // application provids function
  CX_ZERO       = 9; // system terminator node

type
  PInputXpression = ^TInputXpression;
  TInputXpression = record
    ix_Version: Byte;   // must be set to IX_VERSION
    ix_Class: Byte;     // class must match exactly
    ix_Code: Word;      // Bits that we want
    ix_CodeMask: Word;  // Set bits here to indicate which bits in ix_Code are don't care bits.
    ix_Qualifier: Word; // Bits that we want
    ix_QualMask : Word; // Set bits here to indicate which bits in ix_Qualifier are don't care bits
    ix_QualSame : Word; // synonyms in qualifier
  end;
  IX = TInputXpression;
  PIX = ^IX;

const
  // ix_Version
  IX_VERSION = 2;

  // ix_QualMask
  IX_NORMALQUALS  = $7FFF; // avoid RELATIVEMOUSE

  // ix_QualSame
  IXSYM_SHIFT = 1; // left- and right- shift are equivalent
  IXSYM_CAPS  = 2; // either shift or caps lock are equivalent
  IXSYM_ALT   = 4; // left- and right- alt are equivalent

  // corresponding QualSame masks
  IXSYM_SHIFTMASK = IEQUALIFIER_LSHIFT or IEQUALIFIER_RSHIFT;
  IXSYM_CAPSMASK  = IXSYM_SHIFTMASK or IEQUALIFIER_CAPSLOCK;
  IXSYM_ALTMASK   = IEQUALIFIER_LALT or IEQUALIFIER_RALT;

type
  // Nodes of the list got from CopyBrokerList(). This function is used by
  // Exchange to get the current brokers. This structure is the same as
  // in AmigaOS and MorphOS, but it is undocumented there.
  PBrokerCopy = ^TBrokerCopy;
  TBrokerCopy = record
    bc_Node: TNode;
    bc_Name: array[0..CBD_NAMELEN - 1] of AnsiChar;
    bc_Title: array[0..CBD_TITLELEN - 1] of AnsiChar;
    bc_Descr: array[0..CBD_DESCRLEN - 1] of AnsiChar;
    bc_Task: PTask;     // Private, do not use this
    bc_Port: PMsgPort;  // Private, do not use this
    bc_Dummy: Word;
    bc_Flags: LongWord;
  end;

var
 CxBase: PLibrary = nil;

const
    COMMODITIESNAME: PAnsiChar = 'commodities.library';

function CreateCxObj(Typ: LongWord; Arg1: IPTR; Arg2: IPTR): PCxObj; syscall CxBase 5;
function CxBroker(Nb: PNewBroker; var Error: LongInt): PCxObj; syscall CxBase 6;
function ActivateCxObj(Co: PCxObj; Tru: LongInt): LongInt; syscall CxBase 7;
procedure DeleteCxObj(Co: PCxObj); syscall CxBase 8;
procedure DeleteCxObjAll(Co: PCxObj); syscall CxBase 9;
function CxObjType(Co: PCxObj): LongWord; syscall CxBase 10;
function CxObjError(Co: PCxObj): LongInt; syscall CxBase 11;
procedure ClearCxObjError(Co: PCxObj); syscall CxBase 12;
function SetCxObjPri(Co: PCxObj; Pri: LongInt): LongInt; syscall CxBase 13;
procedure AttachCxObj(HeadObj: PCxObj; Co: PCxObj); syscall CxBase 14;
procedure EnqueueCxObj(HeadObj: PCxObj; Co: PCxObj); syscall CxBase 15;
procedure InsertCxObj(HeadObj: PCxObj; Co: PCxObj; Pred: PCxObj); syscall CxBase 16;
procedure RemoveCxObj(Co: PCxObj); syscall CxBase 17;
procedure SetTranslate(Translator: PCxObj; Events: PInputEvent); syscall CxBase 19;
procedure SetFilter(Filter: PCxObj; Text: STRPTR); syscall CxBase 20;
procedure SetFilterIX(Filter: PCxObj; Ix: PInputXpression); syscall CxBase 21;
function ParseIX(Description: STRPTR; Ix: PInputXpression): LongInt; syscall CxBase 22;
function CxMsgType(Cxm: PCxMsg): LongWord; syscall CxBase 23;
function CxMsgData(Cxm: PCxMsg): APTR; syscall CxBase 24;
function CxMsgID(Cxm: PCxMsg): LongInt; syscall CxBase 25;
procedure DivertCxMsg(Cxm: PCxMsg; HeadObj: PCxObj; ReturnObj: PCxObj); syscall CxBase 26;
procedure RouteCxMsg(Cxm: PCxMsg; Co: PCxObj); syscall CxBase 27;
procedure DisposeCxMsg(Cxm: PCxMsg); syscall CxBase 28;
function InvertKeyMap(AnsiCode: LongWord; Event: PInputEvent; Km: PKeyMap): LongBool; syscall CxBase 29;
procedure AddIEvents(Events: PInputEvent); syscall CxBase 30;
function CopyBrokerList(CopyOfList: PList): LongInt; syscall CxBase 31;
procedure FreeBrokerList(BrokerList: PList); syscall CxBase 32;
function BrokerCommand(Name: STRPTR; Command: LongWord): LongWord; syscall CxBase 33;
function MatchIX(Event: PInputEvent; Ix: PInputXpression): LongBool; syscall CxBase 34;

// macros

function CxFilter(D: STRPTR): PCxObj; inline;
function CxSender(Port: PMsgPort; Id: longint): PCxObj; inline;
function CxSignal(Task: pTask; Sig: Byte): PCxObj; inline;
function CxTranslate(Ie: PInputEvent): PCxObj; inline;
function CxDebug(Id: LongInt): PCxObj; inline;
function CxCustom(Action: Pointer; Id: LongInt): PCxObj; inline;

implementation

function CxFilter(D: STRPTR): PCxObj; inline;
begin
  CxFilter := CreateCxObj(CX_FILTER, IPTR(d), 0)
end;

function CxSender(Port: PMsgPort; Id: longint): PCxObj; inline;
begin
  CxSender := CreateCxObj(CX_SEND, IPTR(Port), Id);
end;

function CxSignal(Task: pTask; Sig: Byte): PCxObj;
begin
  CxSignal:= CreateCxObj(CX_SIGNAL, IPTR(task), Sig);
end;

function CxTranslate(Ie: PInputEvent): PCxObj;
begin
  CxTranslate := CreateCxObj(CX_TRANSLATE, IPTR(Ie), 0);
end;

function CxDebug(Id: LongInt): PCxObj;
begin
  CxDebug := CreateCxObj(CX_DEBUG, Id, 0)
end;

function CxCustom(Action: Pointer; Id: LongInt): PCxObj;
begin
  CxCustom := CreateCxObj(CX_CUSTOM, IPTR(Action), Id);
end;

const
  // Change LIBVERSION to proper values
  LIBVERSION: longword = 0;

initialization
  CxBase := OpenLibrary(COMMODITIESNAME, LIBVERSION);
finalization
  if Assigned(CxBase) then
    CloseLibrary(CxBase);
end.



