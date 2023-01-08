unit googlegamesConfiguration;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAchievementConfiguration = Class;
  TAchievementConfigurationDetail = Class;
  TAchievementConfigurationListResponse = Class;
  TGamesNumberAffixConfiguration = Class;
  TGamesNumberFormatConfiguration = Class;
  TImageConfiguration = Class;
  TLeaderboardConfiguration = Class;
  TLeaderboardConfigurationDetail = Class;
  TLeaderboardConfigurationListResponse = Class;
  TLocalizedString = Class;
  TLocalizedStringBundle = Class;
  TAchievementConfigurationArray = Array of TAchievementConfiguration;
  TAchievementConfigurationDetailArray = Array of TAchievementConfigurationDetail;
  TAchievementConfigurationListResponseArray = Array of TAchievementConfigurationListResponse;
  TGamesNumberAffixConfigurationArray = Array of TGamesNumberAffixConfiguration;
  TGamesNumberFormatConfigurationArray = Array of TGamesNumberFormatConfiguration;
  TImageConfigurationArray = Array of TImageConfiguration;
  TLeaderboardConfigurationArray = Array of TLeaderboardConfiguration;
  TLeaderboardConfigurationDetailArray = Array of TLeaderboardConfigurationDetail;
  TLeaderboardConfigurationListResponseArray = Array of TLeaderboardConfigurationListResponse;
  TLocalizedStringArray = Array of TLocalizedString;
  TLocalizedStringBundleArray = Array of TLocalizedStringBundle;
  //Anonymous types, using auto-generated names
  TAchievementConfigurationListResponseTypeitemsArray = Array of TAchievementConfiguration;
  TLeaderboardConfigurationListResponseTypeitemsArray = Array of TLeaderboardConfiguration;
  TLocalizedStringBundleTypetranslationsArray = Array of TLocalizedString;
  
  { --------------------------------------------------------------------
    TAchievementConfiguration
    --------------------------------------------------------------------}
  
  TAchievementConfiguration = Class(TGoogleBaseObject)
  Private
    FachievementType : String;
    Fdraft : TAchievementConfigurationDetail;
    Fid : String;
    FinitialState : String;
    Fkind : String;
    F_published : TAchievementConfigurationDetail;
    FstepsToUnlock : integer;
    Ftoken : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetachievementType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdraft(AIndex : Integer; const AValue : TAchievementConfigurationDetail); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinitialState(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_published(AIndex : Integer; const AValue : TAchievementConfigurationDetail); virtual;
    Procedure SetstepsToUnlock(AIndex : Integer; const AValue : integer); virtual;
    Procedure Settoken(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property achievementType : String Index 0 Read FachievementType Write SetachievementType;
    Property draft : TAchievementConfigurationDetail Index 8 Read Fdraft Write Setdraft;
    Property id : String Index 16 Read Fid Write Setid;
    Property initialState : String Index 24 Read FinitialState Write SetinitialState;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property _published : TAchievementConfigurationDetail Index 40 Read F_published Write Set_published;
    Property stepsToUnlock : integer Index 48 Read FstepsToUnlock Write SetstepsToUnlock;
    Property token : String Index 56 Read Ftoken Write Settoken;
  end;
  TAchievementConfigurationClass = Class of TAchievementConfiguration;
  
  { --------------------------------------------------------------------
    TAchievementConfigurationDetail
    --------------------------------------------------------------------}
  
  TAchievementConfigurationDetail = Class(TGoogleBaseObject)
  Private
    Fdescription : TLocalizedStringBundle;
    FiconUrl : String;
    Fkind : String;
    Fname : TLocalizedStringBundle;
    FpointValue : integer;
    FsortRank : integer;
  Protected
    //Property setters
    Procedure Setdescription(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure SeticonUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure SetpointValue(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetsortRank(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property description : TLocalizedStringBundle Index 0 Read Fdescription Write Setdescription;
    Property iconUrl : String Index 8 Read FiconUrl Write SeticonUrl;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property name : TLocalizedStringBundle Index 24 Read Fname Write Setname;
    Property pointValue : integer Index 32 Read FpointValue Write SetpointValue;
    Property sortRank : integer Index 40 Read FsortRank Write SetsortRank;
  end;
  TAchievementConfigurationDetailClass = Class of TAchievementConfigurationDetail;
  
  { --------------------------------------------------------------------
    TAchievementConfigurationListResponse
    --------------------------------------------------------------------}
  
  TAchievementConfigurationListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TAchievementConfigurationListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TAchievementConfigurationListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TAchievementConfigurationListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TAchievementConfigurationListResponseClass = Class of TAchievementConfigurationListResponse;
  
  { --------------------------------------------------------------------
    TGamesNumberAffixConfiguration
    --------------------------------------------------------------------}
  
  TGamesNumberAffixConfiguration = Class(TGoogleBaseObject)
  Private
    Ffew : TLocalizedStringBundle;
    Fmany : TLocalizedStringBundle;
    Fone : TLocalizedStringBundle;
    Fother : TLocalizedStringBundle;
    Ftwo : TLocalizedStringBundle;
    Fzero : TLocalizedStringBundle;
  Protected
    //Property setters
    Procedure Setfew(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure Setmany(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure Setone(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure Setother(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure Settwo(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure Setzero(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
  Public
  Published
    Property few : TLocalizedStringBundle Index 0 Read Ffew Write Setfew;
    Property many : TLocalizedStringBundle Index 8 Read Fmany Write Setmany;
    Property one : TLocalizedStringBundle Index 16 Read Fone Write Setone;
    Property other : TLocalizedStringBundle Index 24 Read Fother Write Setother;
    Property two : TLocalizedStringBundle Index 32 Read Ftwo Write Settwo;
    Property zero : TLocalizedStringBundle Index 40 Read Fzero Write Setzero;
  end;
  TGamesNumberAffixConfigurationClass = Class of TGamesNumberAffixConfiguration;
  
  { --------------------------------------------------------------------
    TGamesNumberFormatConfiguration
    --------------------------------------------------------------------}
  
  TGamesNumberFormatConfiguration = Class(TGoogleBaseObject)
  Private
    FcurrencyCode : String;
    FnumDecimalPlaces : integer;
    FnumberFormatType : String;
    Fsuffix : TGamesNumberAffixConfiguration;
  Protected
    //Property setters
    Procedure SetcurrencyCode(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnumDecimalPlaces(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetnumberFormatType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsuffix(AIndex : Integer; const AValue : TGamesNumberAffixConfiguration); virtual;
  Public
  Published
    Property currencyCode : String Index 0 Read FcurrencyCode Write SetcurrencyCode;
    Property numDecimalPlaces : integer Index 8 Read FnumDecimalPlaces Write SetnumDecimalPlaces;
    Property numberFormatType : String Index 16 Read FnumberFormatType Write SetnumberFormatType;
    Property suffix : TGamesNumberAffixConfiguration Index 24 Read Fsuffix Write Setsuffix;
  end;
  TGamesNumberFormatConfigurationClass = Class of TGamesNumberFormatConfiguration;
  
  { --------------------------------------------------------------------
    TImageConfiguration
    --------------------------------------------------------------------}
  
  TImageConfiguration = Class(TGoogleBaseObject)
  Private
    FimageType : String;
    Fkind : String;
    FresourceId : String;
    Furl : String;
  Protected
    //Property setters
    Procedure SetimageType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetresourceId(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturl(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property imageType : String Index 0 Read FimageType Write SetimageType;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property resourceId : String Index 16 Read FresourceId Write SetresourceId;
    Property url : String Index 24 Read Furl Write Seturl;
  end;
  TImageConfigurationClass = Class of TImageConfiguration;
  
  { --------------------------------------------------------------------
    TLeaderboardConfiguration
    --------------------------------------------------------------------}
  
  TLeaderboardConfiguration = Class(TGoogleBaseObject)
  Private
    Fdraft : TLeaderboardConfigurationDetail;
    Fid : String;
    Fkind : String;
    F_published : TLeaderboardConfigurationDetail;
    FscoreMax : String;
    FscoreMin : String;
    FscoreOrder : String;
    Ftoken : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setdraft(AIndex : Integer; const AValue : TLeaderboardConfigurationDetail); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_published(AIndex : Integer; const AValue : TLeaderboardConfigurationDetail); virtual;
    Procedure SetscoreMax(AIndex : Integer; const AValue : String); virtual;
    Procedure SetscoreMin(AIndex : Integer; const AValue : String); virtual;
    Procedure SetscoreOrder(AIndex : Integer; const AValue : String); virtual;
    Procedure Settoken(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property draft : TLeaderboardConfigurationDetail Index 0 Read Fdraft Write Setdraft;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property _published : TLeaderboardConfigurationDetail Index 24 Read F_published Write Set_published;
    Property scoreMax : String Index 32 Read FscoreMax Write SetscoreMax;
    Property scoreMin : String Index 40 Read FscoreMin Write SetscoreMin;
    Property scoreOrder : String Index 48 Read FscoreOrder Write SetscoreOrder;
    Property token : String Index 56 Read Ftoken Write Settoken;
  end;
  TLeaderboardConfigurationClass = Class of TLeaderboardConfiguration;
  
  { --------------------------------------------------------------------
    TLeaderboardConfigurationDetail
    --------------------------------------------------------------------}
  
  TLeaderboardConfigurationDetail = Class(TGoogleBaseObject)
  Private
    FiconUrl : String;
    Fkind : String;
    Fname : TLocalizedStringBundle;
    FscoreFormat : TGamesNumberFormatConfiguration;
    FsortRank : integer;
  Protected
    //Property setters
    Procedure SeticonUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : TLocalizedStringBundle); virtual;
    Procedure SetscoreFormat(AIndex : Integer; const AValue : TGamesNumberFormatConfiguration); virtual;
    Procedure SetsortRank(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property iconUrl : String Index 0 Read FiconUrl Write SeticonUrl;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : TLocalizedStringBundle Index 16 Read Fname Write Setname;
    Property scoreFormat : TGamesNumberFormatConfiguration Index 24 Read FscoreFormat Write SetscoreFormat;
    Property sortRank : integer Index 32 Read FsortRank Write SetsortRank;
  end;
  TLeaderboardConfigurationDetailClass = Class of TLeaderboardConfigurationDetail;
  
  { --------------------------------------------------------------------
    TLeaderboardConfigurationListResponse
    --------------------------------------------------------------------}
  
  TLeaderboardConfigurationListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TLeaderboardConfigurationListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TLeaderboardConfigurationListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TLeaderboardConfigurationListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TLeaderboardConfigurationListResponseClass = Class of TLeaderboardConfigurationListResponse;
  
  { --------------------------------------------------------------------
    TLocalizedString
    --------------------------------------------------------------------}
  
  TLocalizedString = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Flocale : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocale(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property locale : String Index 8 Read Flocale Write Setlocale;
    Property value : String Index 16 Read Fvalue Write Setvalue;
  end;
  TLocalizedStringClass = Class of TLocalizedString;
  
  { --------------------------------------------------------------------
    TLocalizedStringBundle
    --------------------------------------------------------------------}
  
  TLocalizedStringBundle = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Ftranslations : TLocalizedStringBundleTypetranslationsArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Settranslations(AIndex : Integer; const AValue : TLocalizedStringBundleTypetranslationsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property translations : TLocalizedStringBundleTypetranslationsArray Index 8 Read Ftranslations Write Settranslations;
  end;
  TLocalizedStringBundleClass = Class of TLocalizedStringBundle;
  
  { --------------------------------------------------------------------
    TAchievementConfigurationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAchievementConfigurationsResource, method List
  
  TAchievementConfigurationsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TAchievementConfigurationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(achievementId: string);
    Function Get(achievementId: string) : TAchievementConfiguration;
    Function Insert(applicationId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;
    Function List(applicationId: string; AQuery : string  = '') : TAchievementConfigurationListResponse;
    Function List(applicationId: string; AQuery : TAchievementConfigurationslistOptions) : TAchievementConfigurationListResponse;
    Function Patch(achievementId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;
    Function Update(achievementId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;
  end;
  
  
  { --------------------------------------------------------------------
    TImageConfigurationsResource
    --------------------------------------------------------------------}
  
  TImageConfigurationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Upload(imageType: string; resourceId: string) : TImageConfiguration;
  end;
  
  
  { --------------------------------------------------------------------
    TLeaderboardConfigurationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TLeaderboardConfigurationsResource, method List
  
  TLeaderboardConfigurationsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TLeaderboardConfigurationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(leaderboardId: string);
    Function Get(leaderboardId: string) : TLeaderboardConfiguration;
    Function Insert(applicationId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;
    Function List(applicationId: string; AQuery : string  = '') : TLeaderboardConfigurationListResponse;
    Function List(applicationId: string; AQuery : TLeaderboardConfigurationslistOptions) : TLeaderboardConfigurationListResponse;
    Function Patch(leaderboardId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;
    Function Update(leaderboardId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;
  end;
  
  
  { --------------------------------------------------------------------
    TGamesConfigurationAPI
    --------------------------------------------------------------------}
  
  TGamesConfigurationAPI = Class(TGoogleAPI)
  Private
    FAchievementConfigurationsInstance : TAchievementConfigurationsResource;
    FImageConfigurationsInstance : TImageConfigurationsResource;
    FLeaderboardConfigurationsInstance : TLeaderboardConfigurationsResource;
    Function GetAchievementConfigurationsInstance : TAchievementConfigurationsResource;virtual;
    Function GetImageConfigurationsInstance : TImageConfigurationsResource;virtual;
    Function GetLeaderboardConfigurationsInstance : TLeaderboardConfigurationsResource;virtual;
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
    Function CreateAchievementConfigurationsResource(AOwner : TComponent) : TAchievementConfigurationsResource;virtual;overload;
    Function CreateAchievementConfigurationsResource : TAchievementConfigurationsResource;virtual;overload;
    Function CreateImageConfigurationsResource(AOwner : TComponent) : TImageConfigurationsResource;virtual;overload;
    Function CreateImageConfigurationsResource : TImageConfigurationsResource;virtual;overload;
    Function CreateLeaderboardConfigurationsResource(AOwner : TComponent) : TLeaderboardConfigurationsResource;virtual;overload;
    Function CreateLeaderboardConfigurationsResource : TLeaderboardConfigurationsResource;virtual;overload;
    //Add default on-demand instances for resources
    Property AchievementConfigurationsResource : TAchievementConfigurationsResource Read GetAchievementConfigurationsInstance;
    Property ImageConfigurationsResource : TImageConfigurationsResource Read GetImageConfigurationsInstance;
    Property LeaderboardConfigurationsResource : TLeaderboardConfigurationsResource Read GetLeaderboardConfigurationsInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAchievementConfiguration
  --------------------------------------------------------------------}


Procedure TAchievementConfiguration.SetachievementType(AIndex : Integer; const AValue : String); 

begin
  If (FachievementType=AValue) then exit;
  FachievementType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.Setdraft(AIndex : Integer; const AValue : TAchievementConfigurationDetail); 

begin
  If (Fdraft=AValue) then exit;
  Fdraft:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.SetinitialState(AIndex : Integer; const AValue : String); 

begin
  If (FinitialState=AValue) then exit;
  FinitialState:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.Set_published(AIndex : Integer; const AValue : TAchievementConfigurationDetail); 

begin
  If (F_published=AValue) then exit;
  F_published:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.SetstepsToUnlock(AIndex : Integer; const AValue : integer); 

begin
  If (FstepsToUnlock=AValue) then exit;
  FstepsToUnlock:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfiguration.Settoken(AIndex : Integer; const AValue : String); 

begin
  If (Ftoken=AValue) then exit;
  Ftoken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAchievementConfiguration.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_published' : Result:='published';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAchievementConfigurationDetail
  --------------------------------------------------------------------}


Procedure TAchievementConfigurationDetail.Setdescription(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationDetail.SeticonUrl(AIndex : Integer; const AValue : String); 

begin
  If (FiconUrl=AValue) then exit;
  FiconUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationDetail.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationDetail.Setname(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationDetail.SetpointValue(AIndex : Integer; const AValue : integer); 

begin
  If (FpointValue=AValue) then exit;
  FpointValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationDetail.SetsortRank(AIndex : Integer; const AValue : integer); 

begin
  If (FsortRank=AValue) then exit;
  FsortRank:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAchievementConfigurationListResponse
  --------------------------------------------------------------------}


Procedure TAchievementConfigurationListResponse.Setitems(AIndex : Integer; const AValue : TAchievementConfigurationListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAchievementConfigurationListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAchievementConfigurationListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TGamesNumberAffixConfiguration
  --------------------------------------------------------------------}


Procedure TGamesNumberAffixConfiguration.Setfew(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Ffew=AValue) then exit;
  Ffew:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberAffixConfiguration.Setmany(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fmany=AValue) then exit;
  Fmany:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberAffixConfiguration.Setone(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fone=AValue) then exit;
  Fone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberAffixConfiguration.Setother(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fother=AValue) then exit;
  Fother:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberAffixConfiguration.Settwo(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Ftwo=AValue) then exit;
  Ftwo:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberAffixConfiguration.Setzero(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fzero=AValue) then exit;
  Fzero:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TGamesNumberFormatConfiguration
  --------------------------------------------------------------------}


Procedure TGamesNumberFormatConfiguration.SetcurrencyCode(AIndex : Integer; const AValue : String); 

begin
  If (FcurrencyCode=AValue) then exit;
  FcurrencyCode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberFormatConfiguration.SetnumDecimalPlaces(AIndex : Integer; const AValue : integer); 

begin
  If (FnumDecimalPlaces=AValue) then exit;
  FnumDecimalPlaces:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberFormatConfiguration.SetnumberFormatType(AIndex : Integer; const AValue : String); 

begin
  If (FnumberFormatType=AValue) then exit;
  FnumberFormatType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGamesNumberFormatConfiguration.Setsuffix(AIndex : Integer; const AValue : TGamesNumberAffixConfiguration); 

begin
  If (Fsuffix=AValue) then exit;
  Fsuffix:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TImageConfiguration
  --------------------------------------------------------------------}


Procedure TImageConfiguration.SetimageType(AIndex : Integer; const AValue : String); 

begin
  If (FimageType=AValue) then exit;
  FimageType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageConfiguration.SetresourceId(AIndex : Integer; const AValue : String); 

begin
  If (FresourceId=AValue) then exit;
  FresourceId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageConfiguration.Seturl(AIndex : Integer; const AValue : String); 

begin
  If (Furl=AValue) then exit;
  Furl:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TLeaderboardConfiguration
  --------------------------------------------------------------------}


Procedure TLeaderboardConfiguration.Setdraft(AIndex : Integer; const AValue : TLeaderboardConfigurationDetail); 

begin
  If (Fdraft=AValue) then exit;
  Fdraft:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.Set_published(AIndex : Integer; const AValue : TLeaderboardConfigurationDetail); 

begin
  If (F_published=AValue) then exit;
  F_published:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.SetscoreMax(AIndex : Integer; const AValue : String); 

begin
  If (FscoreMax=AValue) then exit;
  FscoreMax:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.SetscoreMin(AIndex : Integer; const AValue : String); 

begin
  If (FscoreMin=AValue) then exit;
  FscoreMin:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.SetscoreOrder(AIndex : Integer; const AValue : String); 

begin
  If (FscoreOrder=AValue) then exit;
  FscoreOrder:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfiguration.Settoken(AIndex : Integer; const AValue : String); 

begin
  If (Ftoken=AValue) then exit;
  Ftoken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TLeaderboardConfiguration.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_published' : Result:='published';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TLeaderboardConfigurationDetail
  --------------------------------------------------------------------}


Procedure TLeaderboardConfigurationDetail.SeticonUrl(AIndex : Integer; const AValue : String); 

begin
  If (FiconUrl=AValue) then exit;
  FiconUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationDetail.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationDetail.Setname(AIndex : Integer; const AValue : TLocalizedStringBundle); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationDetail.SetscoreFormat(AIndex : Integer; const AValue : TGamesNumberFormatConfiguration); 

begin
  If (FscoreFormat=AValue) then exit;
  FscoreFormat:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationDetail.SetsortRank(AIndex : Integer; const AValue : integer); 

begin
  If (FsortRank=AValue) then exit;
  FsortRank:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TLeaderboardConfigurationListResponse
  --------------------------------------------------------------------}


Procedure TLeaderboardConfigurationListResponse.Setitems(AIndex : Integer; const AValue : TLeaderboardConfigurationListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLeaderboardConfigurationListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TLeaderboardConfigurationListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TLocalizedString
  --------------------------------------------------------------------}


Procedure TLocalizedString.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocalizedString.Setlocale(AIndex : Integer; const AValue : String); 

begin
  If (Flocale=AValue) then exit;
  Flocale:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocalizedString.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TLocalizedStringBundle
  --------------------------------------------------------------------}


Procedure TLocalizedStringBundle.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocalizedStringBundle.Settranslations(AIndex : Integer; const AValue : TLocalizedStringBundleTypetranslationsArray); 

begin
  If (Ftranslations=AValue) then exit;
  Ftranslations:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TLocalizedStringBundle.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'translations' : SetLength(Ftranslations,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAchievementConfigurationsResource
  --------------------------------------------------------------------}


Class Function TAchievementConfigurationsResource.ResourceName : String;

begin
  Result:='achievementConfigurations';
end;

Class Function TAchievementConfigurationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TgamesConfigurationAPI;
end;

Procedure TAchievementConfigurationsResource.Delete(achievementId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'achievements/{achievementId}';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['achievementId',achievementId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TAchievementConfigurationsResource.Get(achievementId: string) : TAchievementConfiguration;

Const
  _HTTPMethod = 'GET';
  _Path       = 'achievements/{achievementId}';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['achievementId',achievementId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAchievementConfiguration) as TAchievementConfiguration;
end;

Function TAchievementConfigurationsResource.Insert(applicationId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;

Const
  _HTTPMethod = 'POST';
  _Path       = 'applications/{applicationId}/achievements';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationId',applicationId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAchievementConfiguration,TAchievementConfiguration) as TAchievementConfiguration;
end;

Function TAchievementConfigurationsResource.List(applicationId: string; AQuery : string = '') : TAchievementConfigurationListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'applications/{applicationId}/achievements';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationId',applicationId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAchievementConfigurationListResponse) as TAchievementConfigurationListResponse;
end;


Function TAchievementConfigurationsResource.List(applicationId: string; AQuery : TAchievementConfigurationslistOptions) : TAchievementConfigurationListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(applicationId,_Q);
end;

Function TAchievementConfigurationsResource.Patch(achievementId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'achievements/{achievementId}';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['achievementId',achievementId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAchievementConfiguration,TAchievementConfiguration) as TAchievementConfiguration;
end;

Function TAchievementConfigurationsResource.Update(achievementId: string; aAchievementConfiguration : TAchievementConfiguration) : TAchievementConfiguration;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'achievements/{achievementId}';
  _Methodid   = 'gamesConfiguration.achievementConfigurations.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['achievementId',achievementId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAchievementConfiguration,TAchievementConfiguration) as TAchievementConfiguration;
end;



{ --------------------------------------------------------------------
  TImageConfigurationsResource
  --------------------------------------------------------------------}


Class Function TImageConfigurationsResource.ResourceName : String;

begin
  Result:='imageConfigurations';
end;

Class Function TImageConfigurationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TgamesConfigurationAPI;
end;

Function TImageConfigurationsResource.Upload(imageType: string; resourceId: string) : TImageConfiguration;

Const
  _HTTPMethod = 'POST';
  _Path       = 'images/{resourceId}/imageType/{imageType}';
  _Methodid   = 'gamesConfiguration.imageConfigurations.upload';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['imageType',imageType,'resourceId',resourceId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TImageConfiguration) as TImageConfiguration;
end;



{ --------------------------------------------------------------------
  TLeaderboardConfigurationsResource
  --------------------------------------------------------------------}


Class Function TLeaderboardConfigurationsResource.ResourceName : String;

begin
  Result:='leaderboardConfigurations';
end;

Class Function TLeaderboardConfigurationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TgamesConfigurationAPI;
end;

Procedure TLeaderboardConfigurationsResource.Delete(leaderboardId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'leaderboards/{leaderboardId}';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['leaderboardId',leaderboardId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TLeaderboardConfigurationsResource.Get(leaderboardId: string) : TLeaderboardConfiguration;

Const
  _HTTPMethod = 'GET';
  _Path       = 'leaderboards/{leaderboardId}';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['leaderboardId',leaderboardId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TLeaderboardConfiguration) as TLeaderboardConfiguration;
end;

Function TLeaderboardConfigurationsResource.Insert(applicationId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;

Const
  _HTTPMethod = 'POST';
  _Path       = 'applications/{applicationId}/leaderboards';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationId',applicationId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aLeaderboardConfiguration,TLeaderboardConfiguration) as TLeaderboardConfiguration;
end;

Function TLeaderboardConfigurationsResource.List(applicationId: string; AQuery : string = '') : TLeaderboardConfigurationListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'applications/{applicationId}/leaderboards';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationId',applicationId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TLeaderboardConfigurationListResponse) as TLeaderboardConfigurationListResponse;
end;


Function TLeaderboardConfigurationsResource.List(applicationId: string; AQuery : TLeaderboardConfigurationslistOptions) : TLeaderboardConfigurationListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(applicationId,_Q);
end;

Function TLeaderboardConfigurationsResource.Patch(leaderboardId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'leaderboards/{leaderboardId}';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['leaderboardId',leaderboardId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aLeaderboardConfiguration,TLeaderboardConfiguration) as TLeaderboardConfiguration;
end;

Function TLeaderboardConfigurationsResource.Update(leaderboardId: string; aLeaderboardConfiguration : TLeaderboardConfiguration) : TLeaderboardConfiguration;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'leaderboards/{leaderboardId}';
  _Methodid   = 'gamesConfiguration.leaderboardConfigurations.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['leaderboardId',leaderboardId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aLeaderboardConfiguration,TLeaderboardConfiguration) as TLeaderboardConfiguration;
end;



{ --------------------------------------------------------------------
  TGamesConfigurationAPI
  --------------------------------------------------------------------}

Class Function TGamesConfigurationAPI.APIName : String;

begin
  Result:='gamesConfiguration';
end;

Class Function TGamesConfigurationAPI.APIVersion : String;

begin
  Result:='v1configuration';
end;

Class Function TGamesConfigurationAPI.APIRevision : String;

begin
  Result:='20160519';
end;

Class Function TGamesConfigurationAPI.APIID : String;

begin
  Result:='gamesConfiguration:v1configuration';
end;

Class Function TGamesConfigurationAPI.APITitle : String;

begin
  Result:='Google Play Game Services Publishing API';
end;

Class Function TGamesConfigurationAPI.APIDescription : String;

begin
  Result:='The Publishing API for Google Play Game Services.';
end;

Class Function TGamesConfigurationAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TGamesConfigurationAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TGamesConfigurationAPI.APIIcon16 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-16.gif';
end;

Class Function TGamesConfigurationAPI.APIIcon32 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-32.gif';
end;

Class Function TGamesConfigurationAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/games/services';
end;

Class Function TGamesConfigurationAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TGamesConfigurationAPI.APIbasePath : string;

begin
  Result:='/games/v1configuration/';
end;

Class Function TGamesConfigurationAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/games/v1configuration/';
end;

Class Function TGamesConfigurationAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TGamesConfigurationAPI.APIservicePath : string;

begin
  Result:='games/v1configuration/';
end;

Class Function TGamesConfigurationAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TGamesConfigurationAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,1);
  Result[0].Name:='https://www.googleapis.com/auth/androidpublisher';
  Result[0].Description:='View and manage your Google Play Developer account';
  
end;

Class Function TGamesConfigurationAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TGamesConfigurationAPI.RegisterAPIResources;

begin
  TAchievementConfiguration.RegisterObject;
  TAchievementConfigurationDetail.RegisterObject;
  TAchievementConfigurationListResponse.RegisterObject;
  TGamesNumberAffixConfiguration.RegisterObject;
  TGamesNumberFormatConfiguration.RegisterObject;
  TImageConfiguration.RegisterObject;
  TLeaderboardConfiguration.RegisterObject;
  TLeaderboardConfigurationDetail.RegisterObject;
  TLeaderboardConfigurationListResponse.RegisterObject;
  TLocalizedString.RegisterObject;
  TLocalizedStringBundle.RegisterObject;
end;


Function TGamesConfigurationAPI.GetAchievementConfigurationsInstance : TAchievementConfigurationsResource;

begin
  if (FAchievementConfigurationsInstance=Nil) then
    FAchievementConfigurationsInstance:=CreateAchievementConfigurationsResource;
  Result:=FAchievementConfigurationsInstance;
end;

Function TGamesConfigurationAPI.CreateAchievementConfigurationsResource : TAchievementConfigurationsResource;

begin
  Result:=CreateAchievementConfigurationsResource(Self);
end;


Function TGamesConfigurationAPI.CreateAchievementConfigurationsResource(AOwner : TComponent) : TAchievementConfigurationsResource;

begin
  Result:=TAchievementConfigurationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TGamesConfigurationAPI.GetImageConfigurationsInstance : TImageConfigurationsResource;

begin
  if (FImageConfigurationsInstance=Nil) then
    FImageConfigurationsInstance:=CreateImageConfigurationsResource;
  Result:=FImageConfigurationsInstance;
end;

Function TGamesConfigurationAPI.CreateImageConfigurationsResource : TImageConfigurationsResource;

begin
  Result:=CreateImageConfigurationsResource(Self);
end;


Function TGamesConfigurationAPI.CreateImageConfigurationsResource(AOwner : TComponent) : TImageConfigurationsResource;

begin
  Result:=TImageConfigurationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TGamesConfigurationAPI.GetLeaderboardConfigurationsInstance : TLeaderboardConfigurationsResource;

begin
  if (FLeaderboardConfigurationsInstance=Nil) then
    FLeaderboardConfigurationsInstance:=CreateLeaderboardConfigurationsResource;
  Result:=FLeaderboardConfigurationsInstance;
end;

Function TGamesConfigurationAPI.CreateLeaderboardConfigurationsResource : TLeaderboardConfigurationsResource;

begin
  Result:=CreateLeaderboardConfigurationsResource(Self);
end;


Function TGamesConfigurationAPI.CreateLeaderboardConfigurationsResource(AOwner : TComponent) : TLeaderboardConfigurationsResource;

begin
  Result:=TLeaderboardConfigurationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TGamesConfigurationAPI.RegisterAPI;
end.
