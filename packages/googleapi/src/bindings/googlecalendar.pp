unit googlecalendar;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAcl = Class;
  TAclRule = Class;
  TCalendar = Class;
  TCalendarList = Class;
  TCalendarListEntry = Class;
  TCalendarNotification = Class;
  TChannel = Class;
  TColorDefinition = Class;
  TColors = Class;
  TError = Class;
  TEvent = Class;
  TEventAttachment = Class;
  TEventAttendee = Class;
  TEventDateTime = Class;
  TEventReminder = Class;
  TEvents = Class;
  TFreeBusyCalendar = Class;
  TFreeBusyGroup = Class;
  TFreeBusyRequest = Class;
  TFreeBusyRequestItem = Class;
  TFreeBusyResponse = Class;
  TSetting = Class;
  TSettings = Class;
  TTimePeriod = Class;
  TAclArray = Array of TAcl;
  TAclRuleArray = Array of TAclRule;
  TCalendarArray = Array of TCalendar;
  TCalendarListArray = Array of TCalendarList;
  TCalendarListEntryArray = Array of TCalendarListEntry;
  TCalendarNotificationArray = Array of TCalendarNotification;
  TChannelArray = Array of TChannel;
  TColorDefinitionArray = Array of TColorDefinition;
  TColorsArray = Array of TColors;
  TErrorArray = Array of TError;
  TEventArray = Array of TEvent;
  TEventAttachmentArray = Array of TEventAttachment;
  TEventAttendeeArray = Array of TEventAttendee;
  TEventDateTimeArray = Array of TEventDateTime;
  TEventReminderArray = Array of TEventReminder;
  TEventsArray = Array of TEvents;
  TFreeBusyCalendarArray = Array of TFreeBusyCalendar;
  TFreeBusyGroupArray = Array of TFreeBusyGroup;
  TFreeBusyRequestArray = Array of TFreeBusyRequest;
  TFreeBusyRequestItemArray = Array of TFreeBusyRequestItem;
  TFreeBusyResponseArray = Array of TFreeBusyResponse;
  TSettingArray = Array of TSetting;
  TSettingsArray = Array of TSettings;
  TTimePeriodArray = Array of TTimePeriod;
  //Anonymous types, using auto-generated names
  TAclRuleTypescope = Class;
  TCalendarListEntryTypenotificationSettings = Class;
  TChannelTypeparams = Class;
  TColorsTypecalendar = Class;
  TColorsTypeevent = Class;
  TEventTypecreator = Class;
  TEventTypeextendedPropertiesTypeprivate = Class;
  TEventTypeextendedPropertiesTypeshared = Class;
  TEventTypeextendedProperties = Class;
  TEventTypegadgetTypepreferences = Class;
  TEventTypegadget = Class;
  TEventTypeorganizer = Class;
  TEventTypereminders = Class;
  TEventTypesource = Class;
  TFreeBusyResponseTypecalendars = Class;
  TFreeBusyResponseTypegroups = Class;
  TAclTypeitemsArray = Array of TAclRule;
  TCalendarListTypeitemsArray = Array of TCalendarListEntry;
  TCalendarListEntryTypedefaultRemindersArray = Array of TEventReminder;
  TCalendarListEntryTypenotificationSettingsTypenotificationsArray = Array of TCalendarNotification;
  TEventTypeattachmentsArray = Array of TEventAttachment;
  TEventTypeattendeesArray = Array of TEventAttendee;
  TEventTyperemindersTypeoverridesArray = Array of TEventReminder;
  TEventsTypedefaultRemindersArray = Array of TEventReminder;
  TEventsTypeitemsArray = Array of TEvent;
  TFreeBusyCalendarTypebusyArray = Array of TTimePeriod;
  TFreeBusyCalendarTypeerrorsArray = Array of TError;
  TFreeBusyGroupTypeerrorsArray = Array of TError;
  TFreeBusyRequestTypeitemsArray = Array of TFreeBusyRequestItem;
  TSettingsTypeitemsArray = Array of TSetting;
  
  { --------------------------------------------------------------------
    TAcl
    --------------------------------------------------------------------}
  
  TAcl = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TAclTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FnextSyncToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAclTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextSyncToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TAclTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property nextSyncToken : String Index 32 Read FnextSyncToken Write SetnextSyncToken;
  end;
  TAclClass = Class of TAcl;
  
  { --------------------------------------------------------------------
    TAclRuleTypescope
    --------------------------------------------------------------------}
  
  TAclRuleTypescope = Class(TGoogleBaseObject)
  Private
    F_type : String;
    Fvalue : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property _type : String Index 0 Read F_type Write Set_type;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TAclRuleTypescopeClass = Class of TAclRuleTypescope;
  
  { --------------------------------------------------------------------
    TAclRule
    --------------------------------------------------------------------}
  
  TAclRule = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fid : String;
    Fkind : String;
    Frole : String;
    Fscope : TAclRuleTypescope;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setrole(AIndex : Integer; const AValue : String); virtual;
    Procedure Setscope(AIndex : Integer; const AValue : TAclRuleTypescope); virtual;
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property role : String Index 24 Read Frole Write Setrole;
    Property scope : TAclRuleTypescope Index 32 Read Fscope Write Setscope;
  end;
  TAclRuleClass = Class of TAclRule;
  
  { --------------------------------------------------------------------
    TCalendar
    --------------------------------------------------------------------}
  
  TCalendar = Class(TGoogleBaseObject)
  Private
    Fdescription : String;
    Fetag : String;
    Fid : String;
    Fkind : String;
    Flocation : String;
    Fsummary : String;
    FtimeZone : String;
  Protected
    //Property setters
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsummary(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeZone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property description : String Index 0 Read Fdescription Write Setdescription;
    Property etag : String Index 8 Read Fetag Write Setetag;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property location : String Index 32 Read Flocation Write Setlocation;
    Property summary : String Index 40 Read Fsummary Write Setsummary;
    Property timeZone : String Index 48 Read FtimeZone Write SettimeZone;
  end;
  TCalendarClass = Class of TCalendar;
  
  { --------------------------------------------------------------------
    TCalendarList
    --------------------------------------------------------------------}
  
  TCalendarList = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TCalendarListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FnextSyncToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TCalendarListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextSyncToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TCalendarListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property nextSyncToken : String Index 32 Read FnextSyncToken Write SetnextSyncToken;
  end;
  TCalendarListClass = Class of TCalendarList;
  
  { --------------------------------------------------------------------
    TCalendarListEntryTypenotificationSettings
    --------------------------------------------------------------------}
  
  TCalendarListEntryTypenotificationSettings = Class(TGoogleBaseObject)
  Private
    Fnotifications : TCalendarListEntryTypenotificationSettingsTypenotificationsArray;
  Protected
    //Property setters
    Procedure Setnotifications(AIndex : Integer; const AValue : TCalendarListEntryTypenotificationSettingsTypenotificationsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property notifications : TCalendarListEntryTypenotificationSettingsTypenotificationsArray Index 0 Read Fnotifications Write Setnotifications;
  end;
  TCalendarListEntryTypenotificationSettingsClass = Class of TCalendarListEntryTypenotificationSettings;
  
  { --------------------------------------------------------------------
    TCalendarListEntry
    --------------------------------------------------------------------}
  
  TCalendarListEntry = Class(TGoogleBaseObject)
  Private
    FaccessRole : String;
    FbackgroundColor : String;
    FcolorId : String;
    FdefaultReminders : TCalendarListEntryTypedefaultRemindersArray;
    Fdeleted : boolean;
    Fdescription : String;
    Fetag : String;
    FforegroundColor : String;
    Fhidden : boolean;
    Fid : String;
    Fkind : String;
    Flocation : String;
    FnotificationSettings : TCalendarListEntryTypenotificationSettings;
    Fprimary : boolean;
    Fselected : boolean;
    Fsummary : String;
    FsummaryOverride : String;
    FtimeZone : String;
  Protected
    //Property setters
    Procedure SetaccessRole(AIndex : Integer; const AValue : String); virtual;
    Procedure SetbackgroundColor(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcolorId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdefaultReminders(AIndex : Integer; const AValue : TCalendarListEntryTypedefaultRemindersArray); virtual;
    Procedure Setdeleted(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure SetforegroundColor(AIndex : Integer; const AValue : String); virtual;
    Procedure Sethidden(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocation(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnotificationSettings(AIndex : Integer; const AValue : TCalendarListEntryTypenotificationSettings); virtual;
    Procedure Setprimary(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setselected(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setsummary(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsummaryOverride(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeZone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property accessRole : String Index 0 Read FaccessRole Write SetaccessRole;
    Property backgroundColor : String Index 8 Read FbackgroundColor Write SetbackgroundColor;
    Property colorId : String Index 16 Read FcolorId Write SetcolorId;
    Property defaultReminders : TCalendarListEntryTypedefaultRemindersArray Index 24 Read FdefaultReminders Write SetdefaultReminders;
    Property deleted : boolean Index 32 Read Fdeleted Write Setdeleted;
    Property description : String Index 40 Read Fdescription Write Setdescription;
    Property etag : String Index 48 Read Fetag Write Setetag;
    Property foregroundColor : String Index 56 Read FforegroundColor Write SetforegroundColor;
    Property hidden : boolean Index 64 Read Fhidden Write Sethidden;
    Property id : String Index 72 Read Fid Write Setid;
    Property kind : String Index 80 Read Fkind Write Setkind;
    Property location : String Index 88 Read Flocation Write Setlocation;
    Property notificationSettings : TCalendarListEntryTypenotificationSettings Index 96 Read FnotificationSettings Write SetnotificationSettings;
    Property primary : boolean Index 104 Read Fprimary Write Setprimary;
    Property selected : boolean Index 112 Read Fselected Write Setselected;
    Property summary : String Index 120 Read Fsummary Write Setsummary;
    Property summaryOverride : String Index 128 Read FsummaryOverride Write SetsummaryOverride;
    Property timeZone : String Index 136 Read FtimeZone Write SettimeZone;
  end;
  TCalendarListEntryClass = Class of TCalendarListEntry;
  
  { --------------------------------------------------------------------
    TCalendarNotification
    --------------------------------------------------------------------}
  
  TCalendarNotification = Class(TGoogleBaseObject)
  Private
    Fmethod : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setmethod(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property method : String Index 0 Read Fmethod Write Setmethod;
    Property _type : String Index 8 Read F_type Write Set_type;
  end;
  TCalendarNotificationClass = Class of TCalendarNotification;
  
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
    TColorDefinition
    --------------------------------------------------------------------}
  
  TColorDefinition = Class(TGoogleBaseObject)
  Private
    Fbackground : String;
    Fforeground : String;
  Protected
    //Property setters
    Procedure Setbackground(AIndex : Integer; const AValue : String); virtual;
    Procedure Setforeground(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property background : String Index 0 Read Fbackground Write Setbackground;
    Property foreground : String Index 8 Read Fforeground Write Setforeground;
  end;
  TColorDefinitionClass = Class of TColorDefinition;
  
  { --------------------------------------------------------------------
    TColorsTypecalendar
    --------------------------------------------------------------------}
  
  TColorsTypecalendar = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TColorsTypecalendarClass = Class of TColorsTypecalendar;
  
  { --------------------------------------------------------------------
    TColorsTypeevent
    --------------------------------------------------------------------}
  
  TColorsTypeevent = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TColorsTypeeventClass = Class of TColorsTypeevent;
  
  { --------------------------------------------------------------------
    TColors
    --------------------------------------------------------------------}
  
  TColors = Class(TGoogleBaseObject)
  Private
    Fcalendar : TColorsTypecalendar;
    Fevent : TColorsTypeevent;
    Fkind : String;
    Fupdated : TDatetime;
  Protected
    //Property setters
    Procedure Setcalendar(AIndex : Integer; const AValue : TColorsTypecalendar); virtual;
    Procedure Setevent(AIndex : Integer; const AValue : TColorsTypeevent); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setupdated(AIndex : Integer; const AValue : TDatetime); virtual;
  Public
  Published
    Property calendar : TColorsTypecalendar Index 0 Read Fcalendar Write Setcalendar;
    Property event : TColorsTypeevent Index 8 Read Fevent Write Setevent;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property updated : TDatetime Index 24 Read Fupdated Write Setupdated;
  end;
  TColorsClass = Class of TColors;
  
  { --------------------------------------------------------------------
    TError
    --------------------------------------------------------------------}
  
  TError = Class(TGoogleBaseObject)
  Private
    Fdomain : String;
    Freason : String;
  Protected
    //Property setters
    Procedure Setdomain(AIndex : Integer; const AValue : String); virtual;
    Procedure Setreason(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property domain : String Index 0 Read Fdomain Write Setdomain;
    Property reason : String Index 8 Read Freason Write Setreason;
  end;
  TErrorClass = Class of TError;
  
  { --------------------------------------------------------------------
    TEventTypecreator
    --------------------------------------------------------------------}
  
  TEventTypecreator = Class(TGoogleBaseObject)
  Private
    FdisplayName : String;
    Femail : String;
    Fid : String;
    F_self : boolean;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetdisplayName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_self(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property displayName : String Index 0 Read FdisplayName Write SetdisplayName;
    Property email : String Index 8 Read Femail Write Setemail;
    Property id : String Index 16 Read Fid Write Setid;
    Property _self : boolean Index 24 Read F_self Write Set_self;
  end;
  TEventTypecreatorClass = Class of TEventTypecreator;
  
  { --------------------------------------------------------------------
    TEventTypeextendedPropertiesTypeprivate
    --------------------------------------------------------------------}
  
  TEventTypeextendedPropertiesTypeprivate = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TEventTypeextendedPropertiesTypeprivateClass = Class of TEventTypeextendedPropertiesTypeprivate;
  
  { --------------------------------------------------------------------
    TEventTypeextendedPropertiesTypeshared
    --------------------------------------------------------------------}
  
  TEventTypeextendedPropertiesTypeshared = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TEventTypeextendedPropertiesTypesharedClass = Class of TEventTypeextendedPropertiesTypeshared;
  
  { --------------------------------------------------------------------
    TEventTypeextendedProperties
    --------------------------------------------------------------------}
  
  TEventTypeextendedProperties = Class(TGoogleBaseObject)
  Private
    F_private : TEventTypeextendedPropertiesTypeprivate;
    Fshared : TEventTypeextendedPropertiesTypeshared;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Set_private(AIndex : Integer; const AValue : TEventTypeextendedPropertiesTypeprivate); virtual;
    Procedure Setshared(AIndex : Integer; const AValue : TEventTypeextendedPropertiesTypeshared); virtual;
  Public
  Published
    Property _private : TEventTypeextendedPropertiesTypeprivate Index 0 Read F_private Write Set_private;
    Property shared : TEventTypeextendedPropertiesTypeshared Index 8 Read Fshared Write Setshared;
  end;
  TEventTypeextendedPropertiesClass = Class of TEventTypeextendedProperties;
  
  { --------------------------------------------------------------------
    TEventTypegadgetTypepreferences
    --------------------------------------------------------------------}
  
  TEventTypegadgetTypepreferences = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TEventTypegadgetTypepreferencesClass = Class of TEventTypegadgetTypepreferences;
  
  { --------------------------------------------------------------------
    TEventTypegadget
    --------------------------------------------------------------------}
  
  TEventTypegadget = Class(TGoogleBaseObject)
  Private
    Fdisplay : String;
    Fheight : integer;
    FiconLink : String;
    Flink : String;
    Fpreferences : TEventTypegadgetTypepreferences;
    Ftitle : String;
    F_type : String;
    Fwidth : integer;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setdisplay(AIndex : Integer; const AValue : String); virtual;
    Procedure Setheight(AIndex : Integer; const AValue : integer); virtual;
    Procedure SeticonLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpreferences(AIndex : Integer; const AValue : TEventTypegadgetTypepreferences); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure Setwidth(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property display : String Index 0 Read Fdisplay Write Setdisplay;
    Property height : integer Index 8 Read Fheight Write Setheight;
    Property iconLink : String Index 16 Read FiconLink Write SeticonLink;
    Property link : String Index 24 Read Flink Write Setlink;
    Property preferences : TEventTypegadgetTypepreferences Index 32 Read Fpreferences Write Setpreferences;
    Property title : String Index 40 Read Ftitle Write Settitle;
    Property _type : String Index 48 Read F_type Write Set_type;
    Property width : integer Index 56 Read Fwidth Write Setwidth;
  end;
  TEventTypegadgetClass = Class of TEventTypegadget;
  
  { --------------------------------------------------------------------
    TEventTypeorganizer
    --------------------------------------------------------------------}
  
  TEventTypeorganizer = Class(TGoogleBaseObject)
  Private
    FdisplayName : String;
    Femail : String;
    Fid : String;
    F_self : boolean;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetdisplayName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_self(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property displayName : String Index 0 Read FdisplayName Write SetdisplayName;
    Property email : String Index 8 Read Femail Write Setemail;
    Property id : String Index 16 Read Fid Write Setid;
    Property _self : boolean Index 24 Read F_self Write Set_self;
  end;
  TEventTypeorganizerClass = Class of TEventTypeorganizer;
  
  { --------------------------------------------------------------------
    TEventTypereminders
    --------------------------------------------------------------------}
  
  TEventTypereminders = Class(TGoogleBaseObject)
  Private
    Foverrides : TEventTyperemindersTypeoverridesArray;
    FuseDefault : boolean;
  Protected
    //Property setters
    Procedure Setoverrides(AIndex : Integer; const AValue : TEventTyperemindersTypeoverridesArray); virtual;
    Procedure SetuseDefault(AIndex : Integer; const AValue : boolean); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property overrides : TEventTyperemindersTypeoverridesArray Index 0 Read Foverrides Write Setoverrides;
    Property useDefault : boolean Index 8 Read FuseDefault Write SetuseDefault;
  end;
  TEventTyperemindersClass = Class of TEventTypereminders;
  
  { --------------------------------------------------------------------
    TEventTypesource
    --------------------------------------------------------------------}
  
  TEventTypesource = Class(TGoogleBaseObject)
  Private
    Ftitle : String;
    Furl : String;
  Protected
    //Property setters
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturl(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property title : String Index 0 Read Ftitle Write Settitle;
    Property url : String Index 8 Read Furl Write Seturl;
  end;
  TEventTypesourceClass = Class of TEventTypesource;
  
  { --------------------------------------------------------------------
    TEvent
    --------------------------------------------------------------------}
  
  TEvent = Class(TGoogleBaseObject)
  Private
    FanyoneCanAddSelf : boolean;
    Fattachments : TEventTypeattachmentsArray;
    Fattendees : TEventTypeattendeesArray;
    FattendeesOmitted : boolean;
    FcolorId : String;
    Fcreated : TDatetime;
    Fcreator : TEventTypecreator;
    Fdescription : String;
    F_end : TEventDateTime;
    FendTimeUnspecified : boolean;
    Fetag : String;
    FextendedProperties : TEventTypeextendedProperties;
    Fgadget : TEventTypegadget;
    FguestsCanInviteOthers : boolean;
    FguestsCanModify : boolean;
    FguestsCanSeeOtherGuests : boolean;
    FhangoutLink : String;
    FhtmlLink : String;
    FiCalUID : String;
    Fid : String;
    Fkind : String;
    Flocation : String;
    Flocked : boolean;
    Forganizer : TEventTypeorganizer;
    ForiginalStartTime : TEventDateTime;
    FprivateCopy : boolean;
    Frecurrence : TStringArray;
    FrecurringEventId : String;
    Freminders : TEventTypereminders;
    Fsequence : integer;
    Fsource : TEventTypesource;
    Fstart : TEventDateTime;
    Fstatus : String;
    Fsummary : String;
    Ftransparency : String;
    Fupdated : TDatetime;
    Fvisibility : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetanyoneCanAddSelf(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setattachments(AIndex : Integer; const AValue : TEventTypeattachmentsArray); virtual;
    Procedure Setattendees(AIndex : Integer; const AValue : TEventTypeattendeesArray); virtual;
    Procedure SetattendeesOmitted(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetcolorId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setcreated(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setcreator(AIndex : Integer; const AValue : TEventTypecreator); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_end(AIndex : Integer; const AValue : TEventDateTime); virtual;
    Procedure SetendTimeUnspecified(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure SetextendedProperties(AIndex : Integer; const AValue : TEventTypeextendedProperties); virtual;
    Procedure Setgadget(AIndex : Integer; const AValue : TEventTypegadget); virtual;
    Procedure SetguestsCanInviteOthers(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetguestsCanModify(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetguestsCanSeeOtherGuests(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SethangoutLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SethtmlLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetiCalUID(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocked(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setorganizer(AIndex : Integer; const AValue : TEventTypeorganizer); virtual;
    Procedure SetoriginalStartTime(AIndex : Integer; const AValue : TEventDateTime); virtual;
    Procedure SetprivateCopy(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setrecurrence(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetrecurringEventId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setreminders(AIndex : Integer; const AValue : TEventTypereminders); virtual;
    Procedure Setsequence(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setsource(AIndex : Integer; const AValue : TEventTypesource); virtual;
    Procedure Setstart(AIndex : Integer; const AValue : TEventDateTime); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsummary(AIndex : Integer; const AValue : String); virtual;
    Procedure Settransparency(AIndex : Integer; const AValue : String); virtual;
    Procedure Setupdated(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setvisibility(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property anyoneCanAddSelf : boolean Index 0 Read FanyoneCanAddSelf Write SetanyoneCanAddSelf;
    Property attachments : TEventTypeattachmentsArray Index 8 Read Fattachments Write Setattachments;
    Property attendees : TEventTypeattendeesArray Index 16 Read Fattendees Write Setattendees;
    Property attendeesOmitted : boolean Index 24 Read FattendeesOmitted Write SetattendeesOmitted;
    Property colorId : String Index 32 Read FcolorId Write SetcolorId;
    Property created : TDatetime Index 40 Read Fcreated Write Setcreated;
    Property creator : TEventTypecreator Index 48 Read Fcreator Write Setcreator;
    Property description : String Index 56 Read Fdescription Write Setdescription;
    Property _end : TEventDateTime Index 64 Read F_end Write Set_end;
    Property endTimeUnspecified : boolean Index 72 Read FendTimeUnspecified Write SetendTimeUnspecified;
    Property etag : String Index 80 Read Fetag Write Setetag;
    Property extendedProperties : TEventTypeextendedProperties Index 88 Read FextendedProperties Write SetextendedProperties;
    Property gadget : TEventTypegadget Index 96 Read Fgadget Write Setgadget;
    Property guestsCanInviteOthers : boolean Index 104 Read FguestsCanInviteOthers Write SetguestsCanInviteOthers;
    Property guestsCanModify : boolean Index 112 Read FguestsCanModify Write SetguestsCanModify;
    Property guestsCanSeeOtherGuests : boolean Index 120 Read FguestsCanSeeOtherGuests Write SetguestsCanSeeOtherGuests;
    Property hangoutLink : String Index 128 Read FhangoutLink Write SethangoutLink;
    Property htmlLink : String Index 136 Read FhtmlLink Write SethtmlLink;
    Property iCalUID : String Index 144 Read FiCalUID Write SetiCalUID;
    Property id : String Index 152 Read Fid Write Setid;
    Property kind : String Index 160 Read Fkind Write Setkind;
    Property location : String Index 168 Read Flocation Write Setlocation;
    Property locked : boolean Index 176 Read Flocked Write Setlocked;
    Property organizer : TEventTypeorganizer Index 184 Read Forganizer Write Setorganizer;
    Property originalStartTime : TEventDateTime Index 192 Read ForiginalStartTime Write SetoriginalStartTime;
    Property privateCopy : boolean Index 200 Read FprivateCopy Write SetprivateCopy;
    Property recurrence : TStringArray Index 208 Read Frecurrence Write Setrecurrence;
    Property recurringEventId : String Index 216 Read FrecurringEventId Write SetrecurringEventId;
    Property reminders : TEventTypereminders Index 224 Read Freminders Write Setreminders;
    Property sequence : integer Index 232 Read Fsequence Write Setsequence;
    Property source : TEventTypesource Index 240 Read Fsource Write Setsource;
    Property start : TEventDateTime Index 248 Read Fstart Write Setstart;
    Property status : String Index 256 Read Fstatus Write Setstatus;
    Property summary : String Index 264 Read Fsummary Write Setsummary;
    Property transparency : String Index 272 Read Ftransparency Write Settransparency;
    Property updated : TDatetime Index 280 Read Fupdated Write Setupdated;
    Property visibility : String Index 288 Read Fvisibility Write Setvisibility;
  end;
  TEventClass = Class of TEvent;
  
  { --------------------------------------------------------------------
    TEventAttachment
    --------------------------------------------------------------------}
  
  TEventAttachment = Class(TGoogleBaseObject)
  Private
    FfileId : String;
    FfileUrl : String;
    FiconLink : String;
    FmimeType : String;
    Ftitle : String;
  Protected
    //Property setters
    Procedure SetfileId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetfileUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SeticonLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmimeType(AIndex : Integer; const AValue : String); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property fileId : String Index 0 Read FfileId Write SetfileId;
    Property fileUrl : String Index 8 Read FfileUrl Write SetfileUrl;
    Property iconLink : String Index 16 Read FiconLink Write SeticonLink;
    Property mimeType : String Index 24 Read FmimeType Write SetmimeType;
    Property title : String Index 32 Read Ftitle Write Settitle;
  end;
  TEventAttachmentClass = Class of TEventAttachment;
  
  { --------------------------------------------------------------------
    TEventAttendee
    --------------------------------------------------------------------}
  
  TEventAttendee = Class(TGoogleBaseObject)
  Private
    FadditionalGuests : integer;
    Fcomment : String;
    FdisplayName : String;
    Femail : String;
    Fid : String;
    Foptional : boolean;
    Forganizer : boolean;
    Fresource : boolean;
    FresponseStatus : String;
    F_self : boolean;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetadditionalGuests(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setcomment(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdisplayName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setoptional(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setorganizer(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setresource(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetresponseStatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_self(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property additionalGuests : integer Index 0 Read FadditionalGuests Write SetadditionalGuests;
    Property comment : String Index 8 Read Fcomment Write Setcomment;
    Property displayName : String Index 16 Read FdisplayName Write SetdisplayName;
    Property email : String Index 24 Read Femail Write Setemail;
    Property id : String Index 32 Read Fid Write Setid;
    Property optional : boolean Index 40 Read Foptional Write Setoptional;
    Property organizer : boolean Index 48 Read Forganizer Write Setorganizer;
    Property resource : boolean Index 56 Read Fresource Write Setresource;
    Property responseStatus : String Index 64 Read FresponseStatus Write SetresponseStatus;
    Property _self : boolean Index 72 Read F_self Write Set_self;
  end;
  TEventAttendeeClass = Class of TEventAttendee;
  
  { --------------------------------------------------------------------
    TEventDateTime
    --------------------------------------------------------------------}
  
  TEventDateTime = Class(TGoogleBaseObject)
  Private
    Fdate : TDate;
    FdateTime : TDatetime;
    FtimeZone : String;
  Protected
    //Property setters
    Procedure Setdate(AIndex : Integer; const AValue : TDate); virtual;
    Procedure SetdateTime(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SettimeZone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property date : TDate Index 0 Read Fdate Write Setdate;
    Property dateTime : TDatetime Index 8 Read FdateTime Write SetdateTime;
    Property timeZone : String Index 16 Read FtimeZone Write SettimeZone;
  end;
  TEventDateTimeClass = Class of TEventDateTime;
  
  { --------------------------------------------------------------------
    TEventReminder
    --------------------------------------------------------------------}
  
  TEventReminder = Class(TGoogleBaseObject)
  Private
    Fmethod : String;
    Fminutes : integer;
  Protected
    //Property setters
    Procedure Setmethod(AIndex : Integer; const AValue : String); virtual;
    Procedure Setminutes(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property method : String Index 0 Read Fmethod Write Setmethod;
    Property minutes : integer Index 8 Read Fminutes Write Setminutes;
  end;
  TEventReminderClass = Class of TEventReminder;
  
  { --------------------------------------------------------------------
    TEvents
    --------------------------------------------------------------------}
  
  TEvents = Class(TGoogleBaseObject)
  Private
    FaccessRole : String;
    FdefaultReminders : TEventsTypedefaultRemindersArray;
    Fdescription : String;
    Fetag : String;
    Fitems : TEventsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FnextSyncToken : String;
    Fsummary : String;
    FtimeZone : String;
    Fupdated : TDatetime;
  Protected
    //Property setters
    Procedure SetaccessRole(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdefaultReminders(AIndex : Integer; const AValue : TEventsTypedefaultRemindersArray); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TEventsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextSyncToken(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsummary(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeZone(AIndex : Integer; const AValue : String); virtual;
    Procedure Setupdated(AIndex : Integer; const AValue : TDatetime); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property accessRole : String Index 0 Read FaccessRole Write SetaccessRole;
    Property defaultReminders : TEventsTypedefaultRemindersArray Index 8 Read FdefaultReminders Write SetdefaultReminders;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property etag : String Index 24 Read Fetag Write Setetag;
    Property items : TEventsTypeitemsArray Index 32 Read Fitems Write Setitems;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property nextPageToken : String Index 48 Read FnextPageToken Write SetnextPageToken;
    Property nextSyncToken : String Index 56 Read FnextSyncToken Write SetnextSyncToken;
    Property summary : String Index 64 Read Fsummary Write Setsummary;
    Property timeZone : String Index 72 Read FtimeZone Write SettimeZone;
    Property updated : TDatetime Index 80 Read Fupdated Write Setupdated;
  end;
  TEventsClass = Class of TEvents;
  
  { --------------------------------------------------------------------
    TFreeBusyCalendar
    --------------------------------------------------------------------}
  
  TFreeBusyCalendar = Class(TGoogleBaseObject)
  Private
    Fbusy : TFreeBusyCalendarTypebusyArray;
    Ferrors : TFreeBusyCalendarTypeerrorsArray;
  Protected
    //Property setters
    Procedure Setbusy(AIndex : Integer; const AValue : TFreeBusyCalendarTypebusyArray); virtual;
    Procedure Seterrors(AIndex : Integer; const AValue : TFreeBusyCalendarTypeerrorsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property busy : TFreeBusyCalendarTypebusyArray Index 0 Read Fbusy Write Setbusy;
    Property errors : TFreeBusyCalendarTypeerrorsArray Index 8 Read Ferrors Write Seterrors;
  end;
  TFreeBusyCalendarClass = Class of TFreeBusyCalendar;
  
  { --------------------------------------------------------------------
    TFreeBusyGroup
    --------------------------------------------------------------------}
  
  TFreeBusyGroup = Class(TGoogleBaseObject)
  Private
    Fcalendars : TStringArray;
    Ferrors : TFreeBusyGroupTypeerrorsArray;
  Protected
    //Property setters
    Procedure Setcalendars(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Seterrors(AIndex : Integer; const AValue : TFreeBusyGroupTypeerrorsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property calendars : TStringArray Index 0 Read Fcalendars Write Setcalendars;
    Property errors : TFreeBusyGroupTypeerrorsArray Index 8 Read Ferrors Write Seterrors;
  end;
  TFreeBusyGroupClass = Class of TFreeBusyGroup;
  
  { --------------------------------------------------------------------
    TFreeBusyRequest
    --------------------------------------------------------------------}
  
  TFreeBusyRequest = Class(TGoogleBaseObject)
  Private
    FcalendarExpansionMax : integer;
    FgroupExpansionMax : integer;
    Fitems : TFreeBusyRequestTypeitemsArray;
    FtimeMax : TDatetime;
    FtimeMin : TDatetime;
    FtimeZone : String;
  Protected
    //Property setters
    Procedure SetcalendarExpansionMax(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetgroupExpansionMax(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TFreeBusyRequestTypeitemsArray); virtual;
    Procedure SettimeMax(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SettimeMin(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SettimeZone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property calendarExpansionMax : integer Index 0 Read FcalendarExpansionMax Write SetcalendarExpansionMax;
    Property groupExpansionMax : integer Index 8 Read FgroupExpansionMax Write SetgroupExpansionMax;
    Property items : TFreeBusyRequestTypeitemsArray Index 16 Read Fitems Write Setitems;
    Property timeMax : TDatetime Index 24 Read FtimeMax Write SettimeMax;
    Property timeMin : TDatetime Index 32 Read FtimeMin Write SettimeMin;
    Property timeZone : String Index 40 Read FtimeZone Write SettimeZone;
  end;
  TFreeBusyRequestClass = Class of TFreeBusyRequest;
  
  { --------------------------------------------------------------------
    TFreeBusyRequestItem
    --------------------------------------------------------------------}
  
  TFreeBusyRequestItem = Class(TGoogleBaseObject)
  Private
    Fid : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
  end;
  TFreeBusyRequestItemClass = Class of TFreeBusyRequestItem;
  
  { --------------------------------------------------------------------
    TFreeBusyResponseTypecalendars
    --------------------------------------------------------------------}
  
  TFreeBusyResponseTypecalendars = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TFreeBusyResponseTypecalendarsClass = Class of TFreeBusyResponseTypecalendars;
  
  { --------------------------------------------------------------------
    TFreeBusyResponseTypegroups
    --------------------------------------------------------------------}
  
  TFreeBusyResponseTypegroups = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TFreeBusyResponseTypegroupsClass = Class of TFreeBusyResponseTypegroups;
  
  { --------------------------------------------------------------------
    TFreeBusyResponse
    --------------------------------------------------------------------}
  
  TFreeBusyResponse = Class(TGoogleBaseObject)
  Private
    Fcalendars : TFreeBusyResponseTypecalendars;
    Fgroups : TFreeBusyResponseTypegroups;
    Fkind : String;
    FtimeMax : TDatetime;
    FtimeMin : TDatetime;
  Protected
    //Property setters
    Procedure Setcalendars(AIndex : Integer; const AValue : TFreeBusyResponseTypecalendars); virtual;
    Procedure Setgroups(AIndex : Integer; const AValue : TFreeBusyResponseTypegroups); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeMax(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure SettimeMin(AIndex : Integer; const AValue : TDatetime); virtual;
  Public
  Published
    Property calendars : TFreeBusyResponseTypecalendars Index 0 Read Fcalendars Write Setcalendars;
    Property groups : TFreeBusyResponseTypegroups Index 8 Read Fgroups Write Setgroups;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property timeMax : TDatetime Index 24 Read FtimeMax Write SettimeMax;
    Property timeMin : TDatetime Index 32 Read FtimeMin Write SettimeMin;
  end;
  TFreeBusyResponseClass = Class of TFreeBusyResponse;
  
  { --------------------------------------------------------------------
    TSetting
    --------------------------------------------------------------------}
  
  TSetting = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fid : String;
    Fkind : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property id : String Index 8 Read Fid Write Setid;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property value : String Index 24 Read Fvalue Write Setvalue;
  end;
  TSettingClass = Class of TSetting;
  
  { --------------------------------------------------------------------
    TSettings
    --------------------------------------------------------------------}
  
  TSettings = Class(TGoogleBaseObject)
  Private
    Fetag : String;
    Fitems : TSettingsTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FnextSyncToken : String;
  Protected
    //Property setters
    Procedure Setetag(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TSettingsTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextSyncToken(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property etag : String Index 0 Read Fetag Write Setetag;
    Property items : TSettingsTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property nextSyncToken : String Index 32 Read FnextSyncToken Write SetnextSyncToken;
  end;
  TSettingsClass = Class of TSettings;
  
  { --------------------------------------------------------------------
    TTimePeriod
    --------------------------------------------------------------------}
  
  TTimePeriod = Class(TGoogleBaseObject)
  Private
    F_end : TDatetime;
    Fstart : TDatetime;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Set_end(AIndex : Integer; const AValue : TDatetime); virtual;
    Procedure Setstart(AIndex : Integer; const AValue : TDatetime); virtual;
  Public
  Published
    Property _end : TDatetime Index 0 Read F_end Write Set_end;
    Property start : TDatetime Index 8 Read Fstart Write Setstart;
  end;
  TTimePeriodClass = Class of TTimePeriod;
  
  { --------------------------------------------------------------------
    TAclResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAclResource, method List
  
  TAclListOptions = Record
    maxResults : integer;
    pageToken : String;
    showDeleted : boolean;
    syncToken : String;
  end;
  
  
  //Optional query Options for TAclResource, method Watch
  
  TAclWatchOptions = Record
    maxResults : integer;
    pageToken : String;
    showDeleted : boolean;
    syncToken : String;
  end;
  
  TAclResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(calendarId: string; ruleId: string);
    Function Get(calendarId: string; ruleId: string) : TAclRule;
    Function Insert(calendarId: string; aAclRule : TAclRule) : TAclRule;
    Function List(calendarId: string; AQuery : string  = '') : TAcl;
    Function List(calendarId: string; AQuery : TAcllistOptions) : TAcl;
    Function Patch(calendarId: string; ruleId: string; aAclRule : TAclRule) : TAclRule;
    Function Update(calendarId: string; ruleId: string; aAclRule : TAclRule) : TAclRule;
    Function Watch(calendarId: string; aChannel : TChannel; AQuery : string  = '') : TChannel;
    Function Watch(calendarId: string; aChannel : TChannel; AQuery : TAclwatchOptions) : TChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TCalendarListResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TCalendarListResource, method Insert
  
  TCalendarListInsertOptions = Record
    colorRgbFormat : boolean;
  end;
  
  
  //Optional query Options for TCalendarListResource, method List
  
  TCalendarListListOptions = Record
    maxResults : integer;
    minAccessRole : String;
    pageToken : String;
    showDeleted : boolean;
    showHidden : boolean;
    syncToken : String;
  end;
  
  
  //Optional query Options for TCalendarListResource, method Patch
  
  TCalendarListPatchOptions = Record
    colorRgbFormat : boolean;
  end;
  
  
  //Optional query Options for TCalendarListResource, method Update
  
  TCalendarListUpdateOptions = Record
    colorRgbFormat : boolean;
  end;
  
  
  //Optional query Options for TCalendarListResource, method Watch
  
  TCalendarListWatchOptions = Record
    maxResults : integer;
    minAccessRole : String;
    pageToken : String;
    showDeleted : boolean;
    showHidden : boolean;
    syncToken : String;
  end;
  
  TCalendarListResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(calendarId: string);
    Function Get(calendarId: string) : TCalendarListEntry;
    Function Insert(aCalendarListEntry : TCalendarListEntry; AQuery : string  = '') : TCalendarListEntry;
    Function Insert(aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListinsertOptions) : TCalendarListEntry;
    Function List(AQuery : string  = '') : TCalendarList;
    Function List(AQuery : TCalendarListlistOptions) : TCalendarList;
    Function Patch(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : string  = '') : TCalendarListEntry;
    Function Patch(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListpatchOptions) : TCalendarListEntry;
    Function Update(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : string  = '') : TCalendarListEntry;
    Function Update(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListupdateOptions) : TCalendarListEntry;
    Function Watch(aChannel : TChannel; AQuery : string  = '') : TChannel;
    Function Watch(aChannel : TChannel; AQuery : TCalendarListwatchOptions) : TChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TCalendarsResource
    --------------------------------------------------------------------}
  
  TCalendarsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Clear(calendarId: string);
    Procedure Delete(calendarId: string);
    Function Get(calendarId: string) : TCalendar;
    Function Insert(aCalendar : TCalendar) : TCalendar;
    Function Patch(calendarId: string; aCalendar : TCalendar) : TCalendar;
    Function Update(calendarId: string; aCalendar : TCalendar) : TCalendar;
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
    TColorsResource
    --------------------------------------------------------------------}
  
  TColorsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get : TColors;
  end;
  
  
  { --------------------------------------------------------------------
    TEventsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TEventsResource, method Delete
  
  TEventsDeleteOptions = Record
    sendNotifications : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method Get
  
  TEventsGetOptions = Record
    alwaysIncludeEmail : boolean;
    maxAttendees : integer;
    timeZone : String;
  end;
  
  
  //Optional query Options for TEventsResource, method Import
  
  TEventsImportOptions = Record
    supportsAttachments : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method Insert
  
  TEventsInsertOptions = Record
    maxAttendees : integer;
    sendNotifications : boolean;
    supportsAttachments : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method Instances
  
  TEventsInstancesOptions = Record
    alwaysIncludeEmail : boolean;
    maxAttendees : integer;
    maxResults : integer;
    originalStart : String;
    pageToken : String;
    showDeleted : boolean;
    timeMax : TDatetime;
    timeMin : TDatetime;
    timeZone : String;
  end;
  
  
  //Optional query Options for TEventsResource, method List
  
  TEventsListOptions = Record
    alwaysIncludeEmail : boolean;
    iCalUID : String;
    maxAttendees : integer;
    maxResults : integer;
    orderBy : String;
    pageToken : String;
    privateExtendedProperty : String;
    q : String;
    sharedExtendedProperty : String;
    showDeleted : boolean;
    showHiddenInvitations : boolean;
    singleEvents : boolean;
    syncToken : String;
    timeMax : TDatetime;
    timeMin : TDatetime;
    timeZone : String;
    updatedMin : TDatetime;
  end;
  
  
  //Optional query Options for TEventsResource, method Move
  
  TEventsMoveOptions = Record
    destination : String;
    sendNotifications : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method Patch
  
  TEventsPatchOptions = Record
    alwaysIncludeEmail : boolean;
    maxAttendees : integer;
    sendNotifications : boolean;
    supportsAttachments : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method QuickAdd
  
  TEventsQuickAddOptions = Record
    sendNotifications : boolean;
    text : String;
  end;
  
  
  //Optional query Options for TEventsResource, method Update
  
  TEventsUpdateOptions = Record
    alwaysIncludeEmail : boolean;
    maxAttendees : integer;
    sendNotifications : boolean;
    supportsAttachments : boolean;
  end;
  
  
  //Optional query Options for TEventsResource, method Watch
  
  TEventsWatchOptions = Record
    alwaysIncludeEmail : boolean;
    iCalUID : String;
    maxAttendees : integer;
    maxResults : integer;
    orderBy : String;
    pageToken : String;
    privateExtendedProperty : String;
    q : String;
    sharedExtendedProperty : String;
    showDeleted : boolean;
    showHiddenInvitations : boolean;
    singleEvents : boolean;
    syncToken : String;
    timeMax : TDatetime;
    timeMin : TDatetime;
    timeZone : String;
    updatedMin : TDatetime;
  end;
  
  TEventsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(calendarId: string; eventId: string; AQuery : string  = '');
    Procedure Delete(calendarId: string; eventId: string; AQuery : TEventsdeleteOptions);
    Function Get(calendarId: string; eventId: string; AQuery : string  = '') : TEvent;
    Function Get(calendarId: string; eventId: string; AQuery : TEventsgetOptions) : TEvent;
    Function Import(calendarId: string; aEvent : TEvent; AQuery : string  = '') : TEvent;
    Function Import(calendarId: string; aEvent : TEvent; AQuery : TEventsimportOptions) : TEvent;
    Function Insert(calendarId: string; aEvent : TEvent; AQuery : string  = '') : TEvent;
    Function Insert(calendarId: string; aEvent : TEvent; AQuery : TEventsinsertOptions) : TEvent;
    Function Instances(calendarId: string; eventId: string; AQuery : string  = '') : TEvents;
    Function Instances(calendarId: string; eventId: string; AQuery : TEventsinstancesOptions) : TEvents;
    Function List(calendarId: string; AQuery : string  = '') : TEvents;
    Function List(calendarId: string; AQuery : TEventslistOptions) : TEvents;
    Function Move(calendarId: string; eventId: string; AQuery : string  = '') : TEvent;
    Function Move(calendarId: string; eventId: string; AQuery : TEventsmoveOptions) : TEvent;
    Function Patch(calendarId: string; eventId: string; aEvent : TEvent; AQuery : string  = '') : TEvent;
    Function Patch(calendarId: string; eventId: string; aEvent : TEvent; AQuery : TEventspatchOptions) : TEvent;
    Function QuickAdd(calendarId: string; AQuery : string  = '') : TEvent;
    Function QuickAdd(calendarId: string; AQuery : TEventsquickAddOptions) : TEvent;
    Function Update(calendarId: string; eventId: string; aEvent : TEvent; AQuery : string  = '') : TEvent;
    Function Update(calendarId: string; eventId: string; aEvent : TEvent; AQuery : TEventsupdateOptions) : TEvent;
    Function Watch(calendarId: string; aChannel : TChannel; AQuery : string  = '') : TChannel;
    Function Watch(calendarId: string; aChannel : TChannel; AQuery : TEventswatchOptions) : TChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TFreebusyResource
    --------------------------------------------------------------------}
  
  TFreebusyResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Query(aFreeBusyRequest : TFreeBusyRequest) : TFreeBusyResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TSettingsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TSettingsResource, method List
  
  TSettingsListOptions = Record
    maxResults : integer;
    pageToken : String;
    syncToken : String;
  end;
  
  
  //Optional query Options for TSettingsResource, method Watch
  
  TSettingsWatchOptions = Record
    maxResults : integer;
    pageToken : String;
    syncToken : String;
  end;
  
  TSettingsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(setting: string) : TSetting;
    Function List(AQuery : string  = '') : TSettings;
    Function List(AQuery : TSettingslistOptions) : TSettings;
    Function Watch(aChannel : TChannel; AQuery : string  = '') : TChannel;
    Function Watch(aChannel : TChannel; AQuery : TSettingswatchOptions) : TChannel;
  end;
  
  
  { --------------------------------------------------------------------
    TCalendarAPI
    --------------------------------------------------------------------}
  
  TCalendarAPI = Class(TGoogleAPI)
  Private
    FAclInstance : TAclResource;
    FCalendarListInstance : TCalendarListResource;
    FCalendarsInstance : TCalendarsResource;
    FChannelsInstance : TChannelsResource;
    FColorsInstance : TColorsResource;
    FEventsInstance : TEventsResource;
    FFreebusyInstance : TFreebusyResource;
    FSettingsInstance : TSettingsResource;
    Function GetAclInstance : TAclResource;virtual;
    Function GetCalendarListInstance : TCalendarListResource;virtual;
    Function GetCalendarsInstance : TCalendarsResource;virtual;
    Function GetChannelsInstance : TChannelsResource;virtual;
    Function GetColorsInstance : TColorsResource;virtual;
    Function GetEventsInstance : TEventsResource;virtual;
    Function GetFreebusyInstance : TFreebusyResource;virtual;
    Function GetSettingsInstance : TSettingsResource;virtual;
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
    Function CreateAclResource(AOwner : TComponent) : TAclResource;virtual;overload;
    Function CreateAclResource : TAclResource;virtual;overload;
    Function CreateCalendarListResource(AOwner : TComponent) : TCalendarListResource;virtual;overload;
    Function CreateCalendarListResource : TCalendarListResource;virtual;overload;
    Function CreateCalendarsResource(AOwner : TComponent) : TCalendarsResource;virtual;overload;
    Function CreateCalendarsResource : TCalendarsResource;virtual;overload;
    Function CreateChannelsResource(AOwner : TComponent) : TChannelsResource;virtual;overload;
    Function CreateChannelsResource : TChannelsResource;virtual;overload;
    Function CreateColorsResource(AOwner : TComponent) : TColorsResource;virtual;overload;
    Function CreateColorsResource : TColorsResource;virtual;overload;
    Function CreateEventsResource(AOwner : TComponent) : TEventsResource;virtual;overload;
    Function CreateEventsResource : TEventsResource;virtual;overload;
    Function CreateFreebusyResource(AOwner : TComponent) : TFreebusyResource;virtual;overload;
    Function CreateFreebusyResource : TFreebusyResource;virtual;overload;
    Function CreateSettingsResource(AOwner : TComponent) : TSettingsResource;virtual;overload;
    Function CreateSettingsResource : TSettingsResource;virtual;overload;
    //Add default on-demand instances for resources
    Property AclResource : TAclResource Read GetAclInstance;
    Property CalendarListResource : TCalendarListResource Read GetCalendarListInstance;
    Property CalendarsResource : TCalendarsResource Read GetCalendarsInstance;
    Property ChannelsResource : TChannelsResource Read GetChannelsInstance;
    Property ColorsResource : TColorsResource Read GetColorsInstance;
    Property EventsResource : TEventsResource Read GetEventsInstance;
    Property FreebusyResource : TFreebusyResource Read GetFreebusyInstance;
    Property SettingsResource : TSettingsResource Read GetSettingsInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAcl
  --------------------------------------------------------------------}


Procedure TAcl.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAcl.Setitems(AIndex : Integer; const AValue : TAclTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAcl.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAcl.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAcl.SetnextSyncToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextSyncToken=AValue) then exit;
  FnextSyncToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAcl.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAclRuleTypescope
  --------------------------------------------------------------------}


Procedure TAclRuleTypescope.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclRuleTypescope.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAclRuleTypescope.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAclRule
  --------------------------------------------------------------------}


Procedure TAclRule.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclRule.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclRule.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclRule.Setrole(AIndex : Integer; const AValue : String); 

begin
  If (Frole=AValue) then exit;
  Frole:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAclRule.Setscope(AIndex : Integer; const AValue : TAclRuleTypescope); 

begin
  If (Fscope=AValue) then exit;
  Fscope:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TCalendar
  --------------------------------------------------------------------}


Procedure TCalendar.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.Setlocation(AIndex : Integer; const AValue : String); 

begin
  If (Flocation=AValue) then exit;
  Flocation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.Setsummary(AIndex : Integer; const AValue : String); 

begin
  If (Fsummary=AValue) then exit;
  Fsummary:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendar.SettimeZone(AIndex : Integer; const AValue : String); 

begin
  If (FtimeZone=AValue) then exit;
  FtimeZone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TCalendarList
  --------------------------------------------------------------------}


Procedure TCalendarList.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarList.Setitems(AIndex : Integer; const AValue : TCalendarListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarList.SetnextSyncToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextSyncToken=AValue) then exit;
  FnextSyncToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCalendarList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCalendarListEntryTypenotificationSettings
  --------------------------------------------------------------------}


Procedure TCalendarListEntryTypenotificationSettings.Setnotifications(AIndex : Integer; const AValue : TCalendarListEntryTypenotificationSettingsTypenotificationsArray); 

begin
  If (Fnotifications=AValue) then exit;
  Fnotifications:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCalendarListEntryTypenotificationSettings.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'notifications' : SetLength(Fnotifications,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCalendarListEntry
  --------------------------------------------------------------------}


Procedure TCalendarListEntry.SetaccessRole(AIndex : Integer; const AValue : String); 

begin
  If (FaccessRole=AValue) then exit;
  FaccessRole:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetbackgroundColor(AIndex : Integer; const AValue : String); 

begin
  If (FbackgroundColor=AValue) then exit;
  FbackgroundColor:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetcolorId(AIndex : Integer; const AValue : String); 

begin
  If (FcolorId=AValue) then exit;
  FcolorId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetdefaultReminders(AIndex : Integer; const AValue : TCalendarListEntryTypedefaultRemindersArray); 

begin
  If (FdefaultReminders=AValue) then exit;
  FdefaultReminders:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setdeleted(AIndex : Integer; const AValue : boolean); 

begin
  If (Fdeleted=AValue) then exit;
  Fdeleted:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetforegroundColor(AIndex : Integer; const AValue : String); 

begin
  If (FforegroundColor=AValue) then exit;
  FforegroundColor:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Sethidden(AIndex : Integer; const AValue : boolean); 

begin
  If (Fhidden=AValue) then exit;
  Fhidden:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setlocation(AIndex : Integer; const AValue : String); 

begin
  If (Flocation=AValue) then exit;
  Flocation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetnotificationSettings(AIndex : Integer; const AValue : TCalendarListEntryTypenotificationSettings); 

begin
  If (FnotificationSettings=AValue) then exit;
  FnotificationSettings:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setprimary(AIndex : Integer; const AValue : boolean); 

begin
  If (Fprimary=AValue) then exit;
  Fprimary:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setselected(AIndex : Integer; const AValue : boolean); 

begin
  If (Fselected=AValue) then exit;
  Fselected:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.Setsummary(AIndex : Integer; const AValue : String); 

begin
  If (Fsummary=AValue) then exit;
  Fsummary:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SetsummaryOverride(AIndex : Integer; const AValue : String); 

begin
  If (FsummaryOverride=AValue) then exit;
  FsummaryOverride:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarListEntry.SettimeZone(AIndex : Integer; const AValue : String); 

begin
  If (FtimeZone=AValue) then exit;
  FtimeZone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCalendarListEntry.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'defaultreminders' : SetLength(FdefaultReminders,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCalendarNotification
  --------------------------------------------------------------------}


Procedure TCalendarNotification.Setmethod(AIndex : Integer; const AValue : String); 

begin
  If (Fmethod=AValue) then exit;
  Fmethod:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCalendarNotification.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TCalendarNotification.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




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
  TColorDefinition
  --------------------------------------------------------------------}


Procedure TColorDefinition.Setbackground(AIndex : Integer; const AValue : String); 

begin
  If (Fbackground=AValue) then exit;
  Fbackground:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TColorDefinition.Setforeground(AIndex : Integer; const AValue : String); 

begin
  If (Fforeground=AValue) then exit;
  Fforeground:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TColorsTypecalendar
  --------------------------------------------------------------------}


Class Function TColorsTypecalendar.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TColorsTypeevent
  --------------------------------------------------------------------}


Class Function TColorsTypeevent.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TColors
  --------------------------------------------------------------------}


Procedure TColors.Setcalendar(AIndex : Integer; const AValue : TColorsTypecalendar); 

begin
  If (Fcalendar=AValue) then exit;
  Fcalendar:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TColors.Setevent(AIndex : Integer; const AValue : TColorsTypeevent); 

begin
  If (Fevent=AValue) then exit;
  Fevent:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TColors.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TColors.Setupdated(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Fupdated=AValue) then exit;
  Fupdated:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TError
  --------------------------------------------------------------------}


Procedure TError.Setdomain(AIndex : Integer; const AValue : String); 

begin
  If (Fdomain=AValue) then exit;
  Fdomain:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TError.Setreason(AIndex : Integer; const AValue : String); 

begin
  If (Freason=AValue) then exit;
  Freason:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEventTypecreator
  --------------------------------------------------------------------}


Procedure TEventTypecreator.SetdisplayName(AIndex : Integer; const AValue : String); 

begin
  If (FdisplayName=AValue) then exit;
  FdisplayName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypecreator.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypecreator.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypecreator.Set_self(AIndex : Integer; const AValue : boolean); 

begin
  If (F_self=AValue) then exit;
  F_self:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEventTypecreator.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_self' : Result:='self';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TEventTypeextendedPropertiesTypeprivate
  --------------------------------------------------------------------}


Class Function TEventTypeextendedPropertiesTypeprivate.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TEventTypeextendedPropertiesTypeshared
  --------------------------------------------------------------------}


Class Function TEventTypeextendedPropertiesTypeshared.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TEventTypeextendedProperties
  --------------------------------------------------------------------}


Procedure TEventTypeextendedProperties.Set_private(AIndex : Integer; const AValue : TEventTypeextendedPropertiesTypeprivate); 

begin
  If (F_private=AValue) then exit;
  F_private:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypeextendedProperties.Setshared(AIndex : Integer; const AValue : TEventTypeextendedPropertiesTypeshared); 

begin
  If (Fshared=AValue) then exit;
  Fshared:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEventTypeextendedProperties.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_private' : Result:='private';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TEventTypegadgetTypepreferences
  --------------------------------------------------------------------}


Class Function TEventTypegadgetTypepreferences.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TEventTypegadget
  --------------------------------------------------------------------}


Procedure TEventTypegadget.Setdisplay(AIndex : Integer; const AValue : String); 

begin
  If (Fdisplay=AValue) then exit;
  Fdisplay:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Setheight(AIndex : Integer; const AValue : integer); 

begin
  If (Fheight=AValue) then exit;
  Fheight:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.SeticonLink(AIndex : Integer; const AValue : String); 

begin
  If (FiconLink=AValue) then exit;
  FiconLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Setlink(AIndex : Integer; const AValue : String); 

begin
  If (Flink=AValue) then exit;
  Flink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Setpreferences(AIndex : Integer; const AValue : TEventTypegadgetTypepreferences); 

begin
  If (Fpreferences=AValue) then exit;
  Fpreferences:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypegadget.Setwidth(AIndex : Integer; const AValue : integer); 

begin
  If (Fwidth=AValue) then exit;
  Fwidth:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEventTypegadget.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TEventTypeorganizer
  --------------------------------------------------------------------}


Procedure TEventTypeorganizer.SetdisplayName(AIndex : Integer; const AValue : String); 

begin
  If (FdisplayName=AValue) then exit;
  FdisplayName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypeorganizer.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypeorganizer.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypeorganizer.Set_self(AIndex : Integer; const AValue : boolean); 

begin
  If (F_self=AValue) then exit;
  F_self:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEventTypeorganizer.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_self' : Result:='self';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TEventTypereminders
  --------------------------------------------------------------------}


Procedure TEventTypereminders.Setoverrides(AIndex : Integer; const AValue : TEventTyperemindersTypeoverridesArray); 

begin
  If (Foverrides=AValue) then exit;
  Foverrides:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypereminders.SetuseDefault(AIndex : Integer; const AValue : boolean); 

begin
  If (FuseDefault=AValue) then exit;
  FuseDefault:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TEventTypereminders.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'overrides' : SetLength(Foverrides,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TEventTypesource
  --------------------------------------------------------------------}


Procedure TEventTypesource.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventTypesource.Seturl(AIndex : Integer; const AValue : String); 

begin
  If (Furl=AValue) then exit;
  Furl:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEvent
  --------------------------------------------------------------------}


Procedure TEvent.SetanyoneCanAddSelf(AIndex : Integer; const AValue : boolean); 

begin
  If (FanyoneCanAddSelf=AValue) then exit;
  FanyoneCanAddSelf:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setattachments(AIndex : Integer; const AValue : TEventTypeattachmentsArray); 

begin
  If (Fattachments=AValue) then exit;
  Fattachments:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setattendees(AIndex : Integer; const AValue : TEventTypeattendeesArray); 

begin
  If (Fattendees=AValue) then exit;
  Fattendees:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetattendeesOmitted(AIndex : Integer; const AValue : boolean); 

begin
  If (FattendeesOmitted=AValue) then exit;
  FattendeesOmitted:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetcolorId(AIndex : Integer; const AValue : String); 

begin
  If (FcolorId=AValue) then exit;
  FcolorId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setcreated(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Fcreated=AValue) then exit;
  Fcreated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setcreator(AIndex : Integer; const AValue : TEventTypecreator); 

begin
  If (Fcreator=AValue) then exit;
  Fcreator:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Set_end(AIndex : Integer; const AValue : TEventDateTime); 

begin
  If (F_end=AValue) then exit;
  F_end:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetendTimeUnspecified(AIndex : Integer; const AValue : boolean); 

begin
  If (FendTimeUnspecified=AValue) then exit;
  FendTimeUnspecified:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetextendedProperties(AIndex : Integer; const AValue : TEventTypeextendedProperties); 

begin
  If (FextendedProperties=AValue) then exit;
  FextendedProperties:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setgadget(AIndex : Integer; const AValue : TEventTypegadget); 

begin
  If (Fgadget=AValue) then exit;
  Fgadget:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetguestsCanInviteOthers(AIndex : Integer; const AValue : boolean); 

begin
  If (FguestsCanInviteOthers=AValue) then exit;
  FguestsCanInviteOthers:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetguestsCanModify(AIndex : Integer; const AValue : boolean); 

begin
  If (FguestsCanModify=AValue) then exit;
  FguestsCanModify:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetguestsCanSeeOtherGuests(AIndex : Integer; const AValue : boolean); 

begin
  If (FguestsCanSeeOtherGuests=AValue) then exit;
  FguestsCanSeeOtherGuests:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SethangoutLink(AIndex : Integer; const AValue : String); 

begin
  If (FhangoutLink=AValue) then exit;
  FhangoutLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SethtmlLink(AIndex : Integer; const AValue : String); 

begin
  If (FhtmlLink=AValue) then exit;
  FhtmlLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetiCalUID(AIndex : Integer; const AValue : String); 

begin
  If (FiCalUID=AValue) then exit;
  FiCalUID:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setlocation(AIndex : Integer; const AValue : String); 

begin
  If (Flocation=AValue) then exit;
  Flocation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setlocked(AIndex : Integer; const AValue : boolean); 

begin
  If (Flocked=AValue) then exit;
  Flocked:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setorganizer(AIndex : Integer; const AValue : TEventTypeorganizer); 

begin
  If (Forganizer=AValue) then exit;
  Forganizer:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetoriginalStartTime(AIndex : Integer; const AValue : TEventDateTime); 

begin
  If (ForiginalStartTime=AValue) then exit;
  ForiginalStartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetprivateCopy(AIndex : Integer; const AValue : boolean); 

begin
  If (FprivateCopy=AValue) then exit;
  FprivateCopy:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setrecurrence(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Frecurrence=AValue) then exit;
  Frecurrence:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.SetrecurringEventId(AIndex : Integer; const AValue : String); 

begin
  If (FrecurringEventId=AValue) then exit;
  FrecurringEventId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setreminders(AIndex : Integer; const AValue : TEventTypereminders); 

begin
  If (Freminders=AValue) then exit;
  Freminders:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setsequence(AIndex : Integer; const AValue : integer); 

begin
  If (Fsequence=AValue) then exit;
  Fsequence:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setsource(AIndex : Integer; const AValue : TEventTypesource); 

begin
  If (Fsource=AValue) then exit;
  Fsource:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setstart(AIndex : Integer; const AValue : TEventDateTime); 

begin
  If (Fstart=AValue) then exit;
  Fstart:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setsummary(AIndex : Integer; const AValue : String); 

begin
  If (Fsummary=AValue) then exit;
  Fsummary:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Settransparency(AIndex : Integer; const AValue : String); 

begin
  If (Ftransparency=AValue) then exit;
  Ftransparency:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setupdated(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Fupdated=AValue) then exit;
  Fupdated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvent.Setvisibility(AIndex : Integer; const AValue : String); 

begin
  If (Fvisibility=AValue) then exit;
  Fvisibility:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEvent.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_end' : Result:='end';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TEvent.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'attachments' : SetLength(Fattachments,ALength);
  'attendees' : SetLength(Fattendees,ALength);
  'recurrence' : SetLength(Frecurrence,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TEventAttachment
  --------------------------------------------------------------------}


Procedure TEventAttachment.SetfileId(AIndex : Integer; const AValue : String); 

begin
  If (FfileId=AValue) then exit;
  FfileId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttachment.SetfileUrl(AIndex : Integer; const AValue : String); 

begin
  If (FfileUrl=AValue) then exit;
  FfileUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttachment.SeticonLink(AIndex : Integer; const AValue : String); 

begin
  If (FiconLink=AValue) then exit;
  FiconLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttachment.SetmimeType(AIndex : Integer; const AValue : String); 

begin
  If (FmimeType=AValue) then exit;
  FmimeType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttachment.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEventAttendee
  --------------------------------------------------------------------}


Procedure TEventAttendee.SetadditionalGuests(AIndex : Integer; const AValue : integer); 

begin
  If (FadditionalGuests=AValue) then exit;
  FadditionalGuests:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setcomment(AIndex : Integer; const AValue : String); 

begin
  If (Fcomment=AValue) then exit;
  Fcomment:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.SetdisplayName(AIndex : Integer; const AValue : String); 

begin
  If (FdisplayName=AValue) then exit;
  FdisplayName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setoptional(AIndex : Integer; const AValue : boolean); 

begin
  If (Foptional=AValue) then exit;
  Foptional:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setorganizer(AIndex : Integer; const AValue : boolean); 

begin
  If (Forganizer=AValue) then exit;
  Forganizer:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Setresource(AIndex : Integer; const AValue : boolean); 

begin
  If (Fresource=AValue) then exit;
  Fresource:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.SetresponseStatus(AIndex : Integer; const AValue : String); 

begin
  If (FresponseStatus=AValue) then exit;
  FresponseStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventAttendee.Set_self(AIndex : Integer; const AValue : boolean); 

begin
  If (F_self=AValue) then exit;
  F_self:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TEventAttendee.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_self' : Result:='self';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TEventDateTime
  --------------------------------------------------------------------}


Procedure TEventDateTime.Setdate(AIndex : Integer; const AValue : TDate); 

begin
  If (Fdate=AValue) then exit;
  Fdate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventDateTime.SetdateTime(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FdateTime=AValue) then exit;
  FdateTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventDateTime.SettimeZone(AIndex : Integer; const AValue : String); 

begin
  If (FtimeZone=AValue) then exit;
  FtimeZone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEventReminder
  --------------------------------------------------------------------}


Procedure TEventReminder.Setmethod(AIndex : Integer; const AValue : String); 

begin
  If (Fmethod=AValue) then exit;
  Fmethod:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEventReminder.Setminutes(AIndex : Integer; const AValue : integer); 

begin
  If (Fminutes=AValue) then exit;
  Fminutes:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TEvents
  --------------------------------------------------------------------}


Procedure TEvents.SetaccessRole(AIndex : Integer; const AValue : String); 

begin
  If (FaccessRole=AValue) then exit;
  FaccessRole:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.SetdefaultReminders(AIndex : Integer; const AValue : TEventsTypedefaultRemindersArray); 

begin
  If (FdefaultReminders=AValue) then exit;
  FdefaultReminders:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setitems(AIndex : Integer; const AValue : TEventsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.SetnextSyncToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextSyncToken=AValue) then exit;
  FnextSyncToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setsummary(AIndex : Integer; const AValue : String); 

begin
  If (Fsummary=AValue) then exit;
  Fsummary:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.SettimeZone(AIndex : Integer; const AValue : String); 

begin
  If (FtimeZone=AValue) then exit;
  FtimeZone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TEvents.Setupdated(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Fupdated=AValue) then exit;
  Fupdated:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TEvents.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'defaultreminders' : SetLength(FdefaultReminders,ALength);
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFreeBusyCalendar
  --------------------------------------------------------------------}


Procedure TFreeBusyCalendar.Setbusy(AIndex : Integer; const AValue : TFreeBusyCalendarTypebusyArray); 

begin
  If (Fbusy=AValue) then exit;
  Fbusy:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyCalendar.Seterrors(AIndex : Integer; const AValue : TFreeBusyCalendarTypeerrorsArray); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFreeBusyCalendar.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'busy' : SetLength(Fbusy,ALength);
  'errors' : SetLength(Ferrors,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFreeBusyGroup
  --------------------------------------------------------------------}


Procedure TFreeBusyGroup.Setcalendars(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fcalendars=AValue) then exit;
  Fcalendars:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyGroup.Seterrors(AIndex : Integer; const AValue : TFreeBusyGroupTypeerrorsArray); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFreeBusyGroup.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'calendars' : SetLength(Fcalendars,ALength);
  'errors' : SetLength(Ferrors,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFreeBusyRequest
  --------------------------------------------------------------------}


Procedure TFreeBusyRequest.SetcalendarExpansionMax(AIndex : Integer; const AValue : integer); 

begin
  If (FcalendarExpansionMax=AValue) then exit;
  FcalendarExpansionMax:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyRequest.SetgroupExpansionMax(AIndex : Integer; const AValue : integer); 

begin
  If (FgroupExpansionMax=AValue) then exit;
  FgroupExpansionMax:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyRequest.Setitems(AIndex : Integer; const AValue : TFreeBusyRequestTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyRequest.SettimeMax(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FtimeMax=AValue) then exit;
  FtimeMax:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyRequest.SettimeMin(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FtimeMin=AValue) then exit;
  FtimeMin:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyRequest.SettimeZone(AIndex : Integer; const AValue : String); 

begin
  If (FtimeZone=AValue) then exit;
  FtimeZone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFreeBusyRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFreeBusyRequestItem
  --------------------------------------------------------------------}


Procedure TFreeBusyRequestItem.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TFreeBusyResponseTypecalendars
  --------------------------------------------------------------------}


Class Function TFreeBusyResponseTypecalendars.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TFreeBusyResponseTypegroups
  --------------------------------------------------------------------}


Class Function TFreeBusyResponseTypegroups.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TFreeBusyResponse
  --------------------------------------------------------------------}


Procedure TFreeBusyResponse.Setcalendars(AIndex : Integer; const AValue : TFreeBusyResponseTypecalendars); 

begin
  If (Fcalendars=AValue) then exit;
  Fcalendars:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyResponse.Setgroups(AIndex : Integer; const AValue : TFreeBusyResponseTypegroups); 

begin
  If (Fgroups=AValue) then exit;
  Fgroups:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyResponse.SettimeMax(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FtimeMax=AValue) then exit;
  FtimeMax:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFreeBusyResponse.SettimeMin(AIndex : Integer; const AValue : TDatetime); 

begin
  If (FtimeMin=AValue) then exit;
  FtimeMin:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSetting
  --------------------------------------------------------------------}


Procedure TSetting.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSetting.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSetting.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSetting.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSettings
  --------------------------------------------------------------------}


Procedure TSettings.Setetag(AIndex : Integer; const AValue : String); 

begin
  If (Fetag=AValue) then exit;
  Fetag:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.Setitems(AIndex : Integer; const AValue : TSettingsTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSettings.SetnextSyncToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextSyncToken=AValue) then exit;
  FnextSyncToken:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSettings.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTimePeriod
  --------------------------------------------------------------------}


Procedure TTimePeriod.Set_end(AIndex : Integer; const AValue : TDatetime); 

begin
  If (F_end=AValue) then exit;
  F_end:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTimePeriod.Setstart(AIndex : Integer; const AValue : TDatetime); 

begin
  If (Fstart=AValue) then exit;
  Fstart:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TTimePeriod.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_end' : Result:='end';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAclResource
  --------------------------------------------------------------------}


Class Function TAclResource.ResourceName : String;

begin
  Result:='acl';
end;

Class Function TAclResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Procedure TAclResource.Delete(calendarId: string; ruleId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'calendars/{calendarId}/acl/{ruleId}';
  _Methodid   = 'calendar.acl.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'ruleId',ruleId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TAclResource.Get(calendarId: string; ruleId: string) : TAclRule;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}/acl/{ruleId}';
  _Methodid   = 'calendar.acl.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'ruleId',ruleId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAclRule) as TAclRule;
end;

Function TAclResource.Insert(calendarId: string; aAclRule : TAclRule) : TAclRule;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/acl';
  _Methodid   = 'calendar.acl.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAclRule,TAclRule) as TAclRule;
end;

Function TAclResource.List(calendarId: string; AQuery : string = '') : TAcl;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}/acl';
  _Methodid   = 'calendar.acl.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAcl) as TAcl;
end;


Function TAclResource.List(calendarId: string; AQuery : TAcllistOptions) : TAcl;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=List(calendarId,_Q);
end;

Function TAclResource.Patch(calendarId: string; ruleId: string; aAclRule : TAclRule) : TAclRule;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'calendars/{calendarId}/acl/{ruleId}';
  _Methodid   = 'calendar.acl.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'ruleId',ruleId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAclRule,TAclRule) as TAclRule;
end;

Function TAclResource.Update(calendarId: string; ruleId: string; aAclRule : TAclRule) : TAclRule;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'calendars/{calendarId}/acl/{ruleId}';
  _Methodid   = 'calendar.acl.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'ruleId',ruleId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAclRule,TAclRule) as TAclRule;
end;

Function TAclResource.Watch(calendarId: string; aChannel : TChannel; AQuery : string = '') : TChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/acl/watch';
  _Methodid   = 'calendar.acl.watch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aChannel,TChannel) as TChannel;
end;


Function TAclResource.Watch(calendarId: string; aChannel : TChannel; AQuery : TAclwatchOptions) : TChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=Watch(calendarId,aChannel,_Q);
end;



{ --------------------------------------------------------------------
  TCalendarListResource
  --------------------------------------------------------------------}


Class Function TCalendarListResource.ResourceName : String;

begin
  Result:='calendarList';
end;

Class Function TCalendarListResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Procedure TCalendarListResource.Delete(calendarId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'users/me/calendarList/{calendarId}';
  _Methodid   = 'calendar.calendarList.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TCalendarListResource.Get(calendarId: string) : TCalendarListEntry;

Const
  _HTTPMethod = 'GET';
  _Path       = 'users/me/calendarList/{calendarId}';
  _Methodid   = 'calendar.calendarList.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCalendarListEntry) as TCalendarListEntry;
end;

Function TCalendarListResource.Insert(aCalendarListEntry : TCalendarListEntry; AQuery : string = '') : TCalendarListEntry;

Const
  _HTTPMethod = 'POST';
  _Path       = 'users/me/calendarList';
  _Methodid   = 'calendar.calendarList.insert';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,aCalendarListEntry,TCalendarListEntry) as TCalendarListEntry;
end;


Function TCalendarListResource.Insert(aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListinsertOptions) : TCalendarListEntry;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'colorRgbFormat',AQuery.colorRgbFormat);
  Result:=Insert(aCalendarListEntry,_Q);
end;

Function TCalendarListResource.List(AQuery : string = '') : TCalendarList;

Const
  _HTTPMethod = 'GET';
  _Path       = 'users/me/calendarList';
  _Methodid   = 'calendar.calendarList.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TCalendarList) as TCalendarList;
end;


Function TCalendarListResource.List(AQuery : TCalendarListlistOptions) : TCalendarList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'minAccessRole',AQuery.minAccessRole);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'showHidden',AQuery.showHidden);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=List(_Q);
end;

Function TCalendarListResource.Patch(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : string = '') : TCalendarListEntry;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'users/me/calendarList/{calendarId}';
  _Methodid   = 'calendar.calendarList.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aCalendarListEntry,TCalendarListEntry) as TCalendarListEntry;
end;


Function TCalendarListResource.Patch(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListpatchOptions) : TCalendarListEntry;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'colorRgbFormat',AQuery.colorRgbFormat);
  Result:=Patch(calendarId,aCalendarListEntry,_Q);
end;

Function TCalendarListResource.Update(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : string = '') : TCalendarListEntry;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'users/me/calendarList/{calendarId}';
  _Methodid   = 'calendar.calendarList.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aCalendarListEntry,TCalendarListEntry) as TCalendarListEntry;
end;


Function TCalendarListResource.Update(calendarId: string; aCalendarListEntry : TCalendarListEntry; AQuery : TCalendarListupdateOptions) : TCalendarListEntry;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'colorRgbFormat',AQuery.colorRgbFormat);
  Result:=Update(calendarId,aCalendarListEntry,_Q);
end;

Function TCalendarListResource.Watch(aChannel : TChannel; AQuery : string = '') : TChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'users/me/calendarList/watch';
  _Methodid   = 'calendar.calendarList.watch';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,aChannel,TChannel) as TChannel;
end;


Function TCalendarListResource.Watch(aChannel : TChannel; AQuery : TCalendarListwatchOptions) : TChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'minAccessRole',AQuery.minAccessRole);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'showHidden',AQuery.showHidden);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=Watch(aChannel,_Q);
end;



{ --------------------------------------------------------------------
  TCalendarsResource
  --------------------------------------------------------------------}


Class Function TCalendarsResource.ResourceName : String;

begin
  Result:='calendars';
end;

Class Function TCalendarsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Procedure TCalendarsResource.Clear(calendarId: string);

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/clear';
  _Methodid   = 'calendar.calendars.clear';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Procedure TCalendarsResource.Delete(calendarId: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'calendars/{calendarId}';
  _Methodid   = 'calendar.calendars.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TCalendarsResource.Get(calendarId: string) : TCalendar;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}';
  _Methodid   = 'calendar.calendars.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TCalendar) as TCalendar;
end;

Function TCalendarsResource.Insert(aCalendar : TCalendar) : TCalendar;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars';
  _Methodid   = 'calendar.calendars.insert';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,'',aCalendar,TCalendar) as TCalendar;
end;

Function TCalendarsResource.Patch(calendarId: string; aCalendar : TCalendar) : TCalendar;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'calendars/{calendarId}';
  _Methodid   = 'calendar.calendars.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCalendar,TCalendar) as TCalendar;
end;

Function TCalendarsResource.Update(calendarId: string; aCalendar : TCalendar) : TCalendar;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'calendars/{calendarId}';
  _Methodid   = 'calendar.calendars.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aCalendar,TCalendar) as TCalendar;
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
  Result:=TcalendarAPI;
end;

Procedure TChannelsResource.Stop(aChannel : TChannel);

Const
  _HTTPMethod = 'POST';
  _Path       = 'channels/stop';
  _Methodid   = 'calendar.channels.stop';

begin
  ServiceCall(_HTTPMethod,_Path,'',aChannel,Nil);
end;



{ --------------------------------------------------------------------
  TColorsResource
  --------------------------------------------------------------------}


Class Function TColorsResource.ResourceName : String;

begin
  Result:='colors';
end;

Class Function TColorsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Function TColorsResource.Get : TColors;

Const
  _HTTPMethod = 'GET';
  _Path       = 'colors';
  _Methodid   = 'calendar.colors.get';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,'',Nil,TColors) as TColors;
end;



{ --------------------------------------------------------------------
  TEventsResource
  --------------------------------------------------------------------}


Class Function TEventsResource.ResourceName : String;

begin
  Result:='events';
end;

Class Function TEventsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Procedure TEventsResource.Delete(calendarId: string; eventId: string; AQuery : string = '');

Const
  _HTTPMethod = 'DELETE';
  _Path       = 'calendars/{calendarId}/events/{eventId}';
  _Methodid   = 'calendar.events.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  ServiceCall(_HTTPMethod,_P,AQuery,Nil,Nil);
end;


Procedure TEventsResource.Delete(calendarId: string; eventId: string; AQuery : TEventsdeleteOptions);

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  Delete(calendarId,eventId,_Q);
end;

Function TEventsResource.Get(calendarId: string; eventId: string; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}/events/{eventId}';
  _Methodid   = 'calendar.events.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TEvent) as TEvent;
end;


Function TEventsResource.Get(calendarId: string; eventId: string; AQuery : TEventsgetOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'timeZone',AQuery.timeZone);
  Result:=Get(calendarId,eventId,_Q);
end;

Function TEventsResource.Import(calendarId: string; aEvent : TEvent; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/events/import';
  _Methodid   = 'calendar.events.import';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEvent,TEvent) as TEvent;
end;


Function TEventsResource.Import(calendarId: string; aEvent : TEvent; AQuery : TEventsimportOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'supportsAttachments',AQuery.supportsAttachments);
  Result:=Import(calendarId,aEvent,_Q);
end;

Function TEventsResource.Insert(calendarId: string; aEvent : TEvent; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/events';
  _Methodid   = 'calendar.events.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEvent,TEvent) as TEvent;
end;


Function TEventsResource.Insert(calendarId: string; aEvent : TEvent; AQuery : TEventsinsertOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  AddToQuery(_Q,'supportsAttachments',AQuery.supportsAttachments);
  Result:=Insert(calendarId,aEvent,_Q);
end;

Function TEventsResource.Instances(calendarId: string; eventId: string; AQuery : string = '') : TEvents;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}/events/{eventId}/instances';
  _Methodid   = 'calendar.events.instances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TEvents) as TEvents;
end;


Function TEventsResource.Instances(calendarId: string; eventId: string; AQuery : TEventsinstancesOptions) : TEvents;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'originalStart',AQuery.originalStart);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'timeMax',AQuery.timeMax);
  AddToQuery(_Q,'timeMin',AQuery.timeMin);
  AddToQuery(_Q,'timeZone',AQuery.timeZone);
  Result:=Instances(calendarId,eventId,_Q);
end;

Function TEventsResource.List(calendarId: string; AQuery : string = '') : TEvents;

Const
  _HTTPMethod = 'GET';
  _Path       = 'calendars/{calendarId}/events';
  _Methodid   = 'calendar.events.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TEvents) as TEvents;
end;


Function TEventsResource.List(calendarId: string; AQuery : TEventslistOptions) : TEvents;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'iCalUID',AQuery.iCalUID);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'orderBy',AQuery.orderBy);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'privateExtendedProperty',AQuery.privateExtendedProperty);
  AddToQuery(_Q,'q',AQuery.q);
  AddToQuery(_Q,'sharedExtendedProperty',AQuery.sharedExtendedProperty);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'showHiddenInvitations',AQuery.showHiddenInvitations);
  AddToQuery(_Q,'singleEvents',AQuery.singleEvents);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  AddToQuery(_Q,'timeMax',AQuery.timeMax);
  AddToQuery(_Q,'timeMin',AQuery.timeMin);
  AddToQuery(_Q,'timeZone',AQuery.timeZone);
  AddToQuery(_Q,'updatedMin',AQuery.updatedMin);
  Result:=List(calendarId,_Q);
end;

Function TEventsResource.Move(calendarId: string; eventId: string; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/events/{eventId}/move';
  _Methodid   = 'calendar.events.move';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TEvent) as TEvent;
end;


Function TEventsResource.Move(calendarId: string; eventId: string; AQuery : TEventsmoveOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'destination',AQuery.destination);
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  Result:=Move(calendarId,eventId,_Q);
end;

Function TEventsResource.Patch(calendarId: string; eventId: string; aEvent : TEvent; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'PATCH';
  _Path       = 'calendars/{calendarId}/events/{eventId}';
  _Methodid   = 'calendar.events.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEvent,TEvent) as TEvent;
end;


Function TEventsResource.Patch(calendarId: string; eventId: string; aEvent : TEvent; AQuery : TEventspatchOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  AddToQuery(_Q,'supportsAttachments',AQuery.supportsAttachments);
  Result:=Patch(calendarId,eventId,aEvent,_Q);
end;

Function TEventsResource.QuickAdd(calendarId: string; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/events/quickAdd';
  _Methodid   = 'calendar.events.quickAdd';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TEvent) as TEvent;
end;


Function TEventsResource.QuickAdd(calendarId: string; AQuery : TEventsquickAddOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  AddToQuery(_Q,'text',AQuery.text);
  Result:=QuickAdd(calendarId,_Q);
end;

Function TEventsResource.Update(calendarId: string; eventId: string; aEvent : TEvent; AQuery : string = '') : TEvent;

Const
  _HTTPMethod = 'PUT';
  _Path       = 'calendars/{calendarId}/events/{eventId}';
  _Methodid   = 'calendar.events.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId,'eventId',eventId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aEvent,TEvent) as TEvent;
end;


Function TEventsResource.Update(calendarId: string; eventId: string; aEvent : TEvent; AQuery : TEventsupdateOptions) : TEvent;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'sendNotifications',AQuery.sendNotifications);
  AddToQuery(_Q,'supportsAttachments',AQuery.supportsAttachments);
  Result:=Update(calendarId,eventId,aEvent,_Q);
end;

Function TEventsResource.Watch(calendarId: string; aChannel : TChannel; AQuery : string = '') : TChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'calendars/{calendarId}/events/watch';
  _Methodid   = 'calendar.events.watch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['calendarId',calendarId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aChannel,TChannel) as TChannel;
end;


Function TEventsResource.Watch(calendarId: string; aChannel : TChannel; AQuery : TEventswatchOptions) : TChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'alwaysIncludeEmail',AQuery.alwaysIncludeEmail);
  AddToQuery(_Q,'iCalUID',AQuery.iCalUID);
  AddToQuery(_Q,'maxAttendees',AQuery.maxAttendees);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'orderBy',AQuery.orderBy);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'privateExtendedProperty',AQuery.privateExtendedProperty);
  AddToQuery(_Q,'q',AQuery.q);
  AddToQuery(_Q,'sharedExtendedProperty',AQuery.sharedExtendedProperty);
  AddToQuery(_Q,'showDeleted',AQuery.showDeleted);
  AddToQuery(_Q,'showHiddenInvitations',AQuery.showHiddenInvitations);
  AddToQuery(_Q,'singleEvents',AQuery.singleEvents);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  AddToQuery(_Q,'timeMax',AQuery.timeMax);
  AddToQuery(_Q,'timeMin',AQuery.timeMin);
  AddToQuery(_Q,'timeZone',AQuery.timeZone);
  AddToQuery(_Q,'updatedMin',AQuery.updatedMin);
  Result:=Watch(calendarId,aChannel,_Q);
end;



{ --------------------------------------------------------------------
  TFreebusyResource
  --------------------------------------------------------------------}


Class Function TFreebusyResource.ResourceName : String;

begin
  Result:='freebusy';
end;

Class Function TFreebusyResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Function TFreebusyResource.Query(aFreeBusyRequest : TFreeBusyRequest) : TFreeBusyResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = 'freeBusy';
  _Methodid   = 'calendar.freebusy.query';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,'',aFreeBusyRequest,TFreeBusyResponse) as TFreeBusyResponse;
end;



{ --------------------------------------------------------------------
  TSettingsResource
  --------------------------------------------------------------------}


Class Function TSettingsResource.ResourceName : String;

begin
  Result:='settings';
end;

Class Function TSettingsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcalendarAPI;
end;

Function TSettingsResource.Get(setting: string) : TSetting;

Const
  _HTTPMethod = 'GET';
  _Path       = 'users/me/settings/{setting}';
  _Methodid   = 'calendar.settings.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['setting',setting]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSetting) as TSetting;
end;

Function TSettingsResource.List(AQuery : string = '') : TSettings;

Const
  _HTTPMethod = 'GET';
  _Path       = 'users/me/settings';
  _Methodid   = 'calendar.settings.list';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TSettings) as TSettings;
end;


Function TSettingsResource.List(AQuery : TSettingslistOptions) : TSettings;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=List(_Q);
end;

Function TSettingsResource.Watch(aChannel : TChannel; AQuery : string = '') : TChannel;

Const
  _HTTPMethod = 'POST';
  _Path       = 'users/me/settings/watch';
  _Methodid   = 'calendar.settings.watch';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,aChannel,TChannel) as TChannel;
end;


Function TSettingsResource.Watch(aChannel : TChannel; AQuery : TSettingswatchOptions) : TChannel;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  AddToQuery(_Q,'syncToken',AQuery.syncToken);
  Result:=Watch(aChannel,_Q);
end;



{ --------------------------------------------------------------------
  TCalendarAPI
  --------------------------------------------------------------------}

Class Function TCalendarAPI.APIName : String;

begin
  Result:='calendar';
end;

Class Function TCalendarAPI.APIVersion : String;

begin
  Result:='v3';
end;

Class Function TCalendarAPI.APIRevision : String;

begin
  Result:='20160515';
end;

Class Function TCalendarAPI.APIID : String;

begin
  Result:='calendar:v3';
end;

Class Function TCalendarAPI.APITitle : String;

begin
  Result:='Calendar API';
end;

Class Function TCalendarAPI.APIDescription : String;

begin
  Result:='Manipulates events and other calendar data.';
end;

Class Function TCalendarAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TCalendarAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TCalendarAPI.APIIcon16 : String;

begin
  Result:='http://www.google.com/images/icons/product/calendar-16.png';
end;

Class Function TCalendarAPI.APIIcon32 : String;

begin
  Result:='http://www.google.com/images/icons/product/calendar-32.png';
end;

Class Function TCalendarAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/google-apps/calendar/firstapp';
end;

Class Function TCalendarAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TCalendarAPI.APIbasePath : string;

begin
  Result:='/calendar/v3/';
end;

Class Function TCalendarAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/calendar/v3/';
end;

Class Function TCalendarAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TCalendarAPI.APIservicePath : string;

begin
  Result:='calendar/v3/';
end;

Class Function TCalendarAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TCalendarAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,2);
  Result[0].Name:='https://www.googleapis.com/auth/calendar';
  Result[0].Description:='Manage your calendars';
  Result[1].Name:='https://www.googleapis.com/auth/calendar.readonly';
  Result[1].Description:='View your calendars';
  
end;

Class Function TCalendarAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TCalendarAPI.RegisterAPIResources;

begin
  TAcl.RegisterObject;
  TAclRuleTypescope.RegisterObject;
  TAclRule.RegisterObject;
  TCalendar.RegisterObject;
  TCalendarList.RegisterObject;
  TCalendarListEntryTypenotificationSettings.RegisterObject;
  TCalendarListEntry.RegisterObject;
  TCalendarNotification.RegisterObject;
  TChannelTypeparams.RegisterObject;
  TChannel.RegisterObject;
  TColorDefinition.RegisterObject;
  TColorsTypecalendar.RegisterObject;
  TColorsTypeevent.RegisterObject;
  TColors.RegisterObject;
  TError.RegisterObject;
  TEventTypecreator.RegisterObject;
  TEventTypeextendedPropertiesTypeprivate.RegisterObject;
  TEventTypeextendedPropertiesTypeshared.RegisterObject;
  TEventTypeextendedProperties.RegisterObject;
  TEventTypegadgetTypepreferences.RegisterObject;
  TEventTypegadget.RegisterObject;
  TEventTypeorganizer.RegisterObject;
  TEventTypereminders.RegisterObject;
  TEventTypesource.RegisterObject;
  TEvent.RegisterObject;
  TEventAttachment.RegisterObject;
  TEventAttendee.RegisterObject;
  TEventDateTime.RegisterObject;
  TEventReminder.RegisterObject;
  TEvents.RegisterObject;
  TFreeBusyCalendar.RegisterObject;
  TFreeBusyGroup.RegisterObject;
  TFreeBusyRequest.RegisterObject;
  TFreeBusyRequestItem.RegisterObject;
  TFreeBusyResponseTypecalendars.RegisterObject;
  TFreeBusyResponseTypegroups.RegisterObject;
  TFreeBusyResponse.RegisterObject;
  TSetting.RegisterObject;
  TSettings.RegisterObject;
  TTimePeriod.RegisterObject;
end;


Function TCalendarAPI.GetAclInstance : TAclResource;

begin
  if (FAclInstance=Nil) then
    FAclInstance:=CreateAclResource;
  Result:=FAclInstance;
end;

Function TCalendarAPI.CreateAclResource : TAclResource;

begin
  Result:=CreateAclResource(Self);
end;


Function TCalendarAPI.CreateAclResource(AOwner : TComponent) : TAclResource;

begin
  Result:=TAclResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetCalendarListInstance : TCalendarListResource;

begin
  if (FCalendarListInstance=Nil) then
    FCalendarListInstance:=CreateCalendarListResource;
  Result:=FCalendarListInstance;
end;

Function TCalendarAPI.CreateCalendarListResource : TCalendarListResource;

begin
  Result:=CreateCalendarListResource(Self);
end;


Function TCalendarAPI.CreateCalendarListResource(AOwner : TComponent) : TCalendarListResource;

begin
  Result:=TCalendarListResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetCalendarsInstance : TCalendarsResource;

begin
  if (FCalendarsInstance=Nil) then
    FCalendarsInstance:=CreateCalendarsResource;
  Result:=FCalendarsInstance;
end;

Function TCalendarAPI.CreateCalendarsResource : TCalendarsResource;

begin
  Result:=CreateCalendarsResource(Self);
end;


Function TCalendarAPI.CreateCalendarsResource(AOwner : TComponent) : TCalendarsResource;

begin
  Result:=TCalendarsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetChannelsInstance : TChannelsResource;

begin
  if (FChannelsInstance=Nil) then
    FChannelsInstance:=CreateChannelsResource;
  Result:=FChannelsInstance;
end;

Function TCalendarAPI.CreateChannelsResource : TChannelsResource;

begin
  Result:=CreateChannelsResource(Self);
end;


Function TCalendarAPI.CreateChannelsResource(AOwner : TComponent) : TChannelsResource;

begin
  Result:=TChannelsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetColorsInstance : TColorsResource;

begin
  if (FColorsInstance=Nil) then
    FColorsInstance:=CreateColorsResource;
  Result:=FColorsInstance;
end;

Function TCalendarAPI.CreateColorsResource : TColorsResource;

begin
  Result:=CreateColorsResource(Self);
end;


Function TCalendarAPI.CreateColorsResource(AOwner : TComponent) : TColorsResource;

begin
  Result:=TColorsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetEventsInstance : TEventsResource;

begin
  if (FEventsInstance=Nil) then
    FEventsInstance:=CreateEventsResource;
  Result:=FEventsInstance;
end;

Function TCalendarAPI.CreateEventsResource : TEventsResource;

begin
  Result:=CreateEventsResource(Self);
end;


Function TCalendarAPI.CreateEventsResource(AOwner : TComponent) : TEventsResource;

begin
  Result:=TEventsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetFreebusyInstance : TFreebusyResource;

begin
  if (FFreebusyInstance=Nil) then
    FFreebusyInstance:=CreateFreebusyResource;
  Result:=FFreebusyInstance;
end;

Function TCalendarAPI.CreateFreebusyResource : TFreebusyResource;

begin
  Result:=CreateFreebusyResource(Self);
end;


Function TCalendarAPI.CreateFreebusyResource(AOwner : TComponent) : TFreebusyResource;

begin
  Result:=TFreebusyResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCalendarAPI.GetSettingsInstance : TSettingsResource;

begin
  if (FSettingsInstance=Nil) then
    FSettingsInstance:=CreateSettingsResource;
  Result:=FSettingsInstance;
end;

Function TCalendarAPI.CreateSettingsResource : TSettingsResource;

begin
  Result:=CreateSettingsResource(Self);
end;


Function TCalendarAPI.CreateSettingsResource(AOwner : TComponent) : TSettingsResource;

begin
  Result:=TSettingsResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TCalendarAPI.RegisterAPI;
end.
