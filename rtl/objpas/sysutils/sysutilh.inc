{%MainUnit sysutils.pp}
{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Florian Klaempfl
    member of the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$MACRO ON}
{$IFNDEF FPC_DOTTEDUNITS}
{$DEFINE SUT:=sysutils}
{$DEFINE BU:=baseunix}
{$ELSE}
{$DEFINE SUT:=System.SysUtils}
{$DEFINE BU:=UnixApi.Base}
{$ENDIF}

{ Using inlining for small system functions/wrappers }
{$inline on}
{$define SYSUTILSINLINE}

  { Read internationalization settings }
  {$i sysinth.inc}

  { Read date & Time function declarations }
  {$i osutilsh.inc}

{$ifndef FPUNONE}
  {$i datih.inc}
{$endif}

function GetTickCount: LongWord; deprecated 'Use GetTickCount64 instead';
function GetTickCount64: QWord;

  { Read String Handling functions declaration }
  {$i sysstrh.inc}

type
   { some helpful data types }

   THandle = System.THandle;

   TProcedure = procedure;

   TFileName = type string;

   TIntegerSet = Set of 0..SizeOf(Integer)*8-1;

   LongRec = packed record
      case Integer of
{$ifdef FPC_LITTLE_ENDIAN}
        0 : (Lo,Hi : Word);
{$else FPC_LITTLE_ENDIAN}
        0 : (Hi,Lo : Word);
{$endif FPC_LITTLE_ENDIAN}
        1 : (Bytes : Array[0..3] of Byte);
   end;

   WordRec = packed record
{$ifdef FPC_LITTLE_ENDIAN}
     Lo,Hi : Byte;
{$else FPC_LITTLE_ENDIAN}
     Hi,Lo : Byte;
{$endif FPC_LITTLE_ENDIAN}
   end;

   Int64Rec = packed record
      case integer of
{$ifdef FPC_LITTLE_ENDIAN}
        0 : (Lo,Hi : Cardinal);
{$else FPC_LITTLE_ENDIAN}
        0 : (Hi,Lo : Cardinal);
{$endif FPC_LITTLE_ENDIAN}
        1 : (Words : Array[0..3] of Word);
        2 : (Bytes : Array[0..7] of Byte);
   end;

   Int128Rec = System.Int128Rec;

   OWordRec = packed record
      case integer of
{$ifdef FPC_LITTLE_ENDIAN}
        0 : (Lo,Hi : QWord);
{$else FPC_LITTLE_ENDIAN}
        0 : (Hi,Lo : QWord);
{$endif FPC_LITTLE_ENDIAN}
        1 : (DWords : Array[0..3] of DWord);
        2 : (Words : Array[0..7] of Word);
        3 : (Bytes : Array[0..15] of Byte);
   end;

   PByteArray = ^TByteArray;
   TByteArray = Array[0..{$ifdef CPU16}32766{$else}32767{$endif}] of Byte;

   PWordarray = ^TWordArray;
   TWordArray = array[0..{$ifdef CPU16}16382{$else}16383{$endif}] of Word;

   TBytes = array of Byte;

   { exceptions }
   Exception = class(TObject)
    private
      fmessage : string;
      fhelpcontext : longint;
    public
      constructor Create(const msg : string);
      constructor CreateFmt(const msg : string; const args : array of const);
      constructor CreateRes(ResString: PResStringRec);
      constructor CreateResFmt(ResString: PResStringRec; const Args: array of const);
      constructor CreateHelp(const Msg: string; AHelpContext: Longint);
      constructor CreateFmtHelp(const Msg: string; const Args: array of const;
        AHelpContext: Longint);
      constructor CreateResHelp(ResString: PResStringRec; AHelpContext: Longint);
      constructor CreateResFmtHelp(ResString: PResStringRec; const Args: array of const;
        AHelpContext: Longint);
      Function ToString : RTLString; override;

      function GetBaseException : Exception;virtual;

      property HelpContext : longint read fhelpcontext write fhelpcontext;
      property Message : string read fmessage write fmessage;
   end;

   ExceptClass = class of Exception;

   EExternal = class(Exception)
{$if defined(win32) or defined(win64) or defined(wince)}
   { OS-provided exception record is stored on stack and has very limited lifetime.
     Therefore store a complete copy. }
   private
     FExceptionRecord: TExceptionRecord;
     function GetExceptionRecord: PExceptionRecord;
   public
     property ExceptionRecord : PExceptionRecord read GetExceptionRecord;
{$endif win32 or win64 or wince}
   end;

   { integer math exceptions }
   EIntError    = Class(EExternal);
   EDivByZero   = Class(EIntError);
   ERangeError  = Class(EIntError);
   EIntOverflow = Class(EIntError);

   { General math errors }
   EMathError  = Class(EExternal);
   EInvalidOp  = Class(EMathError);
   EZeroDivide = Class(EMathError);
   EOverflow   = Class(EMathError);
   EUnderflow  = Class(EMathError);

   { Run-time and I/O Errors }
   EInOutError = class(Exception)
     public
       ErrorCode : Integer;
   end;

   EHeapMemoryError = class(Exception)
     procedure FreeInstance;override;
   end;

   EHeapException = EHeapMemoryError;

   EExternalException = class(EExternal);
   EInvalidPointer  = Class(EHeapMemoryError);
   EOutOfMemory     = Class(EHeapMemoryError);
   EInvalidCast = Class(Exception);
   EVariantError = Class(Exception)
     ErrCode : longint;
     Constructor CreateCode(Code : Longint);
   end;

   EAccessViolation = Class(EExternal);
   EBusError = Class(EAccessViolation);
   EPrivilege = class(EExternal);
   EStackOverflow = class(EExternal);
   EControlC = class(EExternal);

   { String conversion errors }
   EConvertError = class(Exception);
   EFormatError = class(Exception);

   { Other errors }
   EAbort           = Class(Exception);
   EAbstractError   = Class(Exception);
   EAssertionFailed = Class(Exception);
   EObjectCheck     = Class(Exception);
   EThreadError     = Class(Exception);
   ESigQuit         = Class(Exception);

   EPropReadOnly = class(Exception);
   EPropWriteOnly = class(Exception);

   EIntfCastError = class(Exception);
   EInvalidContainer = class(Exception);
   EInvalidInsert = class(Exception);

   EPackageError = class(Exception);
   ECFError = class(Exception);

   EOSError = class(Exception)
   public
     ErrorCode: Longint;
   end;

   ESafecallException = class(Exception);
   ENoThreadSupport = Class(Exception);
   ENoWideStringSupport = Class(Exception);
   ENoDynLibsSupport = class(Exception);

   EProgrammerNotFound = class(Exception);

   EMonitor = class(Exception);
   EMonitorLockException = class(EMonitor);
   ENoMonitorSupportException = class(EMonitor);

   EObjectDisposed = class(Exception);

   ENotImplemented = class(Exception);

   EArgumentException = class(Exception);
   EArgumentOutOfRangeException = class(EArgumentException);
   EArgumentNilException = class(EArgumentException);

   EPathTooLongException = class(Exception);
   ENotSupportedException = class(Exception);
   EDirectoryNotFoundException = class(Exception);
   EFileNotFoundException = class(Exception);
   EPathNotFoundException = class(Exception);

   EInOutArgumentException = class(EArgumentException)
   public
     Path: string;
     constructor Create(const aMsg, aPath: string); overload;
     constructor CreateRes(ResStringRec: PResStringRec; const aPath: string); overload;
     constructor CreateFmt(const fmt : string;  const args : array of const; const aPath : String); overload;
   end;

   EInvalidOpException = class(Exception);

   ENoConstructException = class(Exception);
   EListError = Class(Exception);

   EOperationCancelled = class(Exception);

   { Exception handling routines }
   function ExceptObject: TObject;
   function ExceptAddr: CodePointer;
   function ExceptFrameCount: Longint;
   function ExceptFrames: PCodePointer;
   function ExceptionErrorMessage(ExceptObject: TObject; ExceptAddr: Pointer;
                                  Buffer: PAnsiChar; Size: Integer): Integer;
   procedure ShowException(ExceptObject: TObject; ExceptAddr: Pointer);
   procedure Abort;
   procedure OutOfMemoryError;
   procedure ListIndexError(aIndex,aMax: Integer; aObj: TObject);
   function ListIndexErrorMsg(aIndex, aMaxIndex: SizeInt; const aListObjName: string): string; overload;
   function ListIndexErrorMsg(aIndex, aMaxIndex: SizeInt; aListObj: TObject): string; overload;
   procedure RangeIndexError(aIndex, aMaxIndex: SizeInt; aListObj: TObject);

Type
   TBeepHandler = Procedure;

Var
   OnBeep : TBeephandler = Nil;

   procedure Beep;
   function SysErrorMessage(ErrorCode: Integer): String;

Type
   TCreateGUIDFunc = Function(Out GUID : TGUID) : Integer;

Var
   OnCreateGUID : TCreateGUIDFunc = Nil;
   Function CreateGUID(out GUID : TGUID) : Integer;

type
  TTerminateProc = Function: Boolean;

  procedure AddTerminateProc(TermProc: TTerminateProc);
  function CallTerminateProcs: Boolean;

generic function IfThen<T>(val:boolean;const iftrue:T; const iffalse:T) :T; inline; overload;
generic function Exchange<T>(var target:T; const newvalue:T) :T; inline;
generic function Extract<T>(var from: T) :T;inline;overload;
generic procedure Swap<T>(var lhs,rhs: T);inline;overload;

Var
   OnShowException : Procedure (Msg : ShortString);

Const
   HexDisplayPrefix : string = '$';

const
// commenting is VP fix. These idents are in a different unit there.
  PathDelim={System.}DirectorySeparator;
  DriveDelim={System.}DriveSeparator;
  PathSep={System.}PathSeparator;
  MAX_PATH={System.}MaxPathLen;

Type
   TFileRec=FileRec;
   TTextRec=TextRec;


  { Read PAnsiChar handling functions declaration }
  {$i syspchh.inc}

  { MCBS functions }
  {$i sysansih.inc}
  {$i syscodepagesh.inc}

  { wide string functions }
  {$i syswideh.inc}

{$ifdef FPC_HAS_UNICODESTRING}
  { unicode string functions }
  {$i sysunih.inc}
  {$i sysencodingh.inc}
{$endif FPC_HAS_UNICODESTRING}

{$macro on}
{$define PathStr:=UnicodeString}
{$define PathPChar:=PUnicodeChar}
  { Read filename handling functions declaration }
  {$i finah.inc}
{$define PathStr:=RawByteString}
{$define PathPChar:=PAnsiChar}
  { Read filename handling functions declaration }
  {$i finah.inc}
{$undef PathStr}
{$undef PathPChar}

  { Read other file handling function declarations }
  {$i filutilh.inc}

  { Read disk function declarations }
  {$i diskh.inc}

  { read thread handling }
  {$i systhrdh.inc}

  { Type Helpers}
  {$i syshelph.inc}

  {$IFDEF CPULLVM}
  // LLVM does not allow the constref use.
  procedure FreeAndNil(var obj);
  {$else}    
  procedure FreeAndNil(constref obj : TObject);
  {$ENDIF}
  procedure FreeMemAndNil(var p);

  { interface handling }
  {$i intfh.inc}

{$IFDEF FPC_HAS_FEATURE_UNICODESTRINGS}
  { strange Delphi thing }
  {$i sysmarshalh.inc}
{$ENDIF}

  function SafeLoadLibrary(const FileName: AnsiString;
    ErrorMode: DWord = {$ifdef windows}SEM_NOOPENFILEERRORBOX{$else windows}0{$endif windows}): HMODULE;

  function GetModuleName(Module: HMODULE): string;

{ some packages and unit related constants for compatibility }

const
  pfExeModule = $00000000;
  pfNeverBuild = $00000001;
  pfDesignOnly = $00000002;
  pfRunOnly = $00000004;
  pfIgnoreDupUnits = $00000008;
  pfPackageModule = $40000000;
  pfModuleTypeMask = $C0000000;
  pfV3Produced =  $00000000;
  pfProducerUndefined = $04000000;
  pfBCB4Produced = $08000000;
  pfDelphi4Produced = $0C000000;
  pfLibraryModule = $80000000;
  pfProducerMask = $0C000000;

const
  ufMainUnit     = $01;
  ufPackageUnit  = $02;
  ufWeakUnit     = $04;
  ufOrgWeakUnit  = $08;
  ufImplicitUnit = $10;

  ufWeakPackageUnit = ufPackageUnit or ufWeakUnit;

Type
  TUTF8StringDynArray = Array of UTF8String;

Function ArrayOfConstToStr(const Args: array of const ; aSeparator : Char = ','; aQuoteBegin : Char = '"'; aQuoteEnd : Char = '"') : UTF8String;
Function ArrayOfConstToStrArray(const Args: array of const) : TUTF8StringDynArray;

{ Delphi compatibility }

Type

  { TOSVersion }

  TOSVersion = record
  public type
    TArchitecture = (arIntelX86, arIntelX64, arARM32, arARM64, arIntelX16, arXTensa, arAVR, arM68k, arPowerPC, arPower64,
                     arMips, arMipsel, arMips64, arMips64el, arJVM, arWasm32, arSparc, arSparc64, arRiscV32, arRiscV64, arZ80,
                     arLoongArch64, arOther);

    TPlatform = (pfWindows, pfMacOS, pfiOS, pfAndroid, pfWinRT, pfLinux,
                 pfGo32v2, pfOS2, pfFreeBSD, pfBeos, pfNetBSD, pfAmiga,
                 pfAtari, pfSolaris, pfQNX, pfNetware, pfOpenBSD, pfWDosX,
                 pfPalmos, pfMacOSClassic, pfDarwin, pfEMX, pfWatcom,
                 pfMorphos, pfNetwLibC, pfWinCE, pfGBA, pfNDS, pfEmbedded,
                 pfSymbian, pfHaiku, pfIPhoneSim, pfAIX, pfJava,
                 pfNativeNT, pfMSDos, pfWII, pfAROS, pfDragonFly, pfWin16,
                 pfFreeRTOS, pfZXSpectrum, pfMSXDOS, pfAmstradCPC,
                 pfSinclairQL, pfWasi, pfOther);
    TDelphiPlatform = TPlatform.pfWindows..TPlatform.pfLinux;
  public const
    AllArchitectures = [Low(TArchitecture) .. High(TArchitecture)];
    AllPlatforms = [Low(TPlatform) .. High(TPlatform)];
  private
    class var FFull : string;
    class var FArchitecture: TArchitecture;
    class var FBuild: Integer;
    class var FMajor: Integer;
    class var FMinor: Integer;
    class var FName: string;
    class var FPlatform: TPlatform;
    class var FServicePackMajor: Integer;
    class var FServicePackMinor: Integer;
  {$IFDEF LINUX}
    class var FPrettyName: string;
    class var FLibCVersionMajor: Integer;
    class var FLibCVersionMinor: Integer;
  {$ENDIF LINUX}
    class constructor Create;
  public
    class function Check(AMajor: Integer): Boolean; overload; static; inline;
    class function Check(AMajor, AMinor: Integer): Boolean; overload; static; inline;
    class function Check(AMajor, AMinor, AServicePackMajor: Integer): Boolean; overload; static; inline;
    class function ToString: string; static;
    class property Architecture: TArchitecture read FArchitecture;
    class property Build: Integer read FBuild;
    class property Major: Integer read FMajor;
    class property Minor: Integer read FMinor;
    class property Name: string read FName;
    class property Platform: TPlatform read FPlatform;
    class property ServicePackMajor: Integer read FServicePackMajor;
    class property ServicePackMinor: Integer read FServicePackMinor;
  {$IFDEF LINUX}
    class property PrettyName: string read FPrettyName;
    class property LibCVersionMajor: Integer read FLibCVersionMajor;
    class property LibCVersionMinor: Integer read FLibCVersionMinor;
  {$ENDIF LINUX}
  end;

  TArchitectures = set of TOSVersion.TArchitecture;
  TPlatforms = set of TOSVersion.TPlatform;
  TDelphiPlatforms = set of TOSVersion.TDelphiPlatform;

  Function GetCompiledArchitecture : TOSVersion.TArchitecture;
  Function GetCompiledPlatform : TOSVersion.TPlatform;

{$IFNDEF HAS_INVALIDHANDLE}
const
  INVALID_HANDLE_VALUE = DWORD(-1);
{$ENDIF}
