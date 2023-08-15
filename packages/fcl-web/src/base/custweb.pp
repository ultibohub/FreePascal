{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2009 by the Free Pascal development team

    TWebApplication class.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{ $define CGIDEBUG}
{$mode objfpc}
{$H+}

{$IFNDEF FPC_DOTTEDUNITS}
unit custweb;
{$ENDIF FPC_DOTTEDUNITS}

Interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  Fcl.CustApp,System.Classes,System.SysUtils, FpWeb.Http.Defs, FpWeb.Http.Base, Fcl.EventLog;
{$ELSE FPC_DOTTEDUNITS}
uses
  CustApp,Classes,SysUtils, httpdefs, fphttp, eventlog;
{$ENDIF FPC_DOTTEDUNITS}

Type
  { TCustomWebApplication }

  TGetModuleEvent = Procedure (Sender : TObject; ARequest : TRequest;
                               Var ModuleClass : TCustomHTTPModuleClass) of object;
  TOnShowRequestException = procedure(AResponse: TResponse; AnException: Exception; var handled: boolean);
  TLogEvent = Procedure (EventType: TEventType; const Msg: String) of object;
  TInitModuleEvent = Procedure (Sender : TObject; Module: TCustomHTTPModule) of object;

  { TWebHandler }

  TWebHandler = class(TComponent)
  private
    FDefaultModuleName: String;
    FLegacyRouting: Boolean;
    FOnIdle: TNotifyEvent;
    FOnInitModule: TInitModuleEvent;
    FOnUnknownRequestEncoding: TOnUnknownEncodingEvent;
    FTerminated: boolean;
    FAdministrator: String;
    FAllowDefaultModule: Boolean;
    FApplicationURL: String;
    FEmail: String;
    FModuleVar: String;
    FOnGetModule: TGetModuleEvent;
    FOnShowRequestException: TOnShowRequestException;
    FHandleGetOnPost : Boolean;
    FRedirectOnError : Boolean;
    FRedirectOnErrorURL : String;
    FTitle: string;
    FOnTerminate : TNotifyEvent;
    FOnLog : TLogEvent;
    FPreferModuleName : Boolean;
    procedure DoCallModule(AModule: TCustomHTTPModule; const AModuleName: String; ARequest: TRequest; AResponse: TResponse);
    procedure HandleModuleRequest(Sender: TModuleItem; ARequest: TRequest; AResponse: TResponse);
    procedure OldHandleRequest(ARequest: TRequest; AResponse: TResponse);
  protected
    Class Procedure DoError(const Msg : String; AStatusCode : Integer = 0; const AStatusText : String = '');
    Class Procedure DoError(const Fmt : String; Const Args : Array of const; AStatusCode : Integer = 0; Const AStatusText : String = '');
    procedure Terminate; virtual;
    Function GetModuleName(Arequest : TRequest) : string;
    function WaitForRequest(out ARequest : TRequest; out AResponse : TResponse) : boolean; virtual; abstract;
    procedure EndRequest(ARequest : TRequest;AResponse : TResponse); virtual;
    function FindModule(ModuleClass : TCustomHTTPModuleClass): TCustomHTTPModule;
    Procedure SetBaseURL(AModule : TCustomHTTPModule; Const AModuleName : String; ARequest : TRequest); virtual;
    function GetApplicationURL(ARequest : TRequest): String; virtual;
    procedure ShowRequestException(R: TResponse; E: Exception); virtual;
    Procedure InitRequest(ARequest : TRequest); virtual;
    Procedure InitResponse(AResponse : TResponse); virtual;
    Function GetEmail : String; virtual;
    Function GetAdministrator : String; virtual;
    property Terminated: boolean read FTerminated;
  Public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
    Procedure Run; virtual;
    Procedure Log(EventType : TEventType; Const Msg : String);
    Procedure DoHandleRequest(ARequest : TRequest; AResponse : TResponse);
    Procedure HandleRequest(ARequest : TRequest; AResponse : TResponse); virtual;
    Property HandleGetOnPost : Boolean Read FHandleGetOnPost Write FHandleGetOnPost;
    Property RedirectOnError : boolean Read FRedirectOnError Write FRedirectOnError;
    Property RedirectOnErrorURL : string Read FRedirectOnErrorURL Write FRedirectOnErrorURL;
    Property ApplicationURL : String Read FApplicationURL Write FApplicationURL;
    Property AllowDefaultModule : Boolean Read FAllowDefaultModule Write FAllowDefaultModule;
    Property DefaultModuleName : String Read FDefaultModuleName Write FDefaultModuleName;
    Property ModuleVariable : String Read FModuleVar Write FModuleVar;
    Property OnGetModule : TGetModuleEvent Read FOnGetModule Write FOnGetModule;
    Property Email : String Read GetEmail Write FEmail;
    property Title: string read FTitle write FTitle;
    Property Administrator : String Read GetAdministrator Write FAdministrator;
    property OnShowRequestException: TOnShowRequestException read FOnShowRequestException write FOnShowRequestException;
    property OnIdle: TNotifyEvent read FOnIdle write FOnIdle;
    Property OnLog : TLogEvent Read FOnLog Write FOnLog;
    Property OnUnknownRequestEncoding : TOnUnknownEncodingEvent Read FOnUnknownRequestEncoding Write FOnUnknownRequestEncoding;
    Property OnInitModule: TInitModuleEvent Read FOnInitModule write FOnInitModule;
    Property PreferModuleName : Boolean Read FPreferModuleName Write FPreferModuleName;
    Property LegacyRouting : Boolean Read FLegacyRouting Write FLegacyRouting;
  end;

  TCustomWebApplication = Class(TCustomApplication)
  Private
    FEventLog: TEventLog;
    FWebHandler: TWebHandler;
    function GetAdministrator: String;
    function GetAllowDefaultModule: Boolean;
    function GetApplicationURL: String;
    function GetDefaultModuleName: String;
    function GetEmail: String;
    function GetEventLog: TEventLog;
    function GetHandleGetOnPost: Boolean;
    function GetLegacyRouting: Boolean;
    function GetModuleVar: String;
    function GetOnGetModule: TGetModuleEvent;
    function GetOnShowRequestException: TOnShowRequestException;
    function GetOnUnknownRequestEncoding: TOnUnknownEncodingEvent;
    function GetRedirectOnError: boolean;
    function GetRedirectOnErrorURL: string;
    function GetPreferModuleName: boolean;
    procedure SetAdministrator(const AValue: String);
    procedure SetAllowDefaultModule(const AValue: Boolean);
    procedure SetApplicationURL(const AValue: String);
    procedure SetDefaultModuleName(const AValue: String);
    procedure SetEmail(const AValue: String);
    procedure SetHandleGetOnPost(const AValue: Boolean);
    procedure SetLegacyRouting(AValue: Boolean);
    procedure SetModuleVar(const AValue: String);
    procedure SetOnGetModule(const AValue: TGetModuleEvent);
    procedure SetOnShowRequestException(const AValue: TOnShowRequestException);
    procedure SetOnUnknownRequestEncoding(AValue: TOnUnknownEncodingEvent);
    procedure SetRedirectOnError(const AValue: boolean);
    procedure SetRedirectOnErrorURL(const AValue: string);
    procedure SetPreferModuleName(const AValue: boolean);
    procedure DoOnTerminate(Sender : TObject);
  protected
    Procedure DoRun; override;
    Function CreateEventLog : TEventLog; virtual;
    procedure FreeEventLog(AEventLog: TEventLog); virtual;
    function InitializeWebHandler: TWebHandler; virtual; abstract;
    Procedure DoLog(EventType: TEventType; const Msg: String); override;
    procedure SetTitle(const AValue: string); override;
    property WebHandler: TWebHandler read FWebHandler write FWebHandler;
  Public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure CreateForm(AClass : TComponentClass; out Reference);
    Procedure Initialize; override;
    procedure Terminate; override;
    Property HandleGetOnPost : Boolean Read GetHandleGetOnPost Write SetHandleGetOnPost;
    Property RedirectOnError : boolean Read GetRedirectOnError Write SetRedirectOnError;
    Property RedirectOnErrorURL : string Read GetRedirectOnErrorURL Write SetRedirectOnErrorURL;
    Property ApplicationURL : String Read GetApplicationURL Write SetApplicationURL;
    Property AllowDefaultModule : Boolean Read GetAllowDefaultModule Write SetAllowDefaultModule;
    Property DefaultModuleName : String Read GetDefaultModuleName Write SetDefaultModuleName;
    Property ModuleVariable : String Read GetModuleVar Write SetModuleVar;
    Property OnGetModule : TGetModuleEvent Read GetOnGetModule Write SetOnGetModule;
    Property Email : String Read GetEmail Write SetEmail;
    Property Administrator : String Read GetAdministrator Write SetAdministrator;
    property OnShowRequestException: TOnShowRequestException read GetOnShowRequestException write SetOnShowRequestException;
    Property OnUnknownRequestEncoding : TOnUnknownEncodingEvent Read GetOnUnknownRequestEncoding Write SetOnUnknownRequestEncoding;
    Property EventLog: TEventLog read GetEventLog;
    Property PreferModuleName : Boolean Read GetPreferModuleName Write SetPreferModuleName;
    Property LegacyRouting : Boolean Read GetLegacyRouting Write SetLegacyRouting;
  end;

  EFpWebError = Class(EFPHTTPError);

procedure ExceptionToHTML(S: TStrings; const E: Exception; const Title, Email, Administrator: string);

Implementation


{$IFDEF FPC_DOTTEDUNITS}
uses
  {$ifdef CGIDEBUG}
  dbugintf,
  {$endif}
  FpWeb.Route;
{$ELSE FPC_DOTTEDUNITS}
uses
  {$ifdef CGIDEBUG}
  dbugintf,
  {$endif}
  httproute;
{$ENDIF FPC_DOTTEDUNITS}

resourcestring
  SErrNoModuleNameForRequest = 'Could not determine HTTP module name for request';
  SErrNoModuleForRequest = 'Could not determine HTTP module for request "%s"';
  SErrSendingContent = 'An error (%s) happened while sending response content: %s';
  SModuleError = 'Module Error';
  SAppEncounteredError = 'The application encountered the following error:';
  SError = 'Error: ';
  SNotify = 'Notify: ';

procedure ExceptionToHTML(S: TStrings; const E: Exception; const Title, Email, Administrator: string);
var
  FrameNumber: Integer;
  Frames: PPointer;
  FrameCount: integer;
  TheEmail: String;
begin
  With S do
    begin
    Add('<html><head><title>'+Title+': '+SModuleError+'</title></head>'+LineEnding);
    Add('<body>');
    Add('<center><hr><h1>'+Title+': ERROR</h1><hr></center><br><br>');
    Add(SAppEncounteredError+'<br>');
    Add('<ul>');
    Add('<li>'+SError+' <b>'+E.Message+'</b>');
    Add('<li> Stack trace:<br>');
    Add(BackTraceStrFunc(ExceptAddr)+'<br>');
    FrameCount:=ExceptFrameCount;
    Frames:=ExceptFrames;
    for FrameNumber := 0 to FrameCount-1 do
      Add(BackTraceStrFunc(Frames[FrameNumber])+'<br>');
    Add('</ul><hr>');
    TheEmail:=Email;
    If (TheEmail<>'') then
      Add('<h5><p><i>'+SNotify+Administrator+': <a href="mailto:'+TheEmail+'">'+TheEmail+'</a></i></p></h5>');
    Add('</body></html>');
    end;
end;

Procedure TWebHandler.Run;
var ARequest : TRequest;
    AResponse : TResponse;
begin
  while not FTerminated do
    begin
    if WaitForRequest(ARequest,AResponse) then
      DoHandleRequest(ARequest,AResponse);
    if assigned(OnIdle) then
      OnIdle(Self);
    end;
end;

Procedure TWebHandler.Log(EventType: TEventType; Const Msg: String);
begin
  If Assigned(FOnLog) then
    FOnLog(EventType,Msg);
end;

procedure TWebHandler.ShowRequestException(R: TResponse; E: Exception);

  Function GetStatusCode : integer;

  begin
    if (E is EHTTP) then
      Result:=EHTTP(E).StatusCode
    else
      Result:=E.HelpContext;
    if (Result=0) then
      Result:=500;
  end;

Var
  S : TStrings;
  handled: boolean;
  CT : String;

begin
  if R.ContentSent then exit;
  if assigned(OnShowRequestException) then
    begin
    handled:=false;
    OnShowRequestException(R,E,Handled);
    if handled then exit;
    end;
  If RedirectOnError and not R.HeadersSent then
    begin
    R.SendRedirect(format(RedirectOnErrorURL,[HTTPEncode(E.Message)]));
    R.SendContent;
    Exit;
    end;
  If (not R.HeadersSent) then
    begin
    R.Code:=GetStatusCode;
    if (E is EHTTP) Then
      CT:=EHTTP(E).StatusText
    else
      CT:='';
    if (CT='') then
      CT:='Application error '+E.ClassName;;
    R.CodeText:=CT;
    R.ContentType:='text/html';
    end;
  If (R.ContentType='text/html') then
    begin
    S:=TStringList.Create;
    Try
      ExceptionToHTML(S, E, Title, Email, Administrator);
      R.Content:=S.Text;
      R.SendContent;
    Finally
      FreeAndNil(S);
    end;
    end;
end;

Procedure TWebHandler.InitRequest(ARequest: TRequest);
begin
  ARequest.OnUnknownEncoding:=Self.OnUnknownRequestEncoding;
end;

Procedure TWebHandler.InitResponse(AResponse: TResponse);
begin
  // Do nothing
end;

Function TWebHandler.GetEmail: String;
begin
  Result := FEmail;
end;

Function TWebHandler.GetAdministrator: String;
begin
  Result := FAdministrator;
end;

Procedure TWebHandler.DoCallModule(AModule : TCustomHTTPModule; const AModuleName : String ; ARequest: TRequest; AResponse: TResponse);

begin
  SetBaseURL(AModule,AModuleName,ARequest);
  if (OnInitModule<>Nil) then
    OnInitModule(Self,AModule);
  AModule.DoAfterInitModule(ARequest);
  if AModule.Kind=wkOneShot then
    begin
    try
      AModule.HandleRequest(ARequest,AResponse);
    finally
      AModule.Free;
    end;
    end
  else
    AModule.HandleRequest(ARequest,AResponse);
end;

Procedure TWebHandler.HandleModuleRequest(Sender : TModuleItem; ARequest: TRequest; AResponse: TResponse);

Var
  MC : TCustomHTTPModuleClass;
  M  : TCustomHTTPModule;
  MN : String;

begin
  MC:=Sender.ModuleClass;
  MN:=Sender.ModuleName;
  // Modules expect the path info to contain the action name as the first part. (See getmodulename);
  ARequest.GetNextPathInfo;
  M:=FindModule(MC);
  if (M=Nil) then
    if Sender.SkipStreaming then
      M:=MC.CreateNew(Self)
    else
      M:=MC.Create(Self);
  DoCallModule(M,MN,ARequest,AResponse);
end;

Procedure TWebHandler.HandleRequest(ARequest: TRequest; AResponse: TResponse);

begin
  try
    if LegacyRouting then
      OldHandleRequest(ARequest,AResponse)
    else
      HTTPRouter.RouteRequest(ARequest,AResponse);
  except
    On E : Exception do
      ShowRequestException(AResponse,E);
  end;
end;

Procedure TWebHandler.OldHandleRequest(ARequest: TRequest; AResponse: TResponse);

Var
  MC : TCustomHTTPModuleClass;
  M  : TCustomHTTPModule;
  MN : String;
  MI : TModuleItem;

begin
  MC:=Nil;
  M:=NIL;
  MI:=Nil;
  If (OnGetModule<>Nil) then
    OnGetModule(Self,ARequest,MC);
  If (MC=Nil) then
    begin
    MN:=GetModuleName(ARequest);
    MI:=ModuleFactory.FindModule(MN);
    if (MI=Nil) then
      DoError(SErrNoModuleForRequest,[MN],400,'Not found');
    MC:=MI.ModuleClass;
    end;
  M:=FindModule(MC); // Check if a module exists already
  If (M=Nil) then
    if assigned(MI) and Mi.SkipStreaming then
      M:=MC.CreateNew(Self)
    else
      M:=MC.Create(Self);
   DoCallModule(M,MN,ARequest,AResponse);
end;

function TWebHandler.GetApplicationURL(ARequest: TRequest): String;
begin
  Result:=FApplicationURL;
  If (Result='') then
    Result:=ARequest.ScriptName;
end;

Class Procedure TWebHandler.DoError(Const Msg : String;AStatusCode : Integer = 0; const AStatusText : String = '');

Var
  E : EFpWebError;

begin
  E:=EFpWebError.Create(Msg);
  E.StatusCode:=AStatusCode;
  E.StatusText:=AStatusText;
  Raise E;
end;

Class Procedure TWebHandler.DoError(Const Fmt: String; Const Args: Array of const;
  AStatusCode: Integer = 0; Const AStatusText: String = '');
begin
  DoError(Format(Fmt,Args),AStatusCode,AStatusText);
end;

procedure TWebHandler.Terminate;
begin
  FTerminated := true;
  If Assigned(FOnTerminate) then 
    FOnTerminate(Self);
end;

Function TWebHandler.GetModuleName(Arequest: TRequest): string;

   Function GetDefaultModuleName : String;

   begin
      if (DefaultModuleName<>'') then
        Result:=DefaultModuleName
      else if (ModuleFactory.Count=1) then
        Result:=ModuleFactory[0].ModuleName;
   end;

var
  S : String;
  I : Integer;

begin
  If (FModuleVar<>'') then
    Result:=ARequest.QueryFields.Values[FModuleVar];//Module name from query parameter using the FModuleVar as parameter name (default is 'Module')
  If (Result='') then
    begin
    S:=ARequest.PathInfo;
    If (Length(S)>0) and (S[1]='/') then  
      Delete(S,1,1);                      //Delete the leading '/' if exists
    I:=Length(S);
    If (I>0) and (S[I]='/') then
      Delete(S,I,1);                      //Delete the trailing '/' if exists
    I:=Pos('/',S);
    if (I>0) or PreferModuleName then
      Result:=ARequest.GetNextPathInfo;
    end;
  If (Result='') then
    begin
    if Not AllowDefaultModule then
      DoError(SErrNoModuleNameForRequest,400,'Not found');
    Result:=GetDefaultModuleName
    end;
end;

procedure TWebHandler.EndRequest(ARequest: TRequest; AResponse: TResponse);
begin
  AResponse.Free;
  ARequest.Free;
end;

function TWebHandler.FindModule(ModuleClass: TCustomHTTPModuleClass): TCustomHTTPModule;
Var
  I : Integer;
begin
  I:=ComponentCount-1;
  While (I>=0) and (Not ((Components[i] is ModuleClass) and (TCustomHTTPModule(Components[i]).Kind<>wkOneShot))) do
    Dec(i);
  if (I>=0) then
    Result:=Components[i] as TCustomHTTPModule
  else
    Result:=Nil;
end;

Procedure TWebHandler.SetBaseURL(AModule: TCustomHTTPModule;
  Const AModuleName: String; ARequest: TRequest);

Var
  S,P : String;

begin
  S:=IncludeHTTPPathDelimiter(GetApplicationURL(ARequest));
  P:=IncludeHTTPPathDelimiter(ARequest.ReturnedPathInfo);
  If (P='') or (P='/') then
    P:=IncludeHTTPPathDelimiter(AModuleName);
  if (Length(P)>0) and (P[1]='/') then
    Delete(P,1,1);
{$ifdef CGIDEBUG}
  senddebug(Format('SetBaseURL : "%s" "%s"',[S,P]));
{$endif CGIDEBUG}
  AModule.BaseURL:=S+P;
end;

Procedure TWebHandler.DoHandleRequest(ARequest: TRequest; AResponse: TResponse);
begin
  Try
    HandleRequest(ARequest,AResponse);
    If Not AResponse.ContentSent then
      try
        AResponse.SendContent;
      except
        On E : Exception do
          Log(etError,Format(SErrSendingContent,[E.ClassName,E.Message]));
      end;
  Finally
    EndRequest(ARequest,AResponse);
  end;
end;

constructor TWebHandler.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FModuleVar:='Module'; // Do not localize
  FAllowDefaultModule:=True;
  FHandleGetOnPost := True;
  FRedirectOnError := False;
  FRedirectOnErrorURL := '';
  ModuleFactory.OnModuleRequest:=@HandleModuleRequest;
end;

destructor TWebHandler.Destroy;
begin
  ModuleFactory.OnModuleRequest:=@HandleModuleRequest;
  Inherited;
end;

{ TCustomWebApplication }

function TCustomWebApplication.GetAdministrator: String;
begin
  result := FWebHandler.Administrator;
end;

function TCustomWebApplication.GetAllowDefaultModule: Boolean;
begin
  result := FWebHandler.AllowDefaultModule;
end;

function TCustomWebApplication.GetApplicationURL: String;
begin
  result := FWebHandler.ApplicationURL;
end;

function TCustomWebApplication.GetDefaultModuleName: String;
begin
  Result:=FWebHandler.DefaultModuleName;
end;

function TCustomWebApplication.GetEmail: String;
begin
  result := FWebHandler.Email;
end;

function TCustomWebApplication.CreateEventLog: TEventLog;
begin
  Result:=TEventLog.Create(Nil);
  With Result do
    begin
    Name:=Self.Name+'Logger';
    Identification:=Title;
    RegisterMessageFile(ParamStr(0));
    LogType:=ltSystem;
    Active:=True;
    end;
end;

procedure TCustomWebApplication.FreeEventLog(AEventLog: TEventLog);
begin
  AEventLog.Free;
end;

function TCustomWebApplication.GetEventLog: TEventLog;

begin
  if not assigned(FEventLog) then
    FEventLog := CreateEventLog;
  Result := FEventLog;
end;

function TCustomWebApplication.GetHandleGetOnPost: Boolean;
begin
  result := FWebHandler.HandleGetOnPost;
end;

function TCustomWebApplication.GetLegacyRouting: Boolean;
begin
  Result:=FWebHandler.LegacyRouting;
end;

function TCustomWebApplication.GetModuleVar: String;
begin
  result := FWebHandler.ModuleVariable;
end;

function TCustomWebApplication.GetOnGetModule: TGetModuleEvent;
begin
  result := FWebHandler.OnGetModule;
end;

function TCustomWebApplication.GetOnShowRequestException: TOnShowRequestException;
begin
  result := FWebHandler.OnShowRequestException;
end;

function TCustomWebApplication.GetOnUnknownRequestEncoding: TOnUnknownEncodingEvent;
begin
  Result := FWebHandler.OnUnknownRequestEncoding
end;

function TCustomWebApplication.GetRedirectOnError: boolean;
begin
  result := FWebHandler.RedirectOnError;
end;

function TCustomWebApplication.GetPreferModuleName: boolean;
begin
  result := FWebHandler.PreferModuleName;
end;

function TCustomWebApplication.GetRedirectOnErrorURL: string;
begin
  result := FWebHandler.RedirectOnErrorURL;
end;

procedure TCustomWebApplication.SetAdministrator(const AValue: String);
begin
  FWebHandler.Administrator := AValue;
end;

procedure TCustomWebApplication.SetAllowDefaultModule(const AValue: Boolean);
begin
  FWebHandler.AllowDefaultModule := AValue;
end;

procedure TCustomWebApplication.SetApplicationURL(const AValue: String);
begin
  FWebHandler.ApplicationURL := AValue;
end;

procedure TCustomWebApplication.SetDefaultModuleName(const AValue: String);
begin
  FWebHandler.DefaultModuleName:=AValue;
end;

procedure TCustomWebApplication.SetEmail(const AValue: String);
begin
  FWebHandler.Email := AValue;
end;

procedure TCustomWebApplication.SetHandleGetOnPost(const AValue: Boolean);
begin
  FWebHandler.HandleGetOnPost := AValue;
end;

procedure TCustomWebApplication.SetLegacyRouting(AValue: Boolean);
begin
  FWebHandler.LegacyRouting:=AValue;
end;

procedure TCustomWebApplication.SetModuleVar(const AValue: String);
begin
  FWebHandler.ModuleVariable := AValue;
end;

procedure TCustomWebApplication.SetOnGetModule(const AValue: TGetModuleEvent);
begin
  FWebHandler.OnGetModule := AValue;
end;

procedure TCustomWebApplication.SetOnShowRequestException(const AValue: TOnShowRequestException);
begin
  FWebHandler.OnShowRequestException := AValue;
end;

procedure TCustomWebApplication.SetOnUnknownRequestEncoding(
  AValue: TOnUnknownEncodingEvent);
begin
  FWebHandler.OnUnknownRequestEncoding:=AValue;
end;

procedure TCustomWebApplication.SetRedirectOnError(const AValue: boolean);
begin
  FWebHandler.RedirectOnError := AValue;
end;

procedure TCustomWebApplication.SetPreferModuleName(const AValue: boolean);
begin
  FWebHandler.PreferModuleName := AValue;
end;

procedure TCustomWebApplication.SetRedirectOnErrorURL(const AValue: string);
begin
  FWebHandler.RedirectOnErrorURL :=AValue;
end;

procedure TCustomWebApplication.DoRun;
begin
  FWebHandler.Run;
end;

procedure TCustomWebApplication.SetTitle(const AValue: string);
begin
  inherited SetTitle(AValue);
  FWebHandler.Title := Title;
end;

constructor TCustomWebApplication.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FWebHandler := InitializeWebHandler;
  FWebHandler.FOnTerminate:=@DoOnTerminate;
  FWebHandler.FOnLog:=@Log;
end;

procedure TCustomWebApplication.DoOnTerminate(Sender : TObject);
begin
  If Not Terminated then
    Terminate;
end;

destructor TCustomWebApplication.Destroy;
begin
  FWebHandler.Free;
  FreeEventLog(FEventLog);
  Inherited;
end;

procedure TCustomWebApplication.CreateForm(AClass: TComponentClass; out Reference);
begin
  TComponent(Reference):=AClass.Create(FWebHandler);
end;

procedure TCustomWebApplication.Initialize;
begin
  StopOnException:=True;
  Inherited;
end;

procedure TCustomWebApplication.DoLog(EventType: TEventType; const Msg: String);
begin
  EventLog.log(EventType,Msg);
end;

Procedure TCustomWebApplication.Terminate;

begin
  Inherited;
  If Not Webhandler.FTerminated then
    WebHandler.Terminate;
end;


end.

