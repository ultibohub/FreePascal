{$mode objfpc}
{$IFNDEF FPC_DOTTEDUNITS}
unit OleServer;
{$ENDIF FPC_DOTTEDUNITS}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses WinApi.Windows, WinApi.Messages, WinApi.Activex, System.SysUtils, System.Classes, WinApi.Comobj;
{$ELSE FPC_DOTTEDUNITS}
uses Windows, Messages, ActiveX, SysUtils, Classes, ComObj;
{$ENDIF FPC_DOTTEDUNITS}

type
  TVariantArray = Array of OleVariant;
  TOleServer    = class;
  TConnectKind  = (ckRunningOrNew,
                   ckNewInstance,
                   ckRunningInstance,
                   ckRemote,
                   ckAttachToInterface);

  TServerEventDispatch = class(TObject, IUnknown, IDispatch)
  private
    FServer : TOleServer;
  protected
    function QueryInterface(constref IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    property Server: TOleServer read FServer;
    function ServerDisconnect :Boolean;
  public
    constructor Create(aServer: TOleServer);
  end;

  PServerData = ^TServerData;
  TServerData = record
    ClassID: TGUID;
    IntfIID: TGUID;
    EventIID: TGUID;
    LicenseKey: Pointer;
    Version: Integer;
    InstanceCount: Integer;
  end;

  TOleServer = class(TComponent, IUnknown)
  private
    FRemoteMachineName: string;
    FServerData: PServerData;
    FEventDispatch:     TServerEventDispatch;
    FEventsConnection:  DWord;
  protected
    function QueryInterface(constref IID: TGUID; out Obj): HResult; stdcall; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure Loaded; override;
    procedure InitServerData; virtual; abstract;

    function  GetServer: IUnknown; virtual;

    procedure ConnectEvents(const Obj: IUnknown);
    procedure DisconnectEvents(const Obj: Iunknown);
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); virtual;

    function  GetConnectKind: TConnectKind;
    procedure SetConnectKind(ck: TConnectKind);

    function  GetAutoConnect: Boolean;
    procedure SetAutoConnect(flag: Boolean);

    property  ServerData: PServerData read FServerData write FServerData;
    property  EventDispatch: TServerEventDispatch read FEventDispatch write FEventDispatch;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Connect; virtual; abstract;
    procedure Disconnect; virtual; abstract;

  published
    property AutoConnect: Boolean read GetAutoConnect write SetAutoConnect;
    property ConnectKind: TConnectKind read GetConnectKind write SetConnectKind;
    property RemoteMachineName: string read FRemoteMachineName write FRemoteMachineName;
  end;

implementation

    function TServerEventDispatch.QueryInterface(constref IID: TGUID; out Obj): HResult; stdcall;
      begin
      end;


    function TServerEventDispatch._AddRef: Integer; stdcall;
      begin
      end;


    function TServerEventDispatch._Release: Integer; stdcall;
      begin
      end;


    function TServerEventDispatch.GetTypeInfoCount(out Count: Integer): HResult; stdcall;
      begin
      end;


    function TServerEventDispatch.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
      begin
      end;


    function TServerEventDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
      begin
      end;


    function TServerEventDispatch.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
      begin
      end;


    function TServerEventDispatch.ServerDisconnect :Boolean;
      begin
      end;


    constructor TServerEventDispatch.Create(aServer: TOleServer);
      begin
      end;


    function TOleServer.QueryInterface(constref IID: TGUID; out Obj): HResult; stdcall;
      begin
      end;


    function TOleServer._AddRef: Integer; stdcall;
      begin
      end;


    function TOleServer._Release: Integer; stdcall;
      begin
      end;


    procedure TOleServer.Loaded;
      begin
      end;


    function TOleServer.GetServer: IUnknown;
      begin
      end;


procedure TOleServer.ConnectEvents(const Obj: IUnknown);
begin
  {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}ComObj.InterfaceConnect(Obj, FServerData^.EventIID, FEventDispatch, FEventsConnection);
end;


procedure TOleServer.DisconnectEvents(const Obj: Iunknown);
begin
  {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}ComObj.InterfaceDisconnect(Obj, FServerData^.EventIID, FEventsConnection);
end;


    procedure TOleServer.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
      begin
      end;


    function  TOleServer.GetConnectKind: TConnectKind;
      begin
      end;


    procedure TOleServer.SetConnectKind(ck: TConnectKind);
      begin
      end;


    function  TOleServer.GetAutoConnect: Boolean;
      begin
      end;


    procedure TOleServer.SetAutoConnect(flag: Boolean);
      begin
      end;


    constructor TOleServer.Create(AOwner: TComponent);
      begin
      end;


    destructor TOleServer.Destroy;
      begin
      end;


end.
