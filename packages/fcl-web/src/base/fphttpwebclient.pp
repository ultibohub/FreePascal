{ **********************************************************************
  This file is part of the Free Component Library (FCL)
  Copyright (c) 2015 by the Free Pascal development team
        
  FPHTTPClient implementation of TFpWebclient.
            
  See the file COPYING.FPC, included in this distribution,
  for details about the copyright.
                   
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  **********************************************************************}
                                 
{$IFNDEF FPC_DOTTEDUNITS}
unit fphttpwebclient;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, System.SysUtils, FpWeb.Client, FpWeb.Http.Client;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, SysUtils, fpwebclient, fphttpclient;
{$ENDIF FPC_DOTTEDUNITS}

Type

  { TFPHTTPRequest }

  TFPHTTPRequest = Class(TWebClientRequest)
  Private
    FHTTP : TFPHTTPClient;
  Public
    function GetHeaders: TStrings;override;
    Constructor Create(AHTTP : TFPHTTPClient);
    Destructor Destroy; override;
  end;

  { TFPHTTPRequest }

  TFPHTTPResponse = Class(TWebClientResponse)
  Private
    FHTTP : TFPHTTPClient;
  Protected
    function GetHeaders: TStrings;override;
    Function GetStatusCode : Integer; override;
    Function GetStatusText : String; override;
  Public
    Constructor Create(AHTTP : TFPHTTPRequest);
  end;

  { TFPHTTPWebClient }

  TFPHTTPWebClient = Class(TAbstractWebClient)
  Protected
    Function DoCreateRequest: TWebClientRequest; override;
    Function DoHTTPMethod(Const AMethod,AURL : String; ARequest : TWebClientRequest) : TWebClientResponse; override;
  end;

implementation

{$IFDEF FPC_DOTTEDUNITS}
uses System.DateUtils;
{$ELSE FPC_DOTTEDUNITS}
uses dateutils;
{$ENDIF FPC_DOTTEDUNITS}

{ TFPHTTPRequest }

function TFPHTTPRequest.GetHeaders: TStrings;
begin
  Result:=FHTTP.RequestHeaders;
end;

constructor TFPHTTPRequest.Create(AHTTP: TFPHTTPClient);
begin
  FHTTP:=AHTTP;
end;

destructor TFPHTTPRequest.Destroy;
begin
  FreeAndNil(FHTTP);
  inherited Destroy;
end;

{ TFPHTTPResponse }

function TFPHTTPResponse.GetHeaders: TStrings;
begin
  if Assigned(FHTTP) then
    Result:=FHTTP.ResponseHeaders
  else
    Result:=Inherited GetHeaders;
end;

Function TFPHTTPResponse.GetStatusCode: Integer;
begin
  if Assigned(FHTTP) then
    Result:=FHTTP.ResponseStatusCode
  else
    Result:=0;
end;

Function TFPHTTPResponse.GetStatusText: String;
begin
  if Assigned(FHTTP) then
    Result:=FHTTP.ResponseStatusText
  else
    Result:='';
end;

Constructor TFPHTTPResponse.Create(AHTTP: TFPHTTPRequest);
begin
  Inherited Create(AHTTP);
  FHTTP:=AHTTP.FHTTP;
end;


{ TFPHTTPWebClient }

Function TFPHTTPWebClient.DoCreateRequest: TWebClientRequest;

Var
  C : TFPHTTPClient;

begin
  C:=TFPHTTPClient.Create(Self);
  C.RequestHeaders.NameValueSeparator:=':';
  C.ResponseHeaders.NameValueSeparator:=':';
//  C.HTTPversion:='1.0';
  Result:=TFPHTTPRequest.Create(C);
end;

Function TFPHTTPWebClient.DoHTTPMethod(Const AMethod, AURL: String;
  ARequest: TWebClientRequest): TWebClientResponse;

Var
  U,S : String;
  h : TFPHTTPClient;


begin
  U:=AURL;
  H:=TFPHTTPRequest(ARequest).FHTTP;
  S:=ARequest.ParamsAsQuery;
  if (S<>'') then
    begin
    if Pos('?',U)=0 then
      U:=U+'?';
    U:=U+S;
    end;
  Result:=TFPHTTPResponse.Create(ARequest as TFPHTTPRequest);
  try
    if Assigned(ARequest.Content) and (ARequest.Headers.IndexOfName('Content-length')<0) then
      H.AddHeader('Content-length',IntToStr(ARequest.Content.size));
    if ARequest.Content.Size>0 then
      begin
      H.RequestBody:=ARequest.Content;
      H.RequestBody.Position:=0;
      end;
    H.HTTPMethod(AMethod,U,Result.Content,[]); // Will raise an exception
  except
    FreeAndNil(Result);
    Raise;
  end;
end;

end.

