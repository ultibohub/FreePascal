unit googleandroidenterprise;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAppRestrictionsSchema = Class;
  TAppRestrictionsSchemaRestriction = Class;
  TAppRestrictionsSchemaRestrictionRestrictionValue = Class;
  TAppVersion = Class;
  TApprovalUrlInfo = Class;
  TCollection = Class;
  TCollectionViewersListResponse = Class;
  TCollectionsListResponse = Class;
  TDevice = Class;
  TDeviceState = Class;
  TDevicesListResponse = Class;
  TEnterprise = Class;
  TEnterpriseAccount = Class;
  TEnterprisesListResponse = Class;
  TEnterprisesSendTestPushNotificationResponse = Class;
  TEntitlement = Class;
  TEntitlementsListResponse = Class;
  TGroupLicense = Class;
  TGroupLicenseUsersListResponse = Class;
  TGroupLicensesListResponse = Class;
  TInstall = Class;
  TInstallsListResponse = Class;
  TLocalizedText = Class;
  TPageInfo = Class;
  TPermission = Class;
  TProduct = Class;
  TProductPermission = Class;
  TProductPermissions = Class;
  TProductSet = Class;
  TProductsApproveRequest = Class;
  TProductsGenerateApprovalUrlResponse = Class;
  TProductsListResponse = Class;
  TStoreCluster = Class;
  TStoreLayout = Class;
  TStoreLayoutClustersListResponse = Class;
  TStoreLayoutPagesListResponse = Class;
  TStorePage = Class;
  TTokenPagination = Class;
  TUser = Class;
  TUserToken = Class;
  TUsersListResponse = Class;
  TAppRestrictionsSchemaArray = Array of TAppRestrictionsSchema;
  TAppRestrictionsSchemaRestrictionArray = Array of TAppRestrictionsSchemaRestriction;
  TAppRestrictionsSchemaRestrictionRestrictionValueArray = Array of TAppRestrictionsSchemaRestrictionRestrictionValue;
  TAppVersionArray = Array of TAppVersion;
  TApprovalUrlInfoArray = Array of TApprovalUrlInfo;
  TCollectionArray = Array of TCollection;
  TCollectionViewersListResponseArray = Array of TCollectionViewersListResponse;
  TCollectionsListResponseArray = Array of TCollectionsListResponse;
  TDeviceArray = Array of TDevice;
  TDeviceStateArray = Array of TDeviceState;
  TDevicesListResponseArray = Array of TDevicesListResponse;
  TEnterpriseArray = Array of TEnterprise;
  TEnterpriseAccountArray = Array of TEnterpriseAccount;
  TEnterprisesListResponseArray = Array of TEnterprisesListResponse;
  TEnterprisesSendTestPushNotificationResponseArray = Array of TEnterprisesSendTestPushNotificationResponse;
  TEntitlementArray = Array of TEntitlement;
  TEntitlementsListResponseArray = Array of TEntitlementsListResponse;
  TGroupLicenseArray = Array of TGroupLicense;
  TGroupLicenseUsersListResponseArray = Array of TGroupLicenseUsersListResponse;
  TGroupLicensesListResponseArray = Array of TGroupLicensesListResponse;
  TInstallArray = Array of TInstall;
  TInstallsListResponseArray = Array of TInstallsListResponse;
  TLocalizedTextArray = Array of TLocalizedText;
  TPageInfoArray = Array of TPageInfo;
  TPermissionArray = Array of TPermission;
  TProductArray = Array of TProduct;
  TProductPermissionArray = Array of TProductPermission;
  TProductPermissionsArray = Array of TProductPermissions;
  TProductSetArray = Array of TProductSet;
  TProductsApproveRequestArray = Array of TProductsApproveRequest;
  TProductsGenerateApprovalUrlResponseArray = Array of TProductsGenerateApprovalUrlResponse;
  TProductsListResponseArray = Array of TProductsListResponse;
  TStoreClusterArray = Array of TStoreCluster;
  TStoreLayoutArray = Array of TStoreLayout;
  TStoreLayoutClustersListResponseArray = Array of TStoreLayoutClustersListResponse;
  TStoreLayoutPagesListResponseArray = Array of TStoreLayoutPagesListResponse;
  TStorePageArray = Array of TStorePage;
  TTokenPaginationArray = Array of TTokenPagination;
  TUserArray = Array of TUser;
  TUserTokenArray = Array of TUserToken;
  TUsersListResponseArray = Array of TUsersListResponse;
  //Anonymous types, using auto-generated names
  TAppRestrictionsSchemaTyperestrictionsArray = Array of TAppRestrictionsSchemaRestriction;
  TCollectionViewersListResponseTypeuserArray = Array of TUser;
  TCollectionsListResponseTypecollectionArray = Array of TCollection;
  TDevicesListResponseTypedeviceArray = Array of TDevice;
  TEnterprisesListResponseTypeenterpriseArray = Array of TEnterprise;
  TEntitlementsListResponseTypeentitlementArray = Array of TEntitlement;
  TGroupLicenseUsersListResponseTypeuserArray = Array of TUser;
  TGroupLicensesListResponseTypegroupLicenseArray = Array of TGroupLicense;
  TInstallsListResponseTypeinstallArray = Array of TInstall;
  TProductTypeappVersionArray = Array of TAppVersion;
  TProductPermissionsTypepermissionArray = Array of TProductPermission;
  TProductsListResponseTypeproductArray = Array of TProduct;
  TStoreClusterTypenameArray = Array of TLocalizedText;
  TStoreLayoutClustersListResponseTypeclusterArray = Array of TStoreCluster;
  TStoreLayoutPagesListResponseTypepageArray = Array of TStorePage;
  TStorePageTypenameArray = Array of TLocalizedText;
  TUsersListResponseTypeuserArray = Array of TUser;
  
  { --------------------------------------------------------------------
    TAppRestrictionsSchema
    --------------------------------------------------------------------}
  
  TAppRestrictionsSchema = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Frestrictions : TAppRestrictionsSchemaTyperestrictionsArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setrestrictions(AIndex : Integer; const AValue : TAppRestrictionsSchemaTyperestrictionsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property restrictions : TAppRestrictionsSchemaTyperestrictionsArray Index 8 Read Frestrictions Write Setrestrictions;
  end;
  TAppRestrictionsSchemaClass = Class of TAppRestrictionsSchema;
  
  { --------------------------------------------------------------------
    TAppRestrictionsSchemaRestriction
    --------------------------------------------------------------------}
  
  TAppRestrictionsSchemaRestriction = Class(TGoogleBaseObject)
  Private
    FdefaultValue : TAppRestrictionsSchemaRestrictionRestrictionValue;
    Fdescription : String;
    Fentry : TStringArray;
    FentryValue : TStringArray;
    Fkey : String;
    FrestrictionType : String;
    Ftitle : String;
  Protected
    //Property setters
    Procedure SetdefaultValue(AIndex : Integer; const AValue : TAppRestrictionsSchemaRestrictionRestrictionValue); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setentry(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetentryValue(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure SetrestrictionType(AIndex : Integer; const AValue : String); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property defaultValue : TAppRestrictionsSchemaRestrictionRestrictionValue Index 0 Read FdefaultValue Write SetdefaultValue;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property entry : TStringArray Index 16 Read Fentry Write Setentry;
    Property entryValue : TStringArray Index 24 Read FentryValue Write SetentryValue;
    Property key : String Index 32 Read Fkey Write Setkey;
    Property restrictionType : String Index 40 Read FrestrictionType Write SetrestrictionType;
    Property title : String Index 48 Read Ftitle Write Settitle;
  end;
  TAppRestrictionsSchemaRestrictionClass = Class of TAppRestrictionsSchemaRestriction;
  
  { --------------------------------------------------------------------
    TAppRestrictionsSchemaRestrictionRestrictionValue
    --------------------------------------------------------------------}
  
  TAppRestrictionsSchemaRestrictionRestrictionValue = Class(TGoogleBaseObject)
  Private
    F_type : String;
    FvalueBool : boolean;
    FvalueInteger : integer;
    FvalueMultiselect : TStringArray;
    FvalueString : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure SetvalueBool(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetvalueInteger(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetvalueMultiselect(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetvalueString(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property _type : String Index 0 Read F_type Write Set_type;
    Property valueBool : boolean Index 8 Read FvalueBool Write SetvalueBool;
    Property valueInteger : integer Index 16 Read FvalueInteger Write SetvalueInteger;
    Property valueMultiselect : TStringArray Index 24 Read FvalueMultiselect Write SetvalueMultiselect;
    Property valueString : String Index 32 Read FvalueString Write SetvalueString;
  end;
  TAppRestrictionsSchemaRestrictionRestrictionValueClass = Class of TAppRestrictionsSchemaRestrictionRestrictionValue;
  
  { --------------------------------------------------------------------
    TAppVersion
    --------------------------------------------------------------------}
  
  TAppVersion = Class(TGoogleBaseObject)
  Private
    FversionCode : integer;
    FversionString : String;
  Protected
    //Property setters
    Procedure SetversionCode(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetversionString(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property versionCode : integer Index 0 Read FversionCode Write SetversionCode;
    Property versionString : String Index 8 Read FversionString Write SetversionString;
  end;
  TAppVersionClass = Class of TAppVersion;
  
  { --------------------------------------------------------------------
    TApprovalUrlInfo
    --------------------------------------------------------------------}
  
  TApprovalUrlInfo = Class(TGoogleBaseObject)
  Private
    FapprovalUrl : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetapprovalUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property approvalUrl : String Index 0 Read FapprovalUrl Write SetapprovalUrl;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TApprovalUrlInfoClass = Class of TApprovalUrlInfo;
  
  { --------------------------------------------------------------------
    TCollection
    --------------------------------------------------------------------}
  
  TCollection = Class(TGoogleBaseObject)
  Private
    FcollectionId : String;
    Fkind : String;
    Fname : String;
    FproductId : TStringArray;
    Fvisibility : String;
  Protected
    //Property setters
    Procedure SetcollectionId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setvisibility(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property collectionId : String Index 0 Read FcollectionId Write SetcollectionId;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property productId : TStringArray Index 24 Read FproductId Write SetproductId;
    Property visibility : String Index 32 Read Fvisibility Write Setvisibility;
  end;
  TCollectionClass = Class of TCollection;
  
  { --------------------------------------------------------------------
    TCollectionViewersListResponse
    --------------------------------------------------------------------}
  
  TCollectionViewersListResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fuser : TCollectionViewersListResponseTypeuserArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setuser(AIndex : Integer; const AValue : TCollectionViewersListResponseTypeuserArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property user : TCollectionViewersListResponseTypeuserArray Index 8 Read Fuser Write Setuser;
  end;
  TCollectionViewersListResponseClass = Class of TCollectionViewersListResponse;
  
  { --------------------------------------------------------------------
    TCollectionsListResponse
    --------------------------------------------------------------------}
  
  TCollectionsListResponse = Class(TGoogleBaseObject)
  Private
    Fcollection : TCollectionsListResponseTypecollectionArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setcollection(AIndex : Integer; const AValue : TCollectionsListResponseTypecollectionArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property collection : TCollectionsListResponseTypecollectionArray Index 0 Read Fcollection Write Setcollection;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TCollectionsListResponseClass = Class of TCollectionsListResponse;
  
  { --------------------------------------------------------------------
    TDevice
    --------------------------------------------------------------------}
  
  TDevice = Class(TGoogleBaseObject)
  Private
    FandroidId : String;
    Fkind : String;
    FmanagementType : String;
  Protected
    //Property setters
    Procedure SetandroidId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmanagementType(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property androidId : String Index 0 Read FandroidId Write SetandroidId;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property managementType : String Index 16 Read FmanagementType Write SetmanagementType;
  end;
  TDeviceClass = Class of TDevice;
  
  { --------------------------------------------------------------------
    TDeviceState
    --------------------------------------------------------------------}
  
  TDeviceState = Class(TGoogleBaseObject)
  Private
    FaccountState : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetaccountState(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property accountState : String Index 0 Read FaccountState Write SetaccountState;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TDeviceStateClass = Class of TDeviceState;
  
  { --------------------------------------------------------------------
    TDevicesListResponse
    --------------------------------------------------------------------}
  
  TDevicesListResponse = Class(TGoogleBaseObject)
  Private
    Fdevice : TDevicesListResponseTypedeviceArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setdevice(AIndex : Integer; const AValue : TDevicesListResponseTypedeviceArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property device : TDevicesListResponseTypedeviceArray Index 0 Read Fdevice Write Setdevice;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TDevicesListResponseClass = Class of TDevicesListResponse;
  
  { --------------------------------------------------------------------
    TEnterprise
    --------------------------------------------------------------------}
  
  TEnterprise = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    Fname : String;
    FprimaryDomain : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprimaryDomain(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property primaryDomain : String Index 24 Read FprimaryDomain Write SetprimaryDomain;
  end;
  TEnterpriseClass = Class of TEnterprise;
  
  { --------------------------------------------------------------------
    TEnterpriseAccount
    --------------------------------------------------------------------}
  
  TEnterpriseAccount = Class(TGoogleBaseObject)
  Private
    FaccountEmail : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetaccountEmail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property accountEmail : String Index 0 Read FaccountEmail Write SetaccountEmail;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TEnterpriseAccountClass = Class of TEnterpriseAccount;
  
  { --------------------------------------------------------------------
    TEnterprisesListResponse
    --------------------------------------------------------------------}
  
  TEnterprisesListResponse = Class(TGoogleBaseObject)
  Private
    Fenterprise : TEnterprisesListResponseTypeenterpriseArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setenterprise(AIndex : Integer; const AValue : TEnterprisesListResponseTypeenterpriseArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property enterprise : TEnterprisesListResponseTypeenterpriseArray Index 0 Read Fenterprise Write Setenterprise;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TEnterprisesListResponseClass = Class of TEnterprisesListResponse;
  
  { --------------------------------------------------------------------
    TEnterprisesSendTestPushNotificationResponse
    --------------------------------------------------------------------}
  
  TEnterprisesSendTestPushNotificationResponse = Class(TGoogleBaseObject)
  Private
    FmessageId : String;
    FtopicName : String;
  Protected
    //Property setters
    Procedure SetmessageId(AIndex : Integer; const AValue : String); virtual;
    Procedure SettopicName(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property messageId : String Index 0 Read FmessageId Write SetmessageId;
    Property topicName : String Index 8 Read FtopicName Write SettopicName;
  end;
  TEnterprisesSendTestPushNotificationResponseClass = Class of TEnterprisesSendTestPushNotificationResponse;
  
  { --------------------------------------------------------------------
    TEntitlement
    --------------------------------------------------------------------}
  
  TEntitlement = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    FproductId : String;
    Freason : String;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setreason(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property productId : String Index 8 Read FproductId Write SetproductId;
    Property reason : String Index 16 Read Freason Write Setreason;
  end;
  TEntitlementClass = Class of TEntitlement;
  
  { --------------------------------------------------------------------
    TEntitlementsListResponse
    --------------------------------------------------------------------}
  
  TEntitlementsListResponse = Class(TGoogleBaseObject)
  Private
    Fentitlement : TEntitlementsListResponseTypeentitlementArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setentitlement(AIndex : Integer; const AValue : TEntitlementsListResponseTypeentitlementArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property entitlement : TEntitlementsListResponseTypeentitlementArray Index 0 Read Fentitlement Write Setentitlement;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TEntitlementsListResponseClass = Class of TEntitlementsListResponse;
  
  { --------------------------------------------------------------------
    TGroupLicense
    --------------------------------------------------------------------}
  
  TGroupLicense = Class(TGoogleBaseObject)
  Private
    FacquisitionKind : String;
    Fapproval : String;
    Fkind : String;
    FnumProvisioned : integer;
    FnumPurchased : integer;
    FproductId : String;
  Protected
    //Property setters
    Procedure SetacquisitionKind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setapproval(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnumProvisioned(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetnumPurchased(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property acquisitionKind : String Index 0 Read FacquisitionKind Write SetacquisitionKind;
    Property approval : String Index 8 Read Fapproval Write Setapproval;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property numProvisioned : integer Index 24 Read FnumProvisioned Write SetnumProvisioned;
    Property numPurchased : integer Index 32 Read FnumPurchased Write SetnumPurchased;
    Property productId : String Index 40 Read FproductId Write SetproductId;
  end;
  TGroupLicenseClass = Class of TGroupLicense;
  
  { --------------------------------------------------------------------
    TGroupLicenseUsersListResponse
    --------------------------------------------------------------------}
  
  TGroupLicenseUsersListResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fuser : TGroupLicenseUsersListResponseTypeuserArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setuser(AIndex : Integer; const AValue : TGroupLicenseUsersListResponseTypeuserArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property user : TGroupLicenseUsersListResponseTypeuserArray Index 8 Read Fuser Write Setuser;
  end;
  TGroupLicenseUsersListResponseClass = Class of TGroupLicenseUsersListResponse;
  
  { --------------------------------------------------------------------
    TGroupLicensesListResponse
    --------------------------------------------------------------------}
  
  TGroupLicensesListResponse = Class(TGoogleBaseObject)
  Private
    FgroupLicense : TGroupLicensesListResponseTypegroupLicenseArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure SetgroupLicense(AIndex : Integer; const AValue : TGroupLicensesListResponseTypegroupLicenseArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property groupLicense : TGroupLicensesListResponseTypegroupLicenseArray Index 0 Read FgroupLicense Write SetgroupLicense;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TGroupLicensesListResponseClass = Class of TGroupLicensesListResponse;
  
  { --------------------------------------------------------------------
    TInstall
    --------------------------------------------------------------------}
  
  TInstall = Class(TGoogleBaseObject)
  Private
    FinstallState : String;
    Fkind : String;
    FproductId : String;
    FversionCode : integer;
  Protected
    //Property setters
    Procedure SetinstallState(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetversionCode(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property installState : String Index 0 Read FinstallState Write SetinstallState;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property productId : String Index 16 Read FproductId Write SetproductId;
    Property versionCode : integer Index 24 Read FversionCode Write SetversionCode;
  end;
  TInstallClass = Class of TInstall;
  
  { --------------------------------------------------------------------
    TInstallsListResponse
    --------------------------------------------------------------------}
  
  TInstallsListResponse = Class(TGoogleBaseObject)
  Private
    Finstall : TInstallsListResponseTypeinstallArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setinstall(AIndex : Integer; const AValue : TInstallsListResponseTypeinstallArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property install : TInstallsListResponseTypeinstallArray Index 0 Read Finstall Write Setinstall;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TInstallsListResponseClass = Class of TInstallsListResponse;
  
  { --------------------------------------------------------------------
    TLocalizedText
    --------------------------------------------------------------------}
  
  TLocalizedText = Class(TGoogleBaseObject)
  Private
    Flocale : String;
    Ftext : String;
  Protected
    //Property setters
    Procedure Setlocale(AIndex : Integer; const AValue : String); virtual;
    Procedure Settext(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property locale : String Index 0 Read Flocale Write Setlocale;
    Property text : String Index 8 Read Ftext Write Settext;
  end;
  TLocalizedTextClass = Class of TLocalizedText;
  
  { --------------------------------------------------------------------
    TPageInfo
    --------------------------------------------------------------------}
  
  TPageInfo = Class(TGoogleBaseObject)
  Private
    FresultPerPage : integer;
    FstartIndex : integer;
    FtotalResults : integer;
  Protected
    //Property setters
    Procedure SetresultPerPage(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetstartIndex(AIndex : Integer; const AValue : integer); virtual;
    Procedure SettotalResults(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property resultPerPage : integer Index 0 Read FresultPerPage Write SetresultPerPage;
    Property startIndex : integer Index 8 Read FstartIndex Write SetstartIndex;
    Property totalResults : integer Index 16 Read FtotalResults Write SettotalResults;
  end;
  TPageInfoClass = Class of TPageInfo;
  
  { --------------------------------------------------------------------
    TPermission
    --------------------------------------------------------------------}
  
  TPermission = Class(TGoogleBaseObject)
  Private
    Fdescription : String;
    Fkind : String;
    Fname : String;
    FpermissionId : String;
  Protected
    //Property setters
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpermissionId(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property description : String Index 0 Read Fdescription Write Setdescription;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property permissionId : String Index 24 Read FpermissionId Write SetpermissionId;
  end;
  TPermissionClass = Class of TPermission;
  
  { --------------------------------------------------------------------
    TProduct
    --------------------------------------------------------------------}
  
  TProduct = Class(TGoogleBaseObject)
  Private
    FappVersion : TProductTypeappVersionArray;
    FauthorName : String;
    FdetailsUrl : String;
    FdistributionChannel : String;
    FiconUrl : String;
    Fkind : String;
    FproductId : String;
    FproductPricing : String;
    FrequiresContainerApp : boolean;
    FsmallIconUrl : String;
    Ftitle : String;
    FworkDetailsUrl : String;
  Protected
    //Property setters
    Procedure SetappVersion(AIndex : Integer; const AValue : TProductTypeappVersionArray); virtual;
    Procedure SetauthorName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdetailsUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdistributionChannel(AIndex : Integer; const AValue : String); virtual;
    Procedure SeticonUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductPricing(AIndex : Integer; const AValue : String); virtual;
    Procedure SetrequiresContainerApp(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetsmallIconUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
    Procedure SetworkDetailsUrl(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property appVersion : TProductTypeappVersionArray Index 0 Read FappVersion Write SetappVersion;
    Property authorName : String Index 8 Read FauthorName Write SetauthorName;
    Property detailsUrl : String Index 16 Read FdetailsUrl Write SetdetailsUrl;
    Property distributionChannel : String Index 24 Read FdistributionChannel Write SetdistributionChannel;
    Property iconUrl : String Index 32 Read FiconUrl Write SeticonUrl;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property productId : String Index 48 Read FproductId Write SetproductId;
    Property productPricing : String Index 56 Read FproductPricing Write SetproductPricing;
    Property requiresContainerApp : boolean Index 64 Read FrequiresContainerApp Write SetrequiresContainerApp;
    Property smallIconUrl : String Index 72 Read FsmallIconUrl Write SetsmallIconUrl;
    Property title : String Index 80 Read Ftitle Write Settitle;
    Property workDetailsUrl : String Index 88 Read FworkDetailsUrl Write SetworkDetailsUrl;
  end;
  TProductClass = Class of TProduct;
  
  { --------------------------------------------------------------------
    TProductPermission
    --------------------------------------------------------------------}
  
  TProductPermission = Class(TGoogleBaseObject)
  Private
    FpermissionId : String;
    Fstate : String;
  Protected
    //Property setters
    Procedure SetpermissionId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstate(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property permissionId : String Index 0 Read FpermissionId Write SetpermissionId;
    Property state : String Index 8 Read Fstate Write Setstate;
  end;
  TProductPermissionClass = Class of TProductPermission;
  
  { --------------------------------------------------------------------
    TProductPermissions
    --------------------------------------------------------------------}
  
  TProductPermissions = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fpermission : TProductPermissionsTypepermissionArray;
    FproductId : String;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpermission(AIndex : Integer; const AValue : TProductPermissionsTypepermissionArray); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property permission : TProductPermissionsTypepermissionArray Index 8 Read Fpermission Write Setpermission;
    Property productId : String Index 16 Read FproductId Write SetproductId;
  end;
  TProductPermissionsClass = Class of TProductPermissions;
  
  { --------------------------------------------------------------------
    TProductSet
    --------------------------------------------------------------------}
  
  TProductSet = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    FproductId : TStringArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property productId : TStringArray Index 8 Read FproductId Write SetproductId;
  end;
  TProductSetClass = Class of TProductSet;
  
  { --------------------------------------------------------------------
    TProductsApproveRequest
    --------------------------------------------------------------------}
  
  TProductsApproveRequest = Class(TGoogleBaseObject)
  Private
    FapprovalUrlInfo : TApprovalUrlInfo;
  Protected
    //Property setters
    Procedure SetapprovalUrlInfo(AIndex : Integer; const AValue : TApprovalUrlInfo); virtual;
  Public
  Published
    Property approvalUrlInfo : TApprovalUrlInfo Index 0 Read FapprovalUrlInfo Write SetapprovalUrlInfo;
  end;
  TProductsApproveRequestClass = Class of TProductsApproveRequest;
  
  { --------------------------------------------------------------------
    TProductsGenerateApprovalUrlResponse
    --------------------------------------------------------------------}
  
  TProductsGenerateApprovalUrlResponse = Class(TGoogleBaseObject)
  Private
    Furl : String;
  Protected
    //Property setters
    Procedure Seturl(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property url : String Index 0 Read Furl Write Seturl;
  end;
  TProductsGenerateApprovalUrlResponseClass = Class of TProductsGenerateApprovalUrlResponse;
  
  { --------------------------------------------------------------------
    TProductsListResponse
    --------------------------------------------------------------------}
  
  TProductsListResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    FpageInfo : TPageInfo;
    Fproduct : TProductsListResponseTypeproductArray;
    FtokenPagination : TTokenPagination;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpageInfo(AIndex : Integer; const AValue : TPageInfo); virtual;
    Procedure Setproduct(AIndex : Integer; const AValue : TProductsListResponseTypeproductArray); virtual;
    Procedure SettokenPagination(AIndex : Integer; const AValue : TTokenPagination); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property pageInfo : TPageInfo Index 8 Read FpageInfo Write SetpageInfo;
    Property product : TProductsListResponseTypeproductArray Index 16 Read Fproduct Write Setproduct;
    Property tokenPagination : TTokenPagination Index 24 Read FtokenPagination Write SettokenPagination;
  end;
  TProductsListResponseClass = Class of TProductsListResponse;
  
  { --------------------------------------------------------------------
    TStoreCluster
    --------------------------------------------------------------------}
  
  TStoreCluster = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    Fname : TStoreClusterTypenameArray;
    ForderInPage : String;
    FproductId : TStringArray;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : TStoreClusterTypenameArray); virtual;
    Procedure SetorderInPage(AIndex : Integer; const AValue : String); virtual;
    Procedure SetproductId(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : TStoreClusterTypenameArray Index 16 Read Fname Write Setname;
    Property orderInPage : String Index 24 Read ForderInPage Write SetorderInPage;
    Property productId : TStringArray Index 32 Read FproductId Write SetproductId;
  end;
  TStoreClusterClass = Class of TStoreCluster;
  
  { --------------------------------------------------------------------
    TStoreLayout
    --------------------------------------------------------------------}
  
  TStoreLayout = Class(TGoogleBaseObject)
  Private
    FhomepageId : String;
    Fkind : String;
  Protected
    //Property setters
    Procedure SethomepageId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property homepageId : String Index 0 Read FhomepageId Write SethomepageId;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TStoreLayoutClass = Class of TStoreLayout;
  
  { --------------------------------------------------------------------
    TStoreLayoutClustersListResponse
    --------------------------------------------------------------------}
  
  TStoreLayoutClustersListResponse = Class(TGoogleBaseObject)
  Private
    Fcluster : TStoreLayoutClustersListResponseTypeclusterArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setcluster(AIndex : Integer; const AValue : TStoreLayoutClustersListResponseTypeclusterArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property cluster : TStoreLayoutClustersListResponseTypeclusterArray Index 0 Read Fcluster Write Setcluster;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TStoreLayoutClustersListResponseClass = Class of TStoreLayoutClustersListResponse;
  
  { --------------------------------------------------------------------
    TStoreLayoutPagesListResponse
    --------------------------------------------------------------------}
  
  TStoreLayoutPagesListResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fpage : TStoreLayoutPagesListResponseTypepageArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpage(AIndex : Integer; const AValue : TStoreLayoutPagesListResponseTypepageArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property page : TStoreLayoutPagesListResponseTypepageArray Index 8 Read Fpage Write Setpage;
  end;
  TStoreLayoutPagesListResponseClass = Class of TStoreLayoutPagesListResponse;
  
  { --------------------------------------------------------------------
    TStorePage
    --------------------------------------------------------------------}
  
  TStorePage = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    Flink : TStringArray;
    Fname : TStorePageTypenameArray;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlink(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : TStorePageTypenameArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property link : TStringArray Index 16 Read Flink Write Setlink;
    Property name : TStorePageTypenameArray Index 24 Read Fname Write Setname;
  end;
  TStorePageClass = Class of TStorePage;
  
  { --------------------------------------------------------------------
    TTokenPagination
    --------------------------------------------------------------------}
  
  TTokenPagination = Class(TGoogleBaseObject)
  Private
    FnextPageToken : String;
    FpreviousPageToken : String;
  Protected
    //Property setters
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpreviousPageToken(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property nextPageToken : String Index 0 Read FnextPageToken Write SetnextPageToken;
    Property previousPageToken : String Index 8 Read FpreviousPageToken Write SetpreviousPageToken;
  end;
  TTokenPaginationClass = Class of TTokenPagination;
  
  { --------------------------------------------------------------------
    TUser
    --------------------------------------------------------------------}
  
  TUser = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fkind : String;
    FprimaryEmail : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprimaryEmail(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property primaryEmail : String Index 16 Read FprimaryEmail Write SetprimaryEmail;
  end;
  TUserClass = Class of TUser;
  
  { --------------------------------------------------------------------
    TUserToken
    --------------------------------------------------------------------}
  
  TUserToken = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Ftoken : String;
    FuserId : String;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Settoken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetuserId(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property token : String Index 8 Read Ftoken Write Settoken;
    Property userId : String Index 16 Read FuserId Write SetuserId;
  end;
  TUserTokenClass = Class of TUserToken;
  
  { --------------------------------------------------------------------
    TUsersListResponse
    --------------------------------------------------------------------}
  
  TUsersListResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fuser : TUsersListResponseTypeuserArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setuser(AIndex : Integer; const AValue : TUsersListResponseTypeuserArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property user : TUsersListResponseTypeuserArray Index 8 Read Fuser Write Setuser;
  end;
  TUsersListResponseClass = Class of TUsersListResponse;
  
  { --------------------------------------------------------------------
    TCollectionsResource
    --------------------------------------------------------------------}
  
  TCollectionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(collectionId: string; enterpriseId: string);
    Function Get(collectionId: string; enterpriseId: string) : TCollection;
    Function Insert(enterpriseId: string; aCollection : TCollection) : TCollection;
    Function List(enterpriseId: string) : TCollectionsListResponse;
    Function Patch(collectionId: string; enterpriseId: string; aCollection : TCollection) : TCollection;
    Function Update(collectionId: string; enterpriseId: string; aCollection : TCollection) : TCollection;
  end;
  
  
  { --------------------------------------------------------------------
    TCollectionviewersResource
    --------------------------------------------------------------------}
  
  TCollectionviewersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(collectionId: string; enterpriseId: string; userId: string);
    Function Get(collectionId: string; enterpriseId: string; userId: string) : TUser;
    Function List(collectionId: string; enterpriseId: string) : TCollectionViewersListResponse;
    Function Patch(collectionId: string; enterpriseId: string; userId: string; aUser : TUser) : TUser;
    Function Update(collectionId: string; enterpriseId: string; userId: string; aUser : TUser) : TUser;
  end;
  
  
  { --------------------------------------------------------------------
    TDevicesResource
    --------------------------------------------------------------------}
  
  TDevicesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(deviceId: string; enterpriseId: string; userId: string) : TDevice;
    Function GetState(deviceId: string; enterpriseId: string; userId: string) : TDeviceState;
    Function List(enterpriseId: string; userId: string) : TDevicesListResponse;
    Function SetState(deviceId: string; enterpriseId: string; userId: string; aDeviceState : TDeviceState) : TDeviceState;
  end;
  
  
  { --------------------------------------------------------------------
    TEnterprisesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TEnterprisesResource, method Enroll
  
  TEnterprisesEnrollOptions = Record
    token : String;
  end;
  
  
  //Optional query Options for TEnterprisesResource, method Insert
  
  TEnterprisesInsertOptions = Record
    token : String;
  end;
  
  
  //Optional query Options for TEnterprisesResource, method List
  
  TEnterprisesListOptions = Record
    domain : String;
  end;
  
  TEnterprisesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(enterpriseId: string);
    Function Enroll(aEnterprise : TEnterprise; AQuery : string  = '') : TEnterprise;
    Function Enroll(aEnterprise : TEnterprise; AQuery : TEnterprisesenrollOptions) : TEnterprise;
    Function Get(enterpriseId: string) : TEnterprise;
    Function GetStoreLayout(enterpriseId: string) : TStoreLayout;
    Function Insert(aEnterprise : TEnterprise; AQuery : string  = '') : TEnterprise;
    Function Insert(aEnterprise : TEnterprise; AQuery : TEnterprisesinsertOptions) : TEnterprise;
    Function List(AQuery : string  = '') : TEnterprisesListResponse;
    Function List(AQuery : TEnterpriseslistOptions) : TEnterprisesListResponse;
    Function SendTestPushNotification(enterpriseId: string) : TEnterprisesSendTestPushNotificationResponse;
    Function SetAccount(enterpriseId: string; aEnterpriseAccount : TEnterpriseAccount) : TEnterpriseAccount;
    Function SetStoreLayout(enterpriseId: string; aStoreLayout : TStoreLayout) : TStoreLayout;
    Procedure Unenroll(enterpriseId: string);
  end;
  
  
  { --------------------------------------------------------------------
    TEntitlementsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TEntitlementsResource, method Patch
  
  TEntitlementsPatchOptions = Record
    install : boolean;
  end;
  
  
  //Optional query Options for TEntitlementsResource, method Update
  
  TEntitlementsUpdateOptions = Record
    install : boolean;
  end;
  
  TEntitlementsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(enterpriseId: string; entitlementId: string; userId: string);
    Function Get(enterpriseId: string; entitlementId: string; userId: string) : TEntitlement;
    Function List(enterpriseId: string; userId: string) : TEntitlementsListResponse;
    Function Patch(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : string  = '') : TEntitlement;
    Function Patch(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : TEntitlementspatchOptions) : TEntitlement;
    Function Update(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : string  = '') : TEntitlement;
    Function Update(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : TEntitlementsupdateOptions) : TEntitlement;
  end;
  
  
  { --------------------------------------------------------------------
    TGrouplicensesResource
    --------------------------------------------------------------------}
  
  TGrouplicensesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(enterpriseId: string; groupLicenseId: string) : TGroupLicense;
    Function List(enterpriseId: string) : TGroupLicensesListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TGrouplicenseusersResource
    --------------------------------------------------------------------}
  
  TGrouplicenseusersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function List(enterpriseId: string; groupLicenseId: string) : TGroupLicenseUsersListResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TInstallsResource
    --------------------------------------------------------------------}
  
  TInstallsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(deviceId: string; enterpriseId: string; installId: string; userId: string);
    Function Get(deviceId: string; enterpriseId: string; installId: string; userId: string) : TInstall;
    Function List(deviceId: string; enterpriseId: string; userId: string) : TInstallsListResponse;
    Function Patch(deviceId: string; enterpriseId: string; installId: string; userId: string; aInstall : TInstall) : TInstall;
    Function Update(deviceId: string; enterpriseId: string; installId: string; userId: string; aInstall : TInstall) : TInstall;
  end;
  
  
  { --------------------------------------------------------------------
    TPermissionsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TPermissionsResource, method Get
  
  TPermissionsGetOptions = Record
    language : String;
  end;
  
  TPermissionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(permissionId: string; AQuery : string  = '') : TPermission;
    Function Get(permissionId: string; AQuery : TPermissionsgetOptions) : TPermission;
  end;
  
  
  { --------------------------------------------------------------------
    TProductsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TProductsResource, method GenerateApprovalUrl
  
  TProductsGenerateApprovalUrlOptions = Record
    languageCode : String;
  end;
  
  
  //Optional query Options for TProductsResource, method Get
  
  TProductsGetOptions = Record
    language : String;
  end;
  
  
  //Optional query Options for TProductsResource, method GetAppRestrictionsSchema
  
  TProductsGetAppRestrictionsSchemaOptions = Record
    language : String;
  end;
  
  
  //Optional query Options for TProductsResource, method List
  
  TProductsListOptions = Record
    approved : boolean;
    language : String;
    maxResults : integer;
    query : String;
    token : String;
  end;
  
  TProductsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Approve(enterpriseId: string; productId: string; aProductsApproveRequest : TProductsApproveRequest);
    Function GenerateApprovalUrl(enterpriseId: string; productId: string; AQuery : string  = '') : TProductsGenerateApprovalUrlResponse;
    Function GenerateApprovalUrl(enterpriseId: string; productId: string; AQuery : TProductsgenerateApprovalUrlOptions) : TProductsGenerateApprovalUrlResponse;
    Function Get(enterpriseId: string; productId: string; AQuery : string  = '') : TProduct;
    Function Get(enterpriseId: string; productId: string; AQuery : TProductsgetOptions) : TProduct;
    Function GetAppRestrictionsSchema(enterpriseId: string; productId: string; AQuery : string  = '') : TAppRestrictionsSchema;
    Function GetAppRestrictionsSchema(enterpriseId: string; productId: string; AQuery : TProductsgetAppRestrictionsSchemaOptions) : TAppRestrictionsSchema;
    Function GetPermissions(enterpriseId: string; productId: string) : TProductPermissions;
    Function List(enterpriseId: string; AQuery : string  = '') : TProductsListResponse;
    Function List(enterpriseId: string; AQuery : TProductslistOptions) : TProductsListResponse;
    Function UpdatePermissions(enterpriseId: string; productId: string; aProductPermissions : TProductPermissions) : TProductPermissions;
  end;
  
  
  { --------------------------------------------------------------------
    TStorelayoutclustersResource
    --------------------------------------------------------------------}
  
  TStorelayoutclustersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(clusterId: string; enterpriseId: string; pageId: string);
    Function Get(clusterId: string; enterpriseId: string; pageId: string) : TStoreCluster;
    Function Insert(enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;
    Function List(enterpriseId: string; pageId: string) : TStoreLayoutClustersListResponse;
    Function Patch(clusterId: string; enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;
    Function Update(clusterId: string; enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;
  end;
  
  
  { --------------------------------------------------------------------
    TStorelayoutpagesResource
    --------------------------------------------------------------------}
  
  TStorelayoutpagesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(enterpriseId: string; pageId: string);
    Function Get(enterpriseId: string; pageId: string) : TStorePage;
    Function Insert(enterpriseId: string; aStorePage : TStorePage) : TStorePage;
    Function List(enterpriseId: string) : TStoreLayoutPagesListResponse;
    Function Patch(enterpriseId: string; pageId: string; aStorePage : TStorePage) : TStorePage;
    Function Update(enterpriseId: string; pageId: string; aStorePage : TStorePage) : TStorePage;
  end;
  
  
  { --------------------------------------------------------------------
    TUsersResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TUsersResource, method List
  
  TUsersListOptions = Record
    email : String;
  end;
  
  TUsersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function GenerateToken(enterpriseId: string; userId: string) : TUserToken;
    Function Get(enterpriseId: string; userId: string) : TUser;
    Function GetAvailableProductSet(enterpriseId: string; userId: string) : TProductSet;
    Function List(enterpriseId: string; AQuery : string  = '') : TUsersListResponse;
    Function List(enterpriseId: string; AQuery : TUserslistOptions) : TUsersListResponse;
    Procedure RevokeToken(enterpriseId: string; userId: string);
    Function SetAvailableProductSet(enterpriseId: string; userId: string; aProductSet : TProductSet) : TProductSet;
  end;
  
  
  { --------------------------------------------------------------------
    TAndroidenterpriseAPI
    --------------------------------------------------------------------}
  
  TAndroidenterpriseAPI = Class(TGoogleAPI)
  Private
    FCollectionsInstance : TCollectionsResource;
    FCollectionviewersInstance : TCollectionviewersResource;
    FDevicesInstance : TDevicesResource;
    FEnterprisesInstance : TEnterprisesResource;
    FEntitlementsInstance : TEntitlementsResource;
    FGrouplicensesInstance : TGrouplicensesResource;
    FGrouplicenseusersInstance : TGrouplicenseusersResource;
    FInstallsInstance : TInstallsResource;
    FPermissionsInstance : TPermissionsResource;
    FProductsInstance : TProductsResource;
    FStorelayoutclustersInstance : TStorelayoutclustersResource;
    FStorelayoutpagesInstance : TStorelayoutpagesResource;
    FUsersInstance : TUsersResource;
    Function GetCollectionsInstance : TCollectionsResource;virtual;
    Function GetCollectionviewersInstance : TCollectionviewersResource;virtual;
    Function GetDevicesInstance : TDevicesResource;virtual;
    Function GetEnterprisesInstance : TEnterprisesResource;virtual;
    Function GetEntitlementsInstance : TEntitlementsResource;virtual;
    Function GetGrouplicensesInstance : TGrouplicensesResource;virtual;
    Function GetGrouplicenseusersInstance : TGrouplicenseusersResource;virtual;
    Function GetInstallsInstance : TInstallsResource;virtual;
    Function GetPermissionsInstance : TPermissionsResource;virtual;
    Function GetProductsInstance : TProductsResource;virtual;
    Function GetStorelayoutclustersInstance : TStorelayoutclustersResource;virtual;
    Function GetStorelayoutpagesInstance : TStorelayoutpagesResource;virtual;
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
    Function CreateCollectionsResource(AOwner : TComponent) : TCollectionsResource;virtual;overload;
    Function CreateCollectionsResource : TCollectionsResource;virtual;overload;
    Function CreateCollectionviewersResource(AOwner : TComponent) : TCollectionviewersResource;virtual;overload;
    Function CreateCollectionviewersResource : TCollectionviewersResource;virtual;overload;
    Function CreateDevicesResource(AOwner : TComponent) : TDevicesResource;virtual;overload;
    Function CreateDevicesResource : TDevicesResource;virtual;overload;
    Function CreateEnterprisesResource(AOwner : TComponent) : TEnterprisesResource;virtual;overload;
    Function CreateEnterprisesResource : TEnterprisesResource;virtual;overload;
    Function CreateEntitlementsResource(AOwner : TComponent) : TEntitlementsResource;virtual;overload;
    Function CreateEntitlementsResource : TEntitlementsResource;virtual;overload;
    Function CreateGrouplicensesResource(AOwner : TComponent) : TGrouplicensesResource;virtual;overload;
    Function CreateGrouplicensesResource : TGrouplicensesResource;virtual;overload;
    Function CreateGrouplicenseusersResource(AOwner : TComponent) : TGrouplicenseusersResource;virtual;overload;
    Function CreateGrouplicenseusersResource : TGrouplicenseusersResource;virtual;overload;
    Function CreateInstallsResource(AOwner : TComponent) : TInstallsResource;virtual;overload;
    Function CreateInstallsResource : TInstallsResource;virtual;overload;
    Function CreatePermissionsResource(AOwner : TComponent) : TPermissionsResource;virtual;overload;
    Function CreatePermissionsResource : TPermissionsResource;virtual;overload;
    Function CreateProductsResource(AOwner : TComponent) : TProductsResource;virtual;overload;
    Function CreateProductsResource : TProductsResource;virtual;overload;
    Function CreateStorelayoutclustersResource(AOwner : TComponent) : TStorelayoutclustersResource;virtual;overload;
    Function CreateStorelayoutclustersResource : TStorelayoutclustersResource;virtual;overload;
    Function CreateStorelayoutpagesResource(AOwner : TComponent) : TStorelayoutpagesResource;virtual;overload;
    Function CreateStorelayoutpagesResource : TStorelayoutpagesResource;virtual;overload;
    Function CreateUsersResource(AOwner : TComponent) : TUsersResource;virtual;overload;
    Function CreateUsersResource : TUsersResource;virtual;overload;
    //Add default on-demand instances for resources
    Property CollectionsResource : TCollectionsResource Read GetCollectionsInstance;
    Property CollectionviewersResource : TCollectionviewersResource Read GetCollectionviewersInstance;
    Property DevicesResource : TDevicesResource Read GetDevicesInstance;
    Property EnterprisesResource : TEnterprisesResource Read GetEnterprisesInstance;
    Property EntitlementsResource : TEntitlementsResource Read GetEntitlementsInstance;
    Property GrouplicensesResource : TGrouplicensesResource Read GetGrouplicensesInstance;
    Property GrouplicenseusersResource : TGrouplicenseusersResource Read GetGrouplicenseusersInstance;
    Property InstallsResource : TInstallsResource Read GetInstallsInstance;
    Property PermissionsResource : TPermissionsResource Read GetPermissionsInstance;
    Property ProductsResource : TProductsResource Read GetProductsInstance;
    Property StorelayoutclustersResource : TStorelayoutclustersResource Read GetStorelayoutclustersInstance;
    Property StorelayoutpagesResource : TStorelayoutpagesResource Read GetStorelayoutpagesInstance;
    Property UsersResource : TUsersResource Read GetUsersInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAppRestrictionsSchema
  --------------------------------------------------------------------}


Procedure TAppRestrictionsSchema.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchema.Setrestrictions(AIndex : Integer; const AValue : TAppRestrictionsSchemaTyperestrictionsArray); 

begin
  If (Frestrictions=AValue) then exit;
  Frestrictions:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAppRestrictionsSchema.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'restrictions' : SetLength(Frestrictions,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAppRestrictionsSchemaRestriction
  --------------------------------------------------------------------}


Procedure TAppRestrictionsSchemaRestriction.SetdefaultValue(AIndex : Integer; const AValue : TAppRestrictionsSchemaRestrictionRestrictionValue); 

begin
  If (FdefaultValue=AValue) then exit;
  FdefaultValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.Setentry(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fentry=AValue) then exit;
  Fentry:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.SetentryValue(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FentryValue=AValue) then exit;
  FentryValue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.SetrestrictionType(AIndex : Integer; const AValue : String); 

begin
  If (FrestrictionType=AValue) then exit;
  FrestrictionType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestriction.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAppRestrictionsSchemaRestriction.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'entry' : SetLength(Fentry,ALength);
  'entryvalue' : SetLength(FentryValue,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAppRestrictionsSchemaRestrictionRestrictionValue
  --------------------------------------------------------------------}


Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.SetvalueBool(AIndex : Integer; const AValue : boolean); 

begin
  If (FvalueBool=AValue) then exit;
  FvalueBool:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.SetvalueInteger(AIndex : Integer; const AValue : integer); 

begin
  If (FvalueInteger=AValue) then exit;
  FvalueInteger:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.SetvalueMultiselect(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FvalueMultiselect=AValue) then exit;
  FvalueMultiselect:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.SetvalueString(AIndex : Integer; const AValue : String); 

begin
  If (FvalueString=AValue) then exit;
  FvalueString:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAppRestrictionsSchemaRestrictionRestrictionValue.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAppRestrictionsSchemaRestrictionRestrictionValue.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'valuemultiselect' : SetLength(FvalueMultiselect,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAppVersion
  --------------------------------------------------------------------}


Procedure TAppVersion.SetversionCode(AIndex : Integer; const AValue : integer); 

begin
  If (FversionCode=AValue) then exit;
  FversionCode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAppVersion.SetversionString(AIndex : Integer; const AValue : String); 

begin
  If (FversionString=AValue) then exit;
  FversionString:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TApprovalUrlInfo
  --------------------------------------------------------------------}


Procedure TApprovalUrlInfo.SetapprovalUrl(AIndex : Integer; const AValue : String); 

begin
  If (FapprovalUrl=AValue) then exit;
  FapprovalUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TApprovalUrlInfo.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TCollection
  --------------------------------------------------------------------}


Procedure TCollection.SetcollectionId(AIndex : Integer; const AValue : String); 

begin
  If (FcollectionId=AValue) then exit;
  FcollectionId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollection.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollection.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollection.SetproductId(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollection.Setvisibility(AIndex : Integer; const AValue : String); 

begin
  If (Fvisibility=AValue) then exit;
  Fvisibility:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCollection.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'productid' : SetLength(FproductId,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCollectionViewersListResponse
  --------------------------------------------------------------------}


Procedure TCollectionViewersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollectionViewersListResponse.Setuser(AIndex : Integer; const AValue : TCollectionViewersListResponseTypeuserArray); 

begin
  If (Fuser=AValue) then exit;
  Fuser:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCollectionViewersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'user' : SetLength(Fuser,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCollectionsListResponse
  --------------------------------------------------------------------}


Procedure TCollectionsListResponse.Setcollection(AIndex : Integer; const AValue : TCollectionsListResponseTypecollectionArray); 

begin
  If (Fcollection=AValue) then exit;
  Fcollection:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCollectionsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCollectionsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'collection' : SetLength(Fcollection,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDevice
  --------------------------------------------------------------------}


Procedure TDevice.SetandroidId(AIndex : Integer; const AValue : String); 

begin
  If (FandroidId=AValue) then exit;
  FandroidId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDevice.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDevice.SetmanagementType(AIndex : Integer; const AValue : String); 

begin
  If (FmanagementType=AValue) then exit;
  FmanagementType:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDeviceState
  --------------------------------------------------------------------}


Procedure TDeviceState.SetaccountState(AIndex : Integer; const AValue : String); 

begin
  If (FaccountState=AValue) then exit;
  FaccountState:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDeviceState.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDevicesListResponse
  --------------------------------------------------------------------}


Procedure TDevicesListResponse.Setdevice(AIndex : Integer; const AValue : TDevicesListResponseTypedeviceArray); 

begin
  If (Fdevice=AValue) then exit;
  Fdevice:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDevicesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDevicesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'device' : SetLength(Fdevice,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TEnterprise
  --------------------------------------------------------------------}


Procedure TEnterprise.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterprise.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterprise.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterprise.SetprimaryDomain(AIndex : Integer; const AValue : String); 

begin
  If (FprimaryDomain=AValue) then exit;
  FprimaryDomain:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEnterpriseAccount
  --------------------------------------------------------------------}


Procedure TEnterpriseAccount.SetaccountEmail(AIndex : Integer; const AValue : String); 

begin
  If (FaccountEmail=AValue) then exit;
  FaccountEmail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterpriseAccount.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEnterprisesListResponse
  --------------------------------------------------------------------}


Procedure TEnterprisesListResponse.Setenterprise(AIndex : Integer; const AValue : TEnterprisesListResponseTypeenterpriseArray); 

begin
  If (Fenterprise=AValue) then exit;
  Fenterprise:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterprisesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TEnterprisesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'enterprise' : SetLength(Fenterprise,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TEnterprisesSendTestPushNotificationResponse
  --------------------------------------------------------------------}


Procedure TEnterprisesSendTestPushNotificationResponse.SetmessageId(AIndex : Integer; const AValue : String); 

begin
  If (FmessageId=AValue) then exit;
  FmessageId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEnterprisesSendTestPushNotificationResponse.SettopicName(AIndex : Integer; const AValue : String); 

begin
  If (FtopicName=AValue) then exit;
  FtopicName:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEntitlement
  --------------------------------------------------------------------}


Procedure TEntitlement.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEntitlement.SetproductId(AIndex : Integer; const AValue : String); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEntitlement.Setreason(AIndex : Integer; const AValue : String); 

begin
  If (Freason=AValue) then exit;
  Freason:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEntitlementsListResponse
  --------------------------------------------------------------------}


Procedure TEntitlementsListResponse.Setentitlement(AIndex : Integer; const AValue : TEntitlementsListResponseTypeentitlementArray); 

begin
  If (Fentitlement=AValue) then exit;
  Fentitlement:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEntitlementsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TEntitlementsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'entitlement' : SetLength(Fentitlement,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TGroupLicense
  --------------------------------------------------------------------}


Procedure TGroupLicense.SetacquisitionKind(AIndex : Integer; const AValue : String); 

begin
  If (FacquisitionKind=AValue) then exit;
  FacquisitionKind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicense.Setapproval(AIndex : Integer; const AValue : String); 

begin
  If (Fapproval=AValue) then exit;
  Fapproval:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicense.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicense.SetnumProvisioned(AIndex : Integer; const AValue : integer); 

begin
  If (FnumProvisioned=AValue) then exit;
  FnumProvisioned:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicense.SetnumPurchased(AIndex : Integer; const AValue : integer); 

begin
  If (FnumPurchased=AValue) then exit;
  FnumPurchased:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicense.SetproductId(AIndex : Integer; const AValue : String); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TGroupLicenseUsersListResponse
  --------------------------------------------------------------------}


Procedure TGroupLicenseUsersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicenseUsersListResponse.Setuser(AIndex : Integer; const AValue : TGroupLicenseUsersListResponseTypeuserArray); 

begin
  If (Fuser=AValue) then exit;
  Fuser:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TGroupLicenseUsersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'user' : SetLength(Fuser,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TGroupLicensesListResponse
  --------------------------------------------------------------------}


Procedure TGroupLicensesListResponse.SetgroupLicense(AIndex : Integer; const AValue : TGroupLicensesListResponseTypegroupLicenseArray); 

begin
  If (FgroupLicense=AValue) then exit;
  FgroupLicense:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGroupLicensesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TGroupLicensesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'grouplicense' : SetLength(FgroupLicense,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstall
  --------------------------------------------------------------------}


Procedure TInstall.SetinstallState(AIndex : Integer; const AValue : String); 

begin
  If (FinstallState=AValue) then exit;
  FinstallState:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstall.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstall.SetproductId(AIndex : Integer; const AValue : String); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstall.SetversionCode(AIndex : Integer; const AValue : integer); 

begin
  If (FversionCode=AValue) then exit;
  FversionCode:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstallsListResponse
  --------------------------------------------------------------------}


Procedure TInstallsListResponse.Setinstall(AIndex : Integer; const AValue : TInstallsListResponseTypeinstallArray); 

begin
  If (Finstall=AValue) then exit;
  Finstall:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstallsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstallsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'install' : SetLength(Finstall,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TLocalizedText
  --------------------------------------------------------------------}


Procedure TLocalizedText.Setlocale(AIndex : Integer; const AValue : String); 

begin
  If (Flocale=AValue) then exit;
  Flocale:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLocalizedText.Settext(AIndex : Integer; const AValue : String); 

begin
  If (Ftext=AValue) then exit;
  Ftext:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TPageInfo
  --------------------------------------------------------------------}


Procedure TPageInfo.SetresultPerPage(AIndex : Integer; const AValue : integer); 

begin
  If (FresultPerPage=AValue) then exit;
  FresultPerPage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPageInfo.SetstartIndex(AIndex : Integer; const AValue : integer); 

begin
  If (FstartIndex=AValue) then exit;
  FstartIndex:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPageInfo.SettotalResults(AIndex : Integer; const AValue : integer); 

begin
  If (FtotalResults=AValue) then exit;
  FtotalResults:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TPermission
  --------------------------------------------------------------------}


Procedure TPermission.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPermission.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPermission.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPermission.SetpermissionId(AIndex : Integer; const AValue : String); 

begin
  If (FpermissionId=AValue) then exit;
  FpermissionId:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TProduct
  --------------------------------------------------------------------}


Procedure TProduct.SetappVersion(AIndex : Integer; const AValue : TProductTypeappVersionArray); 

begin
  If (FappVersion=AValue) then exit;
  FappVersion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetauthorName(AIndex : Integer; const AValue : String); 

begin
  If (FauthorName=AValue) then exit;
  FauthorName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetdetailsUrl(AIndex : Integer; const AValue : String); 

begin
  If (FdetailsUrl=AValue) then exit;
  FdetailsUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetdistributionChannel(AIndex : Integer; const AValue : String); 

begin
  If (FdistributionChannel=AValue) then exit;
  FdistributionChannel:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SeticonUrl(AIndex : Integer; const AValue : String); 

begin
  If (FiconUrl=AValue) then exit;
  FiconUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetproductId(AIndex : Integer; const AValue : String); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetproductPricing(AIndex : Integer; const AValue : String); 

begin
  If (FproductPricing=AValue) then exit;
  FproductPricing:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetrequiresContainerApp(AIndex : Integer; const AValue : boolean); 

begin
  If (FrequiresContainerApp=AValue) then exit;
  FrequiresContainerApp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetsmallIconUrl(AIndex : Integer; const AValue : String); 

begin
  If (FsmallIconUrl=AValue) then exit;
  FsmallIconUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProduct.SetworkDetailsUrl(AIndex : Integer; const AValue : String); 

begin
  If (FworkDetailsUrl=AValue) then exit;
  FworkDetailsUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TProduct.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'appversion' : SetLength(FappVersion,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TProductPermission
  --------------------------------------------------------------------}


Procedure TProductPermission.SetpermissionId(AIndex : Integer; const AValue : String); 

begin
  If (FpermissionId=AValue) then exit;
  FpermissionId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductPermission.Setstate(AIndex : Integer; const AValue : String); 

begin
  If (Fstate=AValue) then exit;
  Fstate:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TProductPermissions
  --------------------------------------------------------------------}


Procedure TProductPermissions.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductPermissions.Setpermission(AIndex : Integer; const AValue : TProductPermissionsTypepermissionArray); 

begin
  If (Fpermission=AValue) then exit;
  Fpermission:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductPermissions.SetproductId(AIndex : Integer; const AValue : String); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TProductPermissions.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'permission' : SetLength(Fpermission,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TProductSet
  --------------------------------------------------------------------}


Procedure TProductSet.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductSet.SetproductId(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TProductSet.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'productid' : SetLength(FproductId,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TProductsApproveRequest
  --------------------------------------------------------------------}


Procedure TProductsApproveRequest.SetapprovalUrlInfo(AIndex : Integer; const AValue : TApprovalUrlInfo); 

begin
  If (FapprovalUrlInfo=AValue) then exit;
  FapprovalUrlInfo:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TProductsGenerateApprovalUrlResponse
  --------------------------------------------------------------------}


Procedure TProductsGenerateApprovalUrlResponse.Seturl(AIndex : Integer; const AValue : String); 

begin
  If (Furl=AValue) then exit;
  Furl:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TProductsListResponse
  --------------------------------------------------------------------}


Procedure TProductsListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductsListResponse.SetpageInfo(AIndex : Integer; const AValue : TPageInfo); 

begin
  If (FpageInfo=AValue) then exit;
  FpageInfo:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductsListResponse.Setproduct(AIndex : Integer; const AValue : TProductsListResponseTypeproductArray); 

begin
  If (Fproduct=AValue) then exit;
  Fproduct:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProductsListResponse.SettokenPagination(AIndex : Integer; const AValue : TTokenPagination); 

begin
  If (FtokenPagination=AValue) then exit;
  FtokenPagination:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TProductsListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'product' : SetLength(Fproduct,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TStoreCluster
  --------------------------------------------------------------------}


Procedure TStoreCluster.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreCluster.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreCluster.Setname(AIndex : Integer; const AValue : TStoreClusterTypenameArray); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreCluster.SetorderInPage(AIndex : Integer; const AValue : String); 

begin
  If (ForderInPage=AValue) then exit;
  ForderInPage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreCluster.SetproductId(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FproductId=AValue) then exit;
  FproductId:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TStoreCluster.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'name' : SetLength(Fname,ALength);
  'productid' : SetLength(FproductId,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TStoreLayout
  --------------------------------------------------------------------}


Procedure TStoreLayout.SethomepageId(AIndex : Integer; const AValue : String); 

begin
  If (FhomepageId=AValue) then exit;
  FhomepageId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreLayout.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TStoreLayoutClustersListResponse
  --------------------------------------------------------------------}


Procedure TStoreLayoutClustersListResponse.Setcluster(AIndex : Integer; const AValue : TStoreLayoutClustersListResponseTypeclusterArray); 

begin
  If (Fcluster=AValue) then exit;
  Fcluster:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreLayoutClustersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TStoreLayoutClustersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'cluster' : SetLength(Fcluster,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TStoreLayoutPagesListResponse
  --------------------------------------------------------------------}


Procedure TStoreLayoutPagesListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStoreLayoutPagesListResponse.Setpage(AIndex : Integer; const AValue : TStoreLayoutPagesListResponseTypepageArray); 

begin
  If (Fpage=AValue) then exit;
  Fpage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TStoreLayoutPagesListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'page' : SetLength(Fpage,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TStorePage
  --------------------------------------------------------------------}


Procedure TStorePage.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStorePage.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStorePage.Setlink(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flink=AValue) then exit;
  Flink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TStorePage.Setname(AIndex : Integer; const AValue : TStorePageTypenameArray); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TStorePage.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'link' : SetLength(Flink,ALength);
  'name' : SetLength(Fname,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTokenPagination
  --------------------------------------------------------------------}


Procedure TTokenPagination.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTokenPagination.SetpreviousPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FpreviousPageToken=AValue) then exit;
  FpreviousPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUser
  --------------------------------------------------------------------}


Procedure TUser.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUser.SetprimaryEmail(AIndex : Integer; const AValue : String); 

begin
  If (FprimaryEmail=AValue) then exit;
  FprimaryEmail:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUserToken
  --------------------------------------------------------------------}


Procedure TUserToken.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUserToken.Settoken(AIndex : Integer; const AValue : String); 

begin
  If (Ftoken=AValue) then exit;
  Ftoken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUserToken.SetuserId(AIndex : Integer; const AValue : String); 

begin
  If (FuserId=AValue) then exit;
  FuserId:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUsersListResponse
  --------------------------------------------------------------------}


Procedure TUsersListResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsersListResponse.Setuser(AIndex : Integer; const AValue : TUsersListResponseTypeuserArray); 

begin
  If (Fuser=AValue) then exit;
  Fuser:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUsersListResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'user' : SetLength(Fuser,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCollectionsResource
  --------------------------------------------------------------------}


Class Function TCollectionsResource.ResourceName : String;

begin
  Result:='collections';
end;

Class Function TCollectionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TCollectionsResource.Delete(collectionId: string; enterpriseId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}';
  _Methodid   = 'androidenterprise.collections.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TCollectionsResource.Get(collectionId: string; enterpriseId: string) : TCollection;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}';
  _Methodid   = 'androidenterprise.collections.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCollection) as TCollection;
end;

Function TCollectionsResource.Insert(enterpriseId: string; aCollection : TCollection) : TCollection;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/collections';
  _Methodid   = 'androidenterprise.collections.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCollection,TCollection) as TCollection;
end;

Function TCollectionsResource.List(enterpriseId: string) : TCollectionsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/collections';
  _Methodid   = 'androidenterprise.collections.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCollectionsListResponse) as TCollectionsListResponse;
end;

Function TCollectionsResource.Patch(collectionId: string; enterpriseId: string; aCollection : TCollection) : TCollection;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}';
  _Methodid   = 'androidenterprise.collections.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCollection,TCollection) as TCollection;
end;

Function TCollectionsResource.Update(collectionId: string; enterpriseId: string; aCollection : TCollection) : TCollection;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}';
  _Methodid   = 'androidenterprise.collections.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCollection,TCollection) as TCollection;
end;



{ --------------------------------------------------------------------
  TCollectionviewersResource
  --------------------------------------------------------------------}


Class Function TCollectionviewersResource.ResourceName : String;

begin
  Result:='collectionviewers';
end;

Class Function TCollectionviewersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TCollectionviewersResource.Delete(collectionId: string; enterpriseId: string; userId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}/users/{userId}';
  _Methodid   = 'androidenterprise.collectionviewers.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId,'userId',userId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TCollectionviewersResource.Get(collectionId: string; enterpriseId: string; userId: string) : TUser;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}/users/{userId}';
  _Methodid   = 'androidenterprise.collectionviewers.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUser) as TUser;
end;

Function TCollectionviewersResource.List(collectionId: string; enterpriseId: string) : TCollectionViewersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}/users';
  _Methodid   = 'androidenterprise.collectionviewers.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCollectionViewersListResponse) as TCollectionViewersListResponse;
end;

Function TCollectionviewersResource.Patch(collectionId: string; enterpriseId: string; userId: string; aUser : TUser) : TUser;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}/users/{userId}';
  _Methodid   = 'androidenterprise.collectionviewers.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUser,TUser) as TUser;
end;

Function TCollectionviewersResource.Update(collectionId: string; enterpriseId: string; userId: string; aUser : TUser) : TUser;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/collections/{collectionId}/users/{userId}';
  _Methodid   = 'androidenterprise.collectionviewers.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['collectionId',collectionId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUser,TUser) as TUser;
end;



{ --------------------------------------------------------------------
  TDevicesResource
  --------------------------------------------------------------------}


Class Function TDevicesResource.ResourceName : String;

begin
  Result:='devices';
end;

Class Function TDevicesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Function TDevicesResource.Get(deviceId: string; enterpriseId: string; userId: string) : TDevice;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}';
  _Methodid   = 'androidenterprise.devices.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDevice) as TDevice;
end;

Function TDevicesResource.GetState(deviceId: string; enterpriseId: string; userId: string) : TDeviceState;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/state';
  _Methodid   = 'androidenterprise.devices.getState';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDeviceState) as TDeviceState;
end;

Function TDevicesResource.List(enterpriseId: string; userId: string) : TDevicesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices';
  _Methodid   = 'androidenterprise.devices.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDevicesListResponse) as TDevicesListResponse;
end;

Function TDevicesResource.SetState(deviceId: string; enterpriseId: string; userId: string; aDeviceState : TDeviceState) : TDeviceState;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/state';
  _Methodid   = 'androidenterprise.devices.setState';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDeviceState,TDeviceState) as TDeviceState;
end;



{ --------------------------------------------------------------------
  TEnterprisesResource
  --------------------------------------------------------------------}


Class Function TEnterprisesResource.ResourceName : String;

begin
  Result:='enterprises';
end;

Class Function TEnterprisesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TEnterprisesResource.Delete(enterpriseId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}';
  _Methodid   = 'androidenterprise.enterprises.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TEnterprisesResource.Enroll(aEnterprise : TEnterprise; AQuery : string = '') : TEnterprise;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/enroll';
  _Methodid   = 'androidenterprise.enterprises.enroll';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,aEnterprise,TEnterprise) as TEnterprise;
end;


Function TEnterprisesResource.Enroll(aEnterprise : TEnterprise; AQuery : TEnterprisesenrollOptions) : TEnterprise;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'token',AQuery.token);
  Result:=Enroll(aEnterprise,_Q);
end;

Function TEnterprisesResource.Get(enterpriseId: string) : TEnterprise;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}';
  _Methodid   = 'androidenterprise.enterprises.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TEnterprise) as TEnterprise;
end;

Function TEnterprisesResource.GetStoreLayout(enterpriseId: string) : TStoreLayout;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/storeLayout';
  _Methodid   = 'androidenterprise.enterprises.getStoreLayout';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TStoreLayout) as TStoreLayout;
end;

Function TEnterprisesResource.Insert(aEnterprise : TEnterprise; AQuery : string = '') : TEnterprise;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises';
  _Methodid   = 'androidenterprise.enterprises.insert';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,aEnterprise,TEnterprise) as TEnterprise;
end;


Function TEnterprisesResource.Insert(aEnterprise : TEnterprise; AQuery : TEnterprisesinsertOptions) : TEnterprise;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'token',AQuery.token);
  Result:=Insert(aEnterprise,_Q);
end;

Function TEnterprisesResource.List(AQuery : string = '') : TEnterprisesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises';
  _Methodid   = 'androidenterprise.enterprises.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TEnterprisesListResponse) as TEnterprisesListResponse;
end;


Function TEnterprisesResource.List(AQuery : TEnterpriseslistOptions) : TEnterprisesListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'domain',AQuery.domain);
  Result:=List(_Q);
end;

Function TEnterprisesResource.SendTestPushNotification(enterpriseId: string) : TEnterprisesSendTestPushNotificationResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/sendTestPushNotification';
  _Methodid   = 'androidenterprise.enterprises.sendTestPushNotification';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TEnterprisesSendTestPushNotificationResponse) as TEnterprisesSendTestPushNotificationResponse;
end;

Function TEnterprisesResource.SetAccount(enterpriseId: string; aEnterpriseAccount : TEnterpriseAccount) : TEnterpriseAccount;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/account';
  _Methodid   = 'androidenterprise.enterprises.setAccount';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aEnterpriseAccount,TEnterpriseAccount) as TEnterpriseAccount;
end;

Function TEnterprisesResource.SetStoreLayout(enterpriseId: string; aStoreLayout : TStoreLayout) : TStoreLayout;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/storeLayout';
  _Methodid   = 'androidenterprise.enterprises.setStoreLayout';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStoreLayout,TStoreLayout) as TStoreLayout;
end;

Procedure TEnterprisesResource.Unenroll(enterpriseId: string);

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/unenroll';
  _Methodid   = 'androidenterprise.enterprises.unenroll';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;



{ --------------------------------------------------------------------
  TEntitlementsResource
  --------------------------------------------------------------------}


Class Function TEntitlementsResource.ResourceName : String;

begin
  Result:='entitlements';
end;

Class Function TEntitlementsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TEntitlementsResource.Delete(enterpriseId: string; entitlementId: string; userId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/entitlements/{entitlementId}';
  _Methodid   = 'androidenterprise.entitlements.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'entitlementId',entitlementId,'userId',userId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TEntitlementsResource.Get(enterpriseId: string; entitlementId: string; userId: string) : TEntitlement;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/entitlements/{entitlementId}';
  _Methodid   = 'androidenterprise.entitlements.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'entitlementId',entitlementId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TEntitlement) as TEntitlement;
end;

Function TEntitlementsResource.List(enterpriseId: string; userId: string) : TEntitlementsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/entitlements';
  _Methodid   = 'androidenterprise.entitlements.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TEntitlementsListResponse) as TEntitlementsListResponse;
end;

Function TEntitlementsResource.Patch(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : string = '') : TEntitlement;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/entitlements/{entitlementId}';
  _Methodid   = 'androidenterprise.entitlements.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'entitlementId',entitlementId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEntitlement,TEntitlement) as TEntitlement;
end;


Function TEntitlementsResource.Patch(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : TEntitlementspatchOptions) : TEntitlement;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'install',AQuery.install);
  Result:=Patch(enterpriseId,entitlementId,userId,aEntitlement,_Q);
end;

Function TEntitlementsResource.Update(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : string = '') : TEntitlement;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/entitlements/{entitlementId}';
  _Methodid   = 'androidenterprise.entitlements.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'entitlementId',entitlementId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEntitlement,TEntitlement) as TEntitlement;
end;


Function TEntitlementsResource.Update(enterpriseId: string; entitlementId: string; userId: string; aEntitlement : TEntitlement; AQuery : TEntitlementsupdateOptions) : TEntitlement;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'install',AQuery.install);
  Result:=Update(enterpriseId,entitlementId,userId,aEntitlement,_Q);
end;



{ --------------------------------------------------------------------
  TGrouplicensesResource
  --------------------------------------------------------------------}


Class Function TGrouplicensesResource.ResourceName : String;

begin
  Result:='grouplicenses';
end;

Class Function TGrouplicensesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Function TGrouplicensesResource.Get(enterpriseId: string; groupLicenseId: string) : TGroupLicense;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/groupLicenses/{groupLicenseId}';
  _Methodid   = 'androidenterprise.grouplicenses.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'groupLicenseId',groupLicenseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TGroupLicense) as TGroupLicense;
end;

Function TGrouplicensesResource.List(enterpriseId: string) : TGroupLicensesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/groupLicenses';
  _Methodid   = 'androidenterprise.grouplicenses.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TGroupLicensesListResponse) as TGroupLicensesListResponse;
end;



{ --------------------------------------------------------------------
  TGrouplicenseusersResource
  --------------------------------------------------------------------}


Class Function TGrouplicenseusersResource.ResourceName : String;

begin
  Result:='grouplicenseusers';
end;

Class Function TGrouplicenseusersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Function TGrouplicenseusersResource.List(enterpriseId: string; groupLicenseId: string) : TGroupLicenseUsersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/groupLicenses/{groupLicenseId}/users';
  _Methodid   = 'androidenterprise.grouplicenseusers.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'groupLicenseId',groupLicenseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TGroupLicenseUsersListResponse) as TGroupLicenseUsersListResponse;
end;



{ --------------------------------------------------------------------
  TInstallsResource
  --------------------------------------------------------------------}


Class Function TInstallsResource.ResourceName : String;

begin
  Result:='installs';
end;

Class Function TInstallsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TInstallsResource.Delete(deviceId: string; enterpriseId: string; installId: string; userId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/installs/{installId}';
  _Methodid   = 'androidenterprise.installs.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'installId',installId,'userId',userId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TInstallsResource.Get(deviceId: string; enterpriseId: string; installId: string; userId: string) : TInstall;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/installs/{installId}';
  _Methodid   = 'androidenterprise.installs.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'installId',installId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstall) as TInstall;
end;

Function TInstallsResource.List(deviceId: string; enterpriseId: string; userId: string) : TInstallsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/installs';
  _Methodid   = 'androidenterprise.installs.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstallsListResponse) as TInstallsListResponse;
end;

Function TInstallsResource.Patch(deviceId: string; enterpriseId: string; installId: string; userId: string; aInstall : TInstall) : TInstall;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/installs/{installId}';
  _Methodid   = 'androidenterprise.installs.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'installId',installId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstall,TInstall) as TInstall;
end;

Function TInstallsResource.Update(deviceId: string; enterpriseId: string; installId: string; userId: string; aInstall : TInstall) : TInstall;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/devices/{deviceId}/installs/{installId}';
  _Methodid   = 'androidenterprise.installs.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['deviceId',deviceId,'enterpriseId',enterpriseId,'installId',installId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstall,TInstall) as TInstall;
end;



{ --------------------------------------------------------------------
  TPermissionsResource
  --------------------------------------------------------------------}


Class Function TPermissionsResource.ResourceName : String;

begin
  Result:='permissions';
end;

Class Function TPermissionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Function TPermissionsResource.Get(permissionId: string; AQuery : string = '') : TPermission;

Const
  _HTTPMethod = 'GET';
  _Path       = 'permissions/{permissionId}';
  _Methodid   = 'androidenterprise.permissions.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['permissionId',permissionId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TPermission) as TPermission;
end;


Function TPermissionsResource.Get(permissionId: string; AQuery : TPermissionsgetOptions) : TPermission;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'language',AQuery.language);
  Result:=Get(permissionId,_Q);
end;



{ --------------------------------------------------------------------
  TProductsResource
  --------------------------------------------------------------------}


Class Function TProductsResource.ResourceName : String;

begin
  Result:='products';
end;

Class Function TProductsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TProductsResource.Approve(enterpriseId: string; productId: string; aProductsApproveRequest : TProductsApproveRequest);

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}/approve';
  _Methodid   = 'androidenterprise.products.approve';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  ServiceCall(_HTTPMethod,_P,'',aProductsApproveRequest,Nil);
end;

Function TProductsResource.GenerateApprovalUrl(enterpriseId: string; productId: string; AQuery : string = '') : TProductsGenerateApprovalUrlResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}/generateApprovalUrl';
  _Methodid   = 'androidenterprise.products.generateApprovalUrl';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TProductsGenerateApprovalUrlResponse) as TProductsGenerateApprovalUrlResponse;
end;


Function TProductsResource.GenerateApprovalUrl(enterpriseId: string; productId: string; AQuery : TProductsgenerateApprovalUrlOptions) : TProductsGenerateApprovalUrlResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'languageCode',AQuery.languageCode);
  Result:=GenerateApprovalUrl(enterpriseId,productId,_Q);
end;

Function TProductsResource.Get(enterpriseId: string; productId: string; AQuery : string = '') : TProduct;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}';
  _Methodid   = 'androidenterprise.products.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TProduct) as TProduct;
end;


Function TProductsResource.Get(enterpriseId: string; productId: string; AQuery : TProductsgetOptions) : TProduct;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'language',AQuery.language);
  Result:=Get(enterpriseId,productId,_Q);
end;

Function TProductsResource.GetAppRestrictionsSchema(enterpriseId: string; productId: string; AQuery : string = '') : TAppRestrictionsSchema;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}/appRestrictionsSchema';
  _Methodid   = 'androidenterprise.products.getAppRestrictionsSchema';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAppRestrictionsSchema) as TAppRestrictionsSchema;
end;


Function TProductsResource.GetAppRestrictionsSchema(enterpriseId: string; productId: string; AQuery : TProductsgetAppRestrictionsSchemaOptions) : TAppRestrictionsSchema;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'language',AQuery.language);
  Result:=GetAppRestrictionsSchema(enterpriseId,productId,_Q);
end;

Function TProductsResource.GetPermissions(enterpriseId: string; productId: string) : TProductPermissions;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}/permissions';
  _Methodid   = 'androidenterprise.products.getPermissions';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TProductPermissions) as TProductPermissions;
end;

Function TProductsResource.List(enterpriseId: string; AQuery : string = '') : TProductsListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/products';
  _Methodid   = 'androidenterprise.products.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TProductsListResponse) as TProductsListResponse;
end;


Function TProductsResource.List(enterpriseId: string; AQuery : TProductslistOptions) : TProductsListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'approved',AQuery.approved);
  AddToQuery(_Q,'language',AQuery.language);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'query',AQuery.query);
  AddToQuery(_Q,'token',AQuery.token);
  Result:=List(enterpriseId,_Q);
end;

Function TProductsResource.UpdatePermissions(enterpriseId: string; productId: string; aProductPermissions : TProductPermissions) : TProductPermissions;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/products/{productId}/permissions';
  _Methodid   = 'androidenterprise.products.updatePermissions';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'productId',productId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aProductPermissions,TProductPermissions) as TProductPermissions;
end;



{ --------------------------------------------------------------------
  TStorelayoutclustersResource
  --------------------------------------------------------------------}


Class Function TStorelayoutclustersResource.ResourceName : String;

begin
  Result:='storelayoutclusters';
end;

Class Function TStorelayoutclustersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TStorelayoutclustersResource.Delete(clusterId: string; enterpriseId: string; pageId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters/{clusterId}';
  _Methodid   = 'androidenterprise.storelayoutclusters.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['clusterId',clusterId,'enterpriseId',enterpriseId,'pageId',pageId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TStorelayoutclustersResource.Get(clusterId: string; enterpriseId: string; pageId: string) : TStoreCluster;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters/{clusterId}';
  _Methodid   = 'androidenterprise.storelayoutclusters.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['clusterId',clusterId,'enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TStoreCluster) as TStoreCluster;
end;

Function TStorelayoutclustersResource.Insert(enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters';
  _Methodid   = 'androidenterprise.storelayoutclusters.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStoreCluster,TStoreCluster) as TStoreCluster;
end;

Function TStorelayoutclustersResource.List(enterpriseId: string; pageId: string) : TStoreLayoutClustersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters';
  _Methodid   = 'androidenterprise.storelayoutclusters.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TStoreLayoutClustersListResponse) as TStoreLayoutClustersListResponse;
end;

Function TStorelayoutclustersResource.Patch(clusterId: string; enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters/{clusterId}';
  _Methodid   = 'androidenterprise.storelayoutclusters.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['clusterId',clusterId,'enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStoreCluster,TStoreCluster) as TStoreCluster;
end;

Function TStorelayoutclustersResource.Update(clusterId: string; enterpriseId: string; pageId: string; aStoreCluster : TStoreCluster) : TStoreCluster;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}/clusters/{clusterId}';
  _Methodid   = 'androidenterprise.storelayoutclusters.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['clusterId',clusterId,'enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStoreCluster,TStoreCluster) as TStoreCluster;
end;



{ --------------------------------------------------------------------
  TStorelayoutpagesResource
  --------------------------------------------------------------------}


Class Function TStorelayoutpagesResource.ResourceName : String;

begin
  Result:='storelayoutpages';
end;

Class Function TStorelayoutpagesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TandroidenterpriseAPI;
end;

Procedure TStorelayoutpagesResource.Delete(enterpriseId: string; pageId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}';
  _Methodid   = 'androidenterprise.storelayoutpages.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TStorelayoutpagesResource.Get(enterpriseId: string; pageId: string) : TStorePage;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}';
  _Methodid   = 'androidenterprise.storelayoutpages.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TStorePage) as TStorePage;
end;

Function TStorelayoutpagesResource.Insert(enterpriseId: string; aStorePage : TStorePage) : TStorePage;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages';
  _Methodid   = 'androidenterprise.storelayoutpages.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStorePage,TStorePage) as TStorePage;
end;

Function TStorelayoutpagesResource.List(enterpriseId: string) : TStoreLayoutPagesListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages';
  _Methodid   = 'androidenterprise.storelayoutpages.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TStoreLayoutPagesListResponse) as TStoreLayoutPagesListResponse;
end;

Function TStorelayoutpagesResource.Patch(enterpriseId: string; pageId: string; aStorePage : TStorePage) : TStorePage;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}';
  _Methodid   = 'androidenterprise.storelayoutpages.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStorePage,TStorePage) as TStorePage;
end;

Function TStorelayoutpagesResource.Update(enterpriseId: string; pageId: string; aStorePage : TStorePage) : TStorePage;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/storeLayout/pages/{pageId}';
  _Methodid   = 'androidenterprise.storelayoutpages.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'pageId',pageId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aStorePage,TStorePage) as TStorePage;
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
  Result:=TandroidenterpriseAPI;
end;

Function TUsersResource.GenerateToken(enterpriseId: string; userId: string) : TUserToken;

Const
  _HTTPMethod = 'POST';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/token';
  _Methodid   = 'androidenterprise.users.generateToken';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUserToken) as TUserToken;
end;

Function TUsersResource.Get(enterpriseId: string; userId: string) : TUser;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}';
  _Methodid   = 'androidenterprise.users.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUser) as TUser;
end;

Function TUsersResource.GetAvailableProductSet(enterpriseId: string; userId: string) : TProductSet;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/availableProductSet';
  _Methodid   = 'androidenterprise.users.getAvailableProductSet';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TProductSet) as TProductSet;
end;

Function TUsersResource.List(enterpriseId: string; AQuery : string = '') : TUsersListResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'enterprises/{enterpriseId}/users';
  _Methodid   = 'androidenterprise.users.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TUsersListResponse) as TUsersListResponse;
end;


Function TUsersResource.List(enterpriseId: string; AQuery : TUserslistOptions) : TUsersListResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'email',AQuery.email);
  Result:=List(enterpriseId,_Q);
end;

Procedure TUsersResource.RevokeToken(enterpriseId: string; userId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/token';
  _Methodid   = 'androidenterprise.users.revokeToken';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TUsersResource.SetAvailableProductSet(enterpriseId: string; userId: string; aProductSet : TProductSet) : TProductSet;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'enterprises/{enterpriseId}/users/{userId}/availableProductSet';
  _Methodid   = 'androidenterprise.users.setAvailableProductSet';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['enterpriseId',enterpriseId,'userId',userId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aProductSet,TProductSet) as TProductSet;
end;



{ --------------------------------------------------------------------
  TAndroidenterpriseAPI
  --------------------------------------------------------------------}

Class Function TAndroidenterpriseAPI.APIName : String;

begin
  Result:='androidenterprise';
end;

Class Function TAndroidenterpriseAPI.APIVersion : String;

begin
  Result:='v1';
end;

Class Function TAndroidenterpriseAPI.APIRevision : String;

begin
  Result:='20160511';
end;

Class Function TAndroidenterpriseAPI.APIID : String;

begin
  Result:='androidenterprise:v1';
end;

Class Function TAndroidenterpriseAPI.APITitle : String;

begin
  Result:='Google Play EMM API';
end;

Class Function TAndroidenterpriseAPI.APIDescription : String;

begin
  Result:='Manages the deployment of apps to Android for Work users.';
end;

Class Function TAndroidenterpriseAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TAndroidenterpriseAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TAndroidenterpriseAPI.APIIcon16 : String;

begin
  Result:='https://www.google.com/images/icons/product/android-16.png';
end;

Class Function TAndroidenterpriseAPI.APIIcon32 : String;

begin
  Result:='https://www.google.com/images/icons/product/android-32.png';
end;

Class Function TAndroidenterpriseAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/android/work/play/emm-api';
end;

Class Function TAndroidenterpriseAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TAndroidenterpriseAPI.APIbasePath : string;

begin
  Result:='/androidenterprise/v1/';
end;

Class Function TAndroidenterpriseAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/androidenterprise/v1/';
end;

Class Function TAndroidenterpriseAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TAndroidenterpriseAPI.APIservicePath : string;

begin
  Result:='androidenterprise/v1/';
end;

Class Function TAndroidenterpriseAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TAndroidenterpriseAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,1);
  Result[0].Name:='https://www.googleapis.com/auth/androidenterprise';
  Result[0].Description:='Manage corporate Android devices';
  
end;

Class Function TAndroidenterpriseAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TAndroidenterpriseAPI.RegisterAPIResources;

begin
  TAppRestrictionsSchema.RegisterObject;
  TAppRestrictionsSchemaRestriction.RegisterObject;
  TAppRestrictionsSchemaRestrictionRestrictionValue.RegisterObject;
  TAppVersion.RegisterObject;
  TApprovalUrlInfo.RegisterObject;
  TCollection.RegisterObject;
  TCollectionViewersListResponse.RegisterObject;
  TCollectionsListResponse.RegisterObject;
  TDevice.RegisterObject;
  TDeviceState.RegisterObject;
  TDevicesListResponse.RegisterObject;
  TEnterprise.RegisterObject;
  TEnterpriseAccount.RegisterObject;
  TEnterprisesListResponse.RegisterObject;
  TEnterprisesSendTestPushNotificationResponse.RegisterObject;
  TEntitlement.RegisterObject;
  TEntitlementsListResponse.RegisterObject;
  TGroupLicense.RegisterObject;
  TGroupLicenseUsersListResponse.RegisterObject;
  TGroupLicensesListResponse.RegisterObject;
  TInstall.RegisterObject;
  TInstallsListResponse.RegisterObject;
  TLocalizedText.RegisterObject;
  TPageInfo.RegisterObject;
  TPermission.RegisterObject;
  TProduct.RegisterObject;
  TProductPermission.RegisterObject;
  TProductPermissions.RegisterObject;
  TProductSet.RegisterObject;
  TProductsApproveRequest.RegisterObject;
  TProductsGenerateApprovalUrlResponse.RegisterObject;
  TProductsListResponse.RegisterObject;
  TStoreCluster.RegisterObject;
  TStoreLayout.RegisterObject;
  TStoreLayoutClustersListResponse.RegisterObject;
  TStoreLayoutPagesListResponse.RegisterObject;
  TStorePage.RegisterObject;
  TTokenPagination.RegisterObject;
  TUser.RegisterObject;
  TUserToken.RegisterObject;
  TUsersListResponse.RegisterObject;
end;


Function TAndroidenterpriseAPI.GetCollectionsInstance : TCollectionsResource;

begin
  if (FCollectionsInstance=Nil) then
    FCollectionsInstance:=CreateCollectionsResource;
  Result:=FCollectionsInstance;
end;

Function TAndroidenterpriseAPI.CreateCollectionsResource : TCollectionsResource;

begin
  Result:=CreateCollectionsResource(Self);
end;


Function TAndroidenterpriseAPI.CreateCollectionsResource(AOwner : TComponent) : TCollectionsResource;

begin
  Result:=TCollectionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetCollectionviewersInstance : TCollectionviewersResource;

begin
  if (FCollectionviewersInstance=Nil) then
    FCollectionviewersInstance:=CreateCollectionviewersResource;
  Result:=FCollectionviewersInstance;
end;

Function TAndroidenterpriseAPI.CreateCollectionviewersResource : TCollectionviewersResource;

begin
  Result:=CreateCollectionviewersResource(Self);
end;


Function TAndroidenterpriseAPI.CreateCollectionviewersResource(AOwner : TComponent) : TCollectionviewersResource;

begin
  Result:=TCollectionviewersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetDevicesInstance : TDevicesResource;

begin
  if (FDevicesInstance=Nil) then
    FDevicesInstance:=CreateDevicesResource;
  Result:=FDevicesInstance;
end;

Function TAndroidenterpriseAPI.CreateDevicesResource : TDevicesResource;

begin
  Result:=CreateDevicesResource(Self);
end;


Function TAndroidenterpriseAPI.CreateDevicesResource(AOwner : TComponent) : TDevicesResource;

begin
  Result:=TDevicesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetEnterprisesInstance : TEnterprisesResource;

begin
  if (FEnterprisesInstance=Nil) then
    FEnterprisesInstance:=CreateEnterprisesResource;
  Result:=FEnterprisesInstance;
end;

Function TAndroidenterpriseAPI.CreateEnterprisesResource : TEnterprisesResource;

begin
  Result:=CreateEnterprisesResource(Self);
end;


Function TAndroidenterpriseAPI.CreateEnterprisesResource(AOwner : TComponent) : TEnterprisesResource;

begin
  Result:=TEnterprisesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetEntitlementsInstance : TEntitlementsResource;

begin
  if (FEntitlementsInstance=Nil) then
    FEntitlementsInstance:=CreateEntitlementsResource;
  Result:=FEntitlementsInstance;
end;

Function TAndroidenterpriseAPI.CreateEntitlementsResource : TEntitlementsResource;

begin
  Result:=CreateEntitlementsResource(Self);
end;


Function TAndroidenterpriseAPI.CreateEntitlementsResource(AOwner : TComponent) : TEntitlementsResource;

begin
  Result:=TEntitlementsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetGrouplicensesInstance : TGrouplicensesResource;

begin
  if (FGrouplicensesInstance=Nil) then
    FGrouplicensesInstance:=CreateGrouplicensesResource;
  Result:=FGrouplicensesInstance;
end;

Function TAndroidenterpriseAPI.CreateGrouplicensesResource : TGrouplicensesResource;

begin
  Result:=CreateGrouplicensesResource(Self);
end;


Function TAndroidenterpriseAPI.CreateGrouplicensesResource(AOwner : TComponent) : TGrouplicensesResource;

begin
  Result:=TGrouplicensesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetGrouplicenseusersInstance : TGrouplicenseusersResource;

begin
  if (FGrouplicenseusersInstance=Nil) then
    FGrouplicenseusersInstance:=CreateGrouplicenseusersResource;
  Result:=FGrouplicenseusersInstance;
end;

Function TAndroidenterpriseAPI.CreateGrouplicenseusersResource : TGrouplicenseusersResource;

begin
  Result:=CreateGrouplicenseusersResource(Self);
end;


Function TAndroidenterpriseAPI.CreateGrouplicenseusersResource(AOwner : TComponent) : TGrouplicenseusersResource;

begin
  Result:=TGrouplicenseusersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetInstallsInstance : TInstallsResource;

begin
  if (FInstallsInstance=Nil) then
    FInstallsInstance:=CreateInstallsResource;
  Result:=FInstallsInstance;
end;

Function TAndroidenterpriseAPI.CreateInstallsResource : TInstallsResource;

begin
  Result:=CreateInstallsResource(Self);
end;


Function TAndroidenterpriseAPI.CreateInstallsResource(AOwner : TComponent) : TInstallsResource;

begin
  Result:=TInstallsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetPermissionsInstance : TPermissionsResource;

begin
  if (FPermissionsInstance=Nil) then
    FPermissionsInstance:=CreatePermissionsResource;
  Result:=FPermissionsInstance;
end;

Function TAndroidenterpriseAPI.CreatePermissionsResource : TPermissionsResource;

begin
  Result:=CreatePermissionsResource(Self);
end;


Function TAndroidenterpriseAPI.CreatePermissionsResource(AOwner : TComponent) : TPermissionsResource;

begin
  Result:=TPermissionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetProductsInstance : TProductsResource;

begin
  if (FProductsInstance=Nil) then
    FProductsInstance:=CreateProductsResource;
  Result:=FProductsInstance;
end;

Function TAndroidenterpriseAPI.CreateProductsResource : TProductsResource;

begin
  Result:=CreateProductsResource(Self);
end;


Function TAndroidenterpriseAPI.CreateProductsResource(AOwner : TComponent) : TProductsResource;

begin
  Result:=TProductsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetStorelayoutclustersInstance : TStorelayoutclustersResource;

begin
  if (FStorelayoutclustersInstance=Nil) then
    FStorelayoutclustersInstance:=CreateStorelayoutclustersResource;
  Result:=FStorelayoutclustersInstance;
end;

Function TAndroidenterpriseAPI.CreateStorelayoutclustersResource : TStorelayoutclustersResource;

begin
  Result:=CreateStorelayoutclustersResource(Self);
end;


Function TAndroidenterpriseAPI.CreateStorelayoutclustersResource(AOwner : TComponent) : TStorelayoutclustersResource;

begin
  Result:=TStorelayoutclustersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetStorelayoutpagesInstance : TStorelayoutpagesResource;

begin
  if (FStorelayoutpagesInstance=Nil) then
    FStorelayoutpagesInstance:=CreateStorelayoutpagesResource;
  Result:=FStorelayoutpagesInstance;
end;

Function TAndroidenterpriseAPI.CreateStorelayoutpagesResource : TStorelayoutpagesResource;

begin
  Result:=CreateStorelayoutpagesResource(Self);
end;


Function TAndroidenterpriseAPI.CreateStorelayoutpagesResource(AOwner : TComponent) : TStorelayoutpagesResource;

begin
  Result:=TStorelayoutpagesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TAndroidenterpriseAPI.GetUsersInstance : TUsersResource;

begin
  if (FUsersInstance=Nil) then
    FUsersInstance:=CreateUsersResource;
  Result:=FUsersInstance;
end;

Function TAndroidenterpriseAPI.CreateUsersResource : TUsersResource;

begin
  Result:=CreateUsersResource(Self);
end;


Function TAndroidenterpriseAPI.CreateUsersResource(AOwner : TComponent) : TUsersResource;

begin
  Result:=TUsersResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TAndroidenterpriseAPI.RegisterAPI;
end.
