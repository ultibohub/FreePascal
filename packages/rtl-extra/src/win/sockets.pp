{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$mode objfpc}
{$ModeSwitch out}
{$IFNDEF FPC_DOTTEDUNITS}
unit Sockets;
{$ENDIF FPC_DOTTEDUNITS}

Interface

{$macro on}
{$define maybelibc:=}

{$IFDEF FPC_DOTTEDUNITS}
  Uses
     WinApi.Winsock2,System.CTypes;
{$ELSE FPC_DOTTEDUNITS}
  Uses
     winsock2,ctypes;
{$ENDIF FPC_DOTTEDUNITS}

Type
  // the common socket functions are defined as size_t.
  // without defining them for Windows this way, the 
  // sockets unit is not crossplatform. This is not a mistake
  // wrt 64-bit, the types are "INT" in the headers.
  // Mantis #22834
  size_t  = cuint32;
  ssize_t = cint32;
  tsocklen= cint;
  psocklen= ^tsocklen;

const
  EsockEINTR           = WSAEINTR;
  EsockEBADF           = WSAEBADF;
  EsockEFAULT          = WSAEFAULT;
  EsockEINVAL          = WSAEINVAL;
  EsockEACCESS         = WSAEACCES;
  EsockEMFILE          = WSAEMFILE;
  EsockEMSGSIZE        = WSAEMSGSIZE;
  EsockENOBUFS         = WSAENOBUFS;
  EsockENOTCONN        = WSAENOTCONN;
  EsockENOTSOCK        = WSAENOTSOCK;
  EsockEPROTONOSUPPORT = WSAEPROTONOSUPPORT;
  EsockEWOULDBLOCK     = WSAEWOULDBLOCK;
  EsockADDRINUSE       = WSAEADDRINUSE;

  SHUT_RD          = SD_RECEIVE; // aliases so we are cross-platform
  SHUT_WR          = SD_SEND;
  SHUT_RDWR        = SD_BOTH;

{$i socketsh.inc}
{$i fpwinsockh.inc}

// finalizing Winsock2 stack might upset other DLLS. Mantis #22597
var 
  NoWinsockCleanupCall : Boolean = false;

Implementation

{******************************************************************************
                          Basic Socket Functions
******************************************************************************}

//function fprecvmsg     (s:cint; msg: pmsghdr; flags:cint):ssize_t;
//function fpsendmsg    (s:cint; hdr: pmsghdr; flags:cint):ssize;

//function fpsocket     (domain:cint; xtype:cint; protocol: cint):cint;

function socketerror:cint;
begin
 result:=wsagetlasterror;
end;

function fpsocket       (domain:cint; xtype:cint; protocol: cint):cint;
begin
  fpSocket:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Socket(Domain,xtype,ProtoCol);
end;

function fpsend (s:cint; msg:pointer; len:size_t; flags:cint):ssize_t;
begin
  fpSend:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Send(S,msg,len,flags);
end;

function fpsendto (s:cint; msg:pointer; len:size_t; flags:cint; tox :psockaddr; tolen: tsocklen):ssize_t;
begin
  // Dubious construct, this should be checked. (IPV6 fails ?)
  fpSendTo:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.SendTo(S,msg,Len,Flags,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.PSockAddr(tox),toLen);
end;

function fprecv         (s:cint; buf: pointer; len: size_t; flags: cint):ssize_t;
begin
  fpRecv:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Recv(S,Buf,Len,Flags);
end;

function fprecvfrom    (s:cint; buf: pointer; len: size_t; flags: cint; from : psockaddr; fromlen : psocklen):ssize_t;

begin
  fpRecvFrom:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.RecvFrom(S,Buf,Len,Flags,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.PSockAddr(From),FromLen);
end;

function fpconnect     (s:cint; name  : psockaddr; namelen : tsocklen):cint;

begin
  fpConnect:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Connect(S,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.PSockAddr(name),nameLen);
end;

function fpshutdown     (s:cint; how:cint):cint;
begin
  fpShutDown:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.ShutDown(S,How);
end;

Function socket(Domain,SocketType,Protocol:Longint):Longint;
begin
  socket:=fpsocket(Domain,sockettype,protocol);
end;

Function Send(Sock:Longint;Const Buf;BufLen,Flags:Longint):Longint;

begin
  send:=fpsend(sock,@buf,buflen,flags);
end;

Function SendTo(Sock:Longint;Const Buf;BufLen,Flags:Longint;Var Addr; AddrLen : Longint):Longint;

begin
  sendto:=fpsendto(sock,@buf,buflen,flags,@addr,addrlen);
end;

Function Recv(Sock:Longint;Var Buf;BufLen,Flags:Longint):Longint;
begin
  Recv:=fpRecv(Sock,@Buf,BufLen,Flags);
end;

Function RecvFrom(Sock : Longint; Var Buf; Buflen,Flags : Longint; Var Addr; var AddrLen : longint) : longint;
begin
  RecvFrom:=fpRecvFrom(Sock,@Buf,BufLen,Flags,@Addr,@AddrLen);
end;

function fpbind (s:cint; addrx : psockaddr; addrlen : tsocklen):cint;
begin
  fpbind:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Bind(S,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.PSockAddr(Addrx),AddrLen);
end;

function fplisten      (s:cint; backlog : cint):cint;
begin
  fplisten:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Listen(S,backlog);
end;

function fpaccept      (s:cint; addrx : psockaddr; addrlen : psocklen):cint;
begin
  fpAccept:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.Accept(S,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.PSockAddr(Addrx), AddrLen);
end;

function fpgetsockname (s:cint; name  : psockaddr; namelen : psocklen):cint;
begin
  fpGetSockName:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.GetSockName(S,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.TSockAddr(name^),nameLen^);
end;

function fpgetpeername (s:cint; name  : psockaddr; namelen : psocklen):cint;
begin
  fpGetPeerName:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.GetPeerName(S,{$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.TSockAddr(name^),NameLen^);
end;

function fpgetsockopt  (s:cint; level:cint; optname:cint; optval:pointer; optlen : psocklen):cint;
begin
  fpGetSockOpt:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.GetSockOpt(S,Level,OptName,OptVal,OptLen^);
end;

function fpsetsockopt  (s:cint; level:cint; optname:cint; optval:pointer; optlen :tsocklen):cint;
begin
  fpSetSockOpt:={$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.SetSockOpt(S,Level,OptName,OptVal,OptLen);
end;

function fpsocketpair  (d:cint; xtype:cint; protocol:cint; sv:pcint):cint;
begin
  fpsocketpair:=-1;
  WSASetLastError(EOPNOTSUPP); // so that wsagetlasterror retrieves it
end;

Function CloseSocket(Sock:Longint):Longint;
begin
  result := {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.CloseSocket (Sock);
end;

Function Bind(Sock:Longint;Const Addr;AddrLen:Longint):Boolean;

begin
  bind:=fpBind(Sock,@Addr,AddrLen)=0;
end;

Function Listen(Sock,MaxConnect:Longint):Boolean;

begin
  Listen:=fplisten(Sock,MaxConnect)=0;
end;

Function Accept(Sock:Longint;Var Addr;Var Addrlen:Longint):Longint;

begin
  Accept:=FPAccept(sock,@addr,@addrlen);
end;

Function Shutdown(Sock:Longint;How:Longint):Longint;

begin
 shutdown:=fpshutdown(sock,how);
end;

Function Connect(Sock:Longint;Const Addr;Addrlen:Longint):Boolean;

begin
 connect:=fpconnect(sock,@addr,addrlen)=0;
end;

Function GetSocketName(Sock:Longint;Var Addr;Var Addrlen:Longint):Longint;
begin
 GetSocketName:=fpGetSockName(sock,@addr,@addrlen);
end;

Function GetPeerName(Sock:Longint;Var Addr;Var Addrlen:Longint):Longint;
begin
 GetPeerName:=fpGetPeerName(Sock,@addr,@addrlen);
end;

Function GetSocketOptions(Sock,Level,OptName:Longint;Var OptVal;Var optlen:longint):Longint;
begin
 GetSocketOptions:=fpGetSockOpt(sock,level,optname,@optval,@optlen);
end;

Function SetSocketOptions(Sock,Level,OptName:Longint;Const OptVal;optlen:longint):Longint;

begin
 SetSocketOptions:=fpsetsockopt(sock,level,optname,@optval,optlen);
end;

Function SocketPair(Domain,SocketType,Protocol:Longint;var Pair:TSockArray):Longint;
begin
  SocketPair:=fpsocketpair(domain,sockettype,protocol,@pair[1]);
end;

function fpWrite(handle : longint;Const bufptr;size : dword) : dword;
begin
  fpWrite := dword({$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.send(handle, bufptr, size, 0));
  if fpWrite = dword({$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.SOCKET_ERROR) then
    fpWrite := 0;
end;

function fpRead(handle : longint;var bufptr;size : dword) : dword;
  var
     d : dword;

  begin
     if ioctlsocket(handle,FIONREAD,@d) = {$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.SOCKET_ERROR then
       begin
         fpRead:=0;
         exit;
       end;
     if d>0 then
       begin
         if size>d then
           size:=d;
         fpRead := dword({$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.recv(handle, bufptr, size, 0));
         if fpRead = dword({$IFDEF FPC_DOTTEDUNITS}WinApi.{$ENDIF}Winsock2.SOCKET_ERROR) then
           fpRead := 0;
       end;
  end;

{$i sockets.inc}

{ Winsocket stack needs an init. and cleanup code }
var
  wsadata : twsadata;

initialization
  WSAStartUp(WINSOCK_VERSION,wsadata);
finalization
  If Not NoWinsockCleanupCall Then 
   WSACleanUp;
end.
