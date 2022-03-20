{   CLDR collation helper unit.

    Copyright (c) 2013-2015 by Inoussa OUEDRAOGO

    The source code is distributed under the Library GNU
    General Public License with the following modification:

        - object files and libraries linked into an application may be
          distributed without source code.

    If you didn't receive a copy of the file COPYING, contact:
          Free Software Foundation
          675 Mass Ave
          Cambridge, MA  02139
          USA

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit cldrhelper;

{$mode delphi}
{$H+}
{$PACKENUM 1}
{$modeswitch advancedrecords}
{$scopedenums on}
{$typedaddress on}
{$POINTERMATH on}

{$macro on}
{$ifdef FPC_REQUIRES_PROPER_ALIGNMENT}
  {$define X_PACKED:=}
{$else FPC_REQUIRES_PROPER_ALIGNMENT}
  {$define X_PACKED:=packed}
{$endif FPC_REQUIRES_PROPER_ALIGNMENT}

interface

uses
  SysUtils, Classes, helper;

const
  COLLATION_FILE_PREFIX = 'collation_';

  COLLATION_ITEM_SEARCH = 'search';
  COLLATION_ITEM_STD = 'standard';
  COLLATION_ITEM_DEFAULT = COLLATION_ITEM_STD;

type
  TAliasRec = record
    Name  : UTF8String;
    Alias : UTF8String;
  end;
const
  BCP47_COLLATION_TYPE_ALIAS : array[0..3] of TAliasRec = (
    (Name : 'dict'; Alias : 'dictionary'),
    (Name : 'gb2312'; Alias : 'gb2312han'),
    (Name : 'phonebk'; Alias : 'phonebook'),
    (Name : 'trad'; Alias : 'traditional')
  );

type

  TUCA_LineRecArray = array of TUCA_LineRec;

  ECldrException = class(Exception)
  end;

  TReorderWeigthKind = (
    Primary, Secondary, Tertiary, Identity, Deletion
  );
  TReorderWeigthKinds = set of TReorderWeigthKind;
  TReorderLogicalReset = (
    None,// FirstVariable, LastVariable,
    FirstTertiaryIgnorable, LastTertiaryIgnorable,
    FirstSecondaryIgnorable, LastSecondaryIgnorable,
    FirstPrimaryIgnorable, LastPrimaryIgnorable,
    LastRegular,
    FirstNonIgnorable, LastNonIgnorable,
    FirstTrailing, LastTrailing
  );
const
  FixableReorderLogicalSet = [
    TReorderLogicalReset.LastRegular,TReorderLogicalReset.FirstTrailing,
    TReorderLogicalReset.LastTrailing
  ];

type
  TCollationField = (
    BackWards, VariableLowLimit, VariableHighLimit, Alternate, Normalization,
    Strength
  );
  TCollationFields = set of TCollationField;

  PReorderUnit = ^TReorderUnit;

  { TReorderUnit }

  TReorderUnit = X_PACKED record
  private
    FVirtualPosition : TReorderLogicalReset;
  public
    Context         : TUnicodeCodePointArray;
    ExpansionChars  : TUnicodeCodePointArray;
    Characters      : TUnicodeCodePointArray;
    WeigthKind      : TReorderWeigthKind;
    InitialPosition : Integer;
    Changed         : Boolean;
  public
    property VirtualPosition : TReorderLogicalReset read FVirtualPosition;
    function IsVirtual() : Boolean;inline;
  public
    class function From(
      const AChars,
            AContext         : array of TUnicodeCodePoint;
      const AWeigthKind      : TReorderWeigthKind;
      const AInitialPosition : Integer
    ) : TReorderUnit;static;overload;
    class function From(
      const AChars           : array of TUnicodeCodePoint;
      const AWeigthKind      : TReorderWeigthKind;
      const AInitialPosition : Integer
    ) : TReorderUnit;static;overload;
    class function From(
      const AChar            : TUnicodeCodePoint;
      const AWeigthKind      : TReorderWeigthKind;
      const AInitialPosition : Integer
    ) : TReorderUnit;static;overload;
    class function From(
      const AChar            : TUnicodeCodePoint;
      const AContext         : array of TUnicodeCodePoint;
      const AWeigthKind      : TReorderWeigthKind;
      const AInitialPosition : Integer
    ) : TReorderUnit;static;overload;
    class function From(
      const AReset : TReorderLogicalReset
    ) : TReorderUnit;static;overload;
    procedure SetExpansion(const AChars : array of TUnicodeCodePoint);overload;
    procedure SetExpansion(const AChar : TUnicodeCodePoint);overload;
    procedure Clear();
    procedure Assign(const AItem : PReorderUnit);
    function HasContext() : Boolean;
    function IsExpansion() : Boolean;
  end;


  PReorderSequence = ^TReorderSequence;

  { TReorderSequence }

  TReorderSequence = X_PACKED record
  public
    Reset           : array of TUnicodeCodePoint;
    Elements        : array of TReorderUnit;
    LogicalPosition : TReorderLogicalReset;
    Before          : Boolean;
  public
    procedure Clear();
    procedure SetElementCount(const ALength : Integer);
    procedure Assign(ASource : PReorderSequence);
  end;
  TReorderSequenceArray = array of TReorderSequence;

  { TOrderedCharacters }

  TOrderedCharacters = record
  private
    FActualLength : Integer;
  private
    procedure EnsureSize(const AMinSize : Integer);
  public
    Data : array of TReorderUnit;
    property ActualLength : Integer read FActualLength;

  public
    class function Create(const ACapacity : Integer) : TOrderedCharacters;static;overload;
    class function Create() : TOrderedCharacters;static;overload;
    procedure Clear();
    function Clone() : TOrderedCharacters;
    function Insert(const AItem : TReorderUnit; const ADestPos : Integer) : Integer;
    function Append(const AItem : TReorderUnit) : Integer;
    procedure Delete(const AIndex : Integer);

    procedure ApplyStatement(const AStatement : PReorderSequence);
  end;
  POrderedCharacters = ^TOrderedCharacters;

  { TCldrImport }

  TCldrImport = class
  private
    FSource: string;
    FTypeName: string;
  public
    property Source : string read FSource;
    property TypeName : string read FTypeName;
  end;

  { TCldrImportList }

  TCldrImportList = class
  private
    FItems : array of TCldrImport;
  private
    function GetCount: Integer;
    function GetItem(AIndex : Integer): TCldrImport;
  public
    destructor Destroy();override;
    procedure Clear();
    function IndexOf(const ASource, AType : string) : Integer;
    function Find(const ASource, AType : string) : TCldrImport;
    function Add(const ASource, AType : string) : TCldrImport;
    property Count : Integer read GetCount;
    property Item[AIndex : Integer] : TCldrImport read GetItem;default;
  end;


  TComparisonStrength = (
    Primary, Secondary, Tertiary, Quaternary, Identity
  );

  TSettingOption = (
    Unknown, Strength, Alternate, Backwards, Normalization, CaseLevel, CaseFirst,
    HiraganaQ, NumericOrdering, Reorder, MaxVariable, Import,
    SuppressContractions, Optimize
  );
  PSettingRec = ^TSettingRec;

  { TSettingRec }

  TSettingRec = record
  public
    Name   : UTF8String;
    Values : array of UTF8String;
    OptionValue : TSettingOption;
    Understood : Boolean;
  public
    class function From(
      const AName   : UTF8String;
      const AValues : array of UTF8String;
      const AOption : TSettingOption
    ) : TSettingRec;static;
    procedure Assign(const AItem : PSettingRec);
    procedure Clear();
  end;
  TSettingRecArray = array of TSettingRec;

  TCldrCollationRuleKind = (Unknown, ReorderSequence, Import);
  TCldrCollationRule = record
    Kind    : TCldrCollationRuleKind;
    Reorder : TReorderSequence;
    Import  : TCldrImport;
  end;
  PCldrCollationRule = ^TCldrCollationRule;
  TCldrCollationRuleArray = array of TCldrCollationRule;

  TCldrCollation = class;

  TCldrParserMode = (HeaderParsing, FullParsing);

  { TCldrCollationItem }

  TCldrCollationItem = class
  private
    FAlt: string;
    FBackwards: Boolean;
    FBase: string;
    FChangedFields: TCollationFields;
    FImports: TCldrImportList;
    FMode : TCldrParserMode;
    FNormalization : Boolean;
    FParent: TCldrCollation;
    FRules: TCldrCollationRuleArray;
    FSettings : TSettingRecArray;
    FStrength : TComparisonStrength;
    FTypeName: string;
    FVariableWeight : TUCA_VariableKind;
  public
    class function FindAlias(const AName : UTF8String) : UTF8String;static;
    constructor Create();
    destructor Destroy;override;
    procedure Clear();
    function IsPrivate() : Boolean;
    property Mode : TCldrParserMode read FMode write FMode;
    property Parent : TCldrCollation read FParent;
    property TypeName : string read FTypeName write FTypeName;
    property Alt : string read FAlt write FAlt;
    property Base : string read FBase write FBase;
    property Backwards : Boolean read FBackwards write FBackwards;
    property Rules : TCldrCollationRuleArray read FRules write FRules;
    property ChangedFields : TCollationFields read FChangedFields write FChangedFields;
    property Imports : TCldrImportList read FImports;
    property Settings : TSettingRecArray read FSettings write FSettings;
    property VariableWeight : TUCA_VariableKind read FVariableWeight write FVariableWeight;
    property Normalization : Boolean read FNormalization write FNormalization;
    property Strength : TComparisonStrength read FStrength write FStrength;
  end;

  TCldrCollationRepository = class;

  { TCldrCollation }

  TCldrCollation = class
  private
    FItems : array of TCldrCollationItem;
    FLocalID: string;
    FDefaultType: string;
    FVersion: string;
    FLanguage: string;
    FMode: TCldrParserMode;
    FRepository: TCldrCollationRepository;
  private
    function GetItem(Index : Integer): TCldrCollationItem;
    function GetItemCount: Integer;
  public
    destructor Destroy();override;
    procedure Clear();
    function IndexOf(const AItemName : string) : Integer;overload;
    function IndexOf(const AItemName, AItemAlt : string) : Integer;overload;
    function Find(const AItemName : string) : TCldrCollationItem;overload;
    function Find(const AItemName, AItemAlt : string) : TCldrCollationItem;overload;
    function Add(AItem : TCldrCollationItem) : Integer;
    function FindPublicItemCount() : Integer;
    property Language : string read FLanguage write FLanguage;
    property LocalID : string read FLocalID write FLocalID;
    property Version : string read FVersion write FVersion;
    property DefaultType : string read FDefaultType write FDefaultType;
    property ItemCount : Integer read GetItemCount;
    property Items[Index : Integer] : TCldrCollationItem read GetItem;
    property Mode : TCldrParserMode read FMode write FMode;
    property Repository : TCldrCollationRepository read FRepository;
  end;

  ICldrCollationLoader = interface
    ['{117AAC84-06CE-4EC8-9B07-4E81EC23930C}']
    procedure LoadCollation(
      const ALanguage  : string;
            ACollation : TCldrCollation;
            AMode      : TCldrParserMode
    );
    procedure LoadCollationType(
      const ALanguage,
            ATypeName : string;
            AType     : TCldrCollationItem
    );
  end;

  { TCldrCollationRepository }

  TCldrCollationRepository = class
  private
    FItems : array of TCldrCollation;
    FLoader: ICldrCollationLoader;
  private
    function GetItem(const AIndex : Integer): TCldrCollation;
    function GetItemCount: Integer;
    function IndexOfItem(AItem : TCldrCollation) : Integer;
    procedure Add(AItem : TCldrCollation);
  public
    constructor Create(ALoader : ICldrCollationLoader);
    destructor Destroy;override;
    procedure FreeItems();
    procedure Clear();
    procedure SetLoader(AValue : ICldrCollationLoader);
    function IndexOf(const ALanguage : string) : Integer;
    function Find(const ALanguage : string) : TCldrCollation;
    function Load(const ALanguage : string; const AMode : TCldrParserMode) : TCldrCollation;
    function LoadType(const ALanguage, AType, ATypeALT : string) : TCldrCollationItem;
    property ItemCount : Integer read GetItemCount;
    property Items[const AIndex : Integer] : TCldrCollation read GetItem;
    property Loader : ICldrCollationLoader read FLoader;
  end;

  TRuleVisiterFunction =
    function(
      ARule  : PReorderSequence;
      AOwner : TCldrCollationItem;
      AData  : Pointer
    ) : Boolean;

  function ForEachRule(
    ACollationType : TCldrCollationItem;
    AVisitFunc     : TRuleVisiterFunction;
    ACustomData    : Pointer
  ) : Boolean;

  function ComputeWeigths(
    const AData        : PReorderUnit;
    const ADataLen     : Integer;
    const ADataWeigths : TUCA_LineRecArray;
    const AUnifiedIdeographs : TCodePointRecArray;
      out AResult      : TUCA_LineRecArray
  ) : Integer;
  function FindCollationDefaultItemName(ACollation : TCldrCollation) : string;
  procedure GenerateCdlrCollation(
    ACollation                : TCldrCollation;
    AItemName                 : string;
    AStoreName                : string;
    AStream,
    ANativeEndianStream,
    AOtherEndianStream,
    ABinaryNativeEndianStream,
    ABinaryOtherEndianStream  : TStream;
    ARootChars                : TOrderedCharacters;
    ARootWeigths              : TUCA_LineRecArray;
    AUnifiedIdeographs        : TCodePointRecArray
  );

  procedure GenerateUCA_CLDR_Head(
    ADest  : TStream;
    ABook  : PUCA_DataBook;
    AProps : PUCA_PropBook;
    ACollation : TCldrCollationItem
  );

  function FillInitialPositions(
          AData        : PReorderUnit;
    const ADataLen     : Integer;
    const ADataWeigths : TUCA_LineRecArray
  ) : Integer;

  function IndexOf(
    const APattern        : array of TUnicodeCodePoint;
    const APatternContext : array of TUnicodeCodePoint;
    const ASequence       : PReorderUnit;
    const ASequenceLength : Integer
  ) : Integer;overload;

  function TryStrToLogicalReorder(
    const AValue  : string;
    out   AResult : TReorderLogicalReset
  ) : Boolean;


resourcestring
  sCaseNothandled = 'This case is not handled : "%s", Position = %d.';
  sCodePointExpected = 'Code Point node expected as child at this position "%d".';
  sCollationsExistsAlready = 'This collation already exists : "%s"';
  sCollationsNodeNotFound = '"collations" node not found.';
  sCollationTypeNotFound = 'collation "Type" not found : "%s".';
  sHexAttributeExpected = '"hex" attribute expected at this position "%d".';
  sInvalidAlternateStatement = 'Invalid "Alternate" statement, only one option is permit by statement :"%s".';
  sInvalidBackwardsStatement = 'Invalid "Backwards" statement, only one level is permit by statement :"%s".';
  sInvalidImportStatement = 'Invalid "Import" statement, only one collation is permit by statement :"%s".';
  sInvalidNormalizationStatement = 'Invalid "Normalization" statement, only one option is permit by statement :"%s".';
  sInvalidResetClause = 'Invalid "Reset" clause.';
  sInvalidSettingExpression = 'Invalid Setting expression, Line : "%s".';
  sInvalidSettingValue = 'Invalid Setting value, Setting : "%s", Value : "%s".';
  sInvalidStrengthStatement = 'Invalid "Strength" statement, only one option is permit by statement :"%s".';
  sInvalidSuppressContractionsStatement = 'Invalid "SuppressContractions" statement, only one UnicodeSet is permit by statement :"%s".';
  sInvalidUnicodeSetExpression = 'Invalid Unicode Set expression, Line : "%s".';
  sLoaderNotSet = 'The Repository''s Loader is not set.';
  sNodeNameAssertMessage = 'Expected NodeName "%s", got "%s".';
  sRepositoryNotSet = 'The Repository is not set.';
  sRulesNodeNotFound = '"rules" node not found.';
  sSpecialCharacterExpected = 'Special character expected but found "%s", line = "%s".';
  sTextNodeChildExpected = '(Child) text node expected at this position "%d", but got "%s".';
  sUnexpectedConditionsFailure = 'Unexpected conditions failure.';
  sUniqueChildNodeExpected = 'Unique child node expected at this position "%d".';
  sUnknownResetLogicalPosition = 'Unknown reset logical position : "%s".';
  sVirtualIsReadOnly = 'Virtual logical "Reset" items are read only.';

implementation
uses
  RtlConsts, typinfo;

function TryStrToLogicalReorder(
  const AValue  : string;
  out   AResult : TReorderLogicalReset
) : Boolean;
var
  s : string;
  i : Integer;
begin
  s := StringReplace(AValue,' ','',[rfReplaceAll]);
  s := StringReplace(s,'_','',[rfReplaceAll]);
  i := GetEnumValue(TypeInfo(TReorderLogicalReset),s);
  Result := (i > -1);
  if Result then
    AResult := TReorderLogicalReset(i);
end;

function ToStr(const ACharacters : array of TUnicodeCodePoint): string;overload;
var
  i : Integer;
begin
  Result := '';
  for i := Low(ACharacters) to High(ACharacters) do begin
    if (ACharacters[i] > $FFFF) then
      Result := Result + ' ' + IntToHex(ACharacters[i],5)
    else
      Result := Result + ' ' + IntToHex(ACharacters[i],4);
  end;
  Result := Trim(Result);
end;

function ToStr(const AWeights : array of TUCA_WeightRec): string;overload;
var
  i : Integer;
  p : ^TUCA_WeightRec;
begin
  Result := '';
  p := @AWeights[Low(AWeights)];
  for i := 1 to Length(AWeights) do begin
    Result :=
      Format('%s {%s %s %s %s}',
        [ Result,IntToHex(p^.Weights[0],4),IntToHex(p^.Weights[1],4),
          IntToHex(p^.Weights[2],4), IntToHex(p^.Weights[3],4)
        ]
      );
    Inc(p);
  end;
  Result := Trim(Result);
end;

function IsZero(AItems : TUCA_WeightRecArray) : Boolean;
const ZERO_ITEM  : TUCA_WeightRec = (
        Weights  : (0,0,0,0);
        Variable : False;
      );
var
  c, i : Integer;
begin
  c := Length(AItems);
  if (c < 1) then
    exit(True);
  Result := (AItems[0] = ZERO_ITEM);{
  for i := 0 to c-1 do begin
    if (AItems[i] <> ZERO_ITEM) then
      exit(False);
  end;
  Result := True;}
end;

function IndexOf(
  const APattern        : array of TUnicodeCodePoint;
  const APatternContext : array of TUnicodeCodePoint;
  const ASequence       : PReorderUnit;
  const ASequenceLength : Integer
) : Integer;
var
  i, lp, sizep, lengthContext, sizeContext : Integer;
  p : PReorderUnit;
begin
  Result := -1;
  if (ASequenceLength = 0) then
    exit;
  lp := Length(APattern);
  if (lp = 0) then
    exit;
  sizep := lp*SizeOf(TUnicodeCodePoint);
  lengthContext := Length(APatternContext);
  sizeContext := lengthContext*SizeOf(TUnicodeCodePoint);
  p := ASequence;
  for i := 0 to ASequenceLength - 1 do begin
    if (Length(p^.Characters) = lp) then begin
      if CompareMem(@APattern[0],@p^.Characters[0],sizep) then begin
        if (Length(p^.Context) = lengthContext) and
           ( (lengthContext = 0) or
             CompareMem(@p^.Context[0],@APatternContext[0],sizeContext)
           )
        then begin
          Result := i;
          Break;
        end;
      end;
    end;
    Inc(p);
  end;
end;

{procedure ApplyStatementToSequence(
  var   ASequence  : TOrderedCharacters;
  const AStatement : PReorderSequence;
  const AStatementCount : Integer
);
var
  pse, pd : PReorderUnit;
  kr : Integer;

  function GetNextInsertPos() : Integer;
  var
    kk : Integer;
  begin
    if (pse^.WeigthKind = rwkDeletion) then
      exit(0);
    if (pse^.WeigthKind = rwkIdentity) then
      exit(kr + 1);
    kk := kr + 1;
    pd := @ASequence.Data[kk];
    for kk := kk to ASequence.ActualLength - 1 do begin
      if (pd^.WeigthKind <= pse^.WeigthKind) then
        exit(kk);
      Inc(pd);
    end;
    Result := ASequence.ActualLength;
  end;

var
  locResetPos, i, k, h : Integer;
  pst : PReorderSequence;
begin
  pst := AStatement;
  for h := 0 to AStatementCount - 1 do begin
    locResetPos := -1;
    if (Length(pst^.Reset) > 0) then begin
      locResetPos := IndexOf(pst^.Reset,[],@ASequence.Data[0],ASequence.ActualLength);
      if (locResetPos = -1) then
        raise ECldrException.CreateFmt('Character(s) not found in sequence : "%s".',[ToStr(pst^.Reset)]);
    end;
    pse := @pst^.Elements[0];
    kr := locResetPos;
    k := GetNextInsertPos();
    for i := Low(pst^.Elements) to High(pst^.Elements) do begin
      k := ASequence.Insert(pse^,k)+1;
      Inc(pse);
    end;
    Inc(pst);
  end;
end;}
function FindLogicalPos(
  const ASequence  : POrderedCharacters;
  const APosition  : TReorderLogicalReset
) : Integer;
var
  i, c : Integer;
  p : PReorderUnit;
  firstPos, lastPos : Integer;
begin
  Result := 0;
  if (ASequence^.ActualLength = 0) then
    exit;
  p := @ASequence^.Data[0];
  c := ASequence^.ActualLength;
  if (APosition in FixableReorderLogicalSet) then begin
    for i := 0 to c - 1 do begin
      if (p^.VirtualPosition = APosition) then
        exit(i);
      Inc(p);
    end;
    p := @ASequence^.Data[0];
  end;
  if (APosition in [TReorderLogicalReset.FirstTertiaryIgnorable, TReorderLogicalReset.LastTertiaryIgnorable])
  then begin
    firstPos := -1;
    for i := 0 to c - 1 do begin
      if (p^.WeigthKind <= TReorderWeigthKind.Tertiary) then begin
        firstPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (firstPos = -1) then
      exit(0);
    if (APosition = TReorderLogicalReset.FirstTertiaryIgnorable) then
      exit(firstPos);
    if (p^.WeigthKind < TReorderWeigthKind.Tertiary) then
      exit(firstPos);
    lastPos := -1;
    for i := firstPos + 1 to c - 1 do begin
      if (p^.WeigthKind <> TReorderWeigthKind.Identity) then begin
        lastPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (lastPos = -1) then
      exit(c);
    exit(lastPos);
  end;
  if (APosition in [TReorderLogicalReset.FirstSecondaryIgnorable, TReorderLogicalReset.LastSecondaryIgnorable])
  then begin
    firstPos := -1;
    for i := 0 to c - 1 do begin
      if (p^.WeigthKind <= TReorderWeigthKind.Secondary) then begin
        firstPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (firstPos = -1) then
      exit(0);
    if (APosition = TReorderLogicalReset.FirstSecondaryIgnorable) then
      exit(firstPos);
    if (p^.WeigthKind < TReorderWeigthKind.Secondary) then
      exit(firstPos);
    lastPos := -1;
    for i := firstPos + 1 to c - 1 do begin
      if (p^.WeigthKind <> TReorderWeigthKind.Identity) then begin
        lastPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (lastPos = -1) then
      exit(c);
    exit(lastPos);
  end;
  if (APosition in [TReorderLogicalReset.FirstPrimaryIgnorable, TReorderLogicalReset.LastPrimaryIgnorable])
  then begin
    firstPos := -1;
    for i := 0 to c - 1 do begin
      if (p^.WeigthKind <= TReorderWeigthKind.Primary) then begin
        firstPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (firstPos = -1) then
      exit(0);
    if (APosition = TReorderLogicalReset.FirstPrimaryIgnorable) then
      exit(firstPos);
    if (p^.WeigthKind < TReorderWeigthKind.Primary) then
      exit(firstPos);
    lastPos := -1;
    for i := firstPos + 1 to c - 1 do begin
      if (p^.WeigthKind <> TReorderWeigthKind.Identity) then begin
        lastPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (lastPos = -1) then
      exit(c);
    exit(lastPos);
  end;
  if (APosition = TReorderLogicalReset.FirstNonIgnorable) then begin
    firstPos := -1;
    for i := 0 to c - 1 do begin
      if (p^.WeigthKind <= TReorderWeigthKind.Primary) then begin
        firstPos := i;
        Break;
      end;
      Inc(p);
    end;
    if (firstPos = -1) then
      exit(0);
    exit(firstPos);
  end;
  if (APosition in [TReorderLogicalReset.LastNonIgnorable,TReorderLogicalReset.LastRegular])
  then begin
    exit(c);
  end;
  for i := 0 to c - 1 do begin
    if (p^.VirtualPosition = APosition) then
      exit(i);
    Inc(p);
  end;
end;

procedure ApplyStatementToSequence(
  var   ASequence  : TOrderedCharacters;
  const AStatement : PReorderSequence;
  const AStatementCount : Integer
);
var
  pse, pd : PReorderUnit;
  kr : Integer;
  pst : PReorderSequence;

  function GetNextInsertPos() : Integer;
  var
    kk : Integer;
  begin
    if (pse^.WeigthKind = TReorderWeigthKind.Deletion) then
      exit(0);
    if (pse^.WeigthKind = TReorderWeigthKind.Identity) then
      exit(kr + 1);
    if not pst^.Before then begin
      kk := kr + 1;
      if (kk >= ASequence.ActualLength) then
        exit(kk);
      pd := @ASequence.Data[kk];
      for kk := kk to ASequence.ActualLength - 1 do begin
        if (pd^.WeigthKind <= pse^.WeigthKind) then
          exit(kk);
        Inc(pd);
      end;
      Result := ASequence.ActualLength;
    end else begin
      if (kr = 0) then
        exit(0);
      pd := @ASequence.Data[kr];
      if pd^.IsVirtual() and (pd^.VirtualPosition in FixableReorderLogicalSet) then begin
        kr := kr-1;
        if (kr = 0) then
          exit;
      end;
      kk := kr;
      pd := @ASequence.Data[kk];
      if (pd^.WeigthKind = TReorderWeigthKind.Primary) then begin
        pd^.WeigthKind := pse^.WeigthKind;
        pse^.WeigthKind := TReorderWeigthKind.Primary;
        exit(kk);
      end;
      for kk := kk downto 0 do begin
        if (pd^.WeigthKind = TReorderWeigthKind.Deletion) or (pd^.WeigthKind <= pse^.WeigthKind) then begin
          if (pd^.WeigthKind > pse^.WeigthKind) then
            pd^.WeigthKind := pse^.WeigthKind;
          exit(kk);
        end;
        Dec(pd);
      end;
      Result := 0;
    end;
  end;

var
  locResetPos, i, k, h : Integer;
begin
  if (Length(AStatement^.Elements) = 0) then
    exit;
  pst := AStatement;
  for h := 0 to AStatementCount - 1 do begin
    locResetPos := -1;
    if (pst^.LogicalPosition > TReorderLogicalReset.None) then
      locResetPos := FindLogicalPos(@ASequence,pst^.LogicalPosition)
    else if (Length(pst^.Reset) > 0) then begin
      locResetPos := IndexOf(pst^.Reset,[],@ASequence.Data[0],ASequence.ActualLength);
      {if (locResetPos = -1) then
        raise ECldrException.CreateFmt('Character(s) not found in sequence : "%s".',[ToStr(pst^.Reset)]);}
      if (locResetPos = -1) then
        locResetPos := ASequence.ActualLength;
    end;
    if (pst^.LogicalPosition in FixableReorderLogicalSet) then begin
      if (locResetPos < 0) or
         (locResetPos >= ASequence.ActualLength) or
         not(ASequence.Data[locResetPos].VirtualPosition in FixableReorderLogicalSet)
      then begin
        locResetPos := ASequence.Append(TReorderUnit.From(pst^.LogicalPosition));
      end;
    end;

    pse := @pst^.Elements[0];
    kr := locResetPos;
    k := GetNextInsertPos();
    for i := Low(pst^.Elements) to High(pst^.Elements) do begin
      k := ASequence.Insert(pse^,k)+1;
      Inc(pse);
    end;
    Inc(pst);
  end;
end;

type
  PUCA_WeightRecArray = ^TUCA_WeightRecArray;
  TUCASortKey = array of Word;

function SimpleFormKey(const ACEList : TUCA_WeightRecArray) : TUCASortKey;
var
  r : TUCASortKey;
  i, c, k, ral, levelCount : Integer;
  pce : ^TUCA_WeightRec;
begin
  c := Length(ACEList);
  if (c = 0) then
    exit(nil);
  //SetLength(r,((3+1{Level Separator})*c));
  levelCount := Length(ACEList[0].Weights);
  if (levelCount > 3) then
    levelCount := 3;
  SetLength(r,(levelCount*c + levelCount));
  ral := 0;
  for i := 0 to levelCount - 1 do begin
    for k := 0 to c - 1 do begin
      pce := @ACEList[k];
      if (pce^.Weights[i] <> 0) then begin
        r[ral] := pce^.Weights[i];
        ral := ral + 1;
      end;
      //pce := pce + 1;
    end;
    r[ral] := 0;
    ral := ral + 1;
  end;
  ral := ral - 1;
  SetLength(r,ral);
  Result := r;
end;

function CompareSortKey(const A, B : TUCASortKey) : Integer;
var
  i, hb : Integer;
begin
  if (Pointer(A) = Pointer(B)) then
    exit(0);
  Result := 1;
  hb := Length(B) - 1;
  for i := 0 to Length(A) - 1 do begin
    if (i > hb) then
      exit;
    if (A[i] < B[i]) then
      exit(-1);
    if (A[i] > B[i]) then
      exit(1);
  end;
  if (Length(A) = Length(B)) then
    exit(0);
  exit(-1);
end;

{function ComputeWeigths(
  const AData        : PReorderUnit;
  const ADataLen     : Integer;
  const ADataWeigths : TUCA_LineRecArray;
  out   AResult      : TUCA_LineRecArray
) : Integer;

  function GetWeigth(AItem : PReorderUnit) : PUCA_WeightRecArray;
  begin
    Result := nil;
    if (AItem^.InitialPosition < 1) or (AItem^.InitialPosition > Length(ADataWeigths)) then
      raise ECldrException.CreateFmt('Invalid "InitialPosition" value : %d.',[AItem^.InitialPosition]);
    Result := @ADataWeigths[(AItem^.InitialPosition-1)].Weights;
  end;

var
  c, i, ral : Integer;
  p, q : PReorderUnit;
  r : TUCA_LineRecArray;
  pr : PUCA_LineRec;
  pbase : PReorderUnit;
  pw, pwb : PUCA_WeightRecArray;
  cw, ki : Integer;
begin
  Result := 0;
  if (ADataLen < 1) then
    exit;
  c := ADataLen;
  ral := 0;
  SetLength(r,c);
  FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
  q := nil;
  pbase := nil;
  p := AData+1;
  pr := @r[0];
  i := 1;
  while (i < c) do begin
    if p^.Changed then begin
      if (pbase = nil) then begin
        pbase := p - 1;
        pwb := GetWeigth(pbase);
      end;
      if (p^.WeigthKind = rwkIdentity) then begin
        pr^.CodePoints := Copy(p^.Characters);
        q := p - 1;
        if (q = pbase) then
          pw := pwb
        else
          pw := @((pr-1)^.Weights);
        pr^.Weights := Copy(pw^);
        Inc(pr);
        Inc(ral);
      end else begin
        pr^.CodePoints := Copy(p^.Characters);
        q := p - 1;
        if (q = pbase) then begin
          pw := pwb;
          cw := (Length(pw^)+1);
          SetLength(pr^.Weights,cw);
          Move(pw^[0],pr^.Weights[0],((cw-1)*SizeOf(pw^[0])));
          FillByte(pr^.Weights[(cw-1)],SizeOf(pr^.Weights[0]),0);
          ki := Ord(p^.WeigthKind);
          pr^.Weights[(cw-1)].Weights[ki] := pr^.Weights[(cw-2)].Weights[ki]+1;
        end else begin
          pw := @((pr-1)^.Weights);
          pr^.Weights := Copy(pw^);
          cw := Length(pr^.Weights);
          ki := Ord(p^.WeigthKind);
          for ki := Ord(rwkPrimary) to Ord(rwkTertiary) do begin
            if (ki < Ord(p^.WeigthKind)) then
              pr^.Weights[(cw-1)].Weights[ki] := pw^[(cw-1)].Weights[ki]
            else if (ki = Ord(p^.WeigthKind)) then begin
              if (pw^[(cw-1)].Weights[ki] = 0) then
                pr^.Weights[(cw-1)].Weights[ki] := pwb^[(Length(pwb^)-1)].Weights[ki]+1
              else
                pr^.Weights[(cw-1)].Weights[ki] := pw^[(cw-1)].Weights[ki]+1;
            end else begin
              pr^.Weights[(cw-1)].Weights[ki] := 0;
            end;
          end;
        end;
        Inc(pr);
        Inc(ral);
      end;
    end else begin
      pbase := nil;
      pwb := nil;
    end;
    Inc(p);
    Inc(i);
  end;
  SetLength(r,ral);
  AResult := r;
  Result := Length(AResult);
end;}
function IndexOf(
  const APattern : array of TUnicodeCodePoint;
  const AList    : PUCA_LineRec;
  const AListLen : Integer
) : Integer;overload;
var
  i, lengthPattern, sizePattern : Integer;
  pl : PUCA_LineRec;
begin
  Result := -1;
  if (Length(APattern) = 0) then
    exit;
  if (AListLen = 0) then
    exit;
  lengthPattern := Length(APattern);
  sizePattern := lengthPattern*SizeOf(TUnicodeCodePoint);
  pl := AList;
  for i := 0 to AListLen - 1 do begin
    if (Length(pl^.CodePoints) = lengthPattern) and
       CompareMem(@pl^.CodePoints[0],@APattern[0],sizePattern)
    then begin
      Result := i;
      Break;
    end;
    Inc(pl);
  end;
end;

function IsIgnorable(AWeight : TUCA_WeightRecArray) : Boolean;
var
  i : Integer;
begin
  if (Length(AWeight) = 0) then
    exit(True);
  for i := Low(AWeight) to High(AWeight) do begin
    if (AWeight[i].Weights[0] <> 0) or
       (AWeight[i].Weights[1] <> 0) or
       (AWeight[i].Weights[2] <> 0)
    then begin
      exit(False);
    end;
  end;
  Result := True;
end;

function RemoveIgnorables(
        AItem    : TUnicodeCodePointArray;
  const AList    : PUCA_LineRec;
  const AListLen : Integer
) : TUnicodeCodePointArray;
var
  i, c, k : Integer;
begin
  SetLength(Result,Length(AItem));
  c := 0;
  for i := 0 to Length(AItem) - 1 do begin
    k := IndexOf([AItem[i]],AList,AListLen);
    if (k >= 0) and
       IsIgnorable(AList[k].Weights)
    then
      k := -1;
    if (k >= 0) then begin
      Result[c] := AItem[i];
      c := c+1;
    end;
  end;
  SetLength(Result,c);
end;

function Compress(
  const AData   : TUCA_LineRecArray;
  out   AResult : TUCA_LineRecArray
) : Boolean;
var
  r : TUCA_LineRecArray;
  pr, p : PUCA_LineRec;
  ral : Integer;

  function FindOutSlot() : Boolean;
  var
    k : Integer;
  begin
    k := IndexOf(p^.CodePoints,@r[0],ral);
    Result := (k >= 0);
    if (k = -1) then begin
      k := ral;
      ral := ral + 1;
    end;
    pr := @r[k];
  end;

  procedure AddContextData();
  var
    k : Integer;
  begin
    if not p^.HasContext() then
      exit;
    k := Length(pr^.Context.Data);
    SetLength(pr^.Context.Data,(k+1));
    pr^.Context.Data[k].CodePoints := Copy(p^.Context.Data[0].CodePoints);
    pr^.Context.Data[k].Weights := Copy(p^.Weights);
  end;

  procedure AddItem();
  begin
    pr^.Assign(p);
    if p^.HasContext() then begin
      SetLength(pr^.Context.Data,0);
      pr^.Weights := nil;
      AddContextData();
    end;
  end;

var
  c, i : Integer;
begin
  c := Length(AData);
  if (c = 0) then
    exit;
  SetLength(r,c);
  FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
  pr := @r[0];
  p := @AData[0];
  ral := 0;
  i := 0;
  AddItem();
  ral := 1;
  i := 1;
  Inc(p);
  while (i < c) do begin
    if FindOutSlot() then
      AddContextData()
    else
      AddItem();
    Inc(p);
    Inc(i);
  end;
  SetLength(r,ral);
  AResult := r;
  Result := (ral < Length(AData));
end;

function MarkSuffixAsChanged(
  const AData : PReorderUnit;
  const ADataLen : Integer
) : Integer;
var
  i, k : Integer;
  p, q : PReorderUnit;
  suffixChar : TUnicodeCodePoint;
begin
  Result := 0;
  if (ADataLen <= 1) then
    exit;
  q := AData;
  p := AData;
  for i := 0 to ADataLen - 1 do begin
    if not(p^.IsVirtual()) and p^.Changed then begin
      suffixChar := p^.Characters[0];
      for k := 0 to ADataLen - 1 do begin
        if not(q[k].Changed) and (q[k].Characters[0] = suffixChar) then begin
          q[k].Changed := True;
          Result := Result + 1;
        end;
      end;
    end;
    Inc(p);
  end;
end;

function CountChangedPrimaries(APosition, AEnd : PReorderUnit) : Integer;
var
  p : PReorderUnit;
begin
  p := APosition+1;
  while (p < AEnd) and
        p^.Changed and (p^.WeigthKind = TReorderWeigthKind.Primary)
  do begin
    p := p+1;
  end;
  Result := (p-(APosition+1));
end;

function FindNextUnchangedPrimary(AStartPos, AEnd : PReorderUnit) : PReorderUnit;
var
  p : PReorderUnit;
begin
  p := AStartPos;
  while (p < AEnd) and (p^.WeigthKind <> TReorderWeigthKind.Primary) do begin
    p := p+1;
  end;
  if (p >= AEnd) or p^.Changed or
     (p^.WeigthKind <> TReorderWeigthKind.Primary) or
     (p^.InitialPosition < 1)
  then begin
    p := nil;
  end;
  Result := p;
end;

function ComputeWeigthItem(
  ABase        : PUCA_WeightRecArray;
  APosition    : PReorderUnit;
  AEnd         : PReorderUnit;
  ADataWeigths : TUCA_LineRecArray
) : TUCA_WeightRecArray;
var
  r : TUCA_WeightRecArray;
  c, i : Integer;
  p : PReorderUnit;
  changedPrimaryCount : Integer;
  nextUnchangedPrimary : PReorderUnit;
begin
  case APosition^.WeigthKind of
    TReorderWeigthKind.Primary :
      begin
        if (Length(ABase^) = 2) and
           (ABase^[1].Weights[1] = 0) and (ABase^[1].Weights[2] = 0)
        then begin
          r := Copy(ABase^);
          Inc(r[1].Weights[0]);
        end else begin
          changedPrimaryCount :=  CountChangedPrimaries(APosition,AEnd);
          nextUnchangedPrimary := FindNextUnchangedPrimary(APosition+changedPrimaryCount+1,AEnd);
          if (nextUnchangedPrimary = nil) or
             ( (ABase^[0].Weights[0]+changedPrimaryCount+1) >=
               ADataWeigths[nextUnchangedPrimary^.InitialPosition-1].Weights[0].Weights[0]
             )
          then begin
            p := nil;
            if (nextUnchangedPrimary = nil) and (APosition < (AEnd-1)) then begin
              p := APosition+1;
            end;
            if (nextUnchangedPrimary = nil) and
               ( (p = nil) or (p^.WeigthKind = TReorderWeigthKind.Primary)) and
               (Length(ABase^) = 1) and (ABase^[0].Weights[0] < $FFF0)
            then begin
              SetLength(r,1);
              FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
              r[0].Weights[0] := (ABase^[0].Weights[0] + 1);
              r[0].Variable := ABase^[0].Variable;
            end else begin
              SetLength(r,2);
              FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
              r[0].Weights[0] := (ABase^[0].Weights[0] + 1);
              r[0].Variable := ABase^[0].Variable;
              r[1].Weights[0] := 1;
            end;
          end else begin
            SetLength(r,2);
            FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
            r[0].Weights[0] := (ABase^[0].Weights[0] + 1);
            r[0].Variable := ABase^[0].Variable;
            r[1] := r[0];
          end;
        end;
      end;
    TReorderWeigthKind.Secondary :
      begin
        c := Length(ABase^);
        SetLength(r,c);
        FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
        for i := 0 to c-1 do begin
          r[i].Weights[0] := ABase^[i].Weights[0];
          r[i].Variable := ABase^[i].Variable;
        end;
        r[0].Weights[1] := (ABase^[0].Weights[1] + 1);
      end;
    TReorderWeigthKind.Tertiary :
      begin
        c := Length(ABase^);
        SetLength(r,c);
        FillByte(r[0],(Length(r)*SizeOf(r[0])),0);
        for i := 0 to c-1 do begin
          r[i].Weights[0] := ABase^[i].Weights[0];
          r[i].Weights[1] := ABase^[i].Weights[1];
          r[i].Variable := ABase^[i].Variable;
        end;
        r[0].Weights[2] := (ABase^[0].Weights[2] + 1);
      end;
    TReorderWeigthKind.Identity : r := Copy(ABase^);
    else
      r := nil;
  end;
  Result := r;
end;

{$DEFINE UNI_BUILD_TIME}
{$include weight_derivation.inc}

function InternalComputeWeigths(
  const AData        : PReorderUnit;
  const ADataLen     : Integer;
  const ADataWeigths : TUCA_LineRecArray;
  const AUnifiedIdeographs : TCodePointRecArray;
    out AResult      : TUCA_LineRecArray
) : Integer;

  function GetWeigth(AItem : PReorderUnit) : PUCA_WeightRecArray;
  begin
    Result := nil;
    if (AItem^.InitialPosition < 1) or (AItem^.InitialPosition > Length(ADataWeigths)) then
      raise ECldrException.CreateFmt('Invalid "InitialPosition" value : %d.',[AItem^.InitialPosition]);
    Result := @ADataWeigths[(AItem^.InitialPosition-1)].Weights;
  end;

var
  r : TUCA_LineRecArray;
  pr : PUCA_LineRec;
  dataEnd : PReorderUnit;

  procedure AddContext(const ACodePointPattern : TUnicodeCodePointArray);
  var
    k : Integer;
  begin
    k := Length(pr^.Context.Data);
    SetLength(pr^.Context.Data,(k+1));
    pr^.Context.Data[k].CodePoints := Copy(ACodePointPattern);
    SetLength(pr^.Context.Data[k].Weights,0);
  end;

var
  ral : Integer;
  i : Integer;
  p : PReorderUnit;
  pbase : PReorderUnit;
  pwb : PUCA_WeightRecArray;
  actualBegin : Boolean;
  loopIndex : Integer;

  procedure SkipDeletion();
  begin
    pr^.CodePoints := Copy(p^.Characters);
    pr^.Deleted := True;
    SetLength(pr^.Weights,0);
    if p^.HasContext() then
      AddContext(p^.Context);
    Inc(pr);
    Inc(ral);
    Inc(p);
    Inc(i);
  end;

  procedure FindBaseItem();
  begin
    if (pbase = nil) or (pwb^ = nil) then begin
      if actualBegin then begin
        pwb := @ADataWeigths[0].Weights;
      end else begin
        pbase := p - 1;
        if pbase^.Changed then
          pwb := @((pr-1)^.Weights)
        else
          pwb := GetWeigth(pbase);
        if (pwb^ = nil) and (pbase = AData) then
          pwb := @ADataWeigths[0].Weights;
      end;
    end;
  end;

  function InternalComputeWeights(const AList : array of TUnicodeCodePointArray) : TUCA_WeightRecArray;
  var
    kral : Integer;
    kres : TUCA_WeightRecArray;

    procedure EnsureResultLength(const APlus : Integer);//inline;
    begin
      if ((kral+APlus) > Length(kres)) then
        SetLength(kres,(2*(kral+APlus)));
    end;

    procedure AddToResult(const AValue : TUCA_WeightRecArray);//inline;
    begin
      if not IsZero(AValue) then begin
        EnsureResultLength(Length(AValue));
        Move(AValue[0],kres[kral],(Length(AValue)*SizeOf(kres[0])));
        kral := kral + Length(AValue);
      end;
    end;

  var
    kc, k, ktempIndex, ki : Integer;
    tmpWeight : array of TUCA_PropWeights;
    cp : TUnicodeCodePoint;
  begin
    kc := Length(AList);
    kral := 0;
    SetLength(kres,(10*kc));
    FillChar(kres[0],(Length(kres)*SizeOf(kres[0])),0);
    for k := 0 to kc - 1 do begin
      ktempIndex := IndexOf(AList[k],@r[0],ral);
      if (ktempIndex <> -1) then begin
        AddToResult(r[ktempIndex].Weights);
        Continue;
      end;
      ktempIndex := IndexOf(AList[k],[],AData,ADataLen);
      if (ktempIndex <> -1) then begin
        if not AData[ktempIndex].Changed then begin
          AddToResult(ADataWeigths[AData[ktempIndex].InitialPosition-1].Weights);
          Continue;
        end;
      end;
      if (Length(AList[k]) > 1) then begin
        for ki := 0 to Length(AList[k]) - 1 do begin
          ktempIndex := IndexOf([AList[k][ki]],@r[0],ral);
          if (ktempIndex <> -1) then begin
            AddToResult(r[ktempIndex].Weights);
            Continue;
          end;
          cp := AList[k][ki];
          ktempIndex := IndexOf([cp],[],AData,ADataLen); //ktempIndex := IndexOf([AList[k][ki]],[],AData,ADataLen);
          if (ktempIndex <> -1) then begin
            //if not AData[ktempIndex].Changed then begin
              AddToResult(ADataWeigths[AData[ktempIndex].InitialPosition-1].Weights);
              Continue;
            //end;
          end;
          SetLength(tmpWeight,2);
          DeriveWeight(AList[k][ki],@tmpWeight[0],AUnifiedIdeographs);
          EnsureResultLength(2);
          kres[kral].Weights[0] := tmpWeight[0].Weights[0];
          kres[kral].Weights[1] := tmpWeight[0].Weights[1];
          kres[kral].Weights[2] := tmpWeight[0].Weights[2];
          kres[kral+1].Weights[0] := tmpWeight[1].Weights[0];
          kres[kral+1].Weights[1] := tmpWeight[1].Weights[1];
          kres[kral+1].Weights[2] := tmpWeight[1].Weights[2];
          kral := kral + 2;
          tmpWeight := nil;
        end;
        Continue;// ??????????????
      end;
      SetLength(tmpWeight,2);
      DeriveWeight(AList[k][0],@tmpWeight[0],AUnifiedIdeographs);
      EnsureResultLength(2);
      kres[kral].Weights[0] := tmpWeight[0].Weights[0];
      kres[kral].Weights[1] := tmpWeight[0].Weights[1];
      kres[kral].Weights[2] := tmpWeight[0].Weights[2];
      kres[kral+1].Weights[0] := tmpWeight[1].Weights[0];
      kres[kral+1].Weights[1] := tmpWeight[1].Weights[1];
      kres[kral+1].Weights[2] := tmpWeight[1].Weights[2];
      kral := kral + 2;
      tmpWeight := nil;
    end;
    SetLength(kres,kral);
    Result := kres;
  end;

  procedure Handle_Expansion();
  var
    expChars : array[0..1] of TUnicodeCodePointArray;
    kres : TUCA_WeightRecArray;
  begin
    expChars[0] := (p-1)^.Characters;
    expChars[1] := p^.ExpansionChars;
    kres := InternalComputeWeights(expChars);
    pr^.Weights := ComputeWeigthItem(@kres,p,dataEnd,ADataWeigths);
  end;

  function FindLastNotEmptyWeigth() : PUCA_LineRec;
  var
    p0, pk : PUCA_LineRec;
  begin
    p0 := @r[0];
    pk := pr-1;
    while (pk >= p0) do begin
      if (Length(pk^.Weights) > 0) then
        exit(pk);
      pk := pk-1;
    end;
    Result := nil;
  end;

  procedure CheckWeight(AItem : TUCA_WeightRecArray);
  begin
    if (Length(AItem) = 0) then
      raise ECldrException.Create(sUnexpectedConditionsFailure);
  end;

var
  c, ti : Integer;
  q : PReorderUnit;
  pw : PUCA_WeightRecArray;
  pt : PUCA_LineRec;
begin
  Result := 0;
  if (ADataLen < 1) then
    exit;
  SetLength(AResult,0);
  dataEnd := AData+ADataLen;
  while True do begin
    for loopIndex := 0 to 1 do begin
      c := ADataLen;
      ral := 0;
      SetLength(r,c);
      pr := @r[0];
      for i := Low(r) to High(r) do begin
        pr^.Clear();
        Inc(pr);
      end;
      q := nil;
      pbase := nil;
      pr := @r[0];
      p := AData;
      i := 0;
      while (i < c) do begin
        if (p^.WeigthKind = TReorderWeigthKind.Deletion) then begin
          SkipDeletion();
          Continue;
        end;
        if p^.Changed then begin
          actualBegin := (i = 0) or (((p-1)^.WeigthKind = TReorderWeigthKind.Deletion));
          FindBaseItem();
          if p^.IsExpansion() then begin
            if (loopIndex = 0) then begin
              q := p;
              Inc(p);
              Inc(i);
              while (i < c) do begin
                if (p^.WeigthKind = TReorderWeigthKind.Primary) then
                  Break;
                Inc(p);
                Inc(i);
              end;
              Continue;
            end;
            pr^.CodePoints := Copy(p^.Characters);
            Handle_Expansion();
            if p^.HasContext() then
              AddContext(p^.Context);
            Inc(pr);
            Inc(ral);
          end else if actualBegin then begin
            pr^.CodePoints := Copy(p^.Characters);
            pw := pwb;
            CheckWeight(pw^);
            pr^.Weights := Copy(pw^);
            if p^.HasContext() then
              AddContext(p^.Context);
            Inc(pr);
            Inc(ral);
          end else if (p^.WeigthKind = TReorderWeigthKind.Identity) then begin
            pr^.CodePoints := Copy(p^.Characters);
            q := p - 1;
            if (q = pbase) then
              pw := pwb
            else
              pw := @((pr-1)^.Weights);
            CheckWeight(pw^);
            pr^.Weights := Copy(pw^);
            if p^.HasContext() then
              AddContext(p^.Context);
            Inc(pr);
            Inc(ral);
          end else begin
            CheckWeight(pwb^);
            pr^.CodePoints := Copy(p^.Characters);
            if ((p - 1) = pbase) then begin
              pr^.Weights := ComputeWeigthItem(pwb,p,dataEnd,ADataWeigths);
            end else begin
              if (Length(pr^.Weights) = 0) then begin
                pt := FindLastNotEmptyWeigth();
                if (pt = nil) then
                  raise ECldrException.Create(sUnexpectedConditionsFailure);
                CheckWeight(pt^.Weights);
              end;
              pr^.Weights := ComputeWeigthItem(@pt^.Weights,p,dataEnd,ADataWeigths);
            end;
            if p^.HasContext() then
              AddContext(p^.Context);
            Inc(pr);
            Inc(ral);
          end;
        end else begin
          if (i > 0) and ((p-1)^.WeigthKind <> TReorderWeigthKind.Deletion) and (p-1)^.Changed and
             (ral > 0)
          then begin
            pw := GetWeigth(p);
            CheckWeight(pw^);
            ti := CompareSortKey(SimpleFormKey((pr-1)^.Weights),SimpleFormKey(pw^));
            if ( (p^.WeigthKind = TReorderWeigthKind.Identity) and (ti > 0) ) or
               ( (p^.WeigthKind >= TReorderWeigthKind.Primary) and (ti >= 0) )
            then begin
              p^.Changed := True;
              Continue;
            end;
          end;
          pbase := nil;
          pwb := nil;
        end;
        Inc(p);
        Inc(i);
      end;
    end;
    SetLength(r,ral);
    if (MarkSuffixAsChanged(AData,ADataLen) = 0) then
      Break;
  end;
  Compress(r,AResult);
  Result := Length(AResult);
end;

function ComputeWeigths(
  const AData        : PReorderUnit;
  const ADataLen     : Integer;
  const ADataWeigths : TUCA_LineRecArray;
  const AUnifiedIdeographs : TCodePointRecArray;
    out AResult      : TUCA_LineRecArray
) : Integer;
var
  locData : array of TReorderUnit;
  i, actualLength : Integer;
  p : PReorderUnit;
begin
  SetLength(AResult,0);
  SetLength(locData,ADataLen);
  actualLength := 0;
  p := AData;
  for i := 0 to ADataLen-1 do begin
    if not p^.IsVirtual() then begin
      locData[actualLength].Assign(p);
      actualLength := actualLength+1;
    end;
    Inc(p);
  end;
  if (Length(locData) <> actualLength) then
    SetLength(locData,actualLength);
  Result := InternalComputeWeigths(@locData[0],actualLength,ADataWeigths,AUnifiedIdeographs,AResult);

  p := AData;
  for i := 0 to actualLength-1 do begin
    while p^.IsVirtual() do begin
      Inc(p);
    end;
    p^.Assign(@locData[i]);
    Inc(p);
  end;
end;

const
  // Bidirectional Ordering Controls : Unicode 9 => Page 833
  ARABIC_LETTER_MARK = $061C;//  ALM arabic letter mark alm
  LEFT_TO_RIGHT_MARK = $200E;//  LRM left-to-right mark lrm
  RIGHT_TO_LEFT_MARK = $200F;//  RLM right-to-left mark rlm
  LEFT_TO_RIGHT_EMBEDDING = $202A;//  LRE left-to-right embedding lre
  RIGHT_TO_LEFT_EMBEDDING = $202B;//  RLE right-to-left embedding rle
  POP_DIRECTIONAL_FORMATTING = $202C;//  PDF pop directional formatting pdf
  LEFT_TO_RIGHT_OVERRIDE = $202D;//  LRO left-to-right override lro
  RIGHT_TO_LEFT_OVERRIDE = $202E;//  RLO right-to-left override rlo
  LEFT_TO_RIGHT_ISOLATE = $2066;//  LRI left-to-right isolate lri
  RIGHT_TO_LEFT_ISOLATE = $2067;//  RLI right-to-left isolate rli
  FIRST_STRONG_ISOLATE = $2068;//  FSI first strong isolate fsi
  POP_DIRECTIONAL_ISOLATE = $2069;//  PDI pop directional isolate pdi

  BIDIRECTIONAL_ORDERING_CONTROLS : array[0..11] of DWord = (
    ARABIC_LETTER_MARK, LEFT_TO_RIGHT_MARK, RIGHT_TO_LEFT_MARK,
    LEFT_TO_RIGHT_EMBEDDING, RIGHT_TO_LEFT_EMBEDDING,
    POP_DIRECTIONAL_FORMATTING, LEFT_TO_RIGHT_OVERRIDE, RIGHT_TO_LEFT_OVERRIDE,
    LEFT_TO_RIGHT_ISOLATE, RIGHT_TO_LEFT_ISOLATE, FIRST_STRONG_ISOLATE,
    POP_DIRECTIONAL_ISOLATE
  );

function IsBidirectionalOrderingControls(const ACodePoint : DWord) : Boolean;inline;
begin
  Result :=
    IndexDWord(
      BIDIRECTIONAL_ORDERING_CONTROLS, SizeOf(BIDIRECTIONAL_ORDERING_CONTROLS),
      ACodePoint
    ) >= 0;
end;

function RemoveBidirectionalOrderingControls(
  AItem : TUnicodeCodePointArray
) : TUnicodeCodePointArray;
var
  i, c, k : Integer;
begin
  SetLength(Result,Length(AItem));
  c := 0;
  for i := 0 to Length(AItem) - 1 do begin
    if not IsBidirectionalOrderingControls(AItem[i]) then begin
      Result[c] := AItem[i];
      c := c+1;
    end;
  end;
  SetLength(Result,c);
end;

function FillInitialPositions(
        AData        : PReorderUnit;
  const ADataLen     : Integer;
  const ADataWeigths : TUCA_LineRecArray
) : Integer;
var
  locNotFound, i, cw : Integer;
  p : PReorderUnit;
  pw : PUCA_LineRec;
  chars : TUnicodeCodePointArray;
  k : Integer;
begin
  locNotFound := 0;
  cw := Length(ADataWeigths);
  if (cw > 0) then
    pw := @ADataWeigths[0]
  else
    pw := nil;
  p := AData;
  for i := 0 to ADataLen - 1 do begin
    if not p^.IsVirtual() then begin
      p^.InitialPosition := IndexOf(p^.Characters,pw,cw) + 1;
      if (p^.InitialPosition = 0) then begin
        chars := RemoveBidirectionalOrderingControls(p^.Characters);
        p^.InitialPosition := IndexOf(chars,pw,cw) + 1;
        if (p^.InitialPosition > 0) then begin
          k := IndexOf(chars,[],AData,ADataLen);
          if (k < 0) then
            p^.Characters := chars;
        end;
        if (p^.InitialPosition = 0) then begin
          chars := RemoveIgnorables(p^.Characters,pw,cw);
          p^.InitialPosition := IndexOf(chars,pw,cw) + 1;
        end;
      end;
      if (p^.InitialPosition = 0) then
        Inc(locNotFound);
    end;
    Inc(p);
  end;
  Result := locNotFound;
end;

{ TSettingRec }

class function TSettingRec.From(
  const AName   : UTF8String;
  const AValues : array of UTF8String;
  const AOption : TSettingOption
) : TSettingRec;
var
  i : Integer;
begin
  Result.Name := AName;
  SetLength(Result.Values,Length(AValues));
  for i := 0 to Length(AValues)-1 do
    Result.Values[i] := AValues[i];
  Result.OptionValue := AOption;
end;

procedure TSettingRec.Assign(const AItem : PSettingRec);
begin
  if (AItem = nil) then begin
    Clear();
  end else begin
    Self.Name := AItem^.Name;
    Self.Values := Copy(AItem^.Values);
    Self.OptionValue := AItem^.OptionValue;
    Self.Understood := AItem^.Understood;
  end;
end;

procedure TSettingRec.Clear;
begin
  Name := '';
  Values := nil;
  OptionValue := TSettingOption.Unknown;
  Understood := False;
end;

{ TCldrImportList }

function TCldrImportList.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TCldrImportList.GetItem(AIndex : Integer): TCldrImport;
begin
  if (AIndex < 0) or (AIndex >= Length(FItems)) then
    raise ERangeError.CreateFmt(SListIndexError,[AIndex]);
  Result := FItems[AIndex];
end;

destructor TCldrImportList.Destroy();
begin
  Clear();
  inherited;
end;

procedure TCldrImportList.Clear();
var
  i : Integer;
begin
  for i := Low(FItems) to High(FItems) do
    FreeAndNil(FItems[i]);
  SetLength(FItems,0);
end;

function TCldrImportList.IndexOf(const ASource, AType: string): Integer;
var
  i : Integer;
begin
  for i := Low(FItems) to High(FItems) do begin
    if (FItems[i].Source = ASource) and (FItems[i].TypeName = AType) then begin
      Result := i;
      exit;
    end;
  end;
  Result := -1;
end;

function TCldrImportList.Find(const ASource, AType: string): TCldrImport;
var
  i : Integer;
begin
  i := IndexOf(ASource,AType);
  if (i >= 0) then
    Result := FItems[i]
  else
    Result := nil;
end;

function TCldrImportList.Add(const ASource, AType: string): TCldrImport;
var
  i : Integer;
begin
  i := IndexOf(ASource,AType);
  if (i >= 0) then begin
    Result := FItems[i];
  end else begin
    Result := TCldrImport.Create();
    Result.FSource := ASource;
    Result.FTypeName := AType;
    i := Length(FItems);
    SetLength(FItems,(i+1));
    FItems[i] := Result;
  end;
end;

{ TCldrCollationRepository }

function TCldrCollationRepository.GetItem(const AIndex : Integer): TCldrCollation;
begin
  if (AIndex < 0) or (AIndex >= Length(FItems)) then
    raise ERangeError.CreateFmt(SListIndexError,[AIndex]);
  Result := FItems[AIndex];
end;

function TCldrCollationRepository.GetItemCount: Integer;
begin
  Result := Length(FItems);
end;

function TCldrCollationRepository.IndexOfItem(AItem: TCldrCollation): Integer;
var
  i : Integer;
begin
  for i := Low(FItems) to High(FItems) do begin
    if (FItems[i] = AItem) then begin
      Result := i;
      exit;
    end;
  end;
  Result := -1;
end;

procedure TCldrCollationRepository.Add(AItem: TCldrCollation);
var
  i : Integer;
begin
  if (AItem = nil) then
    raise EArgumentException.CreateFmt(SParamIsNil,['AItem: TCldrCollation']);
  if (IndexOfItem(AItem) >= 0) then
    raise EArgumentException.CreateFmt(sCollationsExistsAlready,[AItem.Language]);
  i := Length(FItems);
  SetLength(FItems,(i+1));
  AItem.FRepository := Self;
  FItems[i] := AItem;
end;

constructor TCldrCollationRepository.Create(ALoader: ICldrCollationLoader);
begin
  if (ALoader = nil) then
    raise EArgumentException.CreateFmt(SInvalidPropertyElement,['Loader']);
  SetLoader(ALoader);
end;

destructor TCldrCollationRepository.Destroy;
begin
  Clear();
  inherited Destroy;
end;

procedure TCldrCollationRepository.FreeItems();
var
  i : Integer;
begin
  for i := 0 to Length(FItems) - 1 do
    FreeAndNil(FItems[i]);
  SetLength(FItems,0);
end;

procedure TCldrCollationRepository.Clear();
begin
  FreeItems();
end;

procedure TCldrCollationRepository.SetLoader(AValue: ICldrCollationLoader);
begin
  if (FLoader <> AValue) then
    FLoader := AValue;
end;

function TCldrCollationRepository.IndexOf(const ALanguage: string): Integer;
var
  i : Integer;
begin
  for i := Low(FItems) to High(FItems) do begin
    if (FItems[i].Language = ALanguage) then begin
      Result := i;
      exit;
    end
  end;
  Result := -1;
end;

function TCldrCollationRepository.Find(const ALanguage: string): TCldrCollation;
var
  i : Integer;
begin
  i := IndexOf(ALanguage);
  if (i >= 0) then
    Result := FItems[i]
  else
    Result := nil;
end;

function TCldrCollationRepository.Load(
  const ALanguage : string;
  const AMode     : TCldrParserMode
) : TCldrCollation;
var
  isnew : Boolean;
begin
  Result := Find(ALanguage);
  if (Result <> nil) then begin
    if (Result.Mode = TCldrParserMode.FullParsing) or (Result.Mode = AMode) then
      exit;
  end;
  isnew := (Result = nil);
  if isnew then
    Result := TCldrCollation.Create();
  try
    Loader.LoadCollation(ALanguage,Result,AMode);
    if isnew then
      Add(Result);
  except
    if isnew then
      FreeAndNil(Result);
    raise;
  end;
end;

function TCldrCollationRepository.LoadType(
  const ALanguage, AType, ATypeALT : string
) : TCldrCollationItem;
var
  item : TCldrCollationItem;
  col : TCldrCollation;
  newItem : Boolean;
begin
  col := Find(ALanguage);
  if (col = nil) then
    col := Load(ALanguage,TCldrParserMode.HeaderParsing);
  if (ATypeALT <> '') then
    item := col.Find(AType,ATypeALT)
  else
    item := col.Find(AType);
  newItem := (item = nil);
  try
    if newItem then
      item := TCldrCollationItem.Create();
    if newItem or (item.Mode = TCldrParserMode.HeaderParsing) then
      Loader.LoadCollationType(ALanguage,AType,item);
    if newItem then
      col.Add(item);
  except
    if newItem then
      item.Free();
    raise;
  end;
  Result := item;
end;

{ TCldrCollationItem }

class function TCldrCollationItem.FindAlias(
  const AName : UTF8String
) : UTF8String;
var
  s : UTF8String;
  i : Integer;
begin
  Result := '';
  if (AName <> '') then begin
    s := LowerCase(AName);
    for i := Low(BCP47_COLLATION_TYPE_ALIAS) to High(BCP47_COLLATION_TYPE_ALIAS) do begin
      if (s = BCP47_COLLATION_TYPE_ALIAS[i].Name) then begin
        Result := BCP47_COLLATION_TYPE_ALIAS[i].Alias;
        break;
      end;
    end;
  end;
end;

constructor TCldrCollationItem.Create;
begin
  FImports := TCldrImportList.Create();
  FNormalization := True;
  FStrength := TComparisonStrength.Tertiary;
end;

destructor TCldrCollationItem.Destroy;
begin
  FImports.Free();
  inherited Destroy;
end;

procedure TCldrCollationItem.Clear();
begin
  FBackwards := False;
  FNormalization := True;
  FStrength := TComparisonStrength.Tertiary;
  FVariableWeight := Low(TUCA_VariableKind);
  FAlt := '';
  FBase := '';
  FTypeName := '';
  FChangedFields := [];
  SetLength(FRules,0);
  SetLength(FSettings,0);
  FImports.Clear();
end;

function TCldrCollationItem.IsPrivate() : Boolean;
begin
  Result := (Pos('private-',TypeName) = 1);
end;

{ TCldrCollation }

function TCldrCollation.GetItem(Index : Integer): TCldrCollationItem;
begin
  if (Index < 0) or (Index >= Length(FItems)) then
    raise ERangeError.CreateFmt(SListIndexError,[Index]);
  Result := FItems[Index];
end;

function TCldrCollation.GetItemCount: Integer;
begin
  Result := Length(FItems);
end;

destructor TCldrCollation.Destroy;
begin
  Clear();
  inherited Destroy;
end;

procedure TCldrCollation.Clear();
var
  i : Integer;
begin
  for i := 0 to Length(FItems) - 1 do
    FreeAndNil(FItems[i]);
  SetLength(FItems,0);
  FLocalID := '';
  FDefaultType := '';
  FVersion := '';
  FLanguage := '';
  FMode := Low(TCldrParserMode);
end;

function TCldrCollation.IndexOf(const AItemName: string): Integer;
var
  i : Integer;
begin
  for i := 0 to ItemCount - 1 do begin
    if SameText(AItemName,Items[i].TypeName) then
      exit(i);
  end;
  Result := -1;
end;

function TCldrCollation.IndexOf(const AItemName, AItemAlt: string): Integer;
var
  i : Integer;
begin
  for i := 0 to ItemCount - 1 do begin
    if SameText(AItemName,Items[i].TypeName) and
       SameText(AItemAlt,Items[i].Alt)
    then begin
      exit(i);
    end;
  end;
  Result := -1;
end;

function TCldrCollation.Find(const AItemName: string): TCldrCollationItem;
var
  i : Integer;
  s : UTF8String;
begin
  i := IndexOf(AItemName);
  if (i = - 1) then begin
    s := TCldrCollationItem.FindAlias(AItemName);
    if (s <> '') then
      i := IndexOf(s);
  end;
  if (i = - 1) then
    Result := nil
  else
    Result := Items[i];
end;

function TCldrCollation.Find(const AItemName, AItemAlt: string): TCldrCollationItem;
var
  i : Integer;
begin
  i := IndexOf(AItemName,AItemAlt);
  if (i = - 1) then
    Result := nil
  else
    Result := Items[i];
end;

function TCldrCollation.Add(AItem: TCldrCollationItem): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems,(Result+1));
  FItems[Result] := AItem;
  AItem.FParent := Self;
end;

function TCldrCollation.FindPublicItemCount() : Integer;
var
  r, i : Integer;
begin
  r := 0;
  for i := 0 to ItemCount-1 do begin
    if not Items[i].IsPrivate() then
      r := r+1;
  end;
  Result := r;
end;

{ TReorderSequence }

procedure TReorderSequence.Clear();
begin
  Reset    := nil;
  Elements := nil;
  LogicalPosition := TReorderLogicalReset(0);
  Before   := False;
end;

procedure TReorderSequence.SetElementCount(const ALength: Integer);
begin
  SetLength(Elements,ALength);
end;

procedure TReorderSequence.Assign(ASource: PReorderSequence);
var
  c, i : Integer;
begin
  if (ASource = nil) then begin
    Self.Clear();
    exit;
  end;
  Self.Reset := Copy(ASource^.Reset);
  c := Length(ASource^.Elements);
  SetLength(Self.Elements,c);
  for i := 0 to c-1 do
    Self.Elements[i].Assign(@ASource^.Elements[i]);
  Self.Before := ASource^.Before;
  Self.LogicalPosition := ASource^.LogicalPosition;
end;

{ TReorderUnit }

function TReorderUnit.IsVirtual() : Boolean;
begin
  Result := (FVirtualPosition > TReorderLogicalReset.None);
end;

class function TReorderUnit.From(
  const AChars,
        AContext         : array of TUnicodeCodePoint;
  const AWeigthKind      : TReorderWeigthKind;
  const AInitialPosition : Integer
) : TReorderUnit;
var
  c : Integer;
begin
  Result.Clear();
  c := Length(AChars);
  SetLength(Result.Characters,c);
  if (c > 0) then
    Move(AChars[0],Result.Characters[0],(c*SizeOf(Result.Characters[0])));
  Result.WeigthKind := AWeigthKind;
  Result.InitialPosition := AInitialPosition;
  Result.Changed := False;
  c := Length(AContext);
  SetLength(Result.Context,c);
  if (c > 0) then
    Move(AContext[0],Result.Context[0],(c*SizeOf(Result.Context[0])));
end;

class function TReorderUnit.From(
  const AChars           : array of TUnicodeCodePoint;
  const AWeigthKind      : TReorderWeigthKind;
  const AInitialPosition : Integer
) : TReorderUnit;
begin
  Result := From(AChars,[],AWeigthKind,AInitialPosition);
end;

class function TReorderUnit.From(
  const AChar            : TUnicodeCodePoint;
  const AWeigthKind      : TReorderWeigthKind;
  const AInitialPosition : Integer
) : TReorderUnit;
begin
  Result := From([AChar],AWeigthKind,AInitialPosition);
end;

class function TReorderUnit.From(
  const AChar            : TUnicodeCodePoint;
  const AContext         : array of TUnicodeCodePoint;
  const AWeigthKind      : TReorderWeigthKind;
  const AInitialPosition : Integer
) : TReorderUnit;
begin
  Result := From([AChar],AContext,AWeigthKind,AInitialPosition);
end;

class function TReorderUnit.From(const AReset: TReorderLogicalReset): TReorderUnit;
begin
  Result.Clear();
  Result.FVirtualPosition := AReset;
end;

procedure TReorderUnit.SetExpansion(const AChars: array of TUnicodeCodePoint);
var
  c : Integer;
begin
  if IsVirtual() then
    raise ECldrException.Create(sVirtualIsReadOnly);

  c := Length(AChars);
  SetLength(ExpansionChars,c);
  if (c > 0) then
    Move(AChars[0],ExpansionChars[0],(c*SizeOf(AChars[0])));
end;

procedure TReorderUnit.SetExpansion(const AChar: TUnicodeCodePoint);
begin
  if IsVirtual() then
    raise ECldrException.Create(sVirtualIsReadOnly);

  SetExpansion([AChar]);
end;

procedure TReorderUnit.Clear();
begin
  Self.FVirtualPosition := TReorderLogicalReset(0);
  Self.Characters := nil;
  Self.Context := nil;
  Self.ExpansionChars := nil;
  Self.InitialPosition := 0;
  Self.WeigthKind := TReorderWeigthKind(0);
  Self.Changed := False;
end;

procedure TReorderUnit.Assign(const AItem : PReorderUnit);
begin
  Clear();
  if (AItem <> nil) then begin
    Self.FVirtualPosition := AItem^.VirtualPosition;
    Self.Characters := Copy(AItem^.Characters);
    //SetLength(Self.Context,Length(AItem^.Context));
    Self.Context := Copy(AItem^.Context);
    Self.ExpansionChars := Copy(AItem^.ExpansionChars);
    Self.WeigthKind := AItem^.WeigthKind;
    Self.InitialPosition := AItem^.InitialPosition;
    Self.Changed := AItem^.Changed;
  end;
end;

function TReorderUnit.HasContext() : Boolean;
begin
  Result := (Length(Context) > 0);
end;

function TReorderUnit.IsExpansion() : Boolean;
begin
  Result := (Length(ExpansionChars) > 0);
end;

{ TOrderedCharacters }

procedure TOrderedCharacters.EnsureSize(const AMinSize : Integer);
var
  c : Integer;
begin
  if (AMinSize > Length(Data)) then begin
    if (AMinSize > 1000) then
      c := AMinSize + 100
    else
      c := (3*AMinSize) div 2 ;
    SetLength(Data,c);
  end;
  FActualLength := AMinSize;
end;

class function TOrderedCharacters.Create(const ACapacity : Integer) : TOrderedCharacters;
begin
  if (ACapacity < 0) then
    raise ERangeError.Create(SRangeError);
  Result.FActualLength := 0;
  SetLength(Result.Data,ACapacity);
end;

class function TOrderedCharacters.Create() : TOrderedCharacters;
begin
  Result := Create(0);
end;

procedure TOrderedCharacters.Clear;
begin
  Data := nil;
  FActualLength := 0;
end;

function TOrderedCharacters.Clone() : TOrderedCharacters;
var
  i : Integer;
begin
  Result.Clear();
  SetLength(Result.Data,Self.ActualLength);
  for i := 0 to Length(Result.Data) - 1 do
    Result.Data[i].Assign(@Self.Data[i]);
  Result.FActualLength := Self.FActualLength;
end;

function TOrderedCharacters.Insert(
  const AItem    : TReorderUnit;
  const ADestPos : Integer
) : Integer;
var
  k, finalPos : Integer;
  p : PReorderUnit;
  i, c : Integer;
begin
  if (ActualLength=0) then begin
    EnsureSize(ActualLength + 1);
    p := @Data[0];
    p^.Assign(@AItem);
    p^.Changed := True;
    exit(0);
  end;
  k := IndexOf(AItem.Characters,AItem.Context,@Data[0],ActualLength);
  if (k = ADestPos) then begin
    Data[ADestPos].Assign(@AItem);
    Data[ADestPos].Changed := True;
    exit(k);
  end;
  finalPos := ADestPos;
  if (finalPos > ActualLength) then
    finalPos := ActualLength;
  c := ActualLength;
  EnsureSize(c + 1);
  Data[c].Clear();
  p := @Data[finalPos];
  if (finalPos = ActualLength-1) then begin
    p^.Assign(@AItem);
    p^.Changed := True;
  end else begin
    if (c > 0) then begin
      p := @Data[c-1];
      for i := finalPos to c - 1 do begin
        Move(Pointer(p)^,Pointer(p+1)^,SizeOf(p^));
        Dec(p);
      end;
    end;
    p := @Data[finalPos];

    {Move(
      Pointer(p)^,Pointer(@p[1])^,
      (ActualLength-(finalPos+1))*SizeOf(TReorderUnit)
    );}
    FillChar(Pointer(p)^,SizeOf(TReorderUnit),0);
    p^.Assign(@AItem);
    p^.Changed := True;
  end;
  if (k >= 0) then begin
    if (k > finalPos) then
      Inc(k);
    Delete(k);
  end;
  Result := finalPos;
end;

function TOrderedCharacters.Append(const AItem : TReorderUnit) : Integer;
begin
  Result := Insert(AItem,ActualLength);
end;

procedure TOrderedCharacters.Delete(const AIndex : Integer);
var
  i : Integer;
  p : PReorderUnit;
begin
  if (AIndex < 0) or (AIndex >= ActualLength) then
    raise ERangeError.CreateFmt(SListIndexError,[AIndex]);
  if (AIndex = (ActualLength-1)) then begin
    Data[AIndex].Clear();
  end else begin
    //Data[AIndex].Clear();
    p := @Data[AIndex];
    p^.Clear();
    for i := AIndex to ActualLength-2 do begin
      Move((p+1)^,p^,SizeOf(p^));
      Inc(p);
    end;
    {Move(
      Pointer(@Data[(AIndex+1)])^,Pointer(@Data[AIndex])^,
      (ActualLength-(AIndex+1))*SizeOf(TReorderUnit)
    );}
    FillChar(Pointer(@Data[(FActualLength-1)])^,SizeOf(TReorderUnit),0);
  end;
  FActualLength := FActualLength - 1;
end;

procedure TOrderedCharacters.ApplyStatement(const AStatement : PReorderSequence);
begin
  ApplyStatementToSequence(Self,AStatement,1);
end;

function FindCollationDefaultItemName(ACollation : TCldrCollation) : string;
begin
  if (ACollation.ItemCount = 0) then
    exit('');
  if (ACollation.IndexOf(ACollation.DefaultType) <> -1) then
    exit(ACollation.DefaultType);
  Result := COLLATION_ITEM_STD;
  if (ACollation.IndexOf(Result) <> -1) then
    exit;
  Result := COLLATION_ITEM_SEARCH;
  if (ACollation.IndexOf(Result) <> -1) then
    exit;
  if (ACollation.ItemCount > 0) then
    Result := ACollation.Items[0].TypeName;
end;

procedure GenerateUCA_CLDR_Head(
  ADest  : TStream;
  ABook  : PUCA_DataBook;
  AProps : PUCA_PropBook;
  ACollation : TCldrCollationItem
);

  procedure AddLine(const ALine : ansistring);
  var
    buffer : ansistring;
  begin
    buffer := ALine + sLineBreak;
    ADest.Write(buffer[1],Length(buffer));
  end;

  procedure AddFields();
  var
    kc : Integer;
    e : TCollationField;
    ks : string;
    ti : PTypeInfo;
  begin
    ti := TypeInfo(TCollationField);
    ks := '';
    kc := 0;
    for e := Low(TCollationField) to High(TCollationField) do begin
      if (e in ACollation.ChangedFields) then begin
        ks := ks + ti^.Name + '.' +
              GetEnumName(ti,Ord(e)) + ', ';
        kc := kc + 1;
      end
    end;
    if (AProps <> nil) then begin
      if (AProps^.VariableLowLimit < High(Word)) then begin
        ks := ks + ti^.Name + '.' +
              GetEnumName(ti,Ord(TCollationField.VariableLowLimit)) + ', ';
        kc := kc + 1;
      end;
      if (AProps^.VariableHighLimit > 0) then begin
        ks := ks + ti^.Name + '.' +
              GetEnumName(ti,Ord(TCollationField.VariableHighLimit)) + ', ';
        kc := kc + 1;
      end;
    end;
    if (kc > 0) then
      ks := Copy(ks,1,(Length(ks)-2));
    AddLine('  UPDATED_FIELDS = [ ' + ks + ' ];');
  end;

begin
  AddLine('{$IFDEF FPC}');
  AddLine('  {$mode DELPHI}{$H+}');
  AddLine('{$ENDIF FPC}');
  AddLine('');
  AddLine('{$IFNDEF FPC}');
  AddLine('  {$DEFINE ENDIAN_LITTLE}');
  AddLine('{$ENDIF !FPC}');
  AddLine('');
  AddLine('unit ' + COLLATION_FILE_PREFIX + LowerCase(ACollation.Parent.LocalID)+ ';'+sLineBreak);
  AddLine('interface'+sLineBreak);
  AddLine('implementation');
  AddLine('uses');
  AddLine('  unicodedata, unicodeducet;'+sLineBreak);
  AddLine('const');
  AddFields();
  AddLine('  COLLATION_NAME = ' + QuotedStr(ACollation.Parent.LocalID) + ';');
  AddLine('  BASE_COLLATION = ' + QuotedStr(ACollation.Base) + ';');
  if (AProps <> nil) then begin
    AddLine('  VARIABLE_LOW_LIMIT = ' + IntToStr(AProps^.VariableLowLimit) + ';');
    AddLine('  VARIABLE_HIGH_LIMIT = ' + IntToStr(AProps^.VariableHighLimit) + ';');
    AddLine('  VARIABLE_WEIGHT = ' + IntToStr(Ord(ABook^.VariableWeight)) + ';');
  end else begin
    AddLine('  VARIABLE_LOW_LIMIT = ' + IntToStr(High(Word)) + ';');
    AddLine('  VARIABLE_HIGH_LIMIT = ' + IntToStr(0) + ';');
    AddLine('  VARIABLE_WEIGHT = ' + IntToStr(0) + ';');
  end;
  AddLine('  BACKWARDS_0 = ' + BoolToStr(ABook^.Backwards[0],'True','False') + ';');
  AddLine('  BACKWARDS_1 = ' + BoolToStr(ABook^.Backwards[1],'True','False') + ';');
  AddLine('  BACKWARDS_2 = ' + BoolToStr(ABook^.Backwards[2],'True','False') + ';');
  AddLine('  BACKWARDS_3 = ' + BoolToStr(ABook^.Backwards[3],'True','False') + ';');
  if (AProps <> nil) then
    AddLine('  PROP_COUNT  = ' + IntToStr(Ord(AProps^.ItemSize)) + ';');
  AddLine('  NO_STRING_NORMALIZATION = ' + BoolToStr(not(ACollation.Normalization),'True','False') + ';');
  AddLine('  COMPARISON_STRENGTH = ' + IntToStr(Ord(ACollation.Strength)+1) + ';');

  AddLine('');
end;

procedure GenerateUCA_CLDR_Registration(
  ADest      : TStream;
  ABook      : PUCA_DataBook;
  ACollation : TCldrCollationItem
);

  procedure AddLine(const ALine : ansistring);
  var
    buffer : ansistring;
  begin
    buffer := ALine + sLineBreak;
    ADest.Write(buffer[1],Length(buffer));
  end;

  procedure GenerateStrBuffer(AStr : AnsiString; const ALength : Integer);
  const LINE_ELEMENT = 8;
  var
    kc, k : Integer;
    buffer : ansistring;
  begin
    kc := Length(AStr);
    if (kc > ALength) then
      kc := ALength;

    buffer := '        ';
    for k := 1 to kc do begin
      buffer := buffer + 'Ord('''+AStr[k]+''')';
      if (k < kc) then begin
        buffer := buffer + ',';
        if ((k mod LINE_ELEMENT) = 0) then
          buffer := buffer+sLineBreak + '        ';
      end;
    end;

    if (kc < ALength) then begin
      buffer := buffer + ',' + sLineBreak+ '        ';
      for k := kc+1 to ALength do begin
        buffer := buffer + '0';
        if (k < ALength) then begin
          buffer := buffer + ',';
          if (((k-kc) mod 30) = 0) then
            buffer := buffer+sLineBreak + '        ';
        end;
      end;
    end;
    AddLine(buffer);
  end;

begin
  AddLine('var');
  AddLine('  CLDR_Collation : TUCA_DataBook = (');
  AddLine('    Base               : nil;');
  AddLine('    Version            : ');
  AddLine('      (');
  GenerateStrBuffer(ABook^.Version,128);
  AddLine('      );');
  AddLine('    CollationName      : ');
  AddLine('      (');
  GenerateStrBuffer(ACollation.Parent.LocalID,128);
  AddLine('      );');
  AddLine('    VariableWeight     : TUCA_VariableKind(VARIABLE_WEIGHT);');
  AddLine('    Backwards          : (BACKWARDS_0,BACKWARDS_1,BACKWARDS_2,BACKWARDS_3);');
  if (Length(ABook^.Lines) > 0) then begin
    AddLine('    BMP_Table1         : @UCA_TABLE_1[0];');
    AddLine('    BMP_Table2         : @UCA_TABLE_2[0];');
    AddLine('    OBMP_Table1        : @UCAO_TABLE_1[0];');
    AddLine('    OBMP_Table2        : @UCAO_TABLE_2[0];');
    AddLine('    PropCount          : PROP_COUNT;');
    AddLine('    Props              : @UCA_PROPS[0];');
  end else begin
    AddLine('    BMP_Table1         : nil;');
    AddLine('    BMP_Table2         : nil;');
    AddLine('    OBMP_Table1        : nil;');
    AddLine('    OBMP_Table2        : nil;');
    AddLine('    PropCount          : 0;');
    AddLine('    Props              : nil;');
  end;
  AddLine('    VariableLowLimit   : VARIABLE_LOW_LIMIT;');
  AddLine('    VariableHighLimit  : VARIABLE_HIGH_LIMIT;');
  AddLine('    NoNormalization    : NO_STRING_NORMALIZATION;');
  AddLine('    ComparisonStrength : COMPARISON_STRENGTH;');
  AddLine('    Dynamic            : False;');
  AddLine('  );');
  AddLine('');

  AddLine('procedure Register();');
  AddLine('begin');
  AddLine('  PrepareCollation(@CLDR_Collation,BASE_COLLATION,UPDATED_FIELDS);');
  AddLine('  RegisterCollation(@CLDR_Collation);');
  AddLine('end;');
  AddLine('');

  AddLine('initialization');
  AddLine('  Register();');
  AddLine('');

  AddLine('finalization');
  AddLine('  UnregisterCollation(COLLATION_NAME);');
  AddLine('');
  AddLine('end.');
end;

procedure CheckEndianTransform(const ASource : PUCA_PropBook);
var
  x, y : array of Byte;
  px, py : PUCA_PropItemRec;
begin
  if (ASource = nil) or (ASource^.ItemSize = 0) then
    exit;
  SetLength(x,ASource^.ItemSize);
  px := PUCA_PropItemRec(@x[0]);
  ReverseFromNativeEndian(ASource^.Items,ASource^.ItemSize,px);

  SetLength(y,ASource^.ItemSize);
  py := PUCA_PropItemRec(@y[0]);
  ReverseToNativeEndian(px,ASource^.ItemSize,py);
  if not CompareMem(ASource^.Items,@y[0],Length(x)) then
    CompareProps(ASource^.Items, PUCA_PropItemRec(@y[0]),ASource^.ItemSize);
end;

function ForEachRule(
  ACollationType : TCldrCollationItem;
  AVisitFunc     : TRuleVisiterFunction;
  ACustomData    : Pointer
) : Boolean;
var
  i : Integer;
  locImport : TCldrImport;
  locRep : TCldrCollationRepository;
  locCollation : TCldrCollation;
  locType : TCldrCollationItem;
  locRules : TCldrCollationRuleArray;
  locRule : PCldrCollationRule;
begin 
  Result := False;
  if not Assigned(AVisitFunc) then
    exit;
  locRules := ACollationType.Rules;
  for i := Low(locRules) to High(locRules) do begin
    locRule := @locRules[i];
    if (locRule^.Kind = TCldrCollationRuleKind.ReorderSequence) then begin  
      if not AVisitFunc(@locRule^.Reorder,ACollationType,ACustomData) then
        exit;
    end else if (locRule^.Kind = TCldrCollationRuleKind.Import) then begin  
      locImport := locRule^.Import;
      locRep := ACollationType.Parent.Repository;
      locCollation := locRep.Load(locImport.Source,TCldrParserMode.FullParsing);
      locType := locCollation.Find(locImport.TypeName);
      if (locType = nil) then begin
        if (locType = nil) then
          raise ECldrException.CreateFmt(sCollationTypeNotFound,[locImport.TypeName]);
      end;
      if not ForEachRule(locType,AVisitFunc,ACustomData) then
        exit;
    end;
  end;
  Result := True;
end;

function ApplyStatementVisitorFunc(
  ARule  : PReorderSequence;
  AOwner : TCldrCollationItem;
  AData  : Pointer
) : Boolean;
var
  locSequence : POrderedCharacters;
begin
  locSequence := POrderedCharacters(AData);
  locSequence^.ApplyStatement(ARule);
  Result := True;
end;

procedure GenerateCdlrCollation(
  ACollation                : TCldrCollation;
  AItemName                 : string;
  AStoreName                : string;
  AStream,
  ANativeEndianStream,
  AOtherEndianStream,
  ABinaryNativeEndianStream,
  ABinaryOtherEndianStream  : TStream;
  ARootChars                : TOrderedCharacters;
  ARootWeigths              : TUCA_LineRecArray;
  AUnifiedIdeographs        : TCodePointRecArray
);

  procedure AddLine(const ALine : ansistring; ADestStream : TStream);
  var
    buffer : ansistring;
  begin
    buffer := ALine + sLineBreak;
    ADestStream.Write(buffer[1],Length(buffer));
  end;

var
  locUcaBook : TUCA_DataBook;
  locSequence : TOrderedCharacters;
  locItem : TCldrCollationItem;
  i : Integer;
  locUcaProps : PUCA_PropBook;
  ucaFirstTable   : TucaBmpFirstTable;
  ucaSecondTable  : TucaBmpSecondTable;
  ucaoFirstTable   : TucaoBmpFirstTable;
  ucaoSecondTable  : TucaOBmpSecondTable;
  locHasProps : Boolean;
  s : string;
  serializedHeader : TSerializedCollationHeader;
  e : TCollationField;
begin
  locItem := ACollation.Find(AItemName);
  if (locItem = nil) then
    raise Exception.CreateFmt('Collation Item not found : "%s".',[AItemName]);
  locSequence := ARootChars.Clone();
  ForEachRule(locItem,ApplyStatementVisitorFunc,@locSequence);
  {for i := 0 to Length(locItem.Rules) - 1 do
    locSequence.ApplyStatement(@locItem.Rules[i]);}
  FillChar(locUcaBook,SizeOf(locUcaBook),0);
  locUcaBook.Version := ACollation.Version;
  locUcaBook.Backwards[1] := locItem.Backwards;
  locUcaBook.VariableWeight := locItem.VariableWeight;
  ComputeWeigths(@locSequence.Data[0],locSequence.ActualLength,ARootWeigths,AUnifiedIdeographs,locUcaBook.Lines);
  for i := 0 to Length(locUcaBook.Lines) - 1 do
    locUcaBook.Lines[i].Stored := True;
  locHasProps := (Length(locUcaBook.Lines) > 0);
  if not locHasProps then
    locUcaProps := nil
  else
    MakeUCA_Props(@locUcaBook,locUcaProps);
  try
    CheckEndianTransform(locUcaProps);
    if locHasProps then begin
      MakeUCA_BmpTables(ucaFirstTable,ucaSecondTable,locUcaProps);
      SetLength(ucaoSecondTable,100);
      MakeUCA_OBmpTables(ucaoFirstTable,ucaoSecondTable,locUcaProps);
    end;
    GenerateLicenceText(AStream);
    GenerateUCA_CLDR_Head(AStream,@locUcaBook,locUcaProps,locItem);
    if locHasProps then begin
      GenerateUCA_BmpTables(AStream,ANativeEndianStream,AOtherEndianStream,ucaFirstTable,ucaSecondTable);
      GenerateUCA_OBmpTables(AStream,ANativeEndianStream,AOtherEndianStream,ucaoFirstTable,ucaoSecondTable);
      GenerateUCA_PropTable(ANativeEndianStream,locUcaProps,ENDIAN_NATIVE);
      GenerateUCA_PropTable(AOtherEndianStream,locUcaProps,ENDIAN_NON_NATIVE);

      AddLine('{$ifdef ENDIAN_LITTLE}',AStream);
        s := GenerateEndianIncludeFileName(AStoreName,ekLittle);
        AddLine(Format('  {$include %s}',[ExtractFileName(s)]),AStream);
      AddLine('{$else ENDIAN_LITTLE}',AStream);
        s := GenerateEndianIncludeFileName(AStoreName,ekBig);
        AddLine(Format('  {$include %s}',[ExtractFileName(s)]),AStream);
      AddLine('{$endif ENDIAN_LITTLE}',AStream);
    end;
    GenerateUCA_CLDR_Registration(AStream,@locUcaBook,locItem);

    FillChar(serializedHeader,SizeOf(TSerializedCollationHeader),0);
    StringToByteArray(locItem.Base,serializedHeader.Base);
    StringToByteArray(ACollation.Version,serializedHeader.Version);
    StringToByteArray(ACollation.Language,serializedHeader.CollationName);
    serializedHeader.VariableWeight := Ord(locUcaBook.VariableWeight);
    SetBit(serializedHeader.Backwards,0,locUcaBook.Backwards[0]);
    SetBit(serializedHeader.Backwards,1,locUcaBook.Backwards[1]);
    SetBit(serializedHeader.Backwards,2,locUcaBook.Backwards[2]);
    SetBit(serializedHeader.Backwards,3,locUcaBook.Backwards[3]);
    serializedHeader.NoNormalization := Ord(not locItem.Normalization);
    if locHasProps then begin
      serializedHeader.BMP_Table1Length := Length(ucaFirstTable);
      serializedHeader.BMP_Table2Length := Length(TucaBmpSecondTableItem) *
                                           (Length(ucaSecondTable) * SizeOf(UInt24));
      serializedHeader.OBMP_Table1Length := Length(ucaoFirstTable) * SizeOf(Word);
      serializedHeader.OBMP_Table2Length := Length(TucaOBmpSecondTableItem) *
                                           (Length(ucaoSecondTable) * SizeOf(UInt24));
      serializedHeader.PropCount := locUcaProps^.ItemSize;
      serializedHeader.VariableLowLimit := locUcaProps^.VariableLowLimit;
      serializedHeader.VariableHighLimit := locUcaProps^.VariableHighLimit;
    end else begin
      serializedHeader.VariableLowLimit := High(Word);
      serializedHeader.VariableHighLimit := 0;
    end;
    serializedHeader.ChangedFields := 0;
    for e := Low(TCollationField) to High(TCollationField) do begin
      if (e in locItem.ChangedFields) then
        SetBit(serializedHeader.ChangedFields,Ord(e),True);
    end;
    ABinaryNativeEndianStream.Write(serializedHeader,SizeOf(serializedHeader));
    ReverseRecordBytes(serializedHeader);
    ABinaryOtherEndianStream.Write(serializedHeader,SizeOf(serializedHeader));
    if locHasProps then begin
      GenerateBinaryUCA_BmpTables(ABinaryNativeEndianStream,ABinaryOtherEndianStream,ucaFirstTable,ucaSecondTable);
      GenerateBinaryUCA_OBmpTables(ABinaryNativeEndianStream,ABinaryOtherEndianStream,ucaoFirstTable,ucaoSecondTable);
      GenerateBinaryUCA_PropTable(ABinaryNativeEndianStream,ABinaryOtherEndianStream,locUcaProps);
    end;
  finally
    locSequence.Clear();
    FreeUcaBook(locUcaProps);
  end;
end;

end.
