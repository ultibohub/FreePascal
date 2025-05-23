{ ---------------------------------------------------------------------
    Windows external definitions.
  ---------------------------------------------------------------------}

const
  oleaut = 'oleaut32.dll';

{ Variant functions }

function VariantChangeTypeEx(var VargDest: TVarData; const VargSrc: TVarData; LCID: Integer; Flags: Word; VarType: Word): HRESULT; stdcall;external oleaut;
function VariantClear(var Varg: TVarData): HRESULT; stdcall;external oleaut;
function VariantCopy(var VargDest: TVarData; const VargSrc: TVarData): HRESULT; stdcall;external oleaut;
function VariantCopyInd(var VargDest: TVarData;  const VargSrc: TVarData): HRESULT; stdcall;external oleaut;
procedure VariantInit(var Varg: TVarData); stdcall;external oleaut;

{  Variant array functions }

function SafeArrayAccessData(psa: PVarArray; var ppvData: Pointer): HRESULT; stdcall;external oleaut;
function SafeArrayAllocData(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayAllocDescriptor(DimCount: longword; var psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayCopy(psa: PVarArray; var psaOut: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayCopyData(psa, psaOut: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayCreate(VarType, Dim: dword; const Bounds: TVarArrayBoundArray): PVarArray; stdcall;external oleaut;
function SafeArrayDestroy(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayDestroyData(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayDestroyDescriptor(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayGetDim(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayGetElemsize(psa: PVarArray): LongWord; stdcall;external oleaut;
function SafeArrayGetElement(psa: PVarArray; Indices: PVarArrayCoorArray;  Data: Pointer): HRESULT; stdcall;external oleaut;
function SafeArrayGetLBound(psa: PVarArray; Dim: dword;  var LBound: longint): HRESULT; stdcall;external oleaut;
function SafeArrayGetUBound(psa: PVarArray; Dim: dword;  var UBound: longint): HRESULT; stdcall;external oleaut;
function SafeArrayLock(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayPtrOfIndex(psa: PVarArray; Indices: PVarArrayCoorArray;  var Address: Pointer): HRESULT; stdcall;external oleaut;
function SafeArrayPutElement(psa: PVarArray; Indices: PVarArrayCoorArray;  const Data: Pointer): HRESULT; stdcall;external oleaut;
function SafeArrayRedim(psa: PVarArray; const NewBound: TVarArrayBound): HRESULT; stdcall;external oleaut;
function SafeArrayUnaccessData(psa: PVarArray): HRESULT; stdcall;external oleaut;
function SafeArrayUnlock(psa: PVarArray): HRESULT; stdcall;external oleaut;

function VarDateFromStr(const strIn: POleStr; alcid: DWORD; dwFlags: Longint; out dateOut: Double): HRESULT; stdcall; external oleaut; overload;
function VarDateFromStr(const strIn: POleStr; alcid: DWORD; dwFlags: Longint; out dateOut: TDateTime): HRESULT; stdcall; external oleaut; overload;


