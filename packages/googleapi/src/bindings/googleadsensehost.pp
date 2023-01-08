unit googleadsensehost;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAccount = Class;
  TAccounts = Class;
  TAdClient = Class;
  TAdClients = Class;
  TAdCode = Class;
  TAdStyle = Class;
  TAdUnit = Class;
  TAdUnits = Class;
  TAssociationSession = Class;
  TCustomChannel = Class;
  TCustomChannels = Class;
  TReport = Class;
  TUrlChannel = Class;
  TUrlChannels = Class;
  TAccountArray = Array of TAccount;
  TAccountsArray = Array of TAccounts;
  TAdClientArray = Array of TAdClient;
  TAdClientsArray = Array of TAdClients;
  TAdCodeArray = Array of TAdCode;
  TAdStyleArray = Array of TAdStyle;
  TAdUnitArray = Array of TAdUnit;
  TAdUnitsArray = Array of TAdUnits;
  TAssociationSessionArray = Array of TAssociationSession;
  TCustomChannelArray = Array of TCustomChannel;
  TCustomChannelsArray = Array of TCustomChannels;
  TReportArray = Array of TReport;
  TUrlChannelArray = Array of TUrlChannel;
  TUrlChannelsArray = Array of TUrlChannels;
  //Anonymous types, using auto-generated names
  TAdStyleTypecolors = Class;
  TAdStyleTypefont = Class;
  TAdUnitTypecontentAdsSettingsTypebackupOption = Class;
  TAdUnitTypecontentAdsSettings = Class;
  TAdUnitTypemobileContentAdsSettings = Class;
  TReportTypeheadersItem = Class;
  TAccountsTypeitemsArray = Array of TAccount;
  TAdClientsTypeitemsArray = Array of TAdClient;
  TAdUnitsTypeitemsArray = Array of TAdUnit;
  TCustomChannelsTypeitemsArray = Array of TCustomChannel;
  TReportTypeheadersArray = Array of TReportTypeheadersItem;
  TReportTyperowsArray = Array of TStringArray;
  TUrlChannelsTypeitemsArray = Array of TUrlChannel;
  
  { --------------------------------------------------------------------
    TAccount
    --------------------------------------------------------------------}
  
  TAccount = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    Fname : String;
    Fstatus : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property status : String Index 24 Read Fstatus Write Setstatus;
  end;
  TAccountClass = Class of TAccount;
  
  { --------------------------------------------------------------------
    TAccounts
    --------------------------------------------------------------------}
  
  TAccounts = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TAccountsTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAccountsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TAccountsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
  end;
  TAccountsClass = Class of TAccounts;
  
  { --------------------------------------------------------------------
    TAdClient
    --------------------------------------------------------------------}
  
  TAdClient = Class(TGoogleBaseObject)
  Private
    FarcOptIn : boolean;
    Fid : String;
    Fkind : String;
    FproductCode : String;
    FsupportsReporting : boolean;
  Protected
    //Property setters
    Procedure SetarcOptIn(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductCode(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsupportsReporting(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property arcOptIn : boolean Index 0 Read FarcOptIn Write SetarcOptIn;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property productCode : String Index 24 Read FproductCode Write SetproductCode;
    Property supportsReporting : boolean Index 32 Read FsupportsReporting Write SetsupportsReporting;
  end;
  TAdClientClass = Class of TAdClient;
  
  { --------------------------------------------------------------------
    TAdClients
    --------------------------------------------------------------------}
  
  TAdClients = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TAdClientsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAdClientsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TAdClientsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
  end;
  TAdClientsClass = Class of TAdClients;
  
  { --------------------------------------------------------------------
    TAdCode
    --------------------------------------------------------------------}
  
  TAdCode = Class(TGoogleBaseObject)
  Private
    FadCode : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetadCode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property adCode : String Index 0 Read FadCode Write SetadCode;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TAdCodeClass = Class of TAdCode;
  
  { --------------------------------------------------------------------
    TAdStyleTypecolors
    --------------------------------------------------------------------}
  
  TAdStyleTypecolors = Class(TGoogleBaseObject)
  Private
    Fbackground : String;
    Fborder : String;
    Ftext : String;
    Ftitle : String;
    Furl : String;
  Protected
    //Property setters
    Procedure Setbackground(AIndex : Integer; const AValue : String); virtual;
    Procedure Setborder(AIndex : Integer; const AValue : String); virtual;
    Procedure Settext(AIndex : Integer; const AValue : String); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturl(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property background : String Index 0 Read Fbackground Write Setbackground;
    Property border : String Index 8 Read Fborder Write Setborder;
    Property text : String Index 16 Read Ftext Write Settext;
    Property title : String Index 24 Read Ftitle Write Settitle;
    Property url : String Index 32 Read Furl Write Seturl;
  end;
  TAdStyleTypecolorsClass = Class of TAdStyleTypecolors;
  
  { --------------------------------------------------------------------
    TAdStyleTypefont
    --------------------------------------------------------------------}
  
  TAdStyleTypefont = Class(TGoogleBaseObject)
  Private
    Ffamily : String;
    Fsize : String;
  Protected
    //Property setters
    Procedure Setfamily(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsize(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property family : String Index 0 Read Ffamily Write Setfamily;
    Property size : String Index 8 Read Fsize Write Setsize;
  end;
  TAdStyleTypefontClass = Class of TAdStyleTypefont;
  
  { --------------------------------------------------------------------
    TAdStyle
    --------------------------------------------------------------------}
  
  TAdStyle = Class(TGoogleBaseObject)
  Private
    Fcolors : TAdStyleTypecolors;
    Fcorners : String;
    Ffont : TAdStyleTypefont;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setcolors(AIndex : Integer; const AValue : TAdStyleTypecolors); virtual;
    Procedure Setcorners(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfont(AIndex : Integer; const AValue : TAdStyleTypefont); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property colors : TAdStyleTypecolors Index 0 Read Fcolors Write Setcolors;
    Property corners : String Index 8 Read Fcorners Write Setcorners;
    Property font : TAdStyleTypefont Index 16 Read Ffont Write Setfont;
    Property kind : String Index 24 Read Fkind Write Setkind;
  end;
  TAdStyleClass = Class of TAdStyle;
  
  { --------------------------------------------------------------------
    TAdUnitTypecontentAdsSettingsTypebackupOption
    --------------------------------------------------------------------}
  
  TAdUnitTypecontentAdsSettingsTypebackupOption = Class(TGoogleBaseObject)
  Private
    Fcolor : String;
    F_type : String;
    Furl : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setcolor(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturl(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property color : String Index 0 Read Fcolor Write Setcolor;
    Property _type : String Index 8 Read F_type Write Set_type;
    Property url : String Index 16 Read Furl Write Seturl;
  end;
  TAdUnitTypecontentAdsSettingsTypebackupOptionClass = Class of TAdUnitTypecontentAdsSettingsTypebackupOption;
  
  { --------------------------------------------------------------------
    TAdUnitTypecontentAdsSettings
    --------------------------------------------------------------------}
  
  TAdUnitTypecontentAdsSettings = Class(TGoogleBaseObject)
  Private
    FbackupOption : TAdUnitTypecontentAdsSettingsTypebackupOption;
    Fsize : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetbackupOption(AIndex : Integer; const AValue : TAdUnitTypecontentAdsSettingsTypebackupOption); virtual;
    Procedure Setsize(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property backupOption : TAdUnitTypecontentAdsSettingsTypebackupOption Index 0 Read FbackupOption Write SetbackupOption;
    Property size : String Index 8 Read Fsize Write Setsize;
    Property _type : String Index 16 Read F_type Write Set_type;
  end;
  TAdUnitTypecontentAdsSettingsClass = Class of TAdUnitTypecontentAdsSettings;
  
  { --------------------------------------------------------------------
    TAdUnitTypemobileContentAdsSettings
    --------------------------------------------------------------------}
  
  TAdUnitTypemobileContentAdsSettings = Class(TGoogleBaseObject)
  Private
    FmarkupLanguage : String;
    FscriptingLanguage : String;
    Fsize : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetmarkupLanguage(AIndex : Integer; const AValue : String); virtual;
    Procedure SetscriptingLanguage(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsize(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property markupLanguage : String Index 0 Read FmarkupLanguage Write SetmarkupLanguage;
    Property scriptingLanguage : String Index 8 Read FscriptingLanguage Write SetscriptingLanguage;
    Property size : String Index 16 Read Fsize Write Setsize;
    Property _type : String Index 24 Read F_type Write Set_type;
  end;
  TAdUnitTypemobileContentAdsSettingsClass = Class of TAdUnitTypemobileContentAdsSettings;
  
  { --------------------------------------------------------------------
    TAdUnit
    --------------------------------------------------------------------}
  
  TAdUnit = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    FcontentAdsSettings : TAdUnitTypecontentAdsSettings;
    FcustomStyle : TAdStyle;
    Fid : String;
    Fkind : String;
    FmobileContentAdsSettings : TAdUnitTypemobileContentAdsSettings;
    Fname : String;
    Fstatus : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcontentAdsSettings(AIndex : Integer; const AValue : TAdUnitTypecontentAdsSettings); virtual;
    Procedure SetcustomStyle(AIndex : Integer; const AValue : TAdStyle); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmobileContentAdsSettings(AIndex : Integer; const AValue : TAdUnitTypemobileContentAdsSettings); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property contentAdsSettings : TAdUnitTypecontentAdsSettings Index 8 Read FcontentAdsSettings Write SetcontentAdsSettings;
    Property customStyle : TAdStyle Index 16 Read FcustomStyle Write SetcustomStyle;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property mobileContentAdsSettings : TAdUnitTypemobileContentAdsSettings Index 40 Read FmobileContentAdsSettings Write SetmobileContentAdsSettings;
    Property name : String Index 48 Read Fname Write Setname;
    Property status : String Index 56 Read Fstatus Write Setstatus;
  end;
  TAdUnitClass = Class of TAdUnit;
  
  { --------------------------------------------------------------------
    TAdUnits
    --------------------------------------------------------------------}
  
  TAdUnits = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TAdUnitsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAdUnitsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TAdUnitsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
  end;
  TAdUnitsClass = Class of TAdUnits;
  
  { --------------------------------------------------------------------
    TAssociationSession
    --------------------------------------------------------------------}
  
  TAssociationSession = Class(TGoogleBaseObject)
  Private
    FaccountId : String;
    Fid : String;
    Fkind : String;
    FproductCodes : TStringArray;
    FredirectUrl : String;
    Fstatus : String;
    FuserLocale : String;
    FwebsiteLocale : String;
    FwebsiteUrl : String;
  Protected
    //Property setters
    Procedure SetaccountId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductCodes(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetredirectUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetuserLocale(AIndex : Integer; const AValue : String); virtual;
    Procedure SetwebsiteLocale(AIndex : Integer; const AValue : String); virtual;
    Procedure SetwebsiteUrl(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property accountId : String Index 0 Read FaccountId Write SetaccountId;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property productCodes : TStringArray Index 24 Read FproductCodes Write SetproductCodes;
    Property redirectUrl : String Index 32 Read FredirectUrl Write SetredirectUrl;
    Property status : String Index 40 Read Fstatus Write Setstatus;
    Property userLocale : String Index 48 Read FuserLocale Write SetuserLocale;
    Property websiteLocale : String Index 56 Read FwebsiteLocale Write SetwebsiteLocale;
    Property websiteUrl : String Index 64 Read FwebsiteUrl Write SetwebsiteUrl;
  end;
  TAssociationSessionClass = Class of TAssociationSession;
  
  { --------------------------------------------------------------------
    TCustomChannel
    --------------------------------------------------------------------}
  
  TCustomChannel = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fid : String;
    Fkind : String;
    Fname : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property name : String Index 24 Read Fname Write Setname;
  end;
  TCustomChannelClass = Class of TCustomChannel;
  
  { --------------------------------------------------------------------
    TCustomChannels
    --------------------------------------------------------------------}
  
  TCustomChannels = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TCustomChannelsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TCustomChannelsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TCustomChannelsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
  end;
  TCustomChannelsClass = Class of TCustomChannels;
  
  { --------------------------------------------------------------------
    TReportTypeheadersItem
    --------------------------------------------------------------------}
  
  TReportTypeheadersItem = Class(TGoogleBaseObject)
  Private
    Fcurrency : String;
    Fname : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setcurrency(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property currency : String Index 0 Read Fcurrency Write Setcurrency;
    Property name : String Index 8 Read Fname Write Setname;
    Property _type : String Index 16 Read F_type Write Set_type;
  end;
  TReportTypeheadersItemClass = Class of TReportTypeheadersItem;
  
  { --------------------------------------------------------------------
    TReport
    --------------------------------------------------------------------}
  
  TReport = Class(TGoogleBaseObject)
  Private
    Faverages : TStringArray;
    Fheaders : TReportTypeheadersArray;
    Fkind : String;
    Frows : TReportTyperowsArray;
    FtotalMatchedRows : String;
    Ftotals : TStringArray;
    Fwarnings : TStringArray;
  Protected
    //Property setters
    Procedure Setaverages(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setheaders(AIndex : Integer; const AValue : TReportTypeheadersArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setrows(AIndex : Integer; const AValue : TReportTyperowsArray); virtual;
    Procedure SettotalMatchedRows(AIndex : Integer; const AValue : String); virtual;
    Procedure Settotals(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setwarnings(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property averages : TStringArray Index 0 Read Faverages Write Setaverages;
    Property headers : TReportTypeheadersArray Index 8 Read Fheaders Write Setheaders;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property rows : TReportTyperowsArray Index 24 Read Frows Write Setrows;
    Property totalMatchedRows : String Index 32 Read FtotalMatchedRows Write SettotalMatchedRows;
    Property totals : TStringArray Index 40 Read Ftotals Write Settotals;
    Property warnings : TStringArray Index 48 Read Fwarnings Write Setwarnings;
  end;
  TReportClass = Class of TReport;
  
  { --------------------------------------------------------------------
    TUrlChannel
    --------------------------------------------------------------------}
  
  TUrlChannel = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    FurlPattern : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SeturlPattern(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property urlPattern : String Index 16 Read FurlPattern Write SeturlPattern;
  end;
  TUrlChannelClass = Class of TUrlChannel;
  
  { --------------------------------------------------------------------
    TUrlChannels
    --------------------------------------------------------------------}
  
  TUrlChannels = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TUrlChannelsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TUrlChannelsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TUrlChannelsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
  end;
  TUrlChannelsClass = Class of TUrlChannels;
  
  { --------------------------------------------------------------------
    TAccountsAdclientsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAccountsAdclientsResource, method List
  
  TAccountsAdclientsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TAccountsAdclientsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(accountId: string; adClientId: string) : TAdClient;
    Function List(accountId: string; AQuery : string  = '') : TAdClients;
    Function List(accountId: string; AQuery : TAccountsAdclientslistOptions) : TAdClients;
  end;
  
  
  { --------------------------------------------------------------------
    TAccountsAdunitsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAccountsAdunitsResource, method GetAdCode
  
  TAccountsAdunitsGetAdCodeOptions = Record
    hostCustomChannelId : String;
  end;
  
  
  //Optional query Options for TAccountsAdunitsResource, method List
  
  TAccountsAdunitsListOptions = Record
    includeInactive : boolean;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TAccountsAdunitsResource, method Patch
  
  TAccountsAdunitsPatchOptions = Record
    adUnitId : String;
  end;
  
  TAccountsAdunitsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(accountId: string; adClientId: string; adUnitId: string) : TAdUnit;
    Function Get(accountId: string; adClientId: string; adUnitId: string) : TAdUnit;
    Function GetAdCode(accountId: string; adClientId: string; adUnitId: string; AQuery : string  = '') : TAdCode;
    Function GetAdCode(accountId: string; adClientId: string; adUnitId: string; AQuery : TAccountsAdunitsgetAdCodeOptions) : TAdCode;
    Function Insert(accountId: string; adClientId: string; aAdUnit : TAdUnit) : TAdUnit;
    Function List(accountId: string; adClientId: string; AQuery : string  = '') : TAdUnits;
    Function List(accountId: string; adClientId: string; AQuery : TAccountsAdunitslistOptions) : TAdUnits;
    Function Patch(accountId: string; adClientId: string; aAdUnit : TAdUnit; AQuery : string  = '') : TAdUnit;
    Function Patch(accountId: string; adClientId: string; aAdUnit : TAdUnit; AQuery : TAccountsAdunitspatchOptions) : TAdUnit;
    Function Update(accountId: string; adClientId: string; aAdUnit : TAdUnit) : TAdUnit;
  end;
  
  
  { --------------------------------------------------------------------
    TAccountsReportsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAccountsReportsResource, method Generate
  
  TAccountsReportsGenerateOptions = Record
    dimension : String;
    endDate : String;
    filter : String;
    locale : String;
    maxResults : integer;
    metric : String;
    sort : String;
    startDate : String;
    startIndex : integer;
  end;
  
  TAccountsReportsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Generate(accountId: string; AQuery : string  = '') : TReport;
    Function Generate(accountId: string; AQuery : TAccountsReportsgenerateOptions) : TReport;
  end;
  
  
  { --------------------------------------------------------------------
    TAccountsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAccountsResource, method List
  
  TAccountsListOptions = Record
    filterAdClientId : String;
  end;
  
  TAccountsResource = Class(TGoogleResource)
  Private
    FAdclientsInstance : TAccountsAdclientsResource;
    FAdunitsInstance : TAccountsAdunitsResource;
    FReportsInstance : TAccountsReportsResource;
    Function GetAdclientsInstance : TAccountsAdclientsResource;virtual;
    Function GetAdunitsInstance : TAccountsAdunitsResource;virtual;
    Function GetReportsInstance : TAccountsReportsResource;virtual;
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(accountId: string) : TAccount;
    Function List(AQuery : string  = '') : TAccounts;
    Function List(AQuery : TAccountslistOptions) : TAccounts;
    Function CreateAdclientsResource(AOwner : TComponent) : TAccountsAdclientsResource;virtual;overload;
    Function CreateAdclientsResource : TAccountsAdclientsResource;virtual;overload;
    Function CreateAdunitsResource(AOwner : TComponent) : TAccountsAdunitsResource;virtual;overload;
    Function CreateAdunitsResource : TAccountsAdunitsResource;virtual;overload;
    Function CreateReportsResource(AOwner : TComponent) : TAccountsReportsResource;virtual;overload;
    Function CreateReportsResource : TAccountsReportsResource;virtual;overload;
    Property AdclientsResource : TAccountsAdclientsResource Read GetAdclientsInstance;
    Property AdunitsResource : TAccountsAdunitsResource Read GetAdunitsInstance;
    Property ReportsResource : TAccountsReportsResource Read GetReportsInstance;
  end;
  
  
  { --------------------------------------------------------------------
    TAdclientsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAdclientsResource, method List
  
  TAdclientsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TAdclientsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(adClientId: string) : TAdClient;
    Function List(AQuery : string  = '') : TAdClients;
    Function List(AQuery : TAdclientslistOptions) : TAdClients;
  end;
  
  
  { --------------------------------------------------------------------
    TAssociationsessionsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAssociationsessionsResource, method Start
  
  TAssociationsessionsStartOptions = Record
    productCode : String;
    userLocale : String;
    websiteLocale : String;
    websiteUrl : String;
  end;
  
  
  //Optional query Options for TAssociationsessionsResource, method Verify
  
  TAssociationsessionsVerifyOptions = Record
    token : String;
  end;
  
  TAssociationsessionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Start(AQuery : string  = '') : TAssociationSession;
    Function Start(AQuery : TAssociationsessionsstartOptions) : TAssociationSession;
    Function Verify(AQuery : string  = '') : TAssociationSession;
    Function Verify(AQuery : TAssociationsessionsverifyOptions) : TAssociationSession;
  end;
  
  
  { --------------------------------------------------------------------
    TCustomchannelsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TCustomchannelsResource, method List
  
  TCustomchannelsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TCustomchannelsResource, method Patch
  
  TCustomchannelsPatchOptions = Record
    customChannelId : String;
  end;
  
  TCustomchannelsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(adClientId: string; customChannelId: string) : TCustomChannel;
    Function Get(adClientId: string; customChannelId: string) : TCustomChannel;
    Function Insert(adClientId: string; aCustomChannel : TCustomChannel) : TCustomChannel;
    Function List(adClientId: string; AQuery : string  = '') : TCustomChannels;
    Function List(adClientId: string; AQuery : TCustomchannelslistOptions) : TCustomChannels;
    Function Patch(adClientId: string; aCustomChannel : TCustomChannel; AQuery : string  = '') : TCustomChannel;
    Function Patch(adClientId: string; aCustomChannel : TCustomChannel; AQuery : TCustomchannelspatchOptions) : TCustomChannel;
    Function Update(adClientId: string; aCustomChannel : TCustomChannel) : TCustomChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TReportsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TReportsResource, method Generate
  
  TReportsGenerateOptions = Record
    dimension : String;
    endDate : String;
    filter : String;
    locale : String;
    maxResults : integer;
    metric : String;
    sort : String;
    startDate : String;
    startIndex : integer;
  end;
  
  TReportsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Generate(AQuery : string  = '') : TReport;
    Function Generate(AQuery : TReportsgenerateOptions) : TReport;
  end;
  
  
  { --------------------------------------------------------------------
    TUrlchannelsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TUrlchannelsResource, method List
  
  TUrlchannelsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TUrlchannelsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(adClientId: string; urlChannelId: string) : TUrlChannel;
    Function Insert(adClientId: string; aUrlChannel : TUrlChannel) : TUrlChannel;
    Function List(adClientId: string; AQuery : string  = '') : TUrlChannels;
    Function List(adClientId: string; AQuery : TUrlchannelslistOptions) : TUrlChannels;
  end;
  
  
  { --------------------------------------------------------------------
    TAdsensehostAPI
    --------------------------------------------------------------------}
  
  TAdsensehostAPI = Class(TGoogleAPI)
  Private
    FAccountsAdclientsInstance : TAccountsAdclientsResource;
    FAccountsAdunitsInstance : TAccountsAdunitsResource;
    FAccountsReportsInstance : TAccountsReportsResource;
    FAccountsInstance : TAccountsResource;
    FAdclientsInstance : TAdclientsResource;
    FAssociationsessionsInstance : TAssociationsessionsResource;
    FCustomchannelsInstance : TCustomchannelsResource;
    FReportsInstance : TReportsResource;
    FUrlchannelsInstance : TUrlchannelsResource;
    Function GetAccountsAdclientsInstance : TAccountsAdclientsResource;virtual;
    Function GetAccountsAdunitsInstance : TAccountsAdunitsResource;virtual;
    Function GetAccountsReportsInstance : TAccountsReportsResource;virtual;
    Function GetAccountsInstance : TAccountsResource;virtual;
    Function GetAdclientsInstance : TAdclientsResource;virtual;
    Function GetAssociationsessionsInstance : TAssociationsessionsResource;virtual;
    Function GetCustomchannelsInstance : TCustomchannelsResource;virtual;
    Function GetReportsInstance : TReportsResource;virtual;
    Function GetUrlchannelsInstance : TUrlchannelsResource;virtual;
  Public
    //Override class functions with API info
    Class Function APIName : String; override;
    Class Function APIVersion : String; override;
    Class Function APIRevision : String; override;
    Class Function APIID : String; override;
    Class Function APITitle : String; override;
    Class Function APIDescription : String; override;
    Class Function APIOwnerDomain : String; override;
    Class Function APIOwnerName : String; override;
    Class Function APIIcon16 : String; override;
    Class Function APIIcon32 : String; override;
    Class Function APIdocumentationLink : String; override;
    Class Function APIrootUrl : string; override;
    Class Function APIbasePath : string;override;
    Class Function APIbaseURL : String;override;
    Class Function APIProtocol : string;override;
    Class Function APIservicePath : string;override;
    Class Function APIbatchPath : String;override;
    Class Function APIAuthScopes : TScopeInfoArray;override;
    Class Function APINeedsAuth : Boolean;override;
    Class Procedure RegisterAPIResources; override;
    //Add create function for resources
    Function CreateAccountsAdclientsResource(AOwner : TComponent) : TAccountsAdclientsResource;virtual;overload;
    Function CreateAccountsAdclientsResource : TAccountsAdclientsResource;virtual;overload;
    Function CreateAccountsAdunitsResource(AOwner : TComponent) : TAccountsAdunitsResource;virtual;overload;
    Function CreateAccountsAdunitsResource : TAccountsAdunitsResource;virtual;overload;
    Function CreateAccountsReportsResource(AOwner : TComponent) : TAccountsReportsResource;virtual;overload;
    Function CreateAccountsReportsResource : TAccountsReportsResource;virtual;overload;
    Function CreateAccountsResource(AOwner : TComponent) : TAccountsResource;virtual;overload;
    Function CreateAccountsResource : TAccountsResource;virtual;overload;
    Function CreateAdclientsResource(AOwner : TComponent) : TAdclientsResource;virtual;overload;
    Function CreateAdclientsResource : TAdclientsResource;virtual;overload;
    Function CreateAssociationsessionsResource(AOwner : TComponent) : TAssociationsessionsResource;virtual;overload;
    Function CreateAssociationsessionsResource : TAssociationsessionsResource;virtual;overload;
    Function CreateCustomchannelsResource(AOwner : TComponent) : TCustomchannelsResource;virtual;overload;
    Function CreateCustomchannelsResource : TCustomchannelsResource;virtual;overload;
    Function CreateReportsResource(AOwner : TComponent) : TReportsResource;virtual;overload;
    Function CreateReportsResource : TReportsResource;virtual;overload;
    Function CreateUrlchannelsResource(AOwner : TComponent) : TUrlchannelsResource;virtual;overload;
    Function CreateUrlchannelsResource : TUrlchannelsResource;virtual;overload;
    //Add default on-demand instances for resources
    Property AccountsAdclientsResource : TAccountsAdclientsResource Read GetAccountsAdclientsInstance;
    Property AccountsAdunitsResource : TAccountsAdunitsResource Read GetAccountsAdunitsInstance;
    Property AccountsReportsResource : TAccountsReportsResource Read GetAccountsReportsInstance;
    Property AccountsResource : TAccountsResource Read GetAccountsInstance;
    Property AdclientsResource : TAdclientsResource Read GetAdclientsInstance;
    Property AssociationsessionsResource : TAssociationsessionsResource Read GetAssociationsessionsInstance;
    Property CustomchannelsResource : TCustomchannelsResource Read GetCustomchannelsInstance;
    Property ReportsResource : TReportsResource Read GetReportsInstance;
    Property UrlchannelsResource : TUrlchannelsResource Read GetUrlchannelsInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAccount
  --------------------------------------------------------------------}


Procedure TAccount.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccount.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccount.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccount.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAccounts
  --------------------------------------------------------------------}


Procedure TAccounts.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccounts.Setitems(AIndex : Integer; const AValue : TAccountsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccounts.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAccounts.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAdClient
  --------------------------------------------------------------------}


Procedure TAdClient.SetarcOptIn(AIndex : Integer; const AValue : boolean); 

begin
  If (FarcOptIn=AValue) then exit;
  FarcOptIn:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClient.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClient.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClient.SetproductCode(AIndex : Integer; const AValue : String); 

begin
  If (FproductCode=AValue) then exit;
  FproductCode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClient.SetsupportsReporting(AIndex : Integer; const AValue : boolean); 

begin
  If (FsupportsReporting=AValue) then exit;
  FsupportsReporting:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdClients
  --------------------------------------------------------------------}


Procedure TAdClients.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClients.Setitems(AIndex : Integer; const AValue : TAdClientsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClients.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdClients.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAdClients.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAdCode
  --------------------------------------------------------------------}


Procedure TAdCode.SetadCode(AIndex : Integer; const AValue : String); 

begin
  If (FadCode=AValue) then exit;
  FadCode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdCode.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdStyleTypecolors
  --------------------------------------------------------------------}


Procedure TAdStyleTypecolors.Setbackground(AIndex : Integer; const AValue : String); 

begin
  If (Fbackground=AValue) then exit;
  Fbackground:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyleTypecolors.Setborder(AIndex : Integer; const AValue : String); 

begin
  If (Fborder=AValue) then exit;
  Fborder:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyleTypecolors.Settext(AIndex : Integer; const AValue : String); 

begin
  If (Ftext=AValue) then exit;
  Ftext:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyleTypecolors.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyleTypecolors.Seturl(AIndex : Integer; const AValue : String); 

begin
  If (Furl=AValue) then exit;
  Furl:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdStyleTypefont
  --------------------------------------------------------------------}


Procedure TAdStyleTypefont.Setfamily(AIndex : Integer; const AValue : String); 

begin
  If (Ffamily=AValue) then exit;
  Ffamily:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyleTypefont.Setsize(AIndex : Integer; const AValue : String); 

begin
  If (Fsize=AValue) then exit;
  Fsize:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdStyle
  --------------------------------------------------------------------}


Procedure TAdStyle.Setcolors(AIndex : Integer; const AValue : TAdStyleTypecolors); 

begin
  If (Fcolors=AValue) then exit;
  Fcolors:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyle.Setcorners(AIndex : Integer; const AValue : String); 

begin
  If (Fcorners=AValue) then exit;
  Fcorners:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyle.Setfont(AIndex : Integer; const AValue : TAdStyleTypefont); 

begin
  If (Ffont=AValue) then exit;
  Ffont:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdStyle.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdUnitTypecontentAdsSettingsTypebackupOption
  --------------------------------------------------------------------}


Procedure TAdUnitTypecontentAdsSettingsTypebackupOption.Setcolor(AIndex : Integer; const AValue : String); 

begin
  If (Fcolor=AValue) then exit;
  Fcolor:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypecontentAdsSettingsTypebackupOption.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypecontentAdsSettingsTypebackupOption.Seturl(AIndex : Integer; const AValue : String); 

begin
  If (Furl=AValue) then exit;
  Furl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAdUnitTypecontentAdsSettingsTypebackupOption.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAdUnitTypecontentAdsSettings
  --------------------------------------------------------------------}


Procedure TAdUnitTypecontentAdsSettings.SetbackupOption(AIndex : Integer; const AValue : TAdUnitTypecontentAdsSettingsTypebackupOption); 

begin
  If (FbackupOption=AValue) then exit;
  FbackupOption:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypecontentAdsSettings.Setsize(AIndex : Integer; const AValue : String); 

begin
  If (Fsize=AValue) then exit;
  Fsize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypecontentAdsSettings.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAdUnitTypecontentAdsSettings.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAdUnitTypemobileContentAdsSettings
  --------------------------------------------------------------------}


Procedure TAdUnitTypemobileContentAdsSettings.SetmarkupLanguage(AIndex : Integer; const AValue : String); 

begin
  If (FmarkupLanguage=AValue) then exit;
  FmarkupLanguage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypemobileContentAdsSettings.SetscriptingLanguage(AIndex : Integer; const AValue : String); 

begin
  If (FscriptingLanguage=AValue) then exit;
  FscriptingLanguage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypemobileContentAdsSettings.Setsize(AIndex : Integer; const AValue : String); 

begin
  If (Fsize=AValue) then exit;
  Fsize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnitTypemobileContentAdsSettings.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAdUnitTypemobileContentAdsSettings.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAdUnit
  --------------------------------------------------------------------}


Procedure TAdUnit.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.SetcontentAdsSettings(AIndex : Integer; const AValue : TAdUnitTypecontentAdsSettings); 

begin
  If (FcontentAdsSettings=AValue) then exit;
  FcontentAdsSettings:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.SetcustomStyle(AIndex : Integer; const AValue : TAdStyle); 

begin
  If (FcustomStyle=AValue) then exit;
  FcustomStyle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.SetmobileContentAdsSettings(AIndex : Integer; const AValue : TAdUnitTypemobileContentAdsSettings); 

begin
  If (FmobileContentAdsSettings=AValue) then exit;
  FmobileContentAdsSettings:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnit.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAdUnits
  --------------------------------------------------------------------}


Procedure TAdUnits.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnits.Setitems(AIndex : Integer; const AValue : TAdUnitsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnits.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdUnits.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAdUnits.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAssociationSession
  --------------------------------------------------------------------}


Procedure TAssociationSession.SetaccountId(AIndex : Integer; const AValue : String); 

begin
  If (FaccountId=AValue) then exit;
  FaccountId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.SetproductCodes(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FproductCodes=AValue) then exit;
  FproductCodes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.SetredirectUrl(AIndex : Integer; const AValue : String); 

begin
  If (FredirectUrl=AValue) then exit;
  FredirectUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.SetuserLocale(AIndex : Integer; const AValue : String); 

begin
  If (FuserLocale=AValue) then exit;
  FuserLocale:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.SetwebsiteLocale(AIndex : Integer; const AValue : String); 

begin
  If (FwebsiteLocale=AValue) then exit;
  FwebsiteLocale:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAssociationSession.SetwebsiteUrl(AIndex : Integer; const AValue : String); 

begin
  If (FwebsiteUrl=AValue) then exit;
  FwebsiteUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAssociationSession.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'productcodes' : SetLength(FproductCodes,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCustomChannel
  --------------------------------------------------------------------}


Procedure TCustomChannel.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannel.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannel.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannel.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TCustomChannels
  --------------------------------------------------------------------}


Procedure TCustomChannels.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannels.Setitems(AIndex : Integer; const AValue : TCustomChannelsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannels.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCustomChannels.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCustomChannels.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TReportTypeheadersItem
  --------------------------------------------------------------------}


Procedure TReportTypeheadersItem.Setcurrency(AIndex : Integer; const AValue : String); 

begin
  If (Fcurrency=AValue) then exit;
  Fcurrency:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReportTypeheadersItem.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReportTypeheadersItem.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TReportTypeheadersItem.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TReport
  --------------------------------------------------------------------}


Procedure TReport.Setaverages(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Faverages=AValue) then exit;
  Faverages:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.Setheaders(AIndex : Integer; const AValue : TReportTypeheadersArray); 

begin
  If (Fheaders=AValue) then exit;
  Fheaders:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.Setrows(AIndex : Integer; const AValue : TReportTyperowsArray); 

begin
  If (Frows=AValue) then exit;
  Frows:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.SettotalMatchedRows(AIndex : Integer; const AValue : String); 

begin
  If (FtotalMatchedRows=AValue) then exit;
  FtotalMatchedRows:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.Settotals(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Ftotals=AValue) then exit;
  Ftotals:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReport.Setwarnings(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fwarnings=AValue) then exit;
  Fwarnings:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TReport.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'averages' : SetLength(Faverages,ALength);
  'headers' : SetLength(Fheaders,ALength);
  'rows' : SetLength(Frows,ALength);
  'totals' : SetLength(Ftotals,ALength);
  'warnings' : SetLength(Fwarnings,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUrlChannel
  --------------------------------------------------------------------}


Procedure TUrlChannel.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlChannel.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlChannel.SeturlPattern(AIndex : Integer; const AValue : String); 

begin
  If (FurlPattern=AValue) then exit;
  FurlPattern:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUrlChannels
  --------------------------------------------------------------------}


Procedure TUrlChannels.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlChannels.Setitems(AIndex : Integer; const AValue : TUrlChannelsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlChannels.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlChannels.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUrlChannels.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAccountsAdclientsResource
  --------------------------------------------------------------------}


Class Function TAccountsAdclientsResource.ResourceName : String;

begin
  Result:='adclients';
end;

Class Function TAccountsAdclientsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAccountsAdclientsResource.Get(accountId: string; adClientId: string) : TAdClient;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}';
  _Methodid   = 'adsensehost.accounts.adclients.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAdClient) as TAdClient;
end;

Function TAccountsAdclientsResource.List(accountId: string; AQuery : string = '') : TAdClients;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/adclients';
  _Methodid   = 'adsensehost.accounts.adclients.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAdClients) as TAdClients;
end;


Function TAccountsAdclientsResource.List(accountId: string; AQuery : TAccountsAdclientslistOptions) : TAdClients;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(accountId,_Q);
end;



{ --------------------------------------------------------------------
  TAccountsAdunitsResource
  --------------------------------------------------------------------}


Class Function TAccountsAdunitsResource.ResourceName : String;

begin
  Result:='adunits';
end;

Class Function TAccountsAdunitsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAccountsAdunitsResource.Delete(accountId: string; adClientId: string; adUnitId: string) : TAdUnit;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits/{adUnitId}';
  _Methodid   = 'adsensehost.accounts.adunits.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId,'adUnitId',adUnitId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAdUnit) as TAdUnit;
end;

Function TAccountsAdunitsResource.Get(accountId: string; adClientId: string; adUnitId: string) : TAdUnit;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits/{adUnitId}';
  _Methodid   = 'adsensehost.accounts.adunits.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId,'adUnitId',adUnitId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAdUnit) as TAdUnit;
end;

Function TAccountsAdunitsResource.GetAdCode(accountId: string; adClientId: string; adUnitId: string; AQuery : string = '') : TAdCode;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits/{adUnitId}/adcode';
  _Methodid   = 'adsensehost.accounts.adunits.getAdCode';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId,'adUnitId',adUnitId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAdCode) as TAdCode;
end;


Function TAccountsAdunitsResource.GetAdCode(accountId: string; adClientId: string; adUnitId: string; AQuery : TAccountsAdunitsgetAdCodeOptions) : TAdCode;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'hostCustomChannelId',AQuery.hostCustomChannelId);
  Result:=GetAdCode(accountId,adClientId,adUnitId,_Q);
end;

Function TAccountsAdunitsResource.Insert(accountId: string; adClientId: string; aAdUnit : TAdUnit) : TAdUnit;

Const
  _HTTPMethod = 'POST';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits';
  _Methodid   = 'adsensehost.accounts.adunits.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAdUnit,TAdUnit) as TAdUnit;
end;

Function TAccountsAdunitsResource.List(accountId: string; adClientId: string; AQuery : string = '') : TAdUnits;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits';
  _Methodid   = 'adsensehost.accounts.adunits.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAdUnits) as TAdUnits;
end;


Function TAccountsAdunitsResource.List(accountId: string; adClientId: string; AQuery : TAccountsAdunitslistOptions) : TAdUnits;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'includeInactive',AQuery.includeInactive);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(accountId,adClientId,_Q);
end;

Function TAccountsAdunitsResource.Patch(accountId: string; adClientId: string; aAdUnit : TAdUnit; AQuery : string = '') : TAdUnit;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits';
  _Methodid   = 'adsensehost.accounts.adunits.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aAdUnit,TAdUnit) as TAdUnit;
end;


Function TAccountsAdunitsResource.Patch(accountId: string; adClientId: string; aAdUnit : TAdUnit; AQuery : TAccountsAdunitspatchOptions) : TAdUnit;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'adUnitId',AQuery.adUnitId);
  Result:=Patch(accountId,adClientId,aAdUnit,_Q);
end;

Function TAccountsAdunitsResource.Update(accountId: string; adClientId: string; aAdUnit : TAdUnit) : TAdUnit;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'accounts/{accountId}/adclients/{adClientId}/adunits';
  _Methodid   = 'adsensehost.accounts.adunits.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId,'adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAdUnit,TAdUnit) as TAdUnit;
end;



{ --------------------------------------------------------------------
  TAccountsReportsResource
  --------------------------------------------------------------------}


Class Function TAccountsReportsResource.ResourceName : String;

begin
  Result:='reports';
end;

Class Function TAccountsReportsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAccountsReportsResource.Generate(accountId: string; AQuery : string = '') : TReport;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}/reports';
  _Methodid   = 'adsensehost.accounts.reports.generate';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TReport) as TReport;
end;


Function TAccountsReportsResource.Generate(accountId: string; AQuery : TAccountsReportsgenerateOptions) : TReport;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'dimension',AQuery.dimension);
  AddToQuery(_Q,'endDate',AQuery.endDate);
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'locale',AQuery.locale);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'metric',AQuery.metric);
  AddToQuery(_Q,'sort',AQuery.sort);
  AddToQuery(_Q,'startDate',AQuery.startDate);
  AddToQuery(_Q,'startIndex',AQuery.startIndex);
  Result:=Generate(accountId,_Q);
end;



{ --------------------------------------------------------------------
  TAccountsResource
  --------------------------------------------------------------------}


Class Function TAccountsResource.ResourceName : String;

begin
  Result:='accounts';
end;

Class Function TAccountsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAccountsResource.Get(accountId: string) : TAccount;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts/{accountId}';
  _Methodid   = 'adsensehost.accounts.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['accountId',accountId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAccount) as TAccount;
end;

Function TAccountsResource.List(AQuery : string = '') : TAccounts;

Const
  _HTTPMethod = 'GET';
  _Path       = 'accounts';
  _Methodid   = 'adsensehost.accounts.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TAccounts) as TAccounts;
end;


Function TAccountsResource.List(AQuery : TAccountslistOptions) : TAccounts;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filterAdClientId',AQuery.filterAdClientId);
  Result:=List(_Q);
end;



Function TAccountsResource.GetAdclientsInstance : TAccountsAdclientsResource;

begin
  if (FAdclientsInstance=Nil) then
    FAdclientsInstance:=CreateAdclientsResource;
  Result:=FAdclientsInstance;
end;

Function TAccountsResource.CreateAdclientsResource : TAccountsAdclientsResource;

begin
  Result:=CreateAdclientsResource(Self);
end;


Function TAccountsResource.CreateAdclientsResource(AOwner : TComponent) : TAccountsAdclientsResource;

begin
  Result:=TAccountsAdclientsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAccountsResource.GetAdunitsInstance : TAccountsAdunitsResource;

begin
  if (FAdunitsInstance=Nil) then
    FAdunitsInstance:=CreateAdunitsResource;
  Result:=FAdunitsInstance;
end;

Function TAccountsResource.CreateAdunitsResource : TAccountsAdunitsResource;

begin
  Result:=CreateAdunitsResource(Self);
end;


Function TAccountsResource.CreateAdunitsResource(AOwner : TComponent) : TAccountsAdunitsResource;

begin
  Result:=TAccountsAdunitsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAccountsResource.GetReportsInstance : TAccountsReportsResource;

begin
  if (FReportsInstance=Nil) then
    FReportsInstance:=CreateReportsResource;
  Result:=FReportsInstance;
end;

Function TAccountsResource.CreateReportsResource : TAccountsReportsResource;

begin
  Result:=CreateReportsResource(Self);
end;


Function TAccountsResource.CreateReportsResource(AOwner : TComponent) : TAccountsReportsResource;

begin
  Result:=TAccountsReportsResource.Create(AOwner);
  Result.API:=Self.API;
end;



{ --------------------------------------------------------------------
  TAdclientsResource
  --------------------------------------------------------------------}


Class Function TAdclientsResource.ResourceName : String;

begin
  Result:='adclients';
end;

Class Function TAdclientsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAdclientsResource.Get(adClientId: string) : TAdClient;

Const
  _HTTPMethod = 'GET';
  _Path       = 'adclients/{adClientId}';
  _Methodid   = 'adsensehost.adclients.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAdClient) as TAdClient;
end;

Function TAdclientsResource.List(AQuery : string = '') : TAdClients;

Const
  _HTTPMethod = 'GET';
  _Path       = 'adclients';
  _Methodid   = 'adsensehost.adclients.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TAdClients) as TAdClients;
end;


Function TAdclientsResource.List(AQuery : TAdclientslistOptions) : TAdClients;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(_Q);
end;



{ --------------------------------------------------------------------
  TAssociationsessionsResource
  --------------------------------------------------------------------}


Class Function TAssociationsessionsResource.ResourceName : String;

begin
  Result:='associationsessions';
end;

Class Function TAssociationsessionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TAssociationsessionsResource.Start(AQuery : string = '') : TAssociationSession;

Const
  _HTTPMethod = 'GET';
  _Path       = 'associationsessions/start';
  _Methodid   = 'adsensehost.associationsessions.start';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TAssociationSession) as TAssociationSession;
end;


Function TAssociationsessionsResource.Start(AQuery : TAssociationsessionsstartOptions) : TAssociationSession;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'productCode',AQuery.productCode);
  AddToQuery(_Q,'userLocale',AQuery.userLocale);
  AddToQuery(_Q,'websiteLocale',AQuery.websiteLocale);
  AddToQuery(_Q,'websiteUrl',AQuery.websiteUrl);
  Result:=Start(_Q);
end;

Function TAssociationsessionsResource.Verify(AQuery : string = '') : TAssociationSession;

Const
  _HTTPMethod = 'GET';
  _Path       = 'associationsessions/verify';
  _Methodid   = 'adsensehost.associationsessions.verify';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TAssociationSession) as TAssociationSession;
end;


Function TAssociationsessionsResource.Verify(AQuery : TAssociationsessionsverifyOptions) : TAssociationSession;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'token',AQuery.token);
  Result:=Verify(_Q);
end;



{ --------------------------------------------------------------------
  TCustomchannelsResource
  --------------------------------------------------------------------}


Class Function TCustomchannelsResource.ResourceName : String;

begin
  Result:='customchannels';
end;

Class Function TCustomchannelsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TCustomchannelsResource.Delete(adClientId: string; customChannelId: string) : TCustomChannel;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'adclients/{adClientId}/customchannels/{customChannelId}';
  _Methodid   = 'adsensehost.customchannels.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId,'customChannelId',customChannelId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCustomChannel) as TCustomChannel;
end;

Function TCustomchannelsResource.Get(adClientId: string; customChannelId: string) : TCustomChannel;

Const
  _HTTPMethod = 'GET';
  _Path       = 'adclients/{adClientId}/customchannels/{customChannelId}';
  _Methodid   = 'adsensehost.customchannels.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId,'customChannelId',customChannelId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCustomChannel) as TCustomChannel;
end;

Function TCustomchannelsResource.Insert(adClientId: string; aCustomChannel : TCustomChannel) : TCustomChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'adclients/{adClientId}/customchannels';
  _Methodid   = 'adsensehost.customchannels.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCustomChannel,TCustomChannel) as TCustomChannel;
end;

Function TCustomchannelsResource.List(adClientId: string; AQuery : string = '') : TCustomChannels;

Const
  _HTTPMethod = 'GET';
  _Path       = 'adclients/{adClientId}/customchannels';
  _Methodid   = 'adsensehost.customchannels.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TCustomChannels) as TCustomChannels;
end;


Function TCustomchannelsResource.List(adClientId: string; AQuery : TCustomchannelslistOptions) : TCustomChannels;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(adClientId,_Q);
end;

Function TCustomchannelsResource.Patch(adClientId: string; aCustomChannel : TCustomChannel; AQuery : string = '') : TCustomChannel;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'adclients/{adClientId}/customchannels';
  _Methodid   = 'adsensehost.customchannels.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aCustomChannel,TCustomChannel) as TCustomChannel;
end;


Function TCustomchannelsResource.Patch(adClientId: string; aCustomChannel : TCustomChannel; AQuery : TCustomchannelspatchOptions) : TCustomChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'customChannelId',AQuery.customChannelId);
  Result:=Patch(adClientId,aCustomChannel,_Q);
end;

Function TCustomchannelsResource.Update(adClientId: string; aCustomChannel : TCustomChannel) : TCustomChannel;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'adclients/{adClientId}/customchannels';
  _Methodid   = 'adsensehost.customchannels.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCustomChannel,TCustomChannel) as TCustomChannel;
end;



{ --------------------------------------------------------------------
  TReportsResource
  --------------------------------------------------------------------}


Class Function TReportsResource.ResourceName : String;

begin
  Result:='reports';
end;

Class Function TReportsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TReportsResource.Generate(AQuery : string = '') : TReport;

Const
  _HTTPMethod = 'GET';
  _Path       = 'reports';
  _Methodid   = 'adsensehost.reports.generate';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TReport) as TReport;
end;


Function TReportsResource.Generate(AQuery : TReportsgenerateOptions) : TReport;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'dimension',AQuery.dimension);
  AddToQuery(_Q,'endDate',AQuery.endDate);
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'locale',AQuery.locale);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'metric',AQuery.metric);
  AddToQuery(_Q,'sort',AQuery.sort);
  AddToQuery(_Q,'startDate',AQuery.startDate);
  AddToQuery(_Q,'startIndex',AQuery.startIndex);
  Result:=Generate(_Q);
end;



{ --------------------------------------------------------------------
  TUrlchannelsResource
  --------------------------------------------------------------------}


Class Function TUrlchannelsResource.ResourceName : String;

begin
  Result:='urlchannels';
end;

Class Function TUrlchannelsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadsensehostAPI;
end;

Function TUrlchannelsResource.Delete(adClientId: string; urlChannelId: string) : TUrlChannel;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'adclients/{adClientId}/urlchannels/{urlChannelId}';
  _Methodid   = 'adsensehost.urlchannels.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId,'urlChannelId',urlChannelId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUrlChannel) as TUrlChannel;
end;

Function TUrlchannelsResource.Insert(adClientId: string; aUrlChannel : TUrlChannel) : TUrlChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'adclients/{adClientId}/urlchannels';
  _Methodid   = 'adsensehost.urlchannels.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlChannel,TUrlChannel) as TUrlChannel;
end;

Function TUrlchannelsResource.List(adClientId: string; AQuery : string = '') : TUrlChannels;

Const
  _HTTPMethod = 'GET';
  _Path       = 'adclients/{adClientId}/urlchannels';
  _Methodid   = 'adsensehost.urlchannels.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['adClientId',adClientId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TUrlChannels) as TUrlChannels;
end;


Function TUrlchannelsResource.List(adClientId: string; AQuery : TUrlchannelslistOptions) : TUrlChannels;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(adClientId,_Q);
end;



{ --------------------------------------------------------------------
  TAdsensehostAPI
  --------------------------------------------------------------------}

Class Function TAdsensehostAPI.APIName : String;

begin
  Result:='adsensehost';
end;

Class Function TAdsensehostAPI.APIVersion : String;

begin
  Result:='v4.1';
end;

Class Function TAdsensehostAPI.APIRevision : String;

begin
  Result:='20160522';
end;

Class Function TAdsensehostAPI.APIID : String;

begin
  Result:='adsensehost:v4.1';
end;

Class Function TAdsensehostAPI.APITitle : String;

begin
  Result:='AdSense Host API';
end;

Class Function TAdsensehostAPI.APIDescription : String;

begin
  Result:='Generates performance reports, generates ad codes, and provides publisher management capabilities for AdSense Hosts.';
end;

Class Function TAdsensehostAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TAdsensehostAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TAdsensehostAPI.APIIcon16 : String;

begin
  Result:='https://www.google.com/images/icons/product/adsense-16.png';
end;

Class Function TAdsensehostAPI.APIIcon32 : String;

begin
  Result:='https://www.google.com/images/icons/product/adsense-32.png';
end;

Class Function TAdsensehostAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/adsense/host/';
end;

Class Function TAdsensehostAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TAdsensehostAPI.APIbasePath : string;

begin
  Result:='/adsensehost/v4.1/';
end;

Class Function TAdsensehostAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/adsensehost/v4.1/';
end;

Class Function TAdsensehostAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TAdsensehostAPI.APIservicePath : string;

begin
  Result:='adsensehost/v4.1/';
end;

Class Function TAdsensehostAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TAdsensehostAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,1);
  Result[0].Name:='https://www.googleapis.com/auth/adsensehost';
  Result[0].Description:='View and manage your AdSense host data and associated accounts';
  
end;

Class Function TAdsensehostAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TAdsensehostAPI.RegisterAPIResources;

begin
  TAccount.RegisterObject;
  TAccounts.RegisterObject;
  TAdClient.RegisterObject;
  TAdClients.RegisterObject;
  TAdCode.RegisterObject;
  TAdStyleTypecolors.RegisterObject;
  TAdStyleTypefont.RegisterObject;
  TAdStyle.RegisterObject;
  TAdUnitTypecontentAdsSettingsTypebackupOption.RegisterObject;
  TAdUnitTypecontentAdsSettings.RegisterObject;
  TAdUnitTypemobileContentAdsSettings.RegisterObject;
  TAdUnit.RegisterObject;
  TAdUnits.RegisterObject;
  TAssociationSession.RegisterObject;
  TCustomChannel.RegisterObject;
  TCustomChannels.RegisterObject;
  TReportTypeheadersItem.RegisterObject;
  TReport.RegisterObject;
  TUrlChannel.RegisterObject;
  TUrlChannels.RegisterObject;
end;


Function TAdsensehostAPI.GetAccountsAdclientsInstance : TAccountsAdclientsResource;

begin
  if (FAccountsAdclientsInstance=Nil) then
    FAccountsAdclientsInstance:=CreateAccountsAdclientsResource;
  Result:=FAccountsAdclientsInstance;
end;

Function TAdsensehostAPI.CreateAccountsAdclientsResource : TAccountsAdclientsResource;

begin
  Result:=CreateAccountsAdclientsResource(Self);
end;


Function TAdsensehostAPI.CreateAccountsAdclientsResource(AOwner : TComponent) : TAccountsAdclientsResource;

begin
  Result:=TAccountsAdclientsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetAccountsAdunitsInstance : TAccountsAdunitsResource;

begin
  if (FAccountsAdunitsInstance=Nil) then
    FAccountsAdunitsInstance:=CreateAccountsAdunitsResource;
  Result:=FAccountsAdunitsInstance;
end;

Function TAdsensehostAPI.CreateAccountsAdunitsResource : TAccountsAdunitsResource;

begin
  Result:=CreateAccountsAdunitsResource(Self);
end;


Function TAdsensehostAPI.CreateAccountsAdunitsResource(AOwner : TComponent) : TAccountsAdunitsResource;

begin
  Result:=TAccountsAdunitsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetAccountsReportsInstance : TAccountsReportsResource;

begin
  if (FAccountsReportsInstance=Nil) then
    FAccountsReportsInstance:=CreateAccountsReportsResource;
  Result:=FAccountsReportsInstance;
end;

Function TAdsensehostAPI.CreateAccountsReportsResource : TAccountsReportsResource;

begin
  Result:=CreateAccountsReportsResource(Self);
end;


Function TAdsensehostAPI.CreateAccountsReportsResource(AOwner : TComponent) : TAccountsReportsResource;

begin
  Result:=TAccountsReportsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetAccountsInstance : TAccountsResource;

begin
  if (FAccountsInstance=Nil) then
    FAccountsInstance:=CreateAccountsResource;
  Result:=FAccountsInstance;
end;

Function TAdsensehostAPI.CreateAccountsResource : TAccountsResource;

begin
  Result:=CreateAccountsResource(Self);
end;


Function TAdsensehostAPI.CreateAccountsResource(AOwner : TComponent) : TAccountsResource;

begin
  Result:=TAccountsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetAdclientsInstance : TAdclientsResource;

begin
  if (FAdclientsInstance=Nil) then
    FAdclientsInstance:=CreateAdclientsResource;
  Result:=FAdclientsInstance;
end;

Function TAdsensehostAPI.CreateAdclientsResource : TAdclientsResource;

begin
  Result:=CreateAdclientsResource(Self);
end;


Function TAdsensehostAPI.CreateAdclientsResource(AOwner : TComponent) : TAdclientsResource;

begin
  Result:=TAdclientsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetAssociationsessionsInstance : TAssociationsessionsResource;

begin
  if (FAssociationsessionsInstance=Nil) then
    FAssociationsessionsInstance:=CreateAssociationsessionsResource;
  Result:=FAssociationsessionsInstance;
end;

Function TAdsensehostAPI.CreateAssociationsessionsResource : TAssociationsessionsResource;

begin
  Result:=CreateAssociationsessionsResource(Self);
end;


Function TAdsensehostAPI.CreateAssociationsessionsResource(AOwner : TComponent) : TAssociationsessionsResource;

begin
  Result:=TAssociationsessionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetCustomchannelsInstance : TCustomchannelsResource;

begin
  if (FCustomchannelsInstance=Nil) then
    FCustomchannelsInstance:=CreateCustomchannelsResource;
  Result:=FCustomchannelsInstance;
end;

Function TAdsensehostAPI.CreateCustomchannelsResource : TCustomchannelsResource;

begin
  Result:=CreateCustomchannelsResource(Self);
end;


Function TAdsensehostAPI.CreateCustomchannelsResource(AOwner : TComponent) : TCustomchannelsResource;

begin
  Result:=TCustomchannelsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetReportsInstance : TReportsResource;

begin
  if (FReportsInstance=Nil) then
    FReportsInstance:=CreateReportsResource;
  Result:=FReportsInstance;
end;

Function TAdsensehostAPI.CreateReportsResource : TReportsResource;

begin
  Result:=CreateReportsResource(Self);
end;


Function TAdsensehostAPI.CreateReportsResource(AOwner : TComponent) : TReportsResource;

begin
  Result:=TReportsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdsensehostAPI.GetUrlchannelsInstance : TUrlchannelsResource;

begin
  if (FUrlchannelsInstance=Nil) then
    FUrlchannelsInstance:=CreateUrlchannelsResource;
  Result:=FUrlchannelsInstance;
end;

Function TAdsensehostAPI.CreateUrlchannelsResource : TUrlchannelsResource;

begin
  Result:=CreateUrlchannelsResource(Self);
end;


Function TAdsensehostAPI.CreateUrlchannelsResource(AOwner : TComponent) : TUrlchannelsResource;

begin
  Result:=TUrlchannelsResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TAdsensehostAPI.RegisterAPI;
end.
