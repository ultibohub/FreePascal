unit win31;

{$MODE objfpc}

{$if defined(FPC_MM_COMPACT) or defined(FPC_MM_LARGE) or defined(FPC_MM_HUGE)}
  {$define VAR_PARAMS_ARE_FAR}
{$endif}

interface

uses
  wintypes;

const
  GFSR_SYSTEMRESOURCES = $0000;
  GFSR_GDIRESOURCES    = $0001;
  GFSR_USERRESOURCES   = $0002;

{****** LogParamError/LogError values *}

{ Error modifier bits }

  ERR_WARNING           = $8000;
  ERR_PARAM             = $4000;

  ERR_SIZE_MASK         = $3000;
  ERR_BYTE              = $1000;
  ERR_WORD              = $2000;
  ERR_DWORD             = $3000;

{****** LogParamError() values *}

{ Generic parameter values }
  ERR_BAD_VALUE         = $6001;
  ERR_BAD_FLAGS         = $6002;
  ERR_BAD_INDEX         = $6003;
  ERR_BAD_DVALUE        = $7004;
  ERR_BAD_DFLAGS        = $7005;
  ERR_BAD_DINDEX        = $7006;
  ERR_BAD_PTR           = $7007;
  ERR_BAD_FUNC_PTR      = $7008;
  ERR_BAD_SELECTOR      = $6009;
  ERR_BAD_STRING_PTR    = $700a;
  ERR_BAD_HANDLE        = $600b;

{ KERNEL parameter errors }
  ERR_BAD_HINSTANCE     = $6020;
  ERR_BAD_HMODULE       = $6021;
  ERR_BAD_GLOBAL_HANDLE = $6022;
  ERR_BAD_LOCAL_HANDLE  = $6023;
  ERR_BAD_ATOM          = $6024;
  ERR_BAD_HFILE         = $6025;

{ USER parameter errors }
  ERR_BAD_HWND          = $6040;
  ERR_BAD_HMENU         = $6041;
  ERR_BAD_HCURSOR       = $6042;
  ERR_BAD_HICON         = $6043;
  ERR_BAD_HDWP          = $6044;
  ERR_BAD_CID           = $6045;
  ERR_BAD_HDRVR         = $6046;

{ GDI parameter errors }
  ERR_BAD_COORDS        = $7060;
  ERR_BAD_GDI_OBJECT    = $6061;
  ERR_BAD_HDC           = $6062;
  ERR_BAD_HPEN          = $6063;
  ERR_BAD_HFONT         = $6064;
  ERR_BAD_HBRUSH        = $6065;
  ERR_BAD_HBITMAP       = $6066;
  ERR_BAD_HRGN          = $6067;
  ERR_BAD_HPALETTE      = $6068;
  ERR_BAD_HMETAFILE     = $6069;


{**** LogError() values *}

{ KERNEL errors }
  ERR_GALLOC            = $0001;
  ERR_GREALLOC          = $0002;
  ERR_GLOCK             = $0003;
  ERR_LALLOC            = $0004;
  ERR_LREALLOC          = $0005;
  ERR_LLOCK             = $0006;
  ERR_ALLOCRES          = $0007;
  ERR_LOCKRES           = $0008;
  ERR_LOADMODULE        = $0009;

{ USER errors }
  ERR_CREATEDLG2        = $0041;
  ERR_CREATEDLG         = $0040;
  ERR_REGISTERCLASS     = $0042;
  ERR_DCBUSY            = $0043;
  ERR_CREATEWND         = $0044;
  ERR_STRUCEXTRA        = $0045;
  ERR_LOADSTR           = $0046;
  ERR_LOADMENU          = $0047;
  ERR_NESTEDBEGINPAINT  = $0048;
  ERR_BADINDEX          = $0049;
  ERR_CREATEMENU        = $004a;

{ GDI errors }
  ERR_CREATEDC          = $0080;
  ERR_CREATEMETA        = $0081;
  ERR_DELOBJSELECTED    = $0082;
  ERR_SELBITMAP         = $0083;

type
{ Debugging support (DEBUG SYSTEM ONLY) }
  LPWINDEBUGINFO = ^WINDEBUGINFO; far;
  WINDEBUGINFO = record
    flags: UINT;
    dwOptions: DWORD;
    dwFilter: DWORD;
    achAllocModule: array [0..7] of AnsiChar;
    dwAllocBreak: DWORD;
    dwAllocCount: DWORD;
  end;
  PWinDebugInfo = ^TWinDebugInfo;
  TWinDebugInfo = WINDEBUGINFO;

const
{ WINDEBUGINFO flags values }
  WDI_OPTIONS           = $0001;
  WDI_FILTER            = $0002;
  WDI_ALLOCBREAK        = $0004;

{ dwOptions values }
  DBO_CHECKHEAP         = $0001;
  DBO_BUFFERFILL        = $0004;
  DBO_DISABLEGPTRAPPING = $0010;
  DBO_CHECKFREE         = $0020;

  DBO_SILENT            = $8000;

  DBO_TRACEBREAK        = $2000;
  DBO_WARNINGBREAK      = $1000;
  DBO_NOERRORBREAK      = $0800;
  DBO_NOFATALBREAK      = $0400;
  DBO_INT3BREAK         = $0100;

{ DebugOutput flags values }
  DBF_TRACE             = $0000;
  DBF_WARNING           = $4000;
  DBF_ERROR             = $8000;
  DBF_FATAL             = $c000;

{ dwFilter values }
  DBF_KERNEL            = $1000;
  DBF_KRN_MEMMAN        = $0001;
  DBF_KRN_LOADMODULE    = $0002;
  DBF_KRN_SEGMENTLOAD   = $0004;
  DBF_USER              = $0800;
  DBF_GDI               = $0400;
  DBF_MMSYSTEM          = $0040;
  DBF_PENWIN            = $0020;
  DBF_APPLICATION       = $0008;
  DBF_DRIVER            = $0010;

{ ExitWindows values }
  EW_REBOOTSYSTEM = $43;

{ Predefined Resource Types }
  OBM_UPARROWI    = 32737;
  OBM_DNARROWI    = 32736;
  OBM_RGARROWI    = 32735;
  OBM_LFARROWI    = 32734;

type
{ GDI typedefs, structures, and functions }
  PSIZE = ^SIZE;
  NPSIZE = ^SIZE; near;
  LPSIZE = ^SIZE; far;
  SIZE = record
    cx: SmallInt;
    cy: SmallInt;
  end;
  TSize = SIZE;

const
{ Drawing bounds accumulation APIs }
  DCB_RESET      = $0001;
  DCB_ACCUMULATE = $0002;
  DCB_DIRTY      = DCB_ACCUMULATE;
  DCB_SET        = DCB_RESET or DCB_ACCUMULATE;
  DCB_ENABLE     = $0004;
  DCB_DISABLE    = $0008;

{ Color support }
  COLOR_INACTIVECAPTIONTEXT = 19;
  COLOR_BTNHIGHLIGHT        = 20;

{ Font support }
{ OutPrecision values }
  OUT_TT_PRECIS      = 4;
  OUT_DEVICE_PRECIS  = 5;
  OUT_RASTER_PRECIS  = 6;
  OUT_TT_ONLY_PRECIS = 7;

{ ClipPrecision values }
  CLIP_LH_ANGLES = $10;
  CLIP_TT_ALWAYS = $20;
  CLIP_EMBEDDED  = $80;

{ tmPitchAndFamily values }
  TMPF_TRUETYPE = $04;

type
  PPANOSE = ^PANOSE;
  LPPANOSE = ^PANOSE; far;
  PANOSE = record
    bFamilyType: BYTE;
    bSerifStyle: BYTE;
    bWeight: BYTE;
    bProportion: BYTE;
    bContrast: BYTE;
    bStrokeVariation: BYTE;
    bArmStyle: BYTE;
    bLetterform: BYTE;
    bMidline: BYTE;
    bXHeight: BYTE;
  end;
  TPanose = PANOSE;

  POUTLINETEXTMETRIC = ^OUTLINETEXTMETRIC;
  LPOUTLINETEXTMETRIC = ^OUTLINETEXTMETRIC; far;
  OUTLINETEXTMETRIC = record
    otmSize: UINT;
    otmTextMetrics: TEXTMETRIC;
    otmFiller: BYTE;
    otmPanoseNumber: PANOSE;
    otmfsSelection: UINT;
    otmfsType: UINT;
    otmsCharSlopeRise: SmallInt;
    otmsCharSlopeRun: SmallInt;
    otmItalicAngle: SmallInt;
    otmEMSquare: UINT;
    otmAscent: SmallInt;
    otmDescent: SmallInt;
    otmLineGap: UINT;
    otmsCapEmHeight: UINT;
    otmsXHeight: UINT;
    otmrcFontBox: RECT;
    otmMacAscent: SmallInt;
    otmMacDescent: SmallInt;
    otmMacLineGap: UINT;
    otmusMinimumPPEM: UINT;
    otmptSubscriptSize: POINT;
    otmptSubscriptOffset: POINT;
    otmptSuperscriptSize: POINT;
    otmptSuperscriptOffset: POINT;
    otmsStrikeoutSize: UINT;
    otmsStrikeoutPosition: SmallInt;
    otmsUnderscorePosition: SmallInt;
    otmsUnderscoreSize: SmallInt;
    otmpFamilyName: PSTR;
    otmpFaceName: PSTR;
    otmpStyleName: PSTR;
    otmpFullName: PSTR;
  end;
  TOutlineTextMetric = OUTLINETEXTMETRIC;

{ Structure passed to FONTENUMPROC }
{ NOTE: NEWTEXTMETRIC is the same as TEXTMETRIC plus 4 new fields }
  PNEWTEXTMETRIC = ^NEWTEXTMETRIC;
  NPNEWTEXTMETRIC = ^NEWTEXTMETRIC; near;
  LPNEWTEXTMETRIC = ^NEWTEXTMETRIC; far;
  NEWTEXTMETRIC = record
    tmHeight: SmallInt;
    tmAscent: SmallInt;
    tmDescent: SmallInt;
    tmInternalLeading: SmallInt;
    tmExternalLeading: SmallInt;
    tmAveCharWidth: SmallInt;
    tmMaxCharWidth: SmallInt;
    tmWeight: SmallInt;
    tmItalic: BYTE;
    tmUnderlined: BYTE;
    tmStruckOut: BYTE;
    tmFirstChar: BYTE;
    tmLastChar: BYTE;
    tmDefaultChar: BYTE;
    tmBreakChar: BYTE;
    tmPitchAndFamily: BYTE;
    tmCharSet: BYTE;
    tmOverhang: SmallInt;
    tmDigitizedAspectX: SmallInt;
    tmDigitizedAspectY: SmallInt;
    ntmFlags: DWORD;
    ntmSizeEM: UINT;
    ntmCellHeight: UINT;
    ntmAvgWidth: UINT;
  end;
  TNewTextMetric = NEWTEXTMETRIC;

const
{ ntmFlags field flags }
  NTM_REGULAR = $00000040;
  NTM_BOLD    = $00000020;
  NTM_ITALIC  = $00000001;

  LF_FULLFACESIZE = 64;

type
{ Structure passed to FONTENUMPROC }
  PENUMLOGFONT = ^ENUMLOGFONT;
  LPENUMLOGFONT = ^ENUMLOGFONT; far;
  ENUMLOGFONT = record
    elfLogFont: LOGFONT;
    elfFullName: array [0..LF_FULLFACESIZE-1] of AnsiChar;
    elfStyle: array [0..LF_FACESIZE-1] of AnsiChar;
  end;
  TEnumLogFont = ENUMLOGFONT;

  FONTENUMPROC = function(lpelf: LPENUMLOGFONT; lpntm: LPNEWTEXTMETRIC; FontType: SmallInt; lpData: LPARAM): SmallInt; far;

const
{ EnumFonts font type values }
  TRUETYPE_FONTTYPE = $0004;

type
  PGLYPHMETRICS = ^GLYPHMETRICS;
  LPGLYPHMETRICS = ^GLYPHMETRICS; far;
  GLYPHMETRICS = record
    gmBlackBoxX: UINT;
    gmBlackBoxY: UINT;
    gmptGlyphOrigin: POINT;
    gmCellIncX: SmallInt;
    gmCellIncY: SmallInt;
  end;
  TGlyphMetrics = GLYPHMETRICS;

  PFIXED = ^FIXED;
  LPFIXED = ^FIXED; far;
  FIXED = record
    fract: UINT;
    value: SmallInt;
  end;
  TFixed = FIXED;

  PMAT2 = ^MAT2;
  LPMAT2 = ^MAT2; far;
  MAT2 = record
    eM11: FIXED;
    eM12: FIXED;
    eM21: FIXED;
    eM22: FIXED;
  end;
  TMat2 = MAT2;

const
{ GetGlyphOutline constants }
  GGO_METRICS     =  0;
  GGO_BITMAP      =  1;
  GGO_NATIVE      =  2;

  TT_POLYGON_TYPE = 24;

  TT_PRIM_LINE    =  1;
  TT_PRIM_QSPLINE =  2;

type
  PPOINTFX = ^POINTFX;
  LPPOINTFX = ^POINTFX; far;
  POINTFX = record
    x: FIXED;
    y: FIXED;
  end;
  TPointFX = POINTFX;

  PTTPOLYCURVE = ^TTPOLYCURVE;
  LPTTPOLYCURVE = ^TTPOLYCURVE; far;
  TTPOLYCURVE = record
    wType: UINT;
    cpfx: UINT;
    apfx: array [0..0] of POINTFX;
  end;
  TTTPOLYCURVE = TTPolyCurve;

  PTTPOLYGONHEADER = ^TTPOLYGONHEADER;
  LPTTPOLYGONHEADER = ^TTPOLYGONHEADER; far;
  TTPOLYGONHEADER = record
    cb: DWORD;
    dwType: DWORD;
    pfxStart: POINTFX;
  end;
  TTTPolygonHeader = TTPOLYGONHEADER;

  PABC = ^ABC;
  LPABC = ^ABC; far;
  ABC = record
    abcA: SmallInt;
    abcB: UINT;
    abcC: SmallInt;
  end;
  TABC = ABC;

  PKERNINGPAIR = ^KERNINGPAIR;
  LPKERNINGPAIR = ^KERNINGPAIR; far;
  KERNINGPAIR = record
    wFirst: WORD;
    wSecond: WORD;
    iKernAmount: SmallInt;
  end;
  TKerningPair = KERNINGPAIR;

  PRASTERIZER_STATUS = ^RASTERIZER_STATUS;
  LPRASTERIZER_STATUS = ^RASTERIZER_STATUS; far;
  RASTERIZER_STATUS = record
    nSize: SmallInt;
    wFlags: SmallInt;
    nLanguageID: SmallInt;
  end;
  TRasterizer_Status = RASTERIZER_STATUS;

const
{ bits defined in wFlags of RASTERIZER_STATUS }
  TT_AVAILABLE = $0001;
  TT_ENABLED   = $0002;

type
{ Printing support }
  PDOCINFO = ^DOCINFO;
  LPDOCINFO = ^DOCINFO; far;
  DOCINFO = record
    cbSize: SmallInt;
    lpszDocName: LPCSTR;
    lpszOutput: LPCSTR;
  end;
  TDocInfo = DOCINFO;

{ System Metrics }
const
{ GetSystemMetrics() codes }
  SM_CXDOUBLECLK       = 36;
  SM_CYDOUBLECLK       = 37;
  SM_CXICONSPACING     = 38;
  SM_CYICONSPACING     = 39;
  SM_MENUDROPALIGNMENT = 40;
  SM_PENWINDOWS        = 41;
  SM_DBCSENABLED       = 42;
  SM_CMETRICS          = 43;

{ System Parameters support }
  SPI_GETBEEP               = 1;
  SPI_SETBEEP               = 2;
  SPI_GETMOUSE              = 3;
  SPI_SETMOUSE              = 4;
  SPI_GETBORDER             = 5;
  SPI_SETBORDER             = 6;
  SPI_GETKEYBOARDSPEED      = 10;
  SPI_SETKEYBOARDSPEED      = 11;
  SPI_LANGDRIVER            = 12;
  SPI_ICONHORIZONTALSPACING = 13;
  SPI_GETSCREENSAVETIMEOUT  = 14;
  SPI_SETSCREENSAVETIMEOUT  = 15;
  SPI_GETSCREENSAVEACTIVE   = 16;
  SPI_SETSCREENSAVEACTIVE   = 17;
  SPI_GETGRIDGRANULARITY    = 18;
  SPI_SETGRIDGRANULARITY    = 19;
  SPI_SETDESKWALLPAPER      = 20;
  SPI_SETDESKPATTERN        = 21;
  SPI_GETKEYBOARDDELAY      = 22;
  SPI_SETKEYBOARDDELAY      = 23;
  SPI_ICONVERTICALSPACING   = 24;
  SPI_GETICONTITLEWRAP      = 25;
  SPI_SETICONTITLEWRAP      = 26;
  SPI_GETMENUDROPALIGNMENT  = 27;
  SPI_SETMENUDROPALIGNMENT  = 28;
  SPI_SETDOUBLECLKWIDTH     = 29;
  SPI_SETDOUBLECLKHEIGHT    = 30;
  SPI_GETICONTITLELOGFONT   = 31;
  SPI_SETDOUBLECLICKTIME    = 32;
  SPI_SETMOUSEBUTTONSWAP    = 33;
  SPI_SETICONTITLELOGFONT   = 34;
  SPI_GETFASTTASKSWITCH     = 35;
  SPI_SETFASTTASKSWITCH     = 36;

{ SystemParametersInfo flags }
  SPIF_UPDATEINIFILE    = $0001;
  SPIF_SENDWININICHANGE = $0002;

{ Window message support }

{ GetQueueStatus flags }
  QS_KEY         = $0001;
  QS_MOUSEMOVE   = $0002;
  QS_MOUSEBUTTON = $0004;
  QS_MOUSE       = QS_MOUSEMOVE or QS_MOUSEBUTTON;
  QS_POSTMESSAGE = $0008;
  QS_TIMER       = $0010;
  QS_PAINT       = $0020;
  QS_SENDMESSAGE = $0040;

  QS_ALLINPUT    = $007f;

{ Power management }
  WM_POWER = $0048;

{ wParam for WM_POWER window message and DRV_POWER driver notification }
  PWR_OK             = 1;
  PWR_FAIL           = (-1);
  PWR_SUSPENDREQUEST = 1;
  PWR_SUSPENDRESUME  = 2;
  PWR_CRITICALRESUME = 3;

{ Window class management }
{ Class field offsets for GetClassLong() and GetClassWord() }
  GCW_ATOM = (-32);

{ Window creation/destroy }

{ Window Styles }
  WS_EX_TOPMOST     = $00000008;
  WS_EX_ACCEPTFILES = $00000010;
  WS_EX_TRANSPARENT = $00000020;

type
{ Window size, position, Z-order, and visibility }
  PWINDOWPLACEMENT = ^WINDOWPLACEMENT;
  LPWINDOWPLACEMENT = ^WINDOWPLACEMENT; far;
  WINDOWPLACEMENT = record
    length: UINT;
    flags: UINT;
    showCmd: UINT;
    ptMinPosition: POINT;
    ptMaxPosition: POINT;
    rcNormalPosition: RECT;
  end;
  TWindowPlacement = WINDOWPLACEMENT;

const
  WPF_SETMINPOSITION     = $0001;
  WPF_RESTORETOMAXIMIZED = $0002;

  WM_WINDOWPOSCHANGING   = $0046;
  WM_WINDOWPOSCHANGED    = $0047;

type
{ WM_WINDOWPOSCHANGING/CHANGED struct pointed to by lParam }
  PWINDOWPOS = ^WINDOWPOS;
  LPWINDOWPOS = ^WINDOWPOS; far;
  WINDOWPOS = record
    hwnd: HWND;
    hwndInsertAfter: HWND;
    x: SmallInt;
    y: SmallInt;
    cx: SmallInt;
    cy: SmallInt;
    flags: UINT;
  end;
  TWindowPos = WINDOWPOS;

const
{ Window drawing support }
  DCX_WINDOW           = $00000001;
  DCX_CACHE            = $00000002;
  DCX_CLIPCHILDREN     = $00000008;
  DCX_CLIPSIBLINGS     = $00000010;
  DCX_PARENTCLIP       = $00000020;

  DCX_EXCLUDERGN       = $00000040;
  DCX_INTERSECTRGN     = $00000080;


  DCX_LOCKWINDOWUPDATE = $00000400;


  DCX_USESTYLE         = $00010000;

{ Window scrolling }
  SW_SCROLLCHILDREN = $0001;
  SW_INVALIDATE     = $0002;
  SW_ERASE          = $0004;

{ Non-client window area management }
{ WM_NCCALCSIZE return flags }
  WVR_ALIGNTOP    = $0010;
  WVR_ALIGNLEFT   = $0020;
  WVR_ALIGNBOTTOM = $0040;
  WVR_ALIGNRIGHT  = $0080;
  WVR_HREDRAW     = $0100;
  WVR_VREDRAW     = $0200;
  WVR_REDRAW      = WVR_HREDRAW or WVR_VREDRAW;
  WVR_VALIDRECTS  = $0400;

type
{ WM_NCCALCSIZE parameter structure }
  PNCCALCSIZE_PARAMS = ^NCCALCSIZE_PARAMS;
  LPNCCALCSIZE_PARAMS = ^NCCALCSIZE_PARAMS; far;
  NCCALCSIZE_PARAMS = record
    rgrc: array [0..2] of RECT;
    lppos: LPWINDOWPOS;
  end;
  TNCCalcSize_Params = NCCALCSIZE_PARAMS;

{ Mouse input support }
  const
{ WM_MOUSEACTIVATE return codes }
  MA_NOACTIVATEANDEAT = 4;

{ Menu support }
{ Flags for TrackPopupMenu }
  TPM_RIGHTBUTTON = $0002;
  TPM_LEFTALIGN   = $0000;
  TPM_CENTERALIGN = $0004;
  TPM_RIGHTALIGN  = $0008;

{ MDI Support }

{ MDI client style bits }
  MDIS_ALLCHILDSTYLES = $0001;

{ wParam values for WM_MDITILE and WM_MDICASCADE messages. }
  MDITILE_VERTICAL     = $0000;
  MDITILE_HORIZONTAL   = $0001;
  MDITILE_SKIPDISABLED = $0002;

{ Static control }
{ Static Control Mesages }
  STM_SETICON = (WM_USER+0);
  STM_GETICON = (WM_USER+1);

{ Edit control }
{ Edit control styles }
  ES_READONLY            = $00000800;
  ES_WANTRETURN          = $00001000;

{ Edit control messages }
  EM_GETFIRSTVISIBLELINE = (WM_USER+30);
  EM_SETREADONLY         = (WM_USER+31);
  EM_SETWORDBREAKPROC    = (WM_USER+32);
  EM_GETWORDBREAKPROC    = (WM_USER+33);
  EM_GETPASSWORDCHAR     = (WM_USER+34);

type
  EDITWORDBREAKPROC = function(lpch: LPSTR; ichCurrent, cch, code: SmallInt): SmallInt; far;

const
{ EDITWORDBREAKPROC code values }
  WB_LEFT                = 0;
  WB_RIGHT               = 1;
  WB_ISDELIMITER         = 2;

{ Listbox control }
{ Listbox styles }
  LBS_DISABLENOSCROLL = $1000;

{ Listbox messages }
  LB_SETITEMHEIGHT    = (WM_USER+33);
  LB_GETITEMHEIGHT    = (WM_USER+34);
  LB_FINDSTRINGEXACT  = (WM_USER+35);

{ Combo box control }
{ Combo box styles }
  CBS_DISABLENOSCROLL      = $0800;

{ Combo box messages }
  CB_GETDROPPEDCONTROLRECT = (WM_USER+18);
  CB_SETITEMHEIGHT         = (WM_USER+19);
  CB_GETITEMHEIGHT         = (WM_USER+20);
  CB_SETEXTENDEDUI         = (WM_USER+21);
  CB_GETEXTENDEDUI         = (WM_USER+22);
  CB_GETDROPPEDSTATE       = (WM_USER+23);
  CB_FINDSTRINGEXACT       = (WM_USER+24);

{ Combo box notification codes }
  CBN_CLOSEUP              = 8;
  CBN_SELENDOK             = 9;
  CBN_SELENDCANCEL         = 10;

{ Computer-based-training (CBT) support }
type
{ HCBT_CREATEWND parameters pointed to by lParam }
  PCBT_CREATEWND = ^CBT_CREATEWND;
  LPCBT_CREATEWND = ^CBT_CREATEWND; far;
  CBT_CREATEWND = record
    lpcs: LPCREATESTRUCT;
    hwndInsertAfter: HWND;
  end;
  TCBT_CreateWnd = CBT_CREATEWND;

{ HCBT_ACTIVATE structure pointed to by lParam }
  PCBTACTIVATESTRUCT = ^CBTACTIVATESTRUCT;
  LPCBTACTIVATESTRUCT = ^CBTACTIVATESTRUCT; far;
  CBTACTIVATESTRUCT = record
    fMouse: BOOL;
    hWndActive: HWND;
  end;
  TCBTActivateStruct = CBTACTIVATESTRUCT;

const
{ Hardware hook support }
  WH_HARDWARE = 8;

type
  PHARDWAREHOOKSTRUCT = ^HARDWAREHOOKSTRUCT;
  LPHARDWAREHOOKSTRUCT = ^HARDWAREHOOKSTRUCT; far;
  HARDWAREHOOKSTRUCT = record
    hWnd: HWND;
    wMessage: UINT;
    wParam: WPARAM;
    lParam: LPARAM;
  end;
  THardwareHookStruct = HARDWAREHOOKSTRUCT;

{ Shell support }
const
{ SetWindowsHook() Shell hook code }
  WH_SHELL                   = 10;

  HSHELL_WINDOWCREATED       = 1;
  HSHELL_WINDOWDESTROYED     = 2;
  HSHELL_ACTIVATESHELLWINDOW = 3;

{ Debugger support }

{ SetWindowsHook debug hook support }
  WH_DEBUG = 9;

type
  PDEBUGHOOKINFO = ^DEBUGHOOKINFO;
  LPDEBUGHOOKINFO = ^DEBUGHOOKINFO; far;
  DEBUGHOOKINFO = record
    hModuleHook: HMODULE;
    reserved: LPARAM;
    lParam: LPARAM;
    wParam: WPARAM;
    code: SmallInt;
  end;
  TDebugHookInfo = DEBUGHOOKINFO;

const
{ Flags returned by GetSystemDebugState. }
  SDS_MENU        = $0001;
  SDS_SYSMODAL    = $0002;
  SDS_NOTASKQUEUE = $0004;
  SDS_DIALOG      = $0008;
  SDS_TASKLOCKED  = $0010;

{ Comm support }
{ new escape functions }
  GETMAXLPT     = 8;
  GETMAXCOM     = 9;
  GETBASEIRQ    = 10;

{ Comm Baud Rate indices }
  CBR_110       = $FF10;
  CBR_300       = $FF11;
  CBR_600       = $FF12;
  CBR_1200      = $FF13;
  CBR_2400      = $FF14;
  CBR_4800      = $FF15;
  CBR_9600      = $FF16;
  CBR_14400     = $FF17;
  CBR_19200     = $FF18;
  CBR_38400     = $FF1B;
  CBR_56000     = $FF1F;
  CBR_128000    = $FF23;
  CBR_256000    = $FF27;

{ notifications passed in low word of lParam on WM_COMMNOTIFY messages }
  CN_RECEIVE    = $0001;
  CN_TRANSMIT   = $0002;
  CN_EVENT      = $0004;

  WM_COMMNOTIFY = $0044;

type
{ Driver support }
  HDRVR = THandle;
  DRIVERPROC = function(dwDriverIdentifier: DWORD; hDriver: HDRVR; msg: UINT; lParam1, lParam2: LPARAM): LRESULT; far;

const
{ Driver messages }
  DRV_LOAD              = $0001;
  DRV_ENABLE            = $0002;
  DRV_OPEN              = $0003;
  DRV_CLOSE             = $0004;
  DRV_DISABLE           = $0005;
  DRV_FREE              = $0006;
  DRV_CONFIGURE         = $0007;
  DRV_QUERYCONFIGURE    = $0008;
  DRV_INSTALL           = $0009;
  DRV_REMOVE            = $000A;
  DRV_EXITSESSION       = $000B;
  DRV_EXITAPPLICATION   = $000C;
  DRV_POWER             = $000F;

  DRV_RESERVED          = $0800;
  DRV_USER              = $4000;

type
{ LPARAM of DRV_CONFIGURE message }
  PDRVCONFIGINFO = ^DRVCONFIGINFO;
  LPDRVCONFIGINFO = ^DRVCONFIGINFO; far;
  DRVCONFIGINFO = record
    dwDCISize: DWORD;
    lpszDCISectionName: LPCSTR;
    lpszDCIAliasName: LPCSTR;
  end;
  TDrvConfigInfo = DRVCONFIGINFO;

const
{ Supported return values for DRV_CONFIGURE message }
  DRVCNF_CANCEL         = $0000;
  DRVCNF_OK             = $0001;
  DRVCNF_RESTART        = $0002;

{ Supported lParam1 of DRV_EXITAPPLICATION notification }
  DRVEA_NORMALEXIT      = $0001;
  DRVEA_ABNORMALEXIT    = $0002;

{ GetNextDriver flags }
  GND_FIRSTINSTANCEONLY = $00000001;

  GND_FORWARD           = $00000000;
  GND_REVERSE           = $00000002;

type
  PDRIVERINFOSTRUCT = ^DRIVERINFOSTRUCT;
  LPDRIVERINFOSTRUCT = ^DRIVERINFOSTRUCT; far;
  DRIVERINFOSTRUCT = record
    length: UINT;
    hDriver: HDRVR;
    hModule: HINST;
    szAliasName: array [0..127] of AnsiChar;
  end;
  TDriverInfoStruct = DRIVERINFOSTRUCT;

function GetFreeSystemResources(SysResource: UINT): UINT; external 'USER';

procedure LogError(err: UINT; lpInfo: FarPointer); external 'KERNEL';
procedure LogParamError(err: UINT; lpfn: FARPROC; param: FarPointer); external 'KERNEL';

function GetWinDebugInfo(lpwdi: LPWINDEBUGINFO; flags: UINT): BOOL; external 'KERNEL';
function SetWinDebugInfo(lpwdi: LPWINDEBUGINFO): BOOL; external 'KERNEL';

procedure DebugOutput(flags: UINT; lpsz: LPCSTR; etc: array of const); cdecl; external 'KERNEL' name '_DebugOutput';

function ExitWindowsExec(Exe, Params: LPCSTR): BOOL; external 'USER';


{ Pointer validation }

function IsBadReadPtr(lp: FarPointer; cb: UINT): BOOL; external 'KERNEL';
function IsBadWritePtr(lp: FarPointer; cb: UINT): BOOL; external 'KERNEL';
function IsBadHugeReadPtr(lp: HugePointer; cb: DWORD): BOOL; external 'KERNEL';
function IsBadHugeReadPtr(lp: FarPointer; cb: DWORD): BOOL; external 'KERNEL';
function IsBadHugeWritePtr(lp: HugePointer; cb: DWORD): BOOL; external 'KERNEL';
function IsBadHugeWritePtr(lp: FarPointer; cb: DWORD): BOOL; external 'KERNEL';
function IsBadCodePtr(lpfn: FARPROC): BOOL; external 'KERNEL';
function IsBadStringPtr(lpsz: LPSTR; cchMax: UINT): BOOL; external 'KERNEL';

{ Task Management }

function IsTask(Task: HTASK): BOOL; external 'KERNEL';

{ File I/O }

function _hread(FileHandle: HFILE; Buffer: HugePointer; Bytes: LongInt): LongInt; external 'KERNEL';
function _hwrite(FileHandle: HFILE; Buffer: HugePointer; Bytes: LongInt): LongInt; external 'KERNEL';

{ International & AnsiChar Translation Support }

function lstrcpyn(lpszString1: LPSTR; lpszString2: LPCSTR; cChars: SmallInt): LPSTR; external 'KERNEL';
procedure hmemcpy(hpvDest, hpvSource: HugePointer; cbCopy: LongInt); external 'KERNEL';
procedure hmemcpy(hpvDest, hpvSource: FarPointer; cbCopy: LongInt); external 'KERNEL';

function IsDBCSLeadByte(bTestChar: BYTE): BOOL; external 'KERNEL';

{ Drawing bounds accumulation APIs }
function SetBoundsRect(hDC: HDC; lprcBounds: LPRECT; flags: UINT): UINT; external 'GDI';
function GetBoundsRect(hDC: HDC; lprcBounds: LPRECT; flags: UINT): UINT; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function SetBoundsRect(hDC: HDC; const lprcBounds: RECT; flags: UINT): UINT; external 'GDI';
function GetBoundsRect(hDC: HDC; var lprcBounds: RECT; flags: UINT): UINT; external 'GDI';
{$endif}

{ Coordinate transformation support }
function SetWindowOrgEx(hdc: HDC; nX, nY: SmallInt; lpPoint: LPPOINT): BOOL; external 'GDI';
function GetWindowOrgEx(hdc: HDC; lpPoint: LPPOINT): BOOL; external 'GDI';

function SetWindowExtEx(hdc: HDC; nX, nY: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';
function GetWindowExtEx(hdc: HDC; lpSize: LPSIZE): BOOL; external 'GDI';

function OffsetWindowOrgEx(hdc: HDC; nX, nY: SmallInt; lpPoint: LPPOINT): BOOL; external 'GDI';
function ScaleWindowExtEx(hdc: HDC; nXnum, nXdenom, nYnum, nYdenom: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';

function SetViewportExtEx(hdc: HDC; nX, nY: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';
function GetViewportExtEx(hdc: HDC; lpSize: LPSIZE): BOOL; external 'GDI';

function SetViewportOrgEx(hdc: HDC; nX, nY: SmallInt; lpPoint: LPPOINT): BOOL; external 'GDI';
function GetViewportOrgEx(hdc: HDC; lpPoint: LPPOINT): BOOL; external 'GDI';

function OffsetViewportOrgEx(hdc: HDC; nX, nY: SmallInt; lpPoint: LPPOINT): BOOL; external 'GDI';
function ScaleViewportExtEx(hdc: HDC; nXnum, nXdenom, nYnum, nYdenom: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';

{ Brush support }
function GetBrushOrgEx(hDC: HDC; lpPoint: LPPOINT): BOOL; external 'GDI';

{ General drawing support }
function MoveToEx(hdc: HDC; x, y: SmallInt; lpPoint: LPPOINT): BOOL; external 'GDI';
function GetCurrentPositionEx(hdc: HDC; lpPoint: LPPOINT): BOOL; external 'GDI';

{ Text support }
function GetTextExtentPoint(hdc: HDC; lpszString: LPCSTR; cbString: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function GetTextExtentPoint(hdc: HDC; lpszString: LPCSTR; cbString: SmallInt; var Size: SIZE): BOOL; external 'GDI';
{$endif}

{ Font support }
function GetAspectRatioFilterEx(hdc: HDC; lpAspectRatio: LPSIZE): BOOL; external 'GDI';

function GetOutlineTextMetrics(hdc: HDC; cbData: UINT; lpotm: LPOUTLINETEXTMETRIC): WORD; external 'GDI';

function EnumFontFamilies(hdc: HDC; lpszFamily: LPCSTR; fntenmprc: FONTENUMPROC; lParam: LPARAM): SmallInt; external 'GDI';
function EnumFontFamilies(hdc: HDC; lpszFamily: LPCSTR; fntenmprc: TFarProc; lParam: LPARAM): SmallInt; external 'GDI';

function GetFontData(hdc: HDC; dwTable, dwOffset: DWORD; lpvBuffer: FarPointer; cbData: DWORD): DWORD; external 'GDI';
function CreateScalableFontResource(fHidden: UINT; lpszResourceFile, lpszFontFile, lpszCurrentPath: LPCSTR): BOOL; external 'GDI';

function GetGlyphOutline(hdc: HDC; uChar, fuFormat: UINT; lpgm: LPGLYPHMETRICS; cbBuffer: DWORD; lpBuffer: FarPointer; lpmat2: LPMAT2): DWORD; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function GetGlyphOutline(hdc: HDC; uChar, fuFormat: UINT; var gm: GLYPHMETRICS; cbBuffer: DWORD; lpBuffer: FarPointer; var mat2: MAT2): DWORD; external 'GDI';
{$endif}

function GetCharABCWidths(hdc: HDC; uFirstChar, uLastChar: UINT; lpabc: LPABC): BOOL; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function GetCharABCWidths(hdc: HDC; uFirstChar, uLastChar: UINT; var abc: ABC): BOOL; external 'GDI';
{$endif}

function GetKerningPairs(hdc: HDC; cPairs: SmallInt; lpkrnpair: LPKERNINGPAIR): SmallInt; external 'GDI';

function GetRasterizerCaps(lpraststat: LPRASTERIZER_STATUS; cb: SmallInt): BOOL; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function GetRasterizerCaps(var raststat: RASTERIZER_STATUS; cb: SmallInt): BOOL; external 'GDI';
{$endif}

{ Bitmap support }
function SetBitmapDimensionEx(hbm: HBITMAP; nX, nY: SmallInt; lpSize: LPSIZE): BOOL; external 'GDI';
function GetBitmapDimensionEx(hBitmap: HBITMAP; lpDimension: LPSIZE): BOOL; external 'GDI';

{ Metafile support }
function SetMetaFileBitsBetter(hmf: HGLOBAL): HMETAFILE; external 'GDI';

{ Printing support }
function StartDoc(hdc: HDC; lpdi: LPDOCINFO): SmallInt; external 'GDI';
{$ifdef VAR_PARAMS_ARE_FAR}
function StartDoc(hdc: HDC; var di: DOCINFO): SmallInt; external 'GDI';
{$endif}
function StartPage(hdc: HDC): SmallInt; external 'GDI';
function EndPage(hdc: HDC): SmallInt; external 'GDI';
function EndDoc(hdc: HDC): SmallInt; external 'GDI';
function AbortDoc(hdc: HDC): SmallInt; external 'GDI';

function SetAbortProc(hdc: HDC; abrtprc: ABORTPROC): SmallInt; external 'GDI';
function SpoolFile(lpszPrinter, lpszPort, lpszJob, lpszFile: LPSTR): HANDLE; external 'GDI';

{ System Parameters support }
function SystemParametersInfo(uAction, uParam: UINT; lpvParam: FarPointer; fuWinIni: UINT): BOOL; external 'USER';

{ Rectangle support }
function SubtractRect(lprcDest: LPRECT; lprcSource1, lprcSource2: LPRECT): BOOL; external 'USER';
{$ifdef VAR_PARAMS_ARE_FAR}
function SubtractRect(var rcDest: RECT; var rcSource1, rcSource2: RECT): BOOL; external 'USER';
{$endif}

{ Window message support }
function GetMessageExtraInfo: LPARAM; external 'USER';
function GetQueueStatus(flags: UINT): DWORD; external 'USER';

{ Window class management }
{ in Windows 3.1+, RegisterClass returns an ATOM that unquely identifies the 
  class. In Windows 3.0 and earlier, the return value is BOOL. That's why we
  redefine this function in the win31 unit. }
function RegisterClass(lpwc: LPWNDCLASS): ATOM; external 'USER';
{$ifdef VAR_PARAMS_ARE_FAR}
function RegisterClass(var wc: WNDCLASS): ATOM; external 'USER';
{$endif}

{ Window size, position, Z-order, and visibility }
function GetWindowPlacement(hwnd: HWND; lpwndpl: LPWINDOWPLACEMENT): BOOL; external 'USER';
function SetWindowPlacement(hwnd: HWND; lpwndpl: LPWINDOWPLACEMENT): BOOL; external 'USER';

{ Window coordinate mapping and hit-testing }

procedure MapWindowPoints(hwndFrom, hwndTo: HWND; lppt: LPPOINT; cpt: UINT); external 'USER';
{$ifdef VAR_PARAMS_ARE_FAR}
procedure MapWindowPoints(hwndFrom, hwndTo: HWND; var pt: POINT; cpt: UINT); external 'USER';
{$endif}

{ Window drawing support }
{ note: the first parameter in this function is declared 'register' in windows.h, even though
        the calling convention of the function is 'pascal'
  todo: figure out whether the first parameter really needs to be passed in register, or
        whether the 'register' modifier is ignored by 16-bit C compilers, when the calling
        convention is 'pascal'.
 }
function GetDCEx({register} hwnd: HWND; hrgnClip: HRGN; flags: DWORD): HDC; external 'USER';

{ Window repainting }
function LockWindowUpdate(hwndLock: HWND): BOOL; external 'USER';
function RedrawWindow(hwnd: HWND; lprcUpdate: LPRECT; hrgnUpdate: HRGN; flags: UINT): BOOL; external 'USER';

{ Window scrolling }
function ScrollWindowEx(hwnd: HWND; dx, dy: SmallInt;
          prcScroll, prcClip: LPRECT;
          hrgnUpdate: HRGN; prcUpdate: LPRECT; flags: UINT): SmallInt; external 'USER';

{ Menu support }
function IsMenu(hmenu: HMENU): BOOL; external 'USER';

{ Scroll bar support }
function EnableScrollBar(hwnd: HWND; fnSBFlags: SmallInt; fuArrowFlags: UINT): BOOL; external 'USER';

{ Clipboard Manager Functions }
function GetOpenClipboardWindow: HWND; external 'USER';

{ Mouse cursor support }
function CopyCursor(hinst: HINST; hcur: HCURSOR): HCURSOR; external 'USER';
function GetCursor: HCURSOR; external 'USER';
procedure GetClipCursor(lprc: LPRECT); external 'USER';
{$ifdef VAR_PARAMS_ARE_FAR}
procedure GetClipCursor(var rc: RECT); external 'USER';
{$endif}

{ Icon support }
function CopyIcon(hinst: HINST; hicon: HICON): HICON; external 'USER';

{ Dialog directory support }
function DlgDirSelectEx(hwndDlg: HWND; lpszPath: LPSTR; cbPath, idListBox: SmallInt): BOOL; external 'USER';
function DlgDirSelectComboBoxEx(hwndDlg: HWND; lpszPath: LPSTR; cbPath, idComboBox: SmallInt): BOOL; external 'USER';

{ Windows hook support }
function SetWindowsHookEx(idHook: SmallInt; lpfn: HOOKPROC; hInstance: HINST; hTask: HTASK): HHOOK; external 'USER';
function UnhookWindowsHookEx(hHook: HHOOK): BOOL; external 'USER';
function CallNextHookEx(hHook: HHOOK; code: SmallInt; wParam: WPARAM; lParam: LPARAM): LRESULT; external 'USER';

{ Debugger support }
function QuerySendMessage(h1, h2, h3: HANDLE; lpmsg: LPMSG): BOOL; external 'USER';
function LockInput(h1: HANDLE; hwndInput: HWND; fLock: BOOL): BOOL; external 'USER';
function GetSystemDebugState: LONG; external 'USER';

{ Comm support }
function EnableCommNotification(idComDev: SmallInt; hwnd: HWND; cbWriteNotify, cbOutQueue: SmallInt): BOOL; external 'USER';

{ Driver support }
function DefDriverProc(dwDriverIdentifier: DWORD; driverID: HDRVR; message: UINT; lParam1, lParam2: LPARAM): LRESULT; external 'USER';
function OpenDriver(szDriverName, szSectionName: LPCSTR; lParam2: LPARAM): HDRVR; external 'USER';
function CloseDriver(hDriver: HDRVR; lParam1, lParam2: LPARAM): LRESULT; external 'USER';
function SendDriverMessage(hDriver: HDRVR; message: UINT; lParam1, lParam2: LPARAM): LRESULT; external 'USER';
function GetDriverModuleHandle(hDriver: HDRVR): HINST; external 'USER';
function GetNextDriver(hdrvr: HDRVR; fdwFlag: DWORD): HDRVR; external 'USER';
function GetDriverInfo(hdrvr: HDRVR; lpdis: LPDRIVERINFOSTRUCT): BOOL; external 'USER';

implementation

end.
