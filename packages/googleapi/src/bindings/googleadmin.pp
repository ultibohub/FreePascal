unit googleadmin;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TActivities = Class;
  TActivity = Class;
  TChannel = Class;
  TUsageReport = Class;
  TUsageReports = Class;
  TActivitiesArray = Array of TActivities;
  TActivityArray = Array of TActivity;
  TChannelArray = Array of TChannel;
  TUsageReportArray = Array of TUsageReport;
  TUsageReportsArray = Array of TUsageReports;
  //Anonymous types, using auto-generated names
  TActivityTypeactor = Class;
  TActivityTypeeventsItemTypeparametersItem = Class;
  TActivityTypeeventsItem = Class;
  TActivityTypeid = Class;
  TChannelTypeparams = Class;
  TUsageReportTypeentity = Class;
  TUsageReportTypeparametersItemTypemsgValueItem = Class;
  TUsageReportTypeparametersItem = Class;
  TUsageReportsTypewarningsItemTypedataItem = Class;
  TUsageReportsTypewarningsItem = Class;
  TActivitiesTypeitemsArray = Array of TActivity;
  TActivityTypeeventsItemTypeparametersArray = Array of TActivityTypeeventsItemTypeparametersItem;
  TActivityTypeeventsArray = Array of TActivityTypeeventsItem;
  TUsageReportTypeparametersItemTypemsgValueArray = Array of TUsageReportTypeparametersItemTypemsgValueItem;
  TUsageReportTypeparametersArray = Array of TUsageReportTypeparametersItem;
  TUsageReportsTypeusageReportsArray = Array of TUsageReport;
  TUsageReportsTypewarningsItemTypedataArray = Array of TUsageReportsTypewarningsItemTypedataItem;
  TUsageReportsTypewarningsArray = Array of TUsageReportsTypewarningsItem;
  
  { --------------------------------------------------------------------
    TActivities
    --------------------------------------------------------------------}
  
  TActivities = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TActivitiesTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TActivitiesTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TActivitiesTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
  end;
  TActivitiesClass = Class of TActivities;
  
  { --------------------------------------------------------------------
    TActivityTypeactor
    --------------------------------------------------------------------}
  
  TActivityTypeactor = Class(TGoogleBaseObject)
  Private
    FcallerType : String;
    Femail : String;
    Fkey : String;
    FprofileId : String;
  Protected
    //Property setters
    Procedure SetcallerType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprofileId(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property callerType : String Index 0 Read FcallerType Write SetcallerType;
    Property email : String Index 8 Read Femail Write Setemail;
    Property key : String Index 16 Read Fkey Write Setkey;
    Property profileId : String Index 24 Read FprofileId Write SetprofileId;
  end;
  TActivityTypeactorClass = Class of TActivityTypeactor;
  
  { --------------------------------------------------------------------
    TActivityTypeeventsItemTypeparametersItem
    --------------------------------------------------------------------}
  
  TActivityTypeeventsItemTypeparametersItem = Class(TGoogleBaseObject)
  Private
    FboolValue : boolean;
    FintValue : String;
    FmultiIntValue : TStringArray;
    FmultiValue : TStringArray;
    Fname : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure SetboolValue(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetintValue(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmultiIntValue(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetmultiValue(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property boolValue : boolean Index 0 Read FboolValue Write SetboolValue;
    Property intValue : String Index 8 Read FintValue Write SetintValue;
    Property multiIntValue : TStringArray Index 16 Read FmultiIntValue Write SetmultiIntValue;
    Property multiValue : TStringArray Index 24 Read FmultiValue Write SetmultiValue;
    Property name : String Index 32 Read Fname Write Setname;
    Property value : String Index 40 Read Fvalue Write Setvalue;
  end;
  TActivityTypeeventsItemTypeparametersItemClass = Class of TActivityTypeeventsItemTypeparametersItem;
  
  { --------------------------------------------------------------------
    TActivityTypeeventsItem
    --------------------------------------------------------------------}
  
  TActivityTypeeventsItem = Class(TGoogleBaseObject)
  Private
    Fname : String;
    Fparameters : TActivityTypeeventsItemTypeparametersArray;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setparameters(AIndex : Integer; const AValue : TActivityTypeeventsItemTypeparametersArray); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property name : String Index 0 Read Fname Write Setname;
    Property parameters : TActivityTypeeventsItemTypeparametersArray Index 8 Read Fparameters Write Setparameters;
    Property _type : String Index 16 Read F_type Write Set_type;
  end;
  TActivityTypeeventsItemClass = Class of TActivityTypeeventsItem;
  
  { --------------------------------------------------------------------
    TActivityTypeid
    --------------------------------------------------------------------}
  
  TActivityTypeid = Class(TGoogleBaseObject)
  Private
    FapplicationName : String;
    FcustomerId : String;
    Ftime : TDatetime;
    FuniqueQualifier : String;
  Protected
    //Property setters
    Procedure SetapplicationName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcustomerId(AIndex : Integer; const AValue : String); virtual;
    Procedure Settime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SetuniqueQualifier(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property applicationName : String Index 0 Read FapplicationName Write SetapplicationName;
    Property customerId : String Index 8 Read FcustomerId Write SetcustomerId;
    Property time : TDatetime Index 16 Read Ftime Write Settime;
    Property uniqueQualifier : String Index 24 Read FuniqueQualifier Write SetuniqueQualifier;
  end;
  TActivityTypeidClass = Class of TActivityTypeid;
  
  { --------------------------------------------------------------------
    TActivity
    --------------------------------------------------------------------}
  
  TActivity = Class(TGoogleBaseObject)
  Private
    Factor : TActivityTypeactor;
    Fetag : String;
    Fevents : TActivityTypeeventsArray;
    Fid : TActivityTypeid;
    FipAddress : String;
    Fkind : String;
    FownerDomain : String;
  Protected
    //Property setters
    Procedure Setactor(AIndex : Integer; const AValue : TActivityTypeactor); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setevents(AIndex : Integer; const AValue : TActivityTypeeventsArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : TActivityTypeid); virtual;
    Procedure SetipAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetownerDomain(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property actor : TActivityTypeactor Index 0 Read Factor Write Setactor;
    Property etag : String Index 8 Read Fetag Write Setetag;
    Property events : TActivityTypeeventsArray Index 16 Read Fevents Write Setevents;
    Property id : TActivityTypeid Index 24 Read Fid Write Setid;
    Property ipAddress : String Index 32 Read FipAddress Write SetipAddress;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property ownerDomain : String Index 48 Read FownerDomain Write SetownerDomain;
  end;
  TActivityClass = Class of TActivity;
  
  { --------------------------------------------------------------------
    TChannelTypeparams
    --------------------------------------------------------------------}
  
  TChannelTypeparams = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TChannelTypeparamsClass = Class of TChannelTypeparams;
  
  { --------------------------------------------------------------------
    TChannel
    --------------------------------------------------------------------}
  
  TChannel = Class(TGoogleBaseObject)
  Private
    Faddress : String;
    Fexpiration : String;
    Fid : String;
    Fkind : String;
    Fparams : TChannelTypeparams;
    Fpayload : boolean;
    FresourceId : String;
    FresourceUri : String;
    Ftoken : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setaddress(AIndex : Integer; const AValue : String); virtual;
    Procedure Setexpiration(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setparams(AIndex : Integer; const AValue : TChannelTypeparams); virtual;
    Procedure Setpayload(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetresourceId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetresourceUri(AIndex : Integer; const AValue : String); virtual;
    Procedure Settoken(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property address : String Index 0 Read Faddress Write Setaddress;
    Property expiration : String Index 8 Read Fexpiration Write Setexpiration;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property params : TChannelTypeparams Index 32 Read Fparams Write Setparams;
    Property payload : boolean Index 40 Read Fpayload Write Setpayload;
    Property resourceId : String Index 48 Read FresourceId Write SetresourceId;
    Property resourceUri : String Index 56 Read FresourceUri Write SetresourceUri;
    Property token : String Index 64 Read Ftoken Write Settoken;
    Property _type : String Index 72 Read F_type Write Set_type;
  end;
  TChannelClass = Class of TChannel;
  
  { --------------------------------------------------------------------
    TUsageReportTypeentity
    --------------------------------------------------------------------}
  
  TUsageReportTypeentity = Class(TGoogleBaseObject)
  Private
    FcustomerId : String;
    FprofileId : String;
    F_type : String;
    FuserEmail : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetcustomerId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprofileId(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure SetuserEmail(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property customerId : String Index 0 Read FcustomerId Write SetcustomerId;
    Property profileId : String Index 8 Read FprofileId Write SetprofileId;
    Property _type : String Index 16 Read F_type Write Set_type;
    Property userEmail : String Index 24 Read FuserEmail Write SetuserEmail;
  end;
  TUsageReportTypeentityClass = Class of TUsageReportTypeentity;
  
  { --------------------------------------------------------------------
    TUsageReportTypeparametersItemTypemsgValueItem
    --------------------------------------------------------------------}
  
  TUsageReportTypeparametersItemTypemsgValueItem = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TUsageReportTypeparametersItemTypemsgValueItemClass = Class of TUsageReportTypeparametersItemTypemsgValueItem;
  
  { --------------------------------------------------------------------
    TUsageReportTypeparametersItem
    --------------------------------------------------------------------}
  
  TUsageReportTypeparametersItem = Class(TGoogleBaseObject)
  Private
    FboolValue : boolean;
    FdatetimeValue : TDatetime;
    FintValue : String;
    FmsgValue : TUsageReportTypeparametersItemTypemsgValueArray;
    Fname : String;
    FstringValue : String;
  Protected
    //Property setters
    Procedure SetboolValue(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetdatetimeValue(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SetintValue(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmsgValue(AIndex : Integer; const AValue : TUsageReportTypeparametersItemTypemsgValueArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstringValue(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property boolValue : boolean Index 0 Read FboolValue Write SetboolValue;
    Property datetimeValue : TDatetime Index 8 Read FdatetimeValue Write SetdatetimeValue;
    Property intValue : String Index 16 Read FintValue Write SetintValue;
    Property msgValue : TUsageReportTypeparametersItemTypemsgValueArray Index 24 Read FmsgValue Write SetmsgValue;
    Property name : String Index 32 Read Fname Write Setname;
    Property stringValue : String Index 40 Read FstringValue Write SetstringValue;
  end;
  TUsageReportTypeparametersItemClass = Class of TUsageReportTypeparametersItem;
  
  { --------------------------------------------------------------------
    TUsageReport
    --------------------------------------------------------------------}
  
  TUsageReport = Class(TGoogleBaseObject)
  Private
    Fdate : String;
    Fentity : TUsageReportTypeentity;
    Fetag : String;
    Fkind : String;
    Fparameters : TUsageReportTypeparametersArray;
  Protected
    //Property setters
    Procedure Setdate(AIndex : Integer; const AValue : String); virtual;
    Procedure Setentity(AIndex : Integer; const AValue : TUsageReportTypeentity); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setparameters(AIndex : Integer; const AValue : TUsageReportTypeparametersArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property date : String Index 0 Read Fdate Write Setdate;
    Property entity : TUsageReportTypeentity Index 8 Read Fentity Write Setentity;
    Property etag : String Index 16 Read Fetag Write Setetag;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property parameters : TUsageReportTypeparametersArray Index 32 Read Fparameters Write Setparameters;
  end;
  TUsageReportClass = Class of TUsageReport;
  
  { --------------------------------------------------------------------
    TUsageReportsTypewarningsItemTypedataItem
    --------------------------------------------------------------------}
  
  TUsageReportsTypewarningsItemTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TUsageReportsTypewarningsItemTypedataItemClass = Class of TUsageReportsTypewarningsItemTypedataItem;
  
  { --------------------------------------------------------------------
    TUsageReportsTypewarningsItem
    --------------------------------------------------------------------}
  
  TUsageReportsTypewarningsItem = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TUsageReportsTypewarningsItemTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TUsageReportsTypewarningsItemTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TUsageReportsTypewarningsItemTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TUsageReportsTypewarningsItemClass = Class of TUsageReportsTypewarningsItem;
  
  { --------------------------------------------------------------------
    TUsageReports
    --------------------------------------------------------------------}
  
  TUsageReports = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fkind : String;
    FnextPageToken : String;
    FusageReports : TUsageReportsTypeusageReportsArray;
    Fwarnings : TUsageReportsTypewarningsArray;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetusageReports(AIndex : Integer; const AValue : TUsageReportsTypeusageReportsArray); virtual;
    Procedure Setwarnings(AIndex : Integer; const AValue : TUsageReportsTypewarningsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
    Property usageReports : TUsageReportsTypeusageReportsArray Index 24 Read FusageReports Write SetusageReports;
    Property warnings : TUsageReportsTypewarningsArray Index 32 Read Fwarnings Write Setwarnings;
  end;
  TUsageReportsClass = Class of TUsageReports;
  
  { --------------------------------------------------------------------
    TActivitiesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TActivitiesResource, method List
  
  TActivitiesListOptions = Record
    actorIpAddress : String;
    customerId : String;
    endTime : String;
    eventName : String;
    filters : String;
    maxResults : integer;
    pageToken : String;
    startTime : String;
  end;
  
  
  //Optional query Options for TActivitiesResource, method Watch
  
  TActivitiesWatchOptions = Record
    actorIpAddress : String;
    customerId : String;
    endTime : String;
    eventName : String;
    filters : String;
    maxResults : integer;
    pageToken : String;
    startTime : String;
  end;
  
  TActivitiesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function List(applicationName: string; userKey: string; AQuery : string  = '') : TActivities;
    Function List(applicationName: string; userKey: string; AQuery : TActivitieslistOptions) : TActivities;
    Function Watch(applicationName: string; userKey: string; aChannel : TChannel; AQuery : string  = '') : TChannel;
    Function Watch(applicationName: string; userKey: string; aChannel : TChannel; AQuery : TActivitieswatchOptions) : TChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TChannelsResource
    --------------------------------------------------------------------}
  
  TChannelsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Stop(aChannel : TChannel);
  end;
  
  
  { --------------------------------------------------------------------
    TCustomerUsageReportsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TCustomerUsageReportsResource, method Get
  
  TCustomerUsageReportsGetOptions = Record
    customerId : String;
    pageToken : String;
    parameters : String;
  end;
  
  TCustomerUsageReportsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(date: string; AQuery : string  = '') : TUsageReports;
    Function Get(date: string; AQuery : TCustomerUsageReportsgetOptions) : TUsageReports;
  end;
  
  
  { --------------------------------------------------------------------
    TUserUsageReportResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TUserUsageReportResource, method Get
  
  TUserUsageReportGetOptions = Record
    customerId : String;
    filters : String;
    maxResults : integer;
    pageToken : String;
    parameters : String;
  end;
  
  TUserUsageReportResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(date: string; userKey: string; AQuery : string  = '') : TUsageReports;
    Function Get(date: string; userKey: string; AQuery : TUserUsageReportgetOptions) : TUsageReports;
  end;
  
  
  { --------------------------------------------------------------------
    TAdminAPI
    --------------------------------------------------------------------}
  
  TAdminAPI = Class(TGoogleAPI)
  Private
    FActivitiesInstance : TActivitiesResource;
    FChannelsInstance : TChannelsResource;
    FCustomerUsageReportsInstance : TCustomerUsageReportsResource;
    FUserUsageReportInstance : TUserUsageReportResource;
    Function GetActivitiesInstance : TActivitiesResource;virtual;
    Function GetChannelsInstance : TChannelsResource;virtual;
    Function GetCustomerUsageReportsInstance : TCustomerUsageReportsResource;virtual;
    Function GetUserUsageReportInstance : TUserUsageReportResource;virtual;
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
    Function CreateActivitiesResource(AOwner : TComponent) : TActivitiesResource;virtual;overload;
    Function CreateActivitiesResource : TActivitiesResource;virtual;overload;
    Function CreateChannelsResource(AOwner : TComponent) : TChannelsResource;virtual;overload;
    Function CreateChannelsResource : TChannelsResource;virtual;overload;
    Function CreateCustomerUsageReportsResource(AOwner : TComponent) : TCustomerUsageReportsResource;virtual;overload;
    Function CreateCustomerUsageReportsResource : TCustomerUsageReportsResource;virtual;overload;
    Function CreateUserUsageReportResource(AOwner : TComponent) : TUserUsageReportResource;virtual;overload;
    Function CreateUserUsageReportResource : TUserUsageReportResource;virtual;overload;
    //Add default on-demand instances for resources
    Property ActivitiesResource : TActivitiesResource Read GetActivitiesInstance;
    Property ChannelsResource : TChannelsResource Read GetChannelsInstance;
    Property CustomerUsageReportsResource : TCustomerUsageReportsResource Read GetCustomerUsageReportsInstance;
    Property UserUsageReportResource : TUserUsageReportResource Read GetUserUsageReportInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TActivities
  --------------------------------------------------------------------}


Procedure TActivities.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivities.Setitems(AIndex : Integer; const AValue : TActivitiesTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivities.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivities.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TActivities.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TActivityTypeactor
  --------------------------------------------------------------------}


Procedure TActivityTypeactor.SetcallerType(AIndex : Integer; const AValue : String); 

begin
  If (FcallerType=AValue) then exit;
  FcallerType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeactor.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeactor.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeactor.SetprofileId(AIndex : Integer; const AValue : String); 

begin
  If (FprofileId=AValue) then exit;
  FprofileId:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TActivityTypeeventsItemTypeparametersItem
  --------------------------------------------------------------------}


Procedure TActivityTypeeventsItemTypeparametersItem.SetboolValue(AIndex : Integer; const AValue : boolean); 

begin
  If (FboolValue=AValue) then exit;
  FboolValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItemTypeparametersItem.SetintValue(AIndex : Integer; const AValue : String); 

begin
  If (FintValue=AValue) then exit;
  FintValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItemTypeparametersItem.SetmultiIntValue(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FmultiIntValue=AValue) then exit;
  FmultiIntValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItemTypeparametersItem.SetmultiValue(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FmultiValue=AValue) then exit;
  FmultiValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItemTypeparametersItem.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItemTypeparametersItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TActivityTypeeventsItemTypeparametersItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'multiintvalue' : SetLength(FmultiIntValue,ALength);
  'multivalue' : SetLength(FmultiValue,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TActivityTypeeventsItem
  --------------------------------------------------------------------}


Procedure TActivityTypeeventsItem.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItem.Setparameters(AIndex : Integer; const AValue : TActivityTypeeventsItemTypeparametersArray); 

begin
  If (Fparameters=AValue) then exit;
  Fparameters:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeeventsItem.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TActivityTypeeventsItem.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TActivityTypeeventsItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'parameters' : SetLength(Fparameters,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TActivityTypeid
  --------------------------------------------------------------------}


Procedure TActivityTypeid.SetapplicationName(AIndex : Integer; const AValue : String); 

begin
  If (FapplicationName=AValue) then exit;
  FapplicationName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeid.SetcustomerId(AIndex : Integer; const AValue : String); 

begin
  If (FcustomerId=AValue) then exit;
  FcustomerId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeid.Settime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Ftime=AValue) then exit;
  Ftime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivityTypeid.SetuniqueQualifier(AIndex : Integer; const AValue : String); 

begin
  If (FuniqueQualifier=AValue) then exit;
  FuniqueQualifier:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TActivity
  --------------------------------------------------------------------}


Procedure TActivity.Setactor(AIndex : Integer; const AValue : TActivityTypeactor); 

begin
  If (Factor=AValue) then exit;
  Factor:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.Setevents(AIndex : Integer; const AValue : TActivityTypeeventsArray); 

begin
  If (Fevents=AValue) then exit;
  Fevents:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.Setid(AIndex : Integer; const AValue : TActivityTypeid); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.SetipAddress(AIndex : Integer; const AValue : String); 

begin
  If (FipAddress=AValue) then exit;
  FipAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TActivity.SetownerDomain(AIndex : Integer; const AValue : String); 

begin
  If (FownerDomain=AValue) then exit;
  FownerDomain:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TActivity.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'events' : SetLength(Fevents,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TChannelTypeparams
  --------------------------------------------------------------------}


Class Function TChannelTypeparams.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TChannel
  --------------------------------------------------------------------}


Procedure TChannel.Setaddress(AIndex : Integer; const AValue : String); 

begin
  If (Faddress=AValue) then exit;
  Faddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Setexpiration(AIndex : Integer; const AValue : String); 

begin
  If (Fexpiration=AValue) then exit;
  Fexpiration:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Setparams(AIndex : Integer; const AValue : TChannelTypeparams); 

begin
  If (Fparams=AValue) then exit;
  Fparams:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Setpayload(AIndex : Integer; const AValue : boolean); 

begin
  If (Fpayload=AValue) then exit;
  Fpayload:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.SetresourceId(AIndex : Integer; const AValue : String); 

begin
  If (FresourceId=AValue) then exit;
  FresourceId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.SetresourceUri(AIndex : Integer; const AValue : String); 

begin
  If (FresourceUri=AValue) then exit;
  FresourceUri:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Settoken(AIndex : Integer; const AValue : String); 

begin
  If (Ftoken=AValue) then exit;
  Ftoken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TChannel.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TUsageReportTypeentity
  --------------------------------------------------------------------}


Procedure TUsageReportTypeentity.SetcustomerId(AIndex : Integer; const AValue : String); 

begin
  If (FcustomerId=AValue) then exit;
  FcustomerId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeentity.SetprofileId(AIndex : Integer; const AValue : String); 

begin
  If (FprofileId=AValue) then exit;
  FprofileId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeentity.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeentity.SetuserEmail(AIndex : Integer; const AValue : String); 

begin
  If (FuserEmail=AValue) then exit;
  FuserEmail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TUsageReportTypeentity.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TUsageReportTypeparametersItemTypemsgValueItem
  --------------------------------------------------------------------}


Class Function TUsageReportTypeparametersItemTypemsgValueItem.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TUsageReportTypeparametersItem
  --------------------------------------------------------------------}


Procedure TUsageReportTypeparametersItem.SetboolValue(AIndex : Integer; const AValue : boolean); 

begin
  If (FboolValue=AValue) then exit;
  FboolValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeparametersItem.SetdatetimeValue(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FdatetimeValue=AValue) then exit;
  FdatetimeValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeparametersItem.SetintValue(AIndex : Integer; const AValue : String); 

begin
  If (FintValue=AValue) then exit;
  FintValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeparametersItem.SetmsgValue(AIndex : Integer; const AValue : TUsageReportTypeparametersItemTypemsgValueArray); 

begin
  If (FmsgValue=AValue) then exit;
  FmsgValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeparametersItem.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportTypeparametersItem.SetstringValue(AIndex : Integer; const AValue : String); 

begin
  If (FstringValue=AValue) then exit;
  FstringValue:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsageReportTypeparametersItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'msgvalue' : SetLength(FmsgValue,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUsageReport
  --------------------------------------------------------------------}


Procedure TUsageReport.Setdate(AIndex : Integer; const AValue : String); 

begin
  If (Fdate=AValue) then exit;
  Fdate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReport.Setentity(AIndex : Integer; const AValue : TUsageReportTypeentity); 

begin
  If (Fentity=AValue) then exit;
  Fentity:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReport.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReport.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReport.Setparameters(AIndex : Integer; const AValue : TUsageReportTypeparametersArray); 

begin
  If (Fparameters=AValue) then exit;
  Fparameters:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsageReport.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'parameters' : SetLength(Fparameters,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUsageReportsTypewarningsItemTypedataItem
  --------------------------------------------------------------------}


Procedure TUsageReportsTypewarningsItemTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportsTypewarningsItemTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUsageReportsTypewarningsItem
  --------------------------------------------------------------------}


Procedure TUsageReportsTypewarningsItem.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportsTypewarningsItem.Setdata(AIndex : Integer; const AValue : TUsageReportsTypewarningsItemTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReportsTypewarningsItem.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsageReportsTypewarningsItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUsageReports
  --------------------------------------------------------------------}


Procedure TUsageReports.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReports.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReports.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReports.SetusageReports(AIndex : Integer; const AValue : TUsageReportsTypeusageReportsArray); 

begin
  If (FusageReports=AValue) then exit;
  FusageReports:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageReports.Setwarnings(AIndex : Integer; const AValue : TUsageReportsTypewarningsArray); 

begin
  If (Fwarnings=AValue) then exit;
  Fwarnings:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsageReports.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'usagereports' : SetLength(FusageReports,ALength);
  'warnings' : SetLength(Fwarnings,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TActivitiesResource
  --------------------------------------------------------------------}


Class Function TActivitiesResource.ResourceName : String;

begin
  Result:='activities';
end;

Class Function TActivitiesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadminAPI;
end;

Function TActivitiesResource.List(applicationName: string; userKey: string; AQuery : string = '') : TActivities;

Const
  _HTTPMethod = 'GET';
  _Path       = 'activity/users/{userKey}/applications/{applicationName}';
  _Methodid   = 'reports.activities.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationName',applicationName,'userKey',userKey]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TActivities) as TActivities;
end;


Function TActivitiesResource.List(applicationName: string; userKey: string; AQuery : TActivitieslistOptions) : TActivities;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'actorIpAddress',AQuery.actorIpAddress);
  AddToQuery(_Q,'customerId',AQuery.customerId);
  AddToQuery(_Q,'endTime',AQuery.endTime);
  AddToQuery(_Q,'eventName',AQuery.eventName);
  AddToQuery(_Q,'filters',AQuery.filters);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'startTime',AQuery.startTime);
  Result:=List(applicationName,userKey,_Q);
end;

Function TActivitiesResource.Watch(applicationName: string; userKey: string; aChannel : TChannel; AQuery : string = '') : TChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'activity/users/{userKey}/applications/{applicationName}/watch';
  _Methodid   = 'reports.activities.watch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['applicationName',applicationName,'userKey',userKey]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aChannel,TChannel) as TChannel;
end;


Function TActivitiesResource.Watch(applicationName: string; userKey: string; aChannel : TChannel; AQuery : TActivitieswatchOptions) : TChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'actorIpAddress',AQuery.actorIpAddress);
  AddToQuery(_Q,'customerId',AQuery.customerId);
  AddToQuery(_Q,'endTime',AQuery.endTime);
  AddToQuery(_Q,'eventName',AQuery.eventName);
  AddToQuery(_Q,'filters',AQuery.filters);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'startTime',AQuery.startTime);
  Result:=Watch(applicationName,userKey,aChannel,_Q);
end;



{ --------------------------------------------------------------------
  TChannelsResource
  --------------------------------------------------------------------}


Class Function TChannelsResource.ResourceName : String;

begin
  Result:='channels';
end;

Class Function TChannelsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadminAPI;
end;

Procedure TChannelsResource.Stop(aChannel : TChannel);

Const
  _HTTPMethod = 'POST';
  _Path       = '/admin/reports_v1/channels/stop';
  _Methodid   = 'admin.channels.stop';

begin
  ServiceCall(_HTTPMethod,_Path,'',aChannel,Nil);
end;



{ --------------------------------------------------------------------
  TCustomerUsageReportsResource
  --------------------------------------------------------------------}


Class Function TCustomerUsageReportsResource.ResourceName : String;

begin
  Result:='customerUsageReports';
end;

Class Function TCustomerUsageReportsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadminAPI;
end;

Function TCustomerUsageReportsResource.Get(date: string; AQuery : string = '') : TUsageReports;

Const
  _HTTPMethod = 'GET';
  _Path       = 'usage/dates/{date}';
  _Methodid   = 'reports.customerUsageReports.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['date',date]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TUsageReports) as TUsageReports;
end;


Function TCustomerUsageReportsResource.Get(date: string; AQuery : TCustomerUsageReportsgetOptions) : TUsageReports;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'customerId',AQuery.customerId);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'parameters',AQuery.parameters);
  Result:=Get(date,_Q);
end;



{ --------------------------------------------------------------------
  TUserUsageReportResource
  --------------------------------------------------------------------}


Class Function TUserUsageReportResource.ResourceName : String;

begin
  Result:='userUsageReport';
end;

Class Function TUserUsageReportResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TadminAPI;
end;

Function TUserUsageReportResource.Get(date: string; userKey: string; AQuery : string = '') : TUsageReports;

Const
  _HTTPMethod = 'GET';
  _Path       = 'usage/users/{userKey}/dates/{date}';
  _Methodid   = 'reports.userUsageReport.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['date',date,'userKey',userKey]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TUsageReports) as TUsageReports;
end;


Function TUserUsageReportResource.Get(date: string; userKey: string; AQuery : TUserUsageReportgetOptions) : TUsageReports;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'customerId',AQuery.customerId);
  AddToQuery(_Q,'filters',AQuery.filters);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'parameters',AQuery.parameters);
  Result:=Get(date,userKey,_Q);
end;



{ --------------------------------------------------------------------
  TAdminAPI
  --------------------------------------------------------------------}

Class Function TAdminAPI.APIName : String;

begin
  Result:='admin';
end;

Class Function TAdminAPI.APIVersion : String;

begin
  Result:='reports_v1';
end;

Class Function TAdminAPI.APIRevision : String;

begin
  Result:='20151113';
end;

Class Function TAdminAPI.APIID : String;

begin
  Result:='admin:reports_v1';
end;

Class Function TAdminAPI.APITitle : String;

begin
  Result:='Admin Reports API';
end;

Class Function TAdminAPI.APIDescription : String;

begin
  Result:='Allows the administrators of Google Apps customers to fetch reports about the usage, collaboration, security and risk for their users.';
end;

Class Function TAdminAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TAdminAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TAdminAPI.APIIcon16 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-16.gif';
end;

Class Function TAdminAPI.APIIcon32 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-32.gif';
end;

Class Function TAdminAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/admin-sdk/reports/';
end;

Class Function TAdminAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TAdminAPI.APIbasePath : string;

begin
  Result:='/admin/reports/v1/';
end;

Class Function TAdminAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/admin/reports/v1/';
end;

Class Function TAdminAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TAdminAPI.APIservicePath : string;

begin
  Result:='admin/reports/v1/';
end;

Class Function TAdminAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TAdminAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,2);
  Result[0].Name:='https://www.googleapis.com/auth/admin.reports.audit.readonly';
  Result[0].Description:='View audit reports of Google Apps for your domain';
  Result[1].Name:='https://www.googleapis.com/auth/admin.reports.usage.readonly';
  Result[1].Description:='View usage reports of Google Apps for your domain';
  
end;

Class Function TAdminAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TAdminAPI.RegisterAPIResources;

begin
  TActivities.RegisterObject;
  TActivityTypeactor.RegisterObject;
  TActivityTypeeventsItemTypeparametersItem.RegisterObject;
  TActivityTypeeventsItem.RegisterObject;
  TActivityTypeid.RegisterObject;
  TActivity.RegisterObject;
  TChannelTypeparams.RegisterObject;
  TChannel.RegisterObject;
  TUsageReportTypeentity.RegisterObject;
  TUsageReportTypeparametersItemTypemsgValueItem.RegisterObject;
  TUsageReportTypeparametersItem.RegisterObject;
  TUsageReport.RegisterObject;
  TUsageReportsTypewarningsItemTypedataItem.RegisterObject;
  TUsageReportsTypewarningsItem.RegisterObject;
  TUsageReports.RegisterObject;
end;


Function TAdminAPI.GetActivitiesInstance : TActivitiesResource;

begin
  if (FActivitiesInstance=Nil) then
    FActivitiesInstance:=CreateActivitiesResource;
  Result:=FActivitiesInstance;
end;

Function TAdminAPI.CreateActivitiesResource : TActivitiesResource;

begin
  Result:=CreateActivitiesResource(Self);
end;


Function TAdminAPI.CreateActivitiesResource(AOwner : TComponent) : TActivitiesResource;

begin
  Result:=TActivitiesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdminAPI.GetChannelsInstance : TChannelsResource;

begin
  if (FChannelsInstance=Nil) then
    FChannelsInstance:=CreateChannelsResource;
  Result:=FChannelsInstance;
end;

Function TAdminAPI.CreateChannelsResource : TChannelsResource;

begin
  Result:=CreateChannelsResource(Self);
end;


Function TAdminAPI.CreateChannelsResource(AOwner : TComponent) : TChannelsResource;

begin
  Result:=TChannelsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdminAPI.GetCustomerUsageReportsInstance : TCustomerUsageReportsResource;

begin
  if (FCustomerUsageReportsInstance=Nil) then
    FCustomerUsageReportsInstance:=CreateCustomerUsageReportsResource;
  Result:=FCustomerUsageReportsInstance;
end;

Function TAdminAPI.CreateCustomerUsageReportsResource : TCustomerUsageReportsResource;

begin
  Result:=CreateCustomerUsageReportsResource(Self);
end;


Function TAdminAPI.CreateCustomerUsageReportsResource(AOwner : TComponent) : TCustomerUsageReportsResource;

begin
  Result:=TCustomerUsageReportsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAdminAPI.GetUserUsageReportInstance : TUserUsageReportResource;

begin
  if (FUserUsageReportInstance=Nil) then
    FUserUsageReportInstance:=CreateUserUsageReportResource;
  Result:=FUserUsageReportInstance;
end;

Function TAdminAPI.CreateUserUsageReportResource : TUserUsageReportResource;

begin
  Result:=CreateUserUsageReportResource(Self);
end;


Function TAdminAPI.CreateUserUsageReportResource(AOwner : TComponent) : TUserUsageReportResource;

begin
  Result:=TUserUsageReportResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TAdminAPI.RegisterAPI;
end.
