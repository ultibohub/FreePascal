unit googlesqladmin;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAclEntry = Class;
  TBackupConfiguration = Class;
  TBackupRun = Class;
  TBackupRunsListResponse = Class;
  TBinLogCoordinates = Class;
  TCloneContext = Class;
  TDatabase = Class;
  TDatabaseFlags = Class;
  TDatabaseInstance = Class;
  TDatabasesListResponse = Class;
  TExportContext = Class;
  TFailoverContext = Class;
  TFlag = Class;
  TFlagsListResponse = Class;
  TImportContext = Class;
  TInstancesCloneRequest = Class;
  TInstancesExportRequest = Class;
  TInstancesFailoverRequest = Class;
  TInstancesImportRequest = Class;
  TInstancesListResponse = Class;
  TInstancesRestoreBackupRequest = Class;
  TIpConfiguration = Class;
  TIpMapping = Class;
  TLocationPreference = Class;
  TMaintenanceWindow = Class;
  TMySqlReplicaConfiguration = Class;
  TOnPremisesConfiguration = Class;
  TOperation = Class;
  TOperationError = Class;
  TOperationErrors = Class;
  TOperationsListResponse = Class;
  TReplicaConfiguration = Class;
  TRestoreBackupContext = Class;
  TSettings = Class;
  TSslCert = Class;
  TSslCertDetail = Class;
  TSslCertsCreateEphemeralRequest = Class;
  TSslCertsInsertRequest = Class;
  TSslCertsInsertResponse = Class;
  TSslCertsListResponse = Class;
  TTier = Class;
  TTiersListResponse = Class;
  TUser = Class;
  TUsersListResponse = Class;
  TAclEntryArray = Array of TAclEntry;
  TBackupConfigurationArray = Array of TBackupConfiguration;
  TBackupRunArray = Array of TBackupRun;
  TBackupRunsListResponseArray = Array of TBackupRunsListResponse;
  TBinLogCoordinatesArray = Array of TBinLogCoordinates;
  TCloneContextArray = Array of TCloneContext;
  TDatabaseArray = Array of TDatabase;
  TDatabaseFlagsArray = Array of TDatabaseFlags;
  TDatabaseInstanceArray = Array of TDatabaseInstance;
  TDatabasesListResponseArray = Array of TDatabasesListResponse;
  TExportContextArray = Array of TExportContext;
  TFailoverContextArray = Array of TFailoverContext;
  TFlagArray = Array of TFlag;
  TFlagsListResponseArray = Array of TFlagsListResponse;
  TImportContextArray = Array of TImportContext;
  TInstancesCloneRequestArray = Array of TInstancesCloneRequest;
  TInstancesExportRequestArray = Array of TInstancesExportRequest;
  TInstancesFailoverRequestArray = Array of TInstancesFailoverRequest;
  TInstancesImportRequestArray = Array of TInstancesImportRequest;
  TInstancesListResponseArray = Array of TInstancesListResponse;
  TInstancesRestoreBackupRequestArray = Array of TInstancesRestoreBackupRequest;
  TIpConfigurationArray = Array of TIpConfiguration;
  TIpMappingArray = Array of TIpMapping;
  TLocationPreferenceArray = Array of TLocationPreference;
  TMaintenanceWindowArray = Array of TMaintenanceWindow;
  TMySqlReplicaConfigurationArray = Array of TMySqlReplicaConfiguration;
  TOnPremisesConfigurationArray = Array of TOnPremisesConfiguration;
  TOperationArray = Array of TOperation;
  TOperationErrorArray = Array of TOperationError;
  TOperationErrorsArray = Array of TOperationErrors;
  TOperationsListResponseArray = Array of TOperationsListResponse;
  TReplicaConfigurationArray = Array of TReplicaConfiguration;
  TRestoreBackupContextArray = Array of TRestoreBackupContext;
  TSettingsArray = Array of TSettings;
  TSslCertArray = Array of TSslCert;
  TSslCertDetailArray = Array of TSslCertDetail;
  TSslCertsCreateEphemeralRequestArray = Array of TSslCertsCreateEphemeralRequest;
  TSslCertsInsertRequestArray = Array of TSslCertsInsertRequest;
  TSslCertsInsertResponseArray = Array of TSslCertsInsertResponse;
  TSslCertsListResponseArray = Array of TSslCertsListResponse;
  TTierArray = Array of TTier;
  TTiersListResponseArray = Array of TTiersListResponse;
  TUserArray = Array of TUser;
  TUsersListResponseArray = Array of TUsersListResponse;
  //Anonymous types, using auto-generated names
  TDatabaseInstanceTypefailoverReplica = Class;
  TExportContextTypecsvExportOptions = Class;
  TExportContextTypesqlExportOptions = Class;
  TImportContextTypecsvImportOptions = Class;
  TBackupRunsListResponseTypeitemsArray = Array of TBackupRun;
  TDatabaseInstanceTypeipAddressesArray = Array of TIpMapping;
  TDatabasesListResponseTypeitemsArray = Array of TDatabase;
  TFlagsListResponseTypeitemsArray = Array of TFlag;
  TInstancesListResponseTypeitemsArray = Array of TDatabaseInstance;
  TIpConfigurationTypeauthorizedNetworksArray = Array of TAclEntry;
  TOperationErrorsTypeerrorsArray = Array of TOperationError;
  TOperationsListResponseTypeitemsArray = Array of TOperation;
  TSettingsTypedatabaseFlagsArray = Array of TDatabaseFlags;
  TSslCertsListResponseTypeitemsArray = Array of TSslCert;
  TTiersListResponseTypeitemsArray = Array of TTier;
  TUsersListResponseTypeitemsArray = Array of TUser;
  
  { --------------------------------------------------------------------
    TAclEntry
    --------------------------------------------------------------------}
  
  TAclEntry = Class(TGoogleBaseObject)
  Private
    FexpirationTime : TDatetime;
    Fkind : String;
    Fname : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure SetexpirationTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property expirationTime : TDatetime Index 0 Read FexpirationTime Write SetexpirationTime;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property value : String Index 24 Read Fvalue Write Setvalue;
  end;
  TAclEntryClass = Class of TAclEntry;
  
  { --------------------------------------------------------------------
    TBackupConfiguration
    --------------------------------------------------------------------}
  
  TBackupConfiguration = Class(TGoogleBaseObject)
  Private
    FbinaryLogEnabled : boolean;
    Fenabled : boolean;
    Fkind : String;
    FstartTime : String;
  Protected
    //Property setters
    Procedure SetbinaryLogEnabled(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setenabled(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstartTime(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property binaryLogEnabled : boolean Index 0 Read FbinaryLogEnabled Write SetbinaryLogEnabled;
    Property enabled : boolean Index 8 Read Fenabled Write Setenabled;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property startTime : String Index 24 Read FstartTime Write SetstartTime;
  end;
  TBackupConfigurationClass = Class of TBackupConfiguration;
  
  { --------------------------------------------------------------------
    TBackupRun
    --------------------------------------------------------------------}
  
  TBackupRun = Class(TGoogleBaseObject)
  Private
    FendTime : TDatetime;
    FenqueuedTime : TDatetime;
    Ferror : TOperationError;
    Fid : String;
    Finstance : String;
    Fkind : String;
    FselfLink : String;
    FstartTime : TDatetime;
    Fstatus : String;
    FwindowStartTime : TDatetime;
  Protected
    //Property setters
    Procedure SetendTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SetenqueuedTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Seterror(AIndex : Integer; const AValue : TOperationError); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstartTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetwindowStartTime(AIndex : Integer; const AValue : TDatetime); virtual;
  Public
  Published
    Property endTime : TDatetime Index 0 Read FendTime Write SetendTime;
    Property enqueuedTime : TDatetime Index 8 Read FenqueuedTime Write SetenqueuedTime;
    Property error : TOperationError Index 16 Read Ferror Write Seterror;
    Property id : String Index 24 Read Fid Write Setid;
    Property instance : String Index 32 Read Finstance Write Setinstance;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property selfLink : String Index 48 Read FselfLink Write SetselfLink;
    Property startTime : TDatetime Index 56 Read FstartTime Write SetstartTime;
    Property status : String Index 64 Read Fstatus Write Setstatus;
    Property windowStartTime : TDatetime Index 72 Read FwindowStartTime Write SetwindowStartTime;
  end;
  TBackupRunClass = Class of TBackupRun;
  
  { --------------------------------------------------------------------
    TBackupRunsListResponse
    --------------------------------------------------------------------}
  
  TBackupRunsListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TBackupRunsListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TBackupRunsListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TBackupRunsListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TBackupRunsListResponseClass = Class of TBackupRunsListResponse;
  
  { --------------------------------------------------------------------
    TBinLogCoordinates
    --------------------------------------------------------------------}
  
  TBinLogCoordinates = Class(TGoogleBaseObject)
  Private
    FbinLogFileName : String;
    FbinLogPosition : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetbinLogFileName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetbinLogPosition(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property binLogFileName : String Index 0 Read FbinLogFileName Write SetbinLogFileName;
    Property binLogPosition : String Index 8 Read FbinLogPosition Write SetbinLogPosition;
    Property kind : String Index 16 Read Fkind Write Setkind;
  end;
  TBinLogCoordinatesClass = Class of TBinLogCoordinates;
  
  { --------------------------------------------------------------------
    TCloneContext
    --------------------------------------------------------------------}
  
  TCloneContext = Class(TGoogleBaseObject)
  Private
    FbinLogCoordinates : TBinLogCoordinates;
    FdestinationInstanceName : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetbinLogCoordinates(AIndex : Integer; const AValue : TBinLogCoordinates); virtual;
    Procedure SetdestinationInstanceName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property binLogCoordinates : TBinLogCoordinates Index 0 Read FbinLogCoordinates Write SetbinLogCoordinates;
    Property destinationInstanceName : String Index 8 Read FdestinationInstanceName Write SetdestinationInstanceName;
    Property kind : String Index 16 Read Fkind Write Setkind;
  end;
  TCloneContextClass = Class of TCloneContext;
  
  { --------------------------------------------------------------------
    TDatabase
    --------------------------------------------------------------------}
  
  TDatabase = Class(TGoogleBaseObject)
  Private
    Fcharset : String;
    Fcollation : String;
    Fetag : String;
    Finstance : String;
    Fkind : String;
    Fname : String;
    Fproject : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setcharset(AIndex : Integer; const AValue : String); virtual;
    Procedure Setcollation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setproject(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property charset : String Index 0 Read Fcharset Write Setcharset;
    Property collation : String Index 8 Read Fcollation Write Setcollation;
    Property etag : String Index 16 Read Fetag Write Setetag;
    Property instance : String Index 24 Read Finstance Write Setinstance;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property project : String Index 48 Read Fproject Write Setproject;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
  end;
  TDatabaseClass = Class of TDatabase;
  
  { --------------------------------------------------------------------
    TDatabaseFlags
    --------------------------------------------------------------------}
  
  TDatabaseFlags = Class(TGoogleBaseObject)
  Private
    Fname : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property name : String Index 0 Read Fname Write Setname;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TDatabaseFlagsClass = Class of TDatabaseFlags;
  
  { --------------------------------------------------------------------
    TDatabaseInstanceTypefailoverReplica
    --------------------------------------------------------------------}
  
  TDatabaseInstanceTypefailoverReplica = Class(TGoogleBaseObject)
  Private
    Favailable : boolean;
    Fname : String;
  Protected
    //Property setters
    Procedure Setavailable(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property available : boolean Index 0 Read Favailable Write Setavailable;
    Property name : String Index 8 Read Fname Write Setname;
  end;
  TDatabaseInstanceTypefailoverReplicaClass = Class of TDatabaseInstanceTypefailoverReplica;
  
  { --------------------------------------------------------------------
    TDatabaseInstance
    --------------------------------------------------------------------}
  
  TDatabaseInstance = Class(TGoogleBaseObject)
  Private
    FbackendType : String;
    FcurrentDiskSize : String;
    FdatabaseVersion : String;
    Fetag : String;
    FfailoverReplica : TDatabaseInstanceTypefailoverReplica;
    FinstanceType : String;
    FipAddresses : TDatabaseInstanceTypeipAddressesArray;
    Fipv6Address : String;
    Fkind : String;
    FmasterInstanceName : String;
    FmaxDiskSize : String;
    Fname : String;
    FonPremisesConfiguration : TOnPremisesConfiguration;
    Fproject : String;
    Fregion : String;
    FreplicaConfiguration : TReplicaConfiguration;
    FreplicaNames : TStringArray;
    FselfLink : String;
    FserverCaCert : TSslCert;
    FserviceAccountEmailAddress : String;
    Fsettings : TSettings;
    Fstate : String;
    FsuspensionReason : TStringArray;
  Protected
    //Property setters
    Procedure SetbackendType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcurrentDiskSize(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdatabaseVersion(AIndex : Integer; const AValue : String); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure SetfailoverReplica(AIndex : Integer; const AValue : TDatabaseInstanceTypefailoverReplica); virtual;
    Procedure SetinstanceType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetipAddresses(AIndex : Integer; const AValue : TDatabaseInstanceTypeipAddressesArray); virtual;
    Procedure Setipv6Address(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmasterInstanceName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmaxDiskSize(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetonPremisesConfiguration(AIndex : Integer; const AValue : TOnPremisesConfiguration); virtual;
    Procedure Setproject(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreplicaConfiguration(AIndex : Integer; const AValue : TReplicaConfiguration); virtual;
    Procedure SetreplicaNames(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetserverCaCert(AIndex : Integer; const AValue : TSslCert); virtual;
    Procedure SetserviceAccountEmailAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsettings(AIndex : Integer; const AValue : TSettings); virtual;
    Procedure Setstate(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsuspensionReason(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property backendType : String Index 0 Read FbackendType Write SetbackendType;
    Property currentDiskSize : String Index 8 Read FcurrentDiskSize Write SetcurrentDiskSize;
    Property databaseVersion : String Index 16 Read FdatabaseVersion Write SetdatabaseVersion;
    Property etag : String Index 24 Read Fetag Write Setetag;
    Property failoverReplica : TDatabaseInstanceTypefailoverReplica Index 32 Read FfailoverReplica Write SetfailoverReplica;
    Property instanceType : String Index 40 Read FinstanceType Write SetinstanceType;
    Property ipAddresses : TDatabaseInstanceTypeipAddressesArray Index 48 Read FipAddresses Write SetipAddresses;
    Property ipv6Address : String Index 56 Read Fipv6Address Write Setipv6Address;
    Property kind : String Index 64 Read Fkind Write Setkind;
    Property masterInstanceName : String Index 72 Read FmasterInstanceName Write SetmasterInstanceName;
    Property maxDiskSize : String Index 80 Read FmaxDiskSize Write SetmaxDiskSize;
    Property name : String Index 88 Read Fname Write Setname;
    Property onPremisesConfiguration : TOnPremisesConfiguration Index 96 Read FonPremisesConfiguration Write SetonPremisesConfiguration;
    Property project : String Index 104 Read Fproject Write Setproject;
    Property region : String Index 112 Read Fregion Write Setregion;
    Property replicaConfiguration : TReplicaConfiguration Index 120 Read FreplicaConfiguration Write SetreplicaConfiguration;
    Property replicaNames : TStringArray Index 128 Read FreplicaNames Write SetreplicaNames;
    Property selfLink : String Index 136 Read FselfLink Write SetselfLink;
    Property serverCaCert : TSslCert Index 144 Read FserverCaCert Write SetserverCaCert;
    Property serviceAccountEmailAddress : String Index 152 Read FserviceAccountEmailAddress Write SetserviceAccountEmailAddress;
    Property settings : TSettings Index 160 Read Fsettings Write Setsettings;
    Property state : String Index 168 Read Fstate Write Setstate;
    Property suspensionReason : TStringArray Index 176 Read FsuspensionReason Write SetsuspensionReason;
  end;
  TDatabaseInstanceClass = Class of TDatabaseInstance;
  
  { --------------------------------------------------------------------
    TDatabasesListResponse
    --------------------------------------------------------------------}
  
  TDatabasesListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TDatabasesListResponseTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TDatabasesListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TDatabasesListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TDatabasesListResponseClass = Class of TDatabasesListResponse;
  
  { --------------------------------------------------------------------
    TExportContextTypecsvExportOptions
    --------------------------------------------------------------------}
  
  TExportContextTypecsvExportOptions = Class(TGoogleBaseObject)
  Private
    FselectQuery : String;
  Protected
    //Property setters
    Procedure SetselectQuery(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property selectQuery : String Index 0 Read FselectQuery Write SetselectQuery;
  end;
  TExportContextTypecsvExportOptionsClass = Class of TExportContextTypecsvExportOptions;
  
  { --------------------------------------------------------------------
    TExportContextTypesqlExportOptions
    --------------------------------------------------------------------}
  
  TExportContextTypesqlExportOptions = Class(TGoogleBaseObject)
  Private
    FschemaOnly : boolean;
    Ftables : TStringArray;
  Protected
    //Property setters
    Procedure SetschemaOnly(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Settables(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property schemaOnly : boolean Index 0 Read FschemaOnly Write SetschemaOnly;
    Property tables : TStringArray Index 8 Read Ftables Write Settables;
  end;
  TExportContextTypesqlExportOptionsClass = Class of TExportContextTypesqlExportOptions;
  
  { --------------------------------------------------------------------
    TExportContext
    --------------------------------------------------------------------}
  
  TExportContext = Class(TGoogleBaseObject)
  Private
    FcsvExportOptions : TExportContextTypecsvExportOptions;
    Fdatabases : TStringArray;
    FfileType : String;
    Fkind : String;
    FsqlExportOptions : TExportContextTypesqlExportOptions;
    Furi : String;
  Protected
    //Property setters
    Procedure SetcsvExportOptions(AIndex : Integer; const AValue : TExportContextTypecsvExportOptions); virtual;
    Procedure Setdatabases(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetfileType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsqlExportOptions(AIndex : Integer; const AValue : TExportContextTypesqlExportOptions); virtual;
    Procedure Seturi(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property csvExportOptions : TExportContextTypecsvExportOptions Index 0 Read FcsvExportOptions Write SetcsvExportOptions;
    Property databases : TStringArray Index 8 Read Fdatabases Write Setdatabases;
    Property fileType : String Index 16 Read FfileType Write SetfileType;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property sqlExportOptions : TExportContextTypesqlExportOptions Index 32 Read FsqlExportOptions Write SetsqlExportOptions;
    Property uri : String Index 40 Read Furi Write Seturi;
  end;
  TExportContextClass = Class of TExportContext;
  
  { --------------------------------------------------------------------
    TFailoverContext
    --------------------------------------------------------------------}
  
  TFailoverContext = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    FsettingsVersion : String;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsettingsVersion(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property settingsVersion : String Index 8 Read FsettingsVersion Write SetsettingsVersion;
  end;
  TFailoverContextClass = Class of TFailoverContext;
  
  { --------------------------------------------------------------------
    TFlag
    --------------------------------------------------------------------}
  
  TFlag = Class(TGoogleBaseObject)
  Private
    FallowedStringValues : TStringArray;
    FappliesTo : TStringArray;
    Fkind : String;
    FmaxValue : String;
    FminValue : String;
    Fname : String;
    FrequiresRestart : boolean;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetallowedStringValues(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetappliesTo(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmaxValue(AIndex : Integer; const AValue : String); virtual;
    Procedure SetminValue(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetrequiresRestart(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property allowedStringValues : TStringArray Index 0 Read FallowedStringValues Write SetallowedStringValues;
    Property appliesTo : TStringArray Index 8 Read FappliesTo Write SetappliesTo;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property maxValue : String Index 24 Read FmaxValue Write SetmaxValue;
    Property minValue : String Index 32 Read FminValue Write SetminValue;
    Property name : String Index 40 Read Fname Write Setname;
    Property requiresRestart : boolean Index 48 Read FrequiresRestart Write SetrequiresRestart;
    Property _type : String Index 56 Read F_type Write Set_type;
  end;
  TFlagClass = Class of TFlag;
  
  { --------------------------------------------------------------------
    TFlagsListResponse
    --------------------------------------------------------------------}
  
  TFlagsListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TFlagsListResponseTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TFlagsListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TFlagsListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TFlagsListResponseClass = Class of TFlagsListResponse;
  
  { --------------------------------------------------------------------
    TImportContextTypecsvImportOptions
    --------------------------------------------------------------------}
  
  TImportContextTypecsvImportOptions = Class(TGoogleBaseObject)
  Private
    Fcolumns : TStringArray;
    Ftable : String;
  Protected
    //Property setters
    Procedure Setcolumns(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Settable(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property columns : TStringArray Index 0 Read Fcolumns Write Setcolumns;
    Property table : String Index 8 Read Ftable Write Settable;
  end;
  TImportContextTypecsvImportOptionsClass = Class of TImportContextTypecsvImportOptions;
  
  { --------------------------------------------------------------------
    TImportContext
    --------------------------------------------------------------------}
  
  TImportContext = Class(TGoogleBaseObject)
  Private
    FcsvImportOptions : TImportContextTypecsvImportOptions;
    Fdatabase : String;
    FfileType : String;
    Fkind : String;
    Furi : String;
  Protected
    //Property setters
    Procedure SetcsvImportOptions(AIndex : Integer; const AValue : TImportContextTypecsvImportOptions); virtual;
    Procedure Setdatabase(AIndex : Integer; const AValue : String); virtual;
    Procedure SetfileType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturi(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property csvImportOptions : TImportContextTypecsvImportOptions Index 0 Read FcsvImportOptions Write SetcsvImportOptions;
    Property database : String Index 8 Read Fdatabase Write Setdatabase;
    Property fileType : String Index 16 Read FfileType Write SetfileType;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property uri : String Index 32 Read Furi Write Seturi;
  end;
  TImportContextClass = Class of TImportContext;
  
  { --------------------------------------------------------------------
    TInstancesCloneRequest
    --------------------------------------------------------------------}
  
  TInstancesCloneRequest = Class(TGoogleBaseObject)
  Private
    FcloneContext : TCloneContext;
  Protected
    //Property setters
    Procedure SetcloneContext(AIndex : Integer; const AValue : TCloneContext); virtual;
  Public
  Published
    Property cloneContext : TCloneContext Index 0 Read FcloneContext Write SetcloneContext;
  end;
  TInstancesCloneRequestClass = Class of TInstancesCloneRequest;
  
  { --------------------------------------------------------------------
    TInstancesExportRequest
    --------------------------------------------------------------------}
  
  TInstancesExportRequest = Class(TGoogleBaseObject)
  Private
    FexportContext : TExportContext;
  Protected
    //Property setters
    Procedure SetexportContext(AIndex : Integer; const AValue : TExportContext); virtual;
  Public
  Published
    Property exportContext : TExportContext Index 0 Read FexportContext Write SetexportContext;
  end;
  TInstancesExportRequestClass = Class of TInstancesExportRequest;
  
  { --------------------------------------------------------------------
    TInstancesFailoverRequest
    --------------------------------------------------------------------}
  
  TInstancesFailoverRequest = Class(TGoogleBaseObject)
  Private
    FfailoverContext : TFailoverContext;
  Protected
    //Property setters
    Procedure SetfailoverContext(AIndex : Integer; const AValue : TFailoverContext); virtual;
  Public
  Published
    Property failoverContext : TFailoverContext Index 0 Read FfailoverContext Write SetfailoverContext;
  end;
  TInstancesFailoverRequestClass = Class of TInstancesFailoverRequest;
  
  { --------------------------------------------------------------------
    TInstancesImportRequest
    --------------------------------------------------------------------}
  
  TInstancesImportRequest = Class(TGoogleBaseObject)
  Private
    FimportContext : TImportContext;
  Protected
    //Property setters
    Procedure SetimportContext(AIndex : Integer; const AValue : TImportContext); virtual;
  Public
  Published
    Property importContext : TImportContext Index 0 Read FimportContext Write SetimportContext;
  end;
  TInstancesImportRequestClass = Class of TInstancesImportRequest;
  
  { --------------------------------------------------------------------
    TInstancesListResponse
    --------------------------------------------------------------------}
  
  TInstancesListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TInstancesListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TInstancesListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TInstancesListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TInstancesListResponseClass = Class of TInstancesListResponse;
  
  { --------------------------------------------------------------------
    TInstancesRestoreBackupRequest
    --------------------------------------------------------------------}
  
  TInstancesRestoreBackupRequest = Class(TGoogleBaseObject)
  Private
    FrestoreBackupContext : TRestoreBackupContext;
  Protected
    //Property setters
    Procedure SetrestoreBackupContext(AIndex : Integer; const AValue : TRestoreBackupContext); virtual;
  Public
  Published
    Property restoreBackupContext : TRestoreBackupContext Index 0 Read FrestoreBackupContext Write SetrestoreBackupContext;
  end;
  TInstancesRestoreBackupRequestClass = Class of TInstancesRestoreBackupRequest;
  
  { --------------------------------------------------------------------
    TIpConfiguration
    --------------------------------------------------------------------}
  
  TIpConfiguration = Class(TGoogleBaseObject)
  Private
    FauthorizedNetworks : TIpConfigurationTypeauthorizedNetworksArray;
    Fipv4Enabled : boolean;
    FrequireSsl : boolean;
  Protected
    //Property setters
    Procedure SetauthorizedNetworks(AIndex : Integer; const AValue : TIpConfigurationTypeauthorizedNetworksArray); virtual;
    Procedure Setipv4Enabled(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetrequireSsl(AIndex : Integer; const AValue : boolean); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property authorizedNetworks : TIpConfigurationTypeauthorizedNetworksArray Index 0 Read FauthorizedNetworks Write SetauthorizedNetworks;
    Property ipv4Enabled : boolean Index 8 Read Fipv4Enabled Write Setipv4Enabled;
    Property requireSsl : boolean Index 16 Read FrequireSsl Write SetrequireSsl;
  end;
  TIpConfigurationClass = Class of TIpConfiguration;
  
  { --------------------------------------------------------------------
    TIpMapping
    --------------------------------------------------------------------}
  
  TIpMapping = Class(TGoogleBaseObject)
  Private
    FipAddress : String;
    FtimeToRetire : TDatetime;
  Protected
    //Property setters
    Procedure SetipAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeToRetire(AIndex : Integer; const AValue : TDatetime); virtual;
  Public
  Published
    Property ipAddress : String Index 0 Read FipAddress Write SetipAddress;
    Property timeToRetire : TDatetime Index 8 Read FtimeToRetire Write SettimeToRetire;
  end;
  TIpMappingClass = Class of TIpMapping;
  
  { --------------------------------------------------------------------
    TLocationPreference
    --------------------------------------------------------------------}
  
  TLocationPreference = Class(TGoogleBaseObject)
  Private
    FfollowGaeApplication : String;
    Fkind : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetfollowGaeApplication(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property followGaeApplication : String Index 0 Read FfollowGaeApplication Write SetfollowGaeApplication;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property zone : String Index 16 Read Fzone Write Setzone;
  end;
  TLocationPreferenceClass = Class of TLocationPreference;
  
  { --------------------------------------------------------------------
    TMaintenanceWindow
    --------------------------------------------------------------------}
  
  TMaintenanceWindow = Class(TGoogleBaseObject)
  Private
    Fday : integer;
    Fhour : integer;
    Fkind : String;
    FupdateTrack : String;
  Protected
    //Property setters
    Procedure Setday(AIndex : Integer; const AValue : integer); virtual;
    Procedure Sethour(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetupdateTrack(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property day : integer Index 0 Read Fday Write Setday;
    Property hour : integer Index 8 Read Fhour Write Sethour;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property updateTrack : String Index 24 Read FupdateTrack Write SetupdateTrack;
  end;
  TMaintenanceWindowClass = Class of TMaintenanceWindow;
  
  { --------------------------------------------------------------------
    TMySqlReplicaConfiguration
    --------------------------------------------------------------------}
  
  TMySqlReplicaConfiguration = Class(TGoogleBaseObject)
  Private
    FcaCertificate : String;
    FclientCertificate : String;
    FclientKey : String;
    FconnectRetryInterval : integer;
    FdumpFilePath : String;
    Fkind : String;
    FmasterHeartbeatPeriod : String;
    Fpassword : String;
    FsslCipher : String;
    Fusername : String;
    FverifyServerCertificate : boolean;
  Protected
    //Property setters
    Procedure SetcaCertificate(AIndex : Integer; const AValue : String); virtual;
    Procedure SetclientCertificate(AIndex : Integer; const AValue : String); virtual;
    Procedure SetclientKey(AIndex : Integer; const AValue : String); virtual;
    Procedure SetconnectRetryInterval(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetdumpFilePath(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmasterHeartbeatPeriod(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpassword(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsslCipher(AIndex : Integer; const AValue : String); virtual;
    Procedure Setusername(AIndex : Integer; const AValue : String); virtual;
    Procedure SetverifyServerCertificate(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property caCertificate : String Index 0 Read FcaCertificate Write SetcaCertificate;
    Property clientCertificate : String Index 8 Read FclientCertificate Write SetclientCertificate;
    Property clientKey : String Index 16 Read FclientKey Write SetclientKey;
    Property connectRetryInterval : integer Index 24 Read FconnectRetryInterval Write SetconnectRetryInterval;
    Property dumpFilePath : String Index 32 Read FdumpFilePath Write SetdumpFilePath;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property masterHeartbeatPeriod : String Index 48 Read FmasterHeartbeatPeriod Write SetmasterHeartbeatPeriod;
    Property password : String Index 56 Read Fpassword Write Setpassword;
    Property sslCipher : String Index 64 Read FsslCipher Write SetsslCipher;
    Property username : String Index 72 Read Fusername Write Setusername;
    Property verifyServerCertificate : boolean Index 80 Read FverifyServerCertificate Write SetverifyServerCertificate;
  end;
  TMySqlReplicaConfigurationClass = Class of TMySqlReplicaConfiguration;
  
  { --------------------------------------------------------------------
    TOnPremisesConfiguration
    --------------------------------------------------------------------}
  
  TOnPremisesConfiguration = Class(TGoogleBaseObject)
  Private
    FhostPort : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SethostPort(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property hostPort : String Index 0 Read FhostPort Write SethostPort;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TOnPremisesConfigurationClass = Class of TOnPremisesConfiguration;
  
  { --------------------------------------------------------------------
    TOperation
    --------------------------------------------------------------------}
  
  TOperation = Class(TGoogleBaseObject)
  Private
    FendTime : TDatetime;
    Ferror : TOperationErrors;
    FexportContext : TExportContext;
    FimportContext : TImportContext;
    FinsertTime : TDatetime;
    Fkind : String;
    Fname : String;
    FoperationType : String;
    FselfLink : String;
    FstartTime : TDatetime;
    Fstatus : String;
    FtargetId : String;
    FtargetLink : String;
    FtargetProject : String;
    Fuser : String;
  Protected
    //Property setters
    Procedure SetendTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Seterror(AIndex : Integer; const AValue : TOperationErrors); virtual;
    Procedure SetexportContext(AIndex : Integer; const AValue : TExportContext); virtual;
    Procedure SetimportContext(AIndex : Integer; const AValue : TImportContext); virtual;
    Procedure SetinsertTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetoperationType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstartTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetId(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetProject(AIndex : Integer; const AValue : String); virtual;
    Procedure Setuser(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property endTime : TDatetime Index 0 Read FendTime Write SetendTime;
    Property error : TOperationErrors Index 8 Read Ferror Write Seterror;
    Property exportContext : TExportContext Index 16 Read FexportContext Write SetexportContext;
    Property importContext : TImportContext Index 24 Read FimportContext Write SetimportContext;
    Property insertTime : TDatetime Index 32 Read FinsertTime Write SetinsertTime;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property name : String Index 48 Read Fname Write Setname;
    Property operationType : String Index 56 Read FoperationType Write SetoperationType;
    Property selfLink : String Index 64 Read FselfLink Write SetselfLink;
    Property startTime : TDatetime Index 72 Read FstartTime Write SetstartTime;
    Property status : String Index 80 Read Fstatus Write Setstatus;
    Property targetId : String Index 88 Read FtargetId Write SettargetId;
    Property targetLink : String Index 96 Read FtargetLink Write SettargetLink;
    Property targetProject : String Index 104 Read FtargetProject Write SettargetProject;
    Property user : String Index 112 Read Fuser Write Setuser;
  end;
  TOperationClass = Class of TOperation;
  
  { --------------------------------------------------------------------
    TOperationError
    --------------------------------------------------------------------}
  
  TOperationError = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fkind : String;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TOperationErrorClass = Class of TOperationError;
  
  { --------------------------------------------------------------------
    TOperationErrors
    --------------------------------------------------------------------}
  
  TOperationErrors = Class(TGoogleBaseObject)
  Private
    Ferrors : TOperationErrorsTypeerrorsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Seterrors(AIndex : Integer; const AValue : TOperationErrorsTypeerrorsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property errors : TOperationErrorsTypeerrorsArray Index 0 Read Ferrors Write Seterrors;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TOperationErrorsClass = Class of TOperationErrors;
  
  { --------------------------------------------------------------------
    TOperationsListResponse
    --------------------------------------------------------------------}
  
  TOperationsListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TOperationsListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TOperationsListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TOperationsListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TOperationsListResponseClass = Class of TOperationsListResponse;
  
  { --------------------------------------------------------------------
    TReplicaConfiguration
    --------------------------------------------------------------------}
  
  TReplicaConfiguration = Class(TGoogleBaseObject)
  Private
    FfailoverTarget : boolean;
    Fkind : String;
    FmysqlReplicaConfiguration : TMySqlReplicaConfiguration;
  Protected
    //Property setters
    Procedure SetfailoverTarget(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmysqlReplicaConfiguration(AIndex : Integer; const AValue : TMySqlReplicaConfiguration); virtual;
  Public
  Published
    Property failoverTarget : boolean Index 0 Read FfailoverTarget Write SetfailoverTarget;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property mysqlReplicaConfiguration : TMySqlReplicaConfiguration Index 16 Read FmysqlReplicaConfiguration Write SetmysqlReplicaConfiguration;
  end;
  TReplicaConfigurationClass = Class of TReplicaConfiguration;
  
  { --------------------------------------------------------------------
    TRestoreBackupContext
    --------------------------------------------------------------------}
  
  TRestoreBackupContext = Class(TGoogleBaseObject)
  Private
    FbackupRunId : String;
    FinstanceId : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetbackupRunId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinstanceId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property backupRunId : String Index 0 Read FbackupRunId Write SetbackupRunId;
    Property instanceId : String Index 8 Read FinstanceId Write SetinstanceId;
    Property kind : String Index 16 Read Fkind Write Setkind;
  end;
  TRestoreBackupContextClass = Class of TRestoreBackupContext;
  
  { --------------------------------------------------------------------
    TSettings
    --------------------------------------------------------------------}
  
  TSettings = Class(TGoogleBaseObject)
  Private
    FactivationPolicy : String;
    FauthorizedGaeApplications : TStringArray;
    FbackupConfiguration : TBackupConfiguration;
    FcrashSafeReplicationEnabled : boolean;
    FdataDiskSizeGb : String;
    FdataDiskType : String;
    FdatabaseFlags : TSettingsTypedatabaseFlagsArray;
    FdatabaseReplicationEnabled : boolean;
    FipConfiguration : TIpConfiguration;
    Fkind : String;
    FlocationPreference : TLocationPreference;
    FmaintenanceWindow : TMaintenanceWindow;
    FpricingPlan : String;
    FreplicationType : String;
    FsettingsVersion : String;
    FstorageAutoResize : boolean;
    Ftier : String;
  Protected
    //Property setters
    Procedure SetactivationPolicy(AIndex : Integer; const AValue : String); virtual;
    Procedure SetauthorizedGaeApplications(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetbackupConfiguration(AIndex : Integer; const AValue : TBackupConfiguration); virtual;
    Procedure SetcrashSafeReplicationEnabled(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetdataDiskSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdataDiskType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdatabaseFlags(AIndex : Integer; const AValue : TSettingsTypedatabaseFlagsArray); virtual;
    Procedure SetdatabaseReplicationEnabled(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetipConfiguration(AIndex : Integer; const AValue : TIpConfiguration); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlocationPreference(AIndex : Integer; const AValue : TLocationPreference); virtual;
    Procedure SetmaintenanceWindow(AIndex : Integer; const AValue : TMaintenanceWindow); virtual;
    Procedure SetpricingPlan(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreplicationType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsettingsVersion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstorageAutoResize(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Settier(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property activationPolicy : String Index 0 Read FactivationPolicy Write SetactivationPolicy;
    Property authorizedGaeApplications : TStringArray Index 8 Read FauthorizedGaeApplications Write SetauthorizedGaeApplications;
    Property backupConfiguration : TBackupConfiguration Index 16 Read FbackupConfiguration Write SetbackupConfiguration;
    Property crashSafeReplicationEnabled : boolean Index 24 Read FcrashSafeReplicationEnabled Write SetcrashSafeReplicationEnabled;
    Property dataDiskSizeGb : String Index 32 Read FdataDiskSizeGb Write SetdataDiskSizeGb;
    Property dataDiskType : String Index 40 Read FdataDiskType Write SetdataDiskType;
    Property databaseFlags : TSettingsTypedatabaseFlagsArray Index 48 Read FdatabaseFlags Write SetdatabaseFlags;
    Property databaseReplicationEnabled : boolean Index 56 Read FdatabaseReplicationEnabled Write SetdatabaseReplicationEnabled;
    Property ipConfiguration : TIpConfiguration Index 64 Read FipConfiguration Write SetipConfiguration;
    Property kind : String Index 72 Read Fkind Write Setkind;
    Property locationPreference : TLocationPreference Index 80 Read FlocationPreference Write SetlocationPreference;
    Property maintenanceWindow : TMaintenanceWindow Index 88 Read FmaintenanceWindow Write SetmaintenanceWindow;
    Property pricingPlan : String Index 96 Read FpricingPlan Write SetpricingPlan;
    Property replicationType : String Index 104 Read FreplicationType Write SetreplicationType;
    Property settingsVersion : String Index 112 Read FsettingsVersion Write SetsettingsVersion;
    Property storageAutoResize : boolean Index 120 Read FstorageAutoResize Write SetstorageAutoResize;
    Property tier : String Index 128 Read Ftier Write Settier;
  end;
  TSettingsClass = Class of TSettings;
  
  { --------------------------------------------------------------------
    TSslCert
    --------------------------------------------------------------------}
  
  TSslCert = Class(TGoogleBaseObject)
  Private
    Fcert : String;
    FcertSerialNumber : String;
    FcommonName : String;
    FcreateTime : TDatetime;
    FexpirationTime : TDatetime;
    Finstance : String;
    Fkind : String;
    FselfLink : String;
    Fsha1Fingerprint : String;
  Protected
    //Property setters
    Procedure Setcert(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcertSerialNumber(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcommonName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreateTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SetexpirationTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsha1Fingerprint(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property cert : String Index 0 Read Fcert Write Setcert;
    Property certSerialNumber : String Index 8 Read FcertSerialNumber Write SetcertSerialNumber;
    Property commonName : String Index 16 Read FcommonName Write SetcommonName;
    Property createTime : TDatetime Index 24 Read FcreateTime Write SetcreateTime;
    Property expirationTime : TDatetime Index 32 Read FexpirationTime Write SetexpirationTime;
    Property instance : String Index 40 Read Finstance Write Setinstance;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property sha1Fingerprint : String Index 64 Read Fsha1Fingerprint Write Setsha1Fingerprint;
  end;
  TSslCertClass = Class of TSslCert;
  
  { --------------------------------------------------------------------
    TSslCertDetail
    --------------------------------------------------------------------}
  
  TSslCertDetail = Class(TGoogleBaseObject)
  Private
    FcertInfo : TSslCert;
    FcertPrivateKey : String;
  Protected
    //Property setters
    Procedure SetcertInfo(AIndex : Integer; const AValue : TSslCert); virtual;
    Procedure SetcertPrivateKey(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property certInfo : TSslCert Index 0 Read FcertInfo Write SetcertInfo;
    Property certPrivateKey : String Index 8 Read FcertPrivateKey Write SetcertPrivateKey;
  end;
  TSslCertDetailClass = Class of TSslCertDetail;
  
  { --------------------------------------------------------------------
    TSslCertsCreateEphemeralRequest
    --------------------------------------------------------------------}
  
  TSslCertsCreateEphemeralRequest = Class(TGoogleBaseObject)
  Private
    Fpublic_key : String;
  Protected
    //Property setters
    Procedure Setpublic_key(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property public_key : String Index 0 Read Fpublic_key Write Setpublic_key;
  end;
  TSslCertsCreateEphemeralRequestClass = Class of TSslCertsCreateEphemeralRequest;
  
  { --------------------------------------------------------------------
    TSslCertsInsertRequest
    --------------------------------------------------------------------}
  
  TSslCertsInsertRequest = Class(TGoogleBaseObject)
  Private
    FcommonName : String;
  Protected
    //Property setters
    Procedure SetcommonName(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property commonName : String Index 0 Read FcommonName Write SetcommonName;
  end;
  TSslCertsInsertRequestClass = Class of TSslCertsInsertRequest;
  
  { --------------------------------------------------------------------
    TSslCertsInsertResponse
    --------------------------------------------------------------------}
  
  TSslCertsInsertResponse = Class(TGoogleBaseObject)
  Private
    FclientCert : TSslCertDetail;
    Fkind : String;
    Foperation : TOperation;
    FserverCaCert : TSslCert;
  Protected
    //Property setters
    Procedure SetclientCert(AIndex : Integer; const AValue : TSslCertDetail); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setoperation(AIndex : Integer; const AValue : TOperation); virtual;
    Procedure SetserverCaCert(AIndex : Integer; const AValue : TSslCert); virtual;
  Public
  Published
    Property clientCert : TSslCertDetail Index 0 Read FclientCert Write SetclientCert;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property operation : TOperation Index 16 Read Foperation Write Setoperation;
    Property serverCaCert : TSslCert Index 24 Read FserverCaCert Write SetserverCaCert;
  end;
  TSslCertsInsertResponseClass = Class of TSslCertsInsertResponse;
  
  { --------------------------------------------------------------------
    TSslCertsListResponse
    --------------------------------------------------------------------}
  
  TSslCertsListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TSslCertsListResponseTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TSslCertsListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TSslCertsListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TSslCertsListResponseClass = Class of TSslCertsListResponse;
  
  { --------------------------------------------------------------------
    TTier
    --------------------------------------------------------------------}
  
  TTier = Class(TGoogleBaseObject)
  Private
    FDiskQuota : String;
    FRAM : String;
    Fkind : String;
    Fregion : TStringArray;
    Ftier : String;
  Protected
    //Property setters
    Procedure SetDiskQuota(AIndex : Integer; const AValue : String); virtual;
    Procedure SetRAM(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Settier(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property DiskQuota : String Index 0 Read FDiskQuota Write SetDiskQuota;
    Property RAM : String Index 8 Read FRAM Write SetRAM;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property region : TStringArray Index 24 Read Fregion Write Setregion;
    Property tier : String Index 32 Read Ftier Write Settier;
  end;
  TTierClass = Class of TTier;
  
  { --------------------------------------------------------------------
    TTiersListResponse
    --------------------------------------------------------------------}
  
  TTiersListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TTiersListResponseTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TTiersListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TTiersListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TTiersListResponseClass = Class of TTiersListResponse;
  
  { --------------------------------------------------------------------
    TUser
    --------------------------------------------------------------------}
  
  TUser = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fhost : String;
    Finstance : String;
    Fkind : String;
    Fname : String;
    Fpassword : String;
    Fproject : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Sethost(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpassword(AIndex : Integer; const AValue : String); virtual;
    Procedure Setproject(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property host : String Index 8 Read Fhost Write Sethost;
    Property instance : String Index 16 Read Finstance Write Setinstance;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property name : String Index 32 Read Fname Write Setname;
    Property password : String Index 40 Read Fpassword Write Setpassword;
    Property project : String Index 48 Read Fproject Write Setproject;
  end;
  TUserClass = Class of TUser;
  
  { --------------------------------------------------------------------
    TUsersListResponse
    --------------------------------------------------------------------}
  
  TUsersListResponse = Class(TGoogleBaseObject)
  Private
    Fitems : TUsersListResponseTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
  Protected
    //Property setters
    Procedure Setitems(AIndex : Integer; const AValue : TUsersListResponseTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property items : TUsersListResponseTypeitemsArray Index 0 Read Fitems Write Setitems;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property nextPageToken : String Index 16 Read FnextPageToken Write SetnextPageToken;
  end;
  TUsersListResponseClass = Class of TUsersListResponse;
  
  { --------------------------------------------------------------------
    TBackupRunsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TBackupRunsResource, method List
  
  TBackupRunsListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TBackupRunsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(id: string; instance: string; project: string) : TOperation;
    Function Get(id: string; instance: string; project: string) : TBackupRun;
    Function List(instance: string; project: string; AQuery : string  = '') : TBackupRunsListResponse;
    Function List(instance: string; project: string; AQuery : TBackupRunslistOptions) : TBackupRunsListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TDatabasesResource
    --------------------------------------------------------------------}
  
  TDatabasesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(database: string; instance: string; project: string) : TOperation;
    Function Get(database: string; instance: string; project: string) : TDatabase;
    Function Insert(instance: string; project: string; aDatabase : TDatabase) : TOperation;
    Function List(instance: string; project: string) : TDatabasesListResponse;
    Function Patch(database: string; instance: string; project: string; aDatabase : TDatabase) : TOperation;
    Function Update(database: string; instance: string; project: string; aDatabase : TDatabase) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TFlagsResource
    --------------------------------------------------------------------}
  
  TFlagsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function List : TFlagsListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TInstancesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TInstancesResource, method List
  
  TInstancesListOptions = Record
    maxResults : integer;
    pageToken : String;
  end;
  
  TInstancesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Clone(instance: string; project: string; aInstancesCloneRequest : TInstancesCloneRequest) : TOperation;
    Function Delete(instance: string; project: string) : TOperation;
    Function Export(instance: string; project: string; aInstancesExportRequest : TInstancesExportRequest) : TOperation;
    Function Failover(instance: string; project: string; aInstancesFailoverRequest : TInstancesFailoverRequest) : TOperation;
    Function Get(instance: string; project: string) : TDatabaseInstance;
    Function Import(instance: string; project: string; aInstancesImportRequest : TInstancesImportRequest) : TOperation;
    Function Insert(project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;
    Function List(project: string; AQuery : string  = '') : TInstancesListResponse;
    Function List(project: string; AQuery : TInstanceslistOptions) : TInstancesListResponse;
    Function Patch(instance: string; project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;
    Function PromoteReplica(instance: string; project: string) : TOperation;
    Function ResetSslConfig(instance: string; project: string) : TOperation;
    Function Restart(instance: string; project: string) : TOperation;
    Function RestoreBackup(instance: string; project: string; aInstancesRestoreBackupRequest : TInstancesRestoreBackupRequest) : TOperation;
    Function StartReplica(instance: string; project: string) : TOperation;
    Function StopReplica(instance: string; project: string) : TOperation;
    Function Update(instance: string; project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TOperationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TOperationsResource, method List
  
  TOperationsListOptions = Record
    instance : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TOperationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(operation: string; project: string) : TOperation;
    Function List(project: string; AQuery : string  = '') : TOperationsListResponse;
    Function List(project: string; AQuery : TOperationslistOptions) : TOperationsListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TSslCertsResource
    --------------------------------------------------------------------}
  
  TSslCertsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function CreateEphemeral(instance: string; project: string; aSslCertsCreateEphemeralRequest : TSslCertsCreateEphemeralRequest) : TSslCert;
    Function Delete(instance: string; project: string; sha1Fingerprint: string) : TOperation;
    Function Get(instance: string; project: string; sha1Fingerprint: string) : TSslCert;
    Function Insert(instance: string; project: string; aSslCertsInsertRequest : TSslCertsInsertRequest) : TSslCertsInsertResponse;
    Function List(instance: string; project: string) : TSslCertsListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TTiersResource
    --------------------------------------------------------------------}
  
  TTiersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function List(project: string) : TTiersListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TUsersResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TUsersResource, method Delete
  
  TUsersDeleteOptions = Record
    host : String;
    _name : String;
  end;
  
  
  //Optional query Options for TUsersResource, method Update
  
  TUsersUpdateOptions = Record
    host : String;
    _name : String;
  end;
  
  TUsersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(instance: string; project: string; AQuery : string  = '') : TOperation;
    Function Delete(instance: string; project: string; AQuery : TUsersdeleteOptions) : TOperation;
    Function Insert(instance: string; project: string; aUser : TUser) : TOperation;
    Function List(instance: string; project: string) : TUsersListResponse;
    Function Update(instance: string; project: string; aUser : TUser; AQuery : string  = '') : TOperation;
    Function Update(instance: string; project: string; aUser : TUser; AQuery : TUsersupdateOptions) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TSqladminAPI
    --------------------------------------------------------------------}
  
  TSqladminAPI = Class(TGoogleAPI)
  Private
    FBackupRunsInstance : TBackupRunsResource;
    FDatabasesInstance : TDatabasesResource;
    FFlagsInstance : TFlagsResource;
    FInstancesInstance : TInstancesResource;
    FOperationsInstance : TOperationsResource;
    FSslCertsInstance : TSslCertsResource;
    FTiersInstance : TTiersResource;
    FUsersInstance : TUsersResource;
    Function GetBackupRunsInstance : TBackupRunsResource;virtual;
    Function GetDatabasesInstance : TDatabasesResource;virtual;
    Function GetFlagsInstance : TFlagsResource;virtual;
    Function GetInstancesInstance : TInstancesResource;virtual;
    Function GetOperationsInstance : TOperationsResource;virtual;
    Function GetSslCertsInstance : TSslCertsResource;virtual;
    Function GetTiersInstance : TTiersResource;virtual;
    Function GetUsersInstance : TUsersResource;virtual;
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
    Function CreateBackupRunsResource(AOwner : TComponent) : TBackupRunsResource;virtual;overload;
    Function CreateBackupRunsResource : TBackupRunsResource;virtual;overload;
    Function CreateDatabasesResource(AOwner : TComponent) : TDatabasesResource;virtual;overload;
    Function CreateDatabasesResource : TDatabasesResource;virtual;overload;
    Function CreateFlagsResource(AOwner : TComponent) : TFlagsResource;virtual;overload;
    Function CreateFlagsResource : TFlagsResource;virtual;overload;
    Function CreateInstancesResource(AOwner : TComponent) : TInstancesResource;virtual;overload;
    Function CreateInstancesResource : TInstancesResource;virtual;overload;
    Function CreateOperationsResource(AOwner : TComponent) : TOperationsResource;virtual;overload;
    Function CreateOperationsResource : TOperationsResource;virtual;overload;
    Function CreateSslCertsResource(AOwner : TComponent) : TSslCertsResource;virtual;overload;
    Function CreateSslCertsResource : TSslCertsResource;virtual;overload;
    Function CreateTiersResource(AOwner : TComponent) : TTiersResource;virtual;overload;
    Function CreateTiersResource : TTiersResource;virtual;overload;
    Function CreateUsersResource(AOwner : TComponent) : TUsersResource;virtual;overload;
    Function CreateUsersResource : TUsersResource;virtual;overload;
    //Add default on-demand instances for resources
    Property BackupRunsResource : TBackupRunsResource Read GetBackupRunsInstance;
    Property DatabasesResource : TDatabasesResource Read GetDatabasesInstance;
    Property FlagsResource : TFlagsResource Read GetFlagsInstance;
    Property InstancesResource : TInstancesResource Read GetInstancesInstance;
    Property OperationsResource : TOperationsResource Read GetOperationsInstance;
    Property SslCertsResource : TSslCertsResource Read GetSslCertsInstance;
    Property TiersResource : TTiersResource Read GetTiersInstance;
    Property UsersResource : TUsersResource Read GetUsersInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAclEntry
  --------------------------------------------------------------------}


Procedure TAclEntry.SetexpirationTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FexpirationTime=AValue) then exit;
  FexpirationTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclEntry.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclEntry.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclEntry.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TBackupConfiguration
  --------------------------------------------------------------------}


Procedure TBackupConfiguration.SetbinaryLogEnabled(AIndex : Integer; const AValue : boolean); 

begin
  If (FbinaryLogEnabled=AValue) then exit;
  FbinaryLogEnabled:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupConfiguration.Setenabled(AIndex : Integer; const AValue : boolean); 

begin
  If (Fenabled=AValue) then exit;
  Fenabled:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupConfiguration.SetstartTime(AIndex : Integer; const AValue : String); 

begin
  If (FstartTime=AValue) then exit;
  FstartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TBackupRun
  --------------------------------------------------------------------}


Procedure TBackupRun.SetendTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FendTime=AValue) then exit;
  FendTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.SetenqueuedTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FenqueuedTime=AValue) then exit;
  FenqueuedTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.Seterror(AIndex : Integer; const AValue : TOperationError); 

begin
  If (Ferror=AValue) then exit;
  Ferror:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.SetstartTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FstartTime=AValue) then exit;
  FstartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRun.SetwindowStartTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FwindowStartTime=AValue) then exit;
  FwindowStartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TBackupRunsListResponse
  --------------------------------------------------------------------}


Procedure TBackupRunsListResponse.Setitems(AIndex : Integer; const AValue : TBackupRunsListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRunsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackupRunsListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TBackupRunsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TBinLogCoordinates
  --------------------------------------------------------------------}


Procedure TBinLogCoordinates.SetbinLogFileName(AIndex : Integer; const AValue : String); 

begin
  If (FbinLogFileName=AValue) then exit;
  FbinLogFileName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBinLogCoordinates.SetbinLogPosition(AIndex : Integer; const AValue : String); 

begin
  If (FbinLogPosition=AValue) then exit;
  FbinLogPosition:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBinLogCoordinates.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TCloneContext
  --------------------------------------------------------------------}


Procedure TCloneContext.SetbinLogCoordinates(AIndex : Integer; const AValue : TBinLogCoordinates); 

begin
  If (FbinLogCoordinates=AValue) then exit;
  FbinLogCoordinates:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCloneContext.SetdestinationInstanceName(AIndex : Integer; const AValue : String); 

begin
  If (FdestinationInstanceName=AValue) then exit;
  FdestinationInstanceName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCloneContext.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDatabase
  --------------------------------------------------------------------}


Procedure TDatabase.Setcharset(AIndex : Integer; const AValue : String); 

begin
  If (Fcharset=AValue) then exit;
  Fcharset:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setcollation(AIndex : Integer; const AValue : String); 

begin
  If (Fcollation=AValue) then exit;
  Fcollation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.Setproject(AIndex : Integer; const AValue : String); 

begin
  If (Fproject=AValue) then exit;
  Fproject:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabase.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDatabaseFlags
  --------------------------------------------------------------------}


Procedure TDatabaseFlags.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseFlags.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDatabaseInstanceTypefailoverReplica
  --------------------------------------------------------------------}


Procedure TDatabaseInstanceTypefailoverReplica.Setavailable(AIndex : Integer; const AValue : boolean); 

begin
  If (Favailable=AValue) then exit;
  Favailable:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstanceTypefailoverReplica.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDatabaseInstance
  --------------------------------------------------------------------}


Procedure TDatabaseInstance.SetbackendType(AIndex : Integer; const AValue : String); 

begin
  If (FbackendType=AValue) then exit;
  FbackendType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetcurrentDiskSize(AIndex : Integer; const AValue : String); 

begin
  If (FcurrentDiskSize=AValue) then exit;
  FcurrentDiskSize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetdatabaseVersion(AIndex : Integer; const AValue : String); 

begin
  If (FdatabaseVersion=AValue) then exit;
  FdatabaseVersion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetfailoverReplica(AIndex : Integer; const AValue : TDatabaseInstanceTypefailoverReplica); 

begin
  If (FfailoverReplica=AValue) then exit;
  FfailoverReplica:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetinstanceType(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceType=AValue) then exit;
  FinstanceType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetipAddresses(AIndex : Integer; const AValue : TDatabaseInstanceTypeipAddressesArray); 

begin
  If (FipAddresses=AValue) then exit;
  FipAddresses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setipv6Address(AIndex : Integer; const AValue : String); 

begin
  If (Fipv6Address=AValue) then exit;
  Fipv6Address:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetmasterInstanceName(AIndex : Integer; const AValue : String); 

begin
  If (FmasterInstanceName=AValue) then exit;
  FmasterInstanceName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetmaxDiskSize(AIndex : Integer; const AValue : String); 

begin
  If (FmaxDiskSize=AValue) then exit;
  FmaxDiskSize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetonPremisesConfiguration(AIndex : Integer; const AValue : TOnPremisesConfiguration); 

begin
  If (FonPremisesConfiguration=AValue) then exit;
  FonPremisesConfiguration:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setproject(AIndex : Integer; const AValue : String); 

begin
  If (Fproject=AValue) then exit;
  Fproject:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetreplicaConfiguration(AIndex : Integer; const AValue : TReplicaConfiguration); 

begin
  If (FreplicaConfiguration=AValue) then exit;
  FreplicaConfiguration:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetreplicaNames(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FreplicaNames=AValue) then exit;
  FreplicaNames:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetserverCaCert(AIndex : Integer; const AValue : TSslCert); 

begin
  If (FserverCaCert=AValue) then exit;
  FserverCaCert:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetserviceAccountEmailAddress(AIndex : Integer; const AValue : String); 

begin
  If (FserviceAccountEmailAddress=AValue) then exit;
  FserviceAccountEmailAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setsettings(AIndex : Integer; const AValue : TSettings); 

begin
  If (Fsettings=AValue) then exit;
  Fsettings:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.Setstate(AIndex : Integer; const AValue : String); 

begin
  If (Fstate=AValue) then exit;
  Fstate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabaseInstance.SetsuspensionReason(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FsuspensionReason=AValue) then exit;
  FsuspensionReason:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDatabaseInstance.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'ipaddresses' : SetLength(FipAddresses,ALength);
  'replicanames' : SetLength(FreplicaNames,ALength);
  'suspensionreason' : SetLength(FsuspensionReason,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDatabasesListResponse
  --------------------------------------------------------------------}


Procedure TDatabasesListResponse.Setitems(AIndex : Integer; const AValue : TDatabasesListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDatabasesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDatabasesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TExportContextTypecsvExportOptions
  --------------------------------------------------------------------}


Procedure TExportContextTypecsvExportOptions.SetselectQuery(AIndex : Integer; const AValue : String); 

begin
  If (FselectQuery=AValue) then exit;
  FselectQuery:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TExportContextTypesqlExportOptions
  --------------------------------------------------------------------}


Procedure TExportContextTypesqlExportOptions.SetschemaOnly(AIndex : Integer; const AValue : boolean); 

begin
  If (FschemaOnly=AValue) then exit;
  FschemaOnly:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContextTypesqlExportOptions.Settables(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Ftables=AValue) then exit;
  Ftables:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TExportContextTypesqlExportOptions.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'tables' : SetLength(Ftables,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TExportContext
  --------------------------------------------------------------------}


Procedure TExportContext.SetcsvExportOptions(AIndex : Integer; const AValue : TExportContextTypecsvExportOptions); 

begin
  If (FcsvExportOptions=AValue) then exit;
  FcsvExportOptions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContext.Setdatabases(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fdatabases=AValue) then exit;
  Fdatabases:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContext.SetfileType(AIndex : Integer; const AValue : String); 

begin
  If (FfileType=AValue) then exit;
  FfileType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContext.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContext.SetsqlExportOptions(AIndex : Integer; const AValue : TExportContextTypesqlExportOptions); 

begin
  If (FsqlExportOptions=AValue) then exit;
  FsqlExportOptions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TExportContext.Seturi(AIndex : Integer; const AValue : String); 

begin
  If (Furi=AValue) then exit;
  Furi:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TExportContext.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'databases' : SetLength(Fdatabases,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFailoverContext
  --------------------------------------------------------------------}


Procedure TFailoverContext.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFailoverContext.SetsettingsVersion(AIndex : Integer; const AValue : String); 

begin
  If (FsettingsVersion=AValue) then exit;
  FsettingsVersion:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TFlag
  --------------------------------------------------------------------}


Procedure TFlag.SetallowedStringValues(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FallowedStringValues=AValue) then exit;
  FallowedStringValues:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.SetappliesTo(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FappliesTo=AValue) then exit;
  FappliesTo:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.SetmaxValue(AIndex : Integer; const AValue : String); 

begin
  If (FmaxValue=AValue) then exit;
  FmaxValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.SetminValue(AIndex : Integer; const AValue : String); 

begin
  If (FminValue=AValue) then exit;
  FminValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.SetrequiresRestart(AIndex : Integer; const AValue : boolean); 

begin
  If (FrequiresRestart=AValue) then exit;
  FrequiresRestart:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlag.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TFlag.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFlag.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'allowedstringvalues' : SetLength(FallowedStringValues,ALength);
  'appliesto' : SetLength(FappliesTo,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFlagsListResponse
  --------------------------------------------------------------------}


Procedure TFlagsListResponse.Setitems(AIndex : Integer; const AValue : TFlagsListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFlagsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFlagsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TImportContextTypecsvImportOptions
  --------------------------------------------------------------------}


Procedure TImportContextTypecsvImportOptions.Setcolumns(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fcolumns=AValue) then exit;
  Fcolumns:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImportContextTypecsvImportOptions.Settable(AIndex : Integer; const AValue : String); 

begin
  If (Ftable=AValue) then exit;
  Ftable:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TImportContextTypecsvImportOptions.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'columns' : SetLength(Fcolumns,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TImportContext
  --------------------------------------------------------------------}


Procedure TImportContext.SetcsvImportOptions(AIndex : Integer; const AValue : TImportContextTypecsvImportOptions); 

begin
  If (FcsvImportOptions=AValue) then exit;
  FcsvImportOptions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImportContext.Setdatabase(AIndex : Integer; const AValue : String); 

begin
  If (Fdatabase=AValue) then exit;
  Fdatabase:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImportContext.SetfileType(AIndex : Integer; const AValue : String); 

begin
  If (FfileType=AValue) then exit;
  FfileType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImportContext.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImportContext.Seturi(AIndex : Integer; const AValue : String); 

begin
  If (Furi=AValue) then exit;
  Furi:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesCloneRequest
  --------------------------------------------------------------------}


Procedure TInstancesCloneRequest.SetcloneContext(AIndex : Integer; const AValue : TCloneContext); 

begin
  If (FcloneContext=AValue) then exit;
  FcloneContext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesExportRequest
  --------------------------------------------------------------------}


Procedure TInstancesExportRequest.SetexportContext(AIndex : Integer; const AValue : TExportContext); 

begin
  If (FexportContext=AValue) then exit;
  FexportContext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesFailoverRequest
  --------------------------------------------------------------------}


Procedure TInstancesFailoverRequest.SetfailoverContext(AIndex : Integer; const AValue : TFailoverContext); 

begin
  If (FfailoverContext=AValue) then exit;
  FfailoverContext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesImportRequest
  --------------------------------------------------------------------}


Procedure TInstancesImportRequest.SetimportContext(AIndex : Integer; const AValue : TImportContext); 

begin
  If (FimportContext=AValue) then exit;
  FimportContext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesListResponse
  --------------------------------------------------------------------}


Procedure TInstancesListResponse.Setitems(AIndex : Integer; const AValue : TInstancesListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstancesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstancesRestoreBackupRequest
  --------------------------------------------------------------------}


Procedure TInstancesRestoreBackupRequest.SetrestoreBackupContext(AIndex : Integer; const AValue : TRestoreBackupContext); 

begin
  If (FrestoreBackupContext=AValue) then exit;
  FrestoreBackupContext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TIpConfiguration
  --------------------------------------------------------------------}


Procedure TIpConfiguration.SetauthorizedNetworks(AIndex : Integer; const AValue : TIpConfigurationTypeauthorizedNetworksArray); 

begin
  If (FauthorizedNetworks=AValue) then exit;
  FauthorizedNetworks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TIpConfiguration.Setipv4Enabled(AIndex : Integer; const AValue : boolean); 

begin
  If (Fipv4Enabled=AValue) then exit;
  Fipv4Enabled:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TIpConfiguration.SetrequireSsl(AIndex : Integer; const AValue : boolean); 

begin
  If (FrequireSsl=AValue) then exit;
  FrequireSsl:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TIpConfiguration.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'authorizednetworks' : SetLength(FauthorizedNetworks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TIpMapping
  --------------------------------------------------------------------}


Procedure TIpMapping.SetipAddress(AIndex : Integer; const AValue : String); 

begin
  If (FipAddress=AValue) then exit;
  FipAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TIpMapping.SettimeToRetire(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FtimeToRetire=AValue) then exit;
  FtimeToRetire:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TLocationPreference
  --------------------------------------------------------------------}


Procedure TLocationPreference.SetfollowGaeApplication(AIndex : Integer; const AValue : String); 

begin
  If (FfollowGaeApplication=AValue) then exit;
  FfollowGaeApplication:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocationPreference.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocationPreference.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMaintenanceWindow
  --------------------------------------------------------------------}


Procedure TMaintenanceWindow.Setday(AIndex : Integer; const AValue : integer); 

begin
  If (Fday=AValue) then exit;
  Fday:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMaintenanceWindow.Sethour(AIndex : Integer; const AValue : integer); 

begin
  If (Fhour=AValue) then exit;
  Fhour:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMaintenanceWindow.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMaintenanceWindow.SetupdateTrack(AIndex : Integer; const AValue : String); 

begin
  If (FupdateTrack=AValue) then exit;
  FupdateTrack:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMySqlReplicaConfiguration
  --------------------------------------------------------------------}


Procedure TMySqlReplicaConfiguration.SetcaCertificate(AIndex : Integer; const AValue : String); 

begin
  If (FcaCertificate=AValue) then exit;
  FcaCertificate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetclientCertificate(AIndex : Integer; const AValue : String); 

begin
  If (FclientCertificate=AValue) then exit;
  FclientCertificate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetclientKey(AIndex : Integer; const AValue : String); 

begin
  If (FclientKey=AValue) then exit;
  FclientKey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetconnectRetryInterval(AIndex : Integer; const AValue : integer); 

begin
  If (FconnectRetryInterval=AValue) then exit;
  FconnectRetryInterval:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetdumpFilePath(AIndex : Integer; const AValue : String); 

begin
  If (FdumpFilePath=AValue) then exit;
  FdumpFilePath:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetmasterHeartbeatPeriod(AIndex : Integer; const AValue : String); 

begin
  If (FmasterHeartbeatPeriod=AValue) then exit;
  FmasterHeartbeatPeriod:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.Setpassword(AIndex : Integer; const AValue : String); 

begin
  If (Fpassword=AValue) then exit;
  Fpassword:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetsslCipher(AIndex : Integer; const AValue : String); 

begin
  If (FsslCipher=AValue) then exit;
  FsslCipher:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.Setusername(AIndex : Integer; const AValue : String); 

begin
  If (Fusername=AValue) then exit;
  Fusername:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMySqlReplicaConfiguration.SetverifyServerCertificate(AIndex : Integer; const AValue : boolean); 

begin
  If (FverifyServerCertificate=AValue) then exit;
  FverifyServerCertificate:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOnPremisesConfiguration
  --------------------------------------------------------------------}


Procedure TOnPremisesConfiguration.SethostPort(AIndex : Integer; const AValue : String); 

begin
  If (FhostPort=AValue) then exit;
  FhostPort:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOnPremisesConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperation
  --------------------------------------------------------------------}


Procedure TOperation.SetendTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FendTime=AValue) then exit;
  FendTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Seterror(AIndex : Integer; const AValue : TOperationErrors); 

begin
  If (Ferror=AValue) then exit;
  Ferror:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetexportContext(AIndex : Integer; const AValue : TExportContext); 

begin
  If (FexportContext=AValue) then exit;
  FexportContext:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetimportContext(AIndex : Integer; const AValue : TImportContext); 

begin
  If (FimportContext=AValue) then exit;
  FimportContext:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetinsertTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FinsertTime=AValue) then exit;
  FinsertTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetoperationType(AIndex : Integer; const AValue : String); 

begin
  If (FoperationType=AValue) then exit;
  FoperationType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetstartTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FstartTime=AValue) then exit;
  FstartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SettargetId(AIndex : Integer; const AValue : String); 

begin
  If (FtargetId=AValue) then exit;
  FtargetId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SettargetLink(AIndex : Integer; const AValue : String); 

begin
  If (FtargetLink=AValue) then exit;
  FtargetLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SettargetProject(AIndex : Integer; const AValue : String); 

begin
  If (FtargetProject=AValue) then exit;
  FtargetProject:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setuser(AIndex : Integer; const AValue : String); 

begin
  If (Fuser=AValue) then exit;
  Fuser:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationError
  --------------------------------------------------------------------}


Procedure TOperationError.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationError.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationError.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationErrors
  --------------------------------------------------------------------}


Procedure TOperationErrors.Seterrors(AIndex : Integer; const AValue : TOperationErrorsTypeerrorsArray); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationErrors.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationErrors.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'errors' : SetLength(Ferrors,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationsListResponse
  --------------------------------------------------------------------}


Procedure TOperationsListResponse.Setitems(AIndex : Integer; const AValue : TOperationsListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TReplicaConfiguration
  --------------------------------------------------------------------}


Procedure TReplicaConfiguration.SetfailoverTarget(AIndex : Integer; const AValue : boolean); 

begin
  If (FfailoverTarget=AValue) then exit;
  FfailoverTarget:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReplicaConfiguration.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TReplicaConfiguration.SetmysqlReplicaConfiguration(AIndex : Integer; const AValue : TMySqlReplicaConfiguration); 

begin
  If (FmysqlReplicaConfiguration=AValue) then exit;
  FmysqlReplicaConfiguration:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TRestoreBackupContext
  --------------------------------------------------------------------}


Procedure TRestoreBackupContext.SetbackupRunId(AIndex : Integer; const AValue : String); 

begin
  If (FbackupRunId=AValue) then exit;
  FbackupRunId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRestoreBackupContext.SetinstanceId(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceId=AValue) then exit;
  FinstanceId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRestoreBackupContext.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSettings
  --------------------------------------------------------------------}


Procedure TSettings.SetactivationPolicy(AIndex : Integer; const AValue : String); 

begin
  If (FactivationPolicy=AValue) then exit;
  FactivationPolicy:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetauthorizedGaeApplications(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FauthorizedGaeApplications=AValue) then exit;
  FauthorizedGaeApplications:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetbackupConfiguration(AIndex : Integer; const AValue : TBackupConfiguration); 

begin
  If (FbackupConfiguration=AValue) then exit;
  FbackupConfiguration:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetcrashSafeReplicationEnabled(AIndex : Integer; const AValue : boolean); 

begin
  If (FcrashSafeReplicationEnabled=AValue) then exit;
  FcrashSafeReplicationEnabled:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetdataDiskSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FdataDiskSizeGb=AValue) then exit;
  FdataDiskSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetdataDiskType(AIndex : Integer; const AValue : String); 

begin
  If (FdataDiskType=AValue) then exit;
  FdataDiskType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetdatabaseFlags(AIndex : Integer; const AValue : TSettingsTypedatabaseFlagsArray); 

begin
  If (FdatabaseFlags=AValue) then exit;
  FdatabaseFlags:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetdatabaseReplicationEnabled(AIndex : Integer; const AValue : boolean); 

begin
  If (FdatabaseReplicationEnabled=AValue) then exit;
  FdatabaseReplicationEnabled:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetipConfiguration(AIndex : Integer; const AValue : TIpConfiguration); 

begin
  If (FipConfiguration=AValue) then exit;
  FipConfiguration:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetlocationPreference(AIndex : Integer; const AValue : TLocationPreference); 

begin
  If (FlocationPreference=AValue) then exit;
  FlocationPreference:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetmaintenanceWindow(AIndex : Integer; const AValue : TMaintenanceWindow); 

begin
  If (FmaintenanceWindow=AValue) then exit;
  FmaintenanceWindow:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetpricingPlan(AIndex : Integer; const AValue : String); 

begin
  If (FpricingPlan=AValue) then exit;
  FpricingPlan:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetreplicationType(AIndex : Integer; const AValue : String); 

begin
  If (FreplicationType=AValue) then exit;
  FreplicationType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetsettingsVersion(AIndex : Integer; const AValue : String); 

begin
  If (FsettingsVersion=AValue) then exit;
  FsettingsVersion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetstorageAutoResize(AIndex : Integer; const AValue : boolean); 

begin
  If (FstorageAutoResize=AValue) then exit;
  FstorageAutoResize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.Settier(AIndex : Integer; const AValue : String); 

begin
  If (Ftier=AValue) then exit;
  Ftier:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSettings.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'authorizedgaeapplications' : SetLength(FauthorizedGaeApplications,ALength);
  'databaseflags' : SetLength(FdatabaseFlags,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSslCert
  --------------------------------------------------------------------}


Procedure TSslCert.Setcert(AIndex : Integer; const AValue : String); 

begin
  If (Fcert=AValue) then exit;
  Fcert:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.SetcertSerialNumber(AIndex : Integer; const AValue : String); 

begin
  If (FcertSerialNumber=AValue) then exit;
  FcertSerialNumber:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.SetcommonName(AIndex : Integer; const AValue : String); 

begin
  If (FcommonName=AValue) then exit;
  FcommonName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.SetcreateTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FcreateTime=AValue) then exit;
  FcreateTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.SetexpirationTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FexpirationTime=AValue) then exit;
  FexpirationTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCert.Setsha1Fingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Fsha1Fingerprint=AValue) then exit;
  Fsha1Fingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertDetail
  --------------------------------------------------------------------}


Procedure TSslCertDetail.SetcertInfo(AIndex : Integer; const AValue : TSslCert); 

begin
  If (FcertInfo=AValue) then exit;
  FcertInfo:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertDetail.SetcertPrivateKey(AIndex : Integer; const AValue : String); 

begin
  If (FcertPrivateKey=AValue) then exit;
  FcertPrivateKey:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertsCreateEphemeralRequest
  --------------------------------------------------------------------}


Procedure TSslCertsCreateEphemeralRequest.Setpublic_key(AIndex : Integer; const AValue : String); 

begin
  If (Fpublic_key=AValue) then exit;
  Fpublic_key:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertsInsertRequest
  --------------------------------------------------------------------}


Procedure TSslCertsInsertRequest.SetcommonName(AIndex : Integer; const AValue : String); 

begin
  If (FcommonName=AValue) then exit;
  FcommonName:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertsInsertResponse
  --------------------------------------------------------------------}


Procedure TSslCertsInsertResponse.SetclientCert(AIndex : Integer; const AValue : TSslCertDetail); 

begin
  If (FclientCert=AValue) then exit;
  FclientCert:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertsInsertResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertsInsertResponse.Setoperation(AIndex : Integer; const AValue : TOperation); 

begin
  If (Foperation=AValue) then exit;
  Foperation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertsInsertResponse.SetserverCaCert(AIndex : Integer; const AValue : TSslCert); 

begin
  If (FserverCaCert=AValue) then exit;
  FserverCaCert:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertsListResponse
  --------------------------------------------------------------------}


Procedure TSslCertsListResponse.Setitems(AIndex : Integer; const AValue : TSslCertsListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSslCertsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTier
  --------------------------------------------------------------------}


Procedure TTier.SetDiskQuota(AIndex : Integer; const AValue : String); 

begin
  If (FDiskQuota=AValue) then exit;
  FDiskQuota:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTier.SetRAM(AIndex : Integer; const AValue : String); 

begin
  If (FRAM=AValue) then exit;
  FRAM:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTier.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTier.Setregion(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTier.Settier(AIndex : Integer; const AValue : String); 

begin
  If (Ftier=AValue) then exit;
  Ftier:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTier.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'region' : SetLength(Fregion,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTiersListResponse
  --------------------------------------------------------------------}


Procedure TTiersListResponse.Setitems(AIndex : Integer; const AValue : TTiersListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTiersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTiersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUser
  --------------------------------------------------------------------}


Procedure TUser.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Sethost(AIndex : Integer; const AValue : String); 

begin
  If (Fhost=AValue) then exit;
  Fhost:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setpassword(AIndex : Integer; const AValue : String); 

begin
  If (Fpassword=AValue) then exit;
  Fpassword:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setproject(AIndex : Integer; const AValue : String); 

begin
  If (Fproject=AValue) then exit;
  Fproject:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUsersListResponse
  --------------------------------------------------------------------}


Procedure TUsersListResponse.Setitems(AIndex : Integer; const AValue : TUsersListResponseTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsersListResponse.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TBackupRunsResource
  --------------------------------------------------------------------}


Class Function TBackupRunsResource.ResourceName : String;

begin
  Result:='backupRuns';
end;

Class Function TBackupRunsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TBackupRunsResource.Delete(id: string; instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'projects/{project}/instances/{instance}/backupRuns/{id}';
  _Methodid   = 'sql.backupRuns.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['id',id,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TBackupRunsResource.Get(id: string; instance: string; project: string) : TBackupRun;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/backupRuns/{id}';
  _Methodid   = 'sql.backupRuns.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['id',id,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TBackupRun) as TBackupRun;
end;

Function TBackupRunsResource.List(instance: string; project: string; AQuery : string = '') : TBackupRunsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/backupRuns';
  _Methodid   = 'sql.backupRuns.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TBackupRunsListResponse) as TBackupRunsListResponse;
end;


Function TBackupRunsResource.List(instance: string; project: string; AQuery : TBackupRunslistOptions) : TBackupRunsListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(instance,project,_Q);
end;



{ --------------------------------------------------------------------
  TDatabasesResource
  --------------------------------------------------------------------}


Class Function TDatabasesResource.ResourceName : String;

begin
  Result:='databases';
end;

Class Function TDatabasesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TDatabasesResource.Delete(database: string; instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'projects/{project}/instances/{instance}/databases/{database}';
  _Methodid   = 'sql.databases.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['database',database,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TDatabasesResource.Get(database: string; instance: string; project: string) : TDatabase;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/databases/{database}';
  _Methodid   = 'sql.databases.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['database',database,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDatabase) as TDatabase;
end;

Function TDatabasesResource.Insert(instance: string; project: string; aDatabase : TDatabase) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/databases';
  _Methodid   = 'sql.databases.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabase,TOperation) as TOperation;
end;

Function TDatabasesResource.List(instance: string; project: string) : TDatabasesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/databases';
  _Methodid   = 'sql.databases.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDatabasesListResponse) as TDatabasesListResponse;
end;

Function TDatabasesResource.Patch(database: string; instance: string; project: string; aDatabase : TDatabase) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'projects/{project}/instances/{instance}/databases/{database}';
  _Methodid   = 'sql.databases.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['database',database,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabase,TOperation) as TOperation;
end;

Function TDatabasesResource.Update(database: string; instance: string; project: string; aDatabase : TDatabase) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'projects/{project}/instances/{instance}/databases/{database}';
  _Methodid   = 'sql.databases.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['database',database,'instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabase,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TFlagsResource
  --------------------------------------------------------------------}


Class Function TFlagsResource.ResourceName : String;

begin
  Result:='flags';
end;

Class Function TFlagsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TFlagsResource.List : TFlagsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'flags';
  _Methodid   = 'sql.flags.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,'',Nil,TFlagsListResponse) as TFlagsListResponse;
end;



{ --------------------------------------------------------------------
  TInstancesResource
  --------------------------------------------------------------------}


Class Function TInstancesResource.ResourceName : String;

begin
  Result:='instances';
end;

Class Function TInstancesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TInstancesResource.Clone(instance: string; project: string; aInstancesCloneRequest : TInstancesCloneRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/clone';
  _Methodid   = 'sql.instances.clone';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesCloneRequest,TOperation) as TOperation;
end;

Function TInstancesResource.Delete(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'projects/{project}/instances/{instance}';
  _Methodid   = 'sql.instances.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.Export(instance: string; project: string; aInstancesExportRequest : TInstancesExportRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/export';
  _Methodid   = 'sql.instances.export';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesExportRequest,TOperation) as TOperation;
end;

Function TInstancesResource.Failover(instance: string; project: string; aInstancesFailoverRequest : TInstancesFailoverRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/failover';
  _Methodid   = 'sql.instances.failover';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesFailoverRequest,TOperation) as TOperation;
end;

Function TInstancesResource.Get(instance: string; project: string) : TDatabaseInstance;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}';
  _Methodid   = 'sql.instances.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDatabaseInstance) as TDatabaseInstance;
end;

Function TInstancesResource.Import(instance: string; project: string; aInstancesImportRequest : TInstancesImportRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/import';
  _Methodid   = 'sql.instances.import';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesImportRequest,TOperation) as TOperation;
end;

Function TInstancesResource.Insert(project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances';
  _Methodid   = 'sql.instances.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabaseInstance,TOperation) as TOperation;
end;

Function TInstancesResource.List(project: string; AQuery : string = '') : TInstancesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances';
  _Methodid   = 'sql.instances.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstancesListResponse) as TInstancesListResponse;
end;


Function TInstancesResource.List(project: string; AQuery : TInstanceslistOptions) : TInstancesListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TInstancesResource.Patch(instance: string; project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'projects/{project}/instances/{instance}';
  _Methodid   = 'sql.instances.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabaseInstance,TOperation) as TOperation;
end;

Function TInstancesResource.PromoteReplica(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/promoteReplica';
  _Methodid   = 'sql.instances.promoteReplica';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.ResetSslConfig(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/resetSslConfig';
  _Methodid   = 'sql.instances.resetSslConfig';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.Restart(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/restart';
  _Methodid   = 'sql.instances.restart';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.RestoreBackup(instance: string; project: string; aInstancesRestoreBackupRequest : TInstancesRestoreBackupRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/restoreBackup';
  _Methodid   = 'sql.instances.restoreBackup';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesRestoreBackupRequest,TOperation) as TOperation;
end;

Function TInstancesResource.StartReplica(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/startReplica';
  _Methodid   = 'sql.instances.startReplica';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.StopReplica(instance: string; project: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/stopReplica';
  _Methodid   = 'sql.instances.stopReplica';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.Update(instance: string; project: string; aDatabaseInstance : TDatabaseInstance) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'projects/{project}/instances/{instance}';
  _Methodid   = 'sql.instances.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDatabaseInstance,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TOperationsResource
  --------------------------------------------------------------------}


Class Function TOperationsResource.ResourceName : String;

begin
  Result:='operations';
end;

Class Function TOperationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TOperationsResource.Get(operation: string; project: string) : TOperation;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/operations/{operation}';
  _Methodid   = 'sql.operations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TOperationsResource.List(project: string; AQuery : string = '') : TOperationsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/operations';
  _Methodid   = 'sql.operations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperationsListResponse) as TOperationsListResponse;
end;


Function TOperationsResource.List(project: string; AQuery : TOperationslistOptions) : TOperationsListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'instance',AQuery.instance);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TSslCertsResource
  --------------------------------------------------------------------}


Class Function TSslCertsResource.ResourceName : String;

begin
  Result:='sslCerts';
end;

Class Function TSslCertsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TSslCertsResource.CreateEphemeral(instance: string; project: string; aSslCertsCreateEphemeralRequest : TSslCertsCreateEphemeralRequest) : TSslCert;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/createEphemeral';
  _Methodid   = 'sql.sslCerts.createEphemeral';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aSslCertsCreateEphemeralRequest,TSslCert) as TSslCert;
end;

Function TSslCertsResource.Delete(instance: string; project: string; sha1Fingerprint: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'projects/{project}/instances/{instance}/sslCerts/{sha1Fingerprint}';
  _Methodid   = 'sql.sslCerts.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'sha1Fingerprint',sha1Fingerprint]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TSslCertsResource.Get(instance: string; project: string; sha1Fingerprint: string) : TSslCert;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/sslCerts/{sha1Fingerprint}';
  _Methodid   = 'sql.sslCerts.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'sha1Fingerprint',sha1Fingerprint]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSslCert) as TSslCert;
end;

Function TSslCertsResource.Insert(instance: string; project: string; aSslCertsInsertRequest : TSslCertsInsertRequest) : TSslCertsInsertResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/sslCerts';
  _Methodid   = 'sql.sslCerts.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aSslCertsInsertRequest,TSslCertsInsertResponse) as TSslCertsInsertResponse;
end;

Function TSslCertsResource.List(instance: string; project: string) : TSslCertsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/sslCerts';
  _Methodid   = 'sql.sslCerts.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSslCertsListResponse) as TSslCertsListResponse;
end;



{ --------------------------------------------------------------------
  TTiersResource
  --------------------------------------------------------------------}


Class Function TTiersResource.ResourceName : String;

begin
  Result:='tiers';
end;

Class Function TTiersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TTiersResource.List(project: string) : TTiersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/tiers';
  _Methodid   = 'sql.tiers.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTiersListResponse) as TTiersListResponse;
end;



{ --------------------------------------------------------------------
  TUsersResource
  --------------------------------------------------------------------}


Class Function TUsersResource.ResourceName : String;

begin
  Result:='users';
end;

Class Function TUsersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TsqladminAPI;
end;

Function TUsersResource.Delete(instance: string; project: string; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'projects/{project}/instances/{instance}/users';
  _Methodid   = 'sql.users.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperation) as TOperation;
end;


Function TUsersResource.Delete(instance: string; project: string; AQuery : TUsersdeleteOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'host',AQuery.host);
  AddToQuery(_Q,'name',AQuery._name);
  Result:=Delete(instance,project,_Q);
end;

Function TUsersResource.Insert(instance: string; project: string; aUser : TUser) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = 'projects/{project}/instances/{instance}/users';
  _Methodid   = 'sql.users.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUser,TOperation) as TOperation;
end;

Function TUsersResource.List(instance: string; project: string) : TUsersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'projects/{project}/instances/{instance}/users';
  _Methodid   = 'sql.users.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUsersListResponse) as TUsersListResponse;
end;

Function TUsersResource.Update(instance: string; project: string; aUser : TUser; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'projects/{project}/instances/{instance}/users';
  _Methodid   = 'sql.users.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aUser,TOperation) as TOperation;
end;


Function TUsersResource.Update(instance: string; project: string; aUser : TUser; AQuery : TUsersupdateOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'host',AQuery.host);
  AddToQuery(_Q,'name',AQuery._name);
  Result:=Update(instance,project,aUser,_Q);
end;



{ --------------------------------------------------------------------
  TSqladminAPI
  --------------------------------------------------------------------}

Class Function TSqladminAPI.APIName : String;

begin
  Result:='sqladmin';
end;

Class Function TSqladminAPI.APIVersion : String;

begin
  Result:='v1beta4';
end;

Class Function TSqladminAPI.APIRevision : String;

begin
  Result:='20160509';
end;

Class Function TSqladminAPI.APIID : String;

begin
  Result:='sqladmin:v1beta4';
end;

Class Function TSqladminAPI.APITitle : String;

begin
  Result:='Cloud SQL Administration API';
end;

Class Function TSqladminAPI.APIDescription : String;

begin
  Result:='Creates and configures Cloud SQL instances, which provide fully-managed MySQL databases.';
end;

Class Function TSqladminAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TSqladminAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TSqladminAPI.APIIcon16 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-16.gif';
end;

Class Function TSqladminAPI.APIIcon32 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-32.gif';
end;

Class Function TSqladminAPI.APIdocumentationLink : String;

begin
  Result:='https://cloud.google.com/sql/docs/reference/latest';
end;

Class Function TSqladminAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TSqladminAPI.APIbasePath : string;

begin
  Result:='/sql/v1beta4/';
end;

Class Function TSqladminAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/sql/v1beta4/';
end;

Class Function TSqladminAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TSqladminAPI.APIservicePath : string;

begin
  Result:='sql/v1beta4/';
end;

Class Function TSqladminAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TSqladminAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,2);
  Result[0].Name:='https://www.googleapis.com/auth/cloud-platform';
  Result[0].Description:='View and manage your data across Google Cloud Platform services';
  Result[1].Name:='https://www.googleapis.com/auth/sqlservice.admin';
  Result[1].Description:='Manage your Google SQL Service instances';
  
end;

Class Function TSqladminAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TSqladminAPI.RegisterAPIResources;

begin
  TAclEntry.RegisterObject;
  TBackupConfiguration.RegisterObject;
  TBackupRun.RegisterObject;
  TBackupRunsListResponse.RegisterObject;
  TBinLogCoordinates.RegisterObject;
  TCloneContext.RegisterObject;
  TDatabase.RegisterObject;
  TDatabaseFlags.RegisterObject;
  TDatabaseInstanceTypefailoverReplica.RegisterObject;
  TDatabaseInstance.RegisterObject;
  TDatabasesListResponse.RegisterObject;
  TExportContextTypecsvExportOptions.RegisterObject;
  TExportContextTypesqlExportOptions.RegisterObject;
  TExportContext.RegisterObject;
  TFailoverContext.RegisterObject;
  TFlag.RegisterObject;
  TFlagsListResponse.RegisterObject;
  TImportContextTypecsvImportOptions.RegisterObject;
  TImportContext.RegisterObject;
  TInstancesCloneRequest.RegisterObject;
  TInstancesExportRequest.RegisterObject;
  TInstancesFailoverRequest.RegisterObject;
  TInstancesImportRequest.RegisterObject;
  TInstancesListResponse.RegisterObject;
  TInstancesRestoreBackupRequest.RegisterObject;
  TIpConfiguration.RegisterObject;
  TIpMapping.RegisterObject;
  TLocationPreference.RegisterObject;
  TMaintenanceWindow.RegisterObject;
  TMySqlReplicaConfiguration.RegisterObject;
  TOnPremisesConfiguration.RegisterObject;
  TOperation.RegisterObject;
  TOperationError.RegisterObject;
  TOperationErrors.RegisterObject;
  TOperationsListResponse.RegisterObject;
  TReplicaConfiguration.RegisterObject;
  TRestoreBackupContext.RegisterObject;
  TSettings.RegisterObject;
  TSslCert.RegisterObject;
  TSslCertDetail.RegisterObject;
  TSslCertsCreateEphemeralRequest.RegisterObject;
  TSslCertsInsertRequest.RegisterObject;
  TSslCertsInsertResponse.RegisterObject;
  TSslCertsListResponse.RegisterObject;
  TTier.RegisterObject;
  TTiersListResponse.RegisterObject;
  TUser.RegisterObject;
  TUsersListResponse.RegisterObject;
end;


Function TSqladminAPI.GetBackupRunsInstance : TBackupRunsResource;

begin
  if (FBackupRunsInstance=Nil) then
    FBackupRunsInstance:=CreateBackupRunsResource;
  Result:=FBackupRunsInstance;
end;

Function TSqladminAPI.CreateBackupRunsResource : TBackupRunsResource;

begin
  Result:=CreateBackupRunsResource(Self);
end;


Function TSqladminAPI.CreateBackupRunsResource(AOwner : TComponent) : TBackupRunsResource;

begin
  Result:=TBackupRunsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetDatabasesInstance : TDatabasesResource;

begin
  if (FDatabasesInstance=Nil) then
    FDatabasesInstance:=CreateDatabasesResource;
  Result:=FDatabasesInstance;
end;

Function TSqladminAPI.CreateDatabasesResource : TDatabasesResource;

begin
  Result:=CreateDatabasesResource(Self);
end;


Function TSqladminAPI.CreateDatabasesResource(AOwner : TComponent) : TDatabasesResource;

begin
  Result:=TDatabasesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetFlagsInstance : TFlagsResource;

begin
  if (FFlagsInstance=Nil) then
    FFlagsInstance:=CreateFlagsResource;
  Result:=FFlagsInstance;
end;

Function TSqladminAPI.CreateFlagsResource : TFlagsResource;

begin
  Result:=CreateFlagsResource(Self);
end;


Function TSqladminAPI.CreateFlagsResource(AOwner : TComponent) : TFlagsResource;

begin
  Result:=TFlagsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetInstancesInstance : TInstancesResource;

begin
  if (FInstancesInstance=Nil) then
    FInstancesInstance:=CreateInstancesResource;
  Result:=FInstancesInstance;
end;

Function TSqladminAPI.CreateInstancesResource : TInstancesResource;

begin
  Result:=CreateInstancesResource(Self);
end;


Function TSqladminAPI.CreateInstancesResource(AOwner : TComponent) : TInstancesResource;

begin
  Result:=TInstancesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetOperationsInstance : TOperationsResource;

begin
  if (FOperationsInstance=Nil) then
    FOperationsInstance:=CreateOperationsResource;
  Result:=FOperationsInstance;
end;

Function TSqladminAPI.CreateOperationsResource : TOperationsResource;

begin
  Result:=CreateOperationsResource(Self);
end;


Function TSqladminAPI.CreateOperationsResource(AOwner : TComponent) : TOperationsResource;

begin
  Result:=TOperationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetSslCertsInstance : TSslCertsResource;

begin
  if (FSslCertsInstance=Nil) then
    FSslCertsInstance:=CreateSslCertsResource;
  Result:=FSslCertsInstance;
end;

Function TSqladminAPI.CreateSslCertsResource : TSslCertsResource;

begin
  Result:=CreateSslCertsResource(Self);
end;


Function TSqladminAPI.CreateSslCertsResource(AOwner : TComponent) : TSslCertsResource;

begin
  Result:=TSslCertsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetTiersInstance : TTiersResource;

begin
  if (FTiersInstance=Nil) then
    FTiersInstance:=CreateTiersResource;
  Result:=FTiersInstance;
end;

Function TSqladminAPI.CreateTiersResource : TTiersResource;

begin
  Result:=CreateTiersResource(Self);
end;


Function TSqladminAPI.CreateTiersResource(AOwner : TComponent) : TTiersResource;

begin
  Result:=TTiersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TSqladminAPI.GetUsersInstance : TUsersResource;

begin
  if (FUsersInstance=Nil) then
    FUsersInstance:=CreateUsersResource;
  Result:=FUsersInstance;
end;

Function TSqladminAPI.CreateUsersResource : TUsersResource;

begin
  Result:=CreateUsersResource(Self);
end;


Function TSqladminAPI.CreateUsersResource(AOwner : TComponent) : TUsersResource;

begin
  Result:=TUsersResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TSqladminAPI.RegisterAPI;
end.
