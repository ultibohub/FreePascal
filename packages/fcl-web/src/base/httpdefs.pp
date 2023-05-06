{
    $Id: header,v 1.1 2000/07/13 06:33:45 michael Exp $
    This file is part of the Free Component Library (FCL)
    Copyright (c) 1999-2000 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{

    HTTPDefs: Basic HTTP protocol declarations and classes

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
{$mode objfpc}
{$H+}
{ $DEFINE CGIDEBUG}
unit HTTPDefs;

interface

uses typinfo, Classes, Sysutils, httpprotocol, uriparser;

const
  DefaultTimeOut = 15;
  SFPWebSession  = 'FPWebSession'; // Cookie name for session.


  fieldAccept = HeaderAccept deprecated;
  FieldAcceptCharset = HeaderAcceptCharset deprecated;
  FieldAcceptEncoding = HeaderAcceptEncoding deprecated;
  FieldAcceptLanguage = HeaderAcceptLanguage deprecated;
  FieldAcceptRanges = HeaderAcceptRanges deprecated;
  FieldAge = HeaderAge deprecated;
  FieldAllow = HeaderAllow deprecated;
  FieldAuthorization = HeaderAuthorization deprecated;
  FieldCacheControl = HeaderCacheControl deprecated;
  FieldConnection = HeaderConnection deprecated;
  FieldContentEncoding = HeaderContentEncoding deprecated;
  FieldContentLanguage = HeaderContentLanguage deprecated;
  FieldContentLength = HeaderContentLength deprecated;
  FieldContentLocation = HeaderContentLocation deprecated;
  FieldContentMD5 = HeaderContentMD5 deprecated;
  FieldContentRange = HeaderContentRange deprecated;
  FieldContentType = HeaderContentType deprecated;
  FieldDate = HeaderDate deprecated;
  FieldETag = HeaderETag deprecated;
  FieldExpires = HeaderExpires deprecated;
  FieldExpect = HeaderExpect deprecated;
  FieldFrom = HeaderFrom deprecated;
  FieldHost = HeaderHost deprecated;
  FieldIfMatch = HeaderIfMatch deprecated;
  FieldIfModifiedSince = HeaderIfModifiedSince deprecated;
  FieldIfNoneMatch = HeaderIfNoneMatch deprecated;
  FieldIfRange = HeaderIfRange deprecated;
  FieldIfUnModifiedSince = HeaderIfUnModifiedSince deprecated;
  FieldLastModified = HeaderLastModified deprecated;
  FieldLocation = HeaderLocation deprecated;
  FieldMaxForwards = HeaderMaxForwards deprecated;
  FieldPragma = HeaderPragma deprecated;
  FieldProxyAuthenticate = HeaderProxyAuthenticate deprecated;
  FieldProxyAuthorization = HeaderProxyAuthorization deprecated;
  FieldRange = HeaderRange deprecated;
  FieldReferer = HeaderReferer deprecated;
  FieldRetryAfter = HeaderRetryAfter deprecated;
  FieldServer = HeaderServer deprecated;
  FieldTE = HeaderTE deprecated;
  FieldTrailer = HeaderTrailer deprecated;
  FieldTransferEncoding = HeaderTransferEncoding deprecated;
  FieldUpgrade = HeaderUpgrade deprecated;
  FieldUserAgent = HeaderUserAgent deprecated;
  FieldVary = HeaderVary deprecated;
  FieldVia = HeaderVia deprecated;
  FieldWarning = HeaderWarning deprecated;
  FieldWWWAuthenticate = HeaderWWWAuthenticate deprecated;

  // These fields are NOT in the HTTP 1.1 definition.
  FieldXRequestedWith = HeaderXRequestedWith deprecated;
  FieldCookie = HeaderCookie deprecated;
  FieldSetCookie = HeaderSetCookie deprecated;

  NoHTTPFields    = 28;

  HTTPDateFmt     = httpProtocol.HTTPDateFmt;
  SCookieExpire   = httpProtocol.SCookieExpire;
  SCookieDomain   = httpProtocol.SCookieDomain;
  SCookiePath     = httpProtocol.SCookiePath;
  SCookieSecure   = httpProtocol.SCookieSecure;
  SCookieHttpOnly = httpProtocol.SCookieHttpOnly;
  SCookieSameSite = httpProtocol.SCookieSameSite;

  HTTPMonths : array[1..12] of string[3] = (
    'Jan', 'Feb', 'Mar', 'Apr',
    'May', 'Jun', 'Jul', 'Aug',
    'Sep', 'Oct', 'Nov', 'Dec');
  HTTPDays: array[1..7] of string[3] = (
    'Sun', 'Mon', 'Tue', 'Wed',
    'Thu', 'Fri', 'Sat');

Type
  // HTTP related variables.
  THTTPVariableType = (hvUnknown,hvHTTPVersion, hvMethod, hvCookie, hvSetCookie, hvXRequestedWith,
                   hvPathInfo,hvPathTranslated,hvRemoteAddress,hvRemoteHost,hvScriptName,
                   hvServerPort,hvURL,hvQuery,hvContent);
  THTTPVariableTypes = Set of THTTPVariableType;

Type
  THTTPVariables = Array[THTTPVariableType] of string;
  THttpFields  = Array[1..NoHTTPFields] of string deprecated;
  THttpIndexes = Array[1..NoHTTPFields] of integer deprecated;

Const
  HeaderBasedVariables = [hvCookie,hvSetCookie,hvXRequestedWith];
  // For this constant, the header names corresponds to the property index used in THTTPHeader.
  HTTPFieldNames : THttpFields
              = (fieldAccept, fieldAcceptCharset, fieldAcceptEncoding,
                 fieldAcceptLanguage, fieldAuthorization, fieldConnection,
                 fieldContentEncoding, fieldContentLanguage, fieldContentLength,
                 fieldContentType, fieldCookie, fieldDate, fieldExpires,
                 fieldFrom, fieldIfModifiedSince, fieldLastModified, fieldLocation,
                 fieldPragma, fieldReferer, fieldRetryAfter, fieldServer,
                 fieldSetCookie, fieldUserAgent, fieldWWWAuthenticate,
                  fieldHost, fieldCacheControl,fieldXRequestedWith,fieldIfNoneMatch) deprecated;

  // Map header names on indexes in property getter/setter. 0 means not mapped !
  HTTPFieldIndexes : THTTPIndexes
                   =  (1,2,3,
                       4,5,6,
                       7,8,9,
                       10,11,12,13,
                       14,15,16,17,
                       18,19,20,21,
                       22,23,24,
                       34,0,36,26) deprecated;

type
  TContentStreamingState = (cssStart, cssData, cssEnd);


type
  TRequest = Class;

  { TCookie }
  TSameSite = (ssEmpty,ssNone,ssStrict,ssLax);

  TCookie = class(TCollectionItem)
  private
    FHttpOnly: Boolean;
    FName: string;
    FSameSite: TSameSite;
    FValue: string;
    FPath: string;
    FDomain: string;
    FExpires: TDateTime;
    FSecure: Boolean;
  protected
    Function GetAsString: string;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    procedure Expire;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
    property Domain: string read FDomain write FDomain;
    property Path: string read FPath write FPath;
    property Expires: TDateTime read FExpires write FExpires;
    property Secure: Boolean read FSecure write FSecure;
    property HttpOnly: Boolean read FHttpOnly write FHttpOnly;
    property SameSite: TSameSite Read FSameSite Write FSameSite;
    Property AsString : String Read GetAsString;
  end;

{ TCookies }

  TCookies = class(TCollection)
  private
  protected
    function GetCookie(Index: Integer): TCookie;
    procedure SetCookie(Index: Integer; Value: TCookie);
  public
    function  Add: TCookie;
    Function CookieByName(const AName : String) : TCookie;
    Function FindCookie(const AName : String): TCookie;
    Function IndexOfCookie(const AName : String) : Integer;
    property Items[Index: Integer]: TCookie read GetCookie write SetCookie; default;
  end;

  { TUploadedFile }

  TUploadedFile = Class(TCollectionItem)
  Private
    FContentType: String;
    FDescription: String;
    FDisposition: String;
    FFieldName: String;
    FFileName: String;
    FLocalFileName: String;
    FSize: Int64;
    FStream : TStream;
  Protected
    // Note that this will free the file stream, to be able to close it - file is share deny write locked!
    Procedure DeleteTempUploadedFile; virtual;
    function GetStream: TStream; virtual;
    Procedure FreeStream; virtual;
  Public
    Destructor Destroy; override;
    Property FieldName : String Read FFieldName Write FFieldName;
    Property FileName : String Read FFileName Write FFileName;
    Property Stream : TStream Read GetStream;
    Property Size : Int64 Read FSize Write FSize;
    Property ContentType : String Read FContentType Write FContentType;
    Property Disposition : String Read FDisposition Write FDisposition;
    Property LocalFileName : String Read FLocalFileName Write FLocalFileName;
    Property Description : String Read FDescription Write FDescription;
  end;
  TUploadedFileClass = Class of TUploadedFile;

  { TUploadedFiles }

  TUploadedFiles = Class(TCollection)
  private
    FRequest : TRequest; // May be nil
    function GetFile(Index : Integer): TUploadedFile;
    procedure SetFile(Index : Integer; const AValue: TUploadedFile);
  Protected
    Function GetTempUploadFileName(Const AName, AFileName : String; ASize : Int64): String;
    Procedure DeleteTempUploadedFiles; virtual;
  public
    Function First : TUploadedFile;
    Function Last : TUploadedFile;
    Function IndexOfFile(const AName : String) : Integer;
    Function FileByName(const AName : String) : TUploadedFile;
    Function FindFile(const AName : String) : TUploadedFile;
    Property Files[Index : Integer] : TUploadedFile read GetFile Write SetFile; default;
  end;
  TUploadedFilesClass = Class of TUploadedFiles;

  { TMimeItem }
  // Used to decode multipart encoded content

  TMimeItem = Class(TCollectionItem)
  private
  protected
    FLocalFilename: string;

    Function CreateUploadedFileStreaming(Files : TUploadedFiles) : TUploadedFile; virtual;
    Function CreateUploadedFile(Files : TUploadedFiles) : TUploadedFile; virtual;
    function CreateFile(Files: TUploadedFiles): TUploadedFile; virtual;
    Function ProcessHeader(Const AHeader,AValue : String) : Boolean; virtual;
    procedure SaveToFile(const AFileName: String); virtual;
    function GetIsFile: Boolean; virtual;
    // These must be implemented in descendents;
    function GetDataSize: Int64; virtual; abstract;
    function GetHeader(AIndex: Integer): String; virtual; abstract;
    Procedure SetHeader(AIndex: Integer; Const AValue: String); virtual; abstract;
  Public
    Procedure ProcessStreaming(const State: TContentStreamingState; const Buf; const Size: Integer); virtual; abstract;
    Procedure Process(Stream : TStream); virtual; abstract;
    Property Data : String index 0 Read GetHeader Write SetHeader;
    Property Name : String index 1 Read GetHeader Write SetHeader;
    Property Disposition : String index 2 Read GetHeader Write SetHeader;
    Property FileName : String index 3 Read GetHeader Write SetHeader;
    Property ContentType : String index 4 Read GetHeader Write SetHeader;
    Property Description : String index 5 Read GetHeader Write SetHeader;
    Property IsFile : Boolean  Read GetIsFile;
    Property DataSize : Int64 Read GetDataSize;
  end;
  TMimeItemClass = Class of TMimeItem;
  { TMimeItems }

  TMimeItems = Class(TCollection)
  private
    FBoundary: string;
    FFiles: TUploadedFiles;
    FPreamble: string;
    function GetP(AIndex : Integer): TMimeItem;
  Protected
    Procedure CreateUploadFiles(Files : TUploadedFiles; Vars : TStrings); virtual;
    procedure FormSplit(var Cnt: String; const boundary: String); virtual;
    procedure ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    // With streaming is meant that the incoming data is processed in smaller
    // chunks. To support streaming descendents have to implement
    // ProcessStreamingMultiPart
    class function SupportsStreamingProcessing: Boolean; virtual;
    procedure SetBoundary(const AValue: string); virtual;
  Public
    Function First : TMimeItem;
    Function Last : TMimeItem;
    Property Parts[AIndex : Integer] : TMimeItem Read GetP; default;
    property Preamble: string read FPreamble;
    Property Boundary: string read FBoundary write SetBoundary;
    Property Files: TUploadedFiles read FFiles write FFiles;
  end;
  TMimeItemsClass = Class of TMimeItems;

  { TStreamingMimeItems }

  TStreamingMimeItems = class(TMimeItems)
  private
    FBuffer: string;
    FBufferCount: SizeInt;
    FCurrentItem: TMimeItem;
    FMimeEndFound: Boolean;
    FAtStart: Boolean;
  protected
    procedure SetBoundary(const AValue: string); override;
    procedure ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer); override;
    class function SupportsStreamingProcessing: Boolean; override;
  end;

  { THTTPHeader }

  THTTPHeader = class(TObject)
  private
    FContentFields: TStrings;
    FCookieFields: TStrings;
    FHTTPVersion: String;
    FFields : THeadersArray;
    FVariables : THTTPVariables;
    FQueryFields: TStrings;
    FCustomHeaders : TStringList;
    function GetCustomHeaders: TStringList;
    function GetSetField(AIndex: Integer): String;
    function GetSetFieldName(AIndex: Integer): String;
    procedure SetCookieFields(const AValue: TStrings);
    Function GetFieldCount : Integer;
    Function GetContentLength : Integer;
    Procedure SetContentLength(Value : Integer);
    Function GetFieldOrigin(AIndex : Integer; Out H : THeader; Out V : THTTPVAriableType) : Boolean;
    Function GetServerPort : Word;
    Procedure SetServerPort(AValue : Word);
    Function GetSetFieldValue(Index : Integer) : String; virtual;
    // These are private, because we need to know for sure the index is in the correct enumerated.
    Function GetHeaderValue(AIndex : Integer) : String;
    Procedure SetHeaderValue(AIndex : Integer; const AValue : String);
    procedure SetHTTPVariable(AIndex: Integer; const AValue : String);
    Function  GetHTTPVariable(AIndex : Integer) : String;
  Protected
    // Kept for backwards compatibility
    Class Function IndexToHTTPHeader (AIndex : Integer) : THeader;
    Class Function IndexToHTTPVariable (AIndex : Integer) : THTTPVariableType;
    procedure SetHTTPVariable(AVariable : THTTPVariableType; const AValue: String);
    Function  GetFieldValue(Index : Integer) : String; virtual; deprecated;
    Procedure SetFieldValue(Index : Integer; const Value : String); virtual; deprecated;
    procedure ParseFirstHeaderLine(const line: String);virtual;
    Procedure ParseCookies; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // This is the clean way to get HTTP headers.
    Function HeaderIsSet(AHeader : THeader) : Boolean;
    Function GetHeader(AHeader : THeader) : String;
    Procedure SetHeader(AHeader : THeader; Const AValue : String);
    // Get/Set a field by name. These calls handle 'known' fields. For unknown fields, Get/SetCustomheader is called.
    procedure SetFieldByName(const AName, AValue: String);
    function GetFieldByName(const AName: String): String;
    // Variables
    Class Function GetVariableHeaderName(AVariable : THTTPVariableType) : String;
    Class Function GetVariableHeaderType(Const aName : string) : THTTPVariableType;
    Function  GetHTTPVariable(AVariable : THTTPVariableType) : String;
    Class Function ParseContentType(const AContentType: String; Parameters: TStrings) : String;
    // Get/Set custom headers.
    Function GetCustomHeader(const Name: String) : String; virtual;
    Procedure SetCustomHeader(const Name, Value: String); virtual;
    Function LoadFromStream(Stream : TStream; IncludeCommand : Boolean) : integer;
    Function LoadFromStrings(Strings: TStrings; IncludeCommand : Boolean) : integer; virtual;
    // Common access
    // This is an internal table. We should try to get rid of it,
    // It requires a lot of duplication.
    property FieldCount: Integer read GetFieldCount; deprecated;
    property Fields[AIndex: Integer]: String read GetSetField ; deprecated;
    property FieldNames[AIndex: Integer]: String read GetSetFieldName ;deprecated;
    property FieldValues[AIndex: Integer]: String read GetSetFieldValue ;deprecated;
    // Official HTTP headers.
    property Accept: String Index Ord(hhAccept) read GetHeaderValue write SetHeaderValue;
    property AcceptCharset: String Index Ord(hhAcceptCharset) Read GetHeaderValue Write SetHeaderValue;
    property AcceptEncoding: String Index Ord(hhAcceptEncoding) Read GetHeaderValue Write SetHeaderValue;
    property AcceptLanguage: String Index Ord(hhAcceptLanguage) Read GetHeaderValue Write SetHeaderValue;
    property Authorization: String Index Ord(hhAuthorization) Read GetHeaderValue Write SetHeaderValue;
    property Connection: String Index Ord(hhConnection) Read GetHeaderValue Write SetHeaderValue;
    property ContentEncoding: String Index Ord(hhContentEncoding) Read GetHeaderValue Write SetHeaderValue;
    property ContentLanguage: String Index Ord(hhContentLanguage) Read GetHeaderValue Write SetHeaderValue;
    property ContentLength: Integer Read GetContentLength Write SetContentLength; // Index 9
    property ContentType: String Index Ord(hhContentType) Read GetHeaderValue Write SetHeaderValue;
    property Date: String Index Ord(hhDate) Read GetHeaderValue Write SetHeaderValue;
    property Expires: String Index Ord(hhExpires) Read GetHeaderValue Write SetHeaderValue;
    property From: String Index Ord(hhFrom) Read GetHeaderValue Write SetHeaderValue;
    Property Host : String Index Ord(hhHost) Read GetHeaderValue Write SetHeaderValue;
    property IfModifiedSince: String Index Ord(hhIfModifiedSince) Read GetHeaderValue Write SetHeaderValue;
    property LastModified: String Index Ord(hhLastModified) Read GetHeaderValue Write SetHeaderValue;
    property Location: String Index Ord(hhLocation) Read GetHeaderValue Write SetHeaderValue;
    property Pragma: String Index Ord(hhPragma) Read GetHeaderValue Write SetHeaderValue;
    property Referer: String Index Ord(hhReferer) Read GetHeaderValue Write SetHeaderValue;
    property RetryAfter: String Index Ord(hhRetryAfter) Read GetHeaderValue Write SetHeaderValue;
    property Server: String Index Ord(hhServer) Read GetHeaderValue Write SetHeaderValue;
    property UserAgent: String Index Ord(hhUserAgent) Read GetHeaderValue Write SetHeaderValue;
    property Warning: String Index Ord(hhWarning) Read GetHeaderValue Write SetHeaderValue;
    property WWWAuthenticate: String Index Ord(hhWWWAuthenticate) Read GetHeaderValue Write SetHeaderValue;
    property Via: String Index Ord(hhVia) Read GetHeaderValue Write SetHeaderValue;
    // HTTP headers, Delphi compatibility
    Property HTTPAccept : String Index Ord(hhAccept) read GetFieldValue Write SetFieldValue;
    Property HTTPAcceptCharset : String Index Ord(hhAcceptCharset) read GetFieldValue Write SetFieldValue;
    Property HTTPAcceptEncoding : String Index Ord(hhAcceptEncoding) read GetFieldValue Write SetFieldValue;
    Property HTTPIfModifiedSince : String Index Ord(hhIfModifiedSince) read GetFieldValue Write SetFieldValue; // Maybe change to TDateTime ??
    Property HTTPReferer : String Index Ord(hhReferer) read GetFieldValue Write SetFieldValue;
    Property HTTPUserAgent : String Index Ord(hhUserAgent) read GetFieldValue Write SetFieldValue;
    // Headers, not in HTTP spec.
    property Cookie: String Index Ord(hvCookie) Read GetHTTPVariable Write SetHTTPVariable;
    property SetCookie: String Index Ord(hvSetCookie) Read GetHTTPVariable Write SetHTTPVariable;
    Property HTTPXRequestedWith : String Index Ord(hvXRequestedWith) read GetHTTPVariable Write SetHTTPVariable;
    Property HttpVersion : String Index ord(hvHTTPVErsion) Read GetHTTPVariable Write SetHTTPVariable;
    Property ProtocolVersion : String Index ord(hvHTTPVErsion) Read GetHTTPVariable Write SetHTTPVariable;
    // Specials, mostly from CGI protocol/Apache.
    Property PathInfo : String index Ord(hvPathInfo) read GetHTTPVariable Write SetHTTPVariable;
    Property PathTranslated : String index Ord(hvPathTranslated) read GetHTTPVariable Write SetHTTPVariable;
    Property RemoteAddress : String Index Ord(hvRemoteAddress) read GetHTTPVariable Write SetHTTPVariable;
    Property RemoteAddr : String Index Ord(hvRemoteAddress) read GetHTTPVariable Write SetHTTPVariable; // Alias, Delphi-compat
    Property RemoteHost : String Index Ord(hvRemoteHost) read  GetHTTPVariable Write SetHTTPVariable;
    Property ScriptName : String Index Ord(hvScriptName) read  GetHTTPVariable Write SetHTTPVariable;
    Property ServerPort : Word Read GetServerPort Write SetServerPort; // Index 30
    Property Method : String Index Ord(hvMethod) read GetHTTPVariable Write SetHTTPVariable;
    Property URL : String Index Ord(hvURL) read GetHTTPVariable Write SetHTTPVariable;
    Property Query : String Index Ord(hvQuery) read GetHTTPVariable Write SetHTTPVariable;
    Property Content : String Index Ord(hvContent) Read GetHTTPVariable Write SetHTTPVariable;
    // Lists
    Property CookieFields : TStrings Read FCookieFields Write SetCookieFields;
    Property ContentFields: TStrings read FContentFields;
    property QueryFields : TStrings read FQueryFields;
    Property CustomHeaders: TStringList read GetCustomHeaders;
  end;

  TStreamingContentType = (sctUnknown, sctMultipart, sctFormUrlEncoded);
  TOnStreamEncodingEvent = Procedure (Sender : TRequest; const State: TContentStreamingState; const Buf; const Size: Integer) of object;
  TOnUnknownEncodingEvent = Procedure (Sender : TRequest; Const ContentType : String;Stream : TStream) of object;
  { TRequest }

  TRequest = class(THttpHeader)
  Private
    class var _RequestCount : {$IFDEF CPU64}QWord{$ELSE}Cardinal{$ENDIF};
  private
    FCommand: String;
    FCommandLine: String;
    FHandleGetOnPost: Boolean;
    FOnUnknownEncoding: TOnUnknownEncodingEvent;
    FFiles : TUploadedFiles;
    FRequestID: String;
    FReturnedPathInfo : String;
    FLocalPathPrefix : string;
    FContentRead : Boolean;
    FRouteParams : TStrings;
    FStreamingContentType: TStreamingContentType;
    FMimeItems: TMimeItems;
    FKeepFullContents: Boolean;
    FStreamingContent: string;
    FStreamingContentRead: Integer;
    FOnStreamEncodingEvent: TOnStreamEncodingEvent;
    function GetLocalPathPrefix: string;
    function GetFirstHeaderLine: String;
    function GetRP(const AParam : String): String;
    procedure SetRP(const AParam : String; const AValue: String);
  Protected
    procedure AllocateRequestID; virtual;
    Function AllowReadContent : Boolean; virtual;
    Function CreateUploadedFiles : TUploadedFiles; virtual;
    Function CreateMimeItems : TMimeItems; virtual;
    procedure HandleUnknownEncoding(Const AContentType : String;Stream : TStream); virtual;
    procedure HandleStreamEncoding(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    procedure ParseFirstHeaderLine(const line: String);override;
    procedure ReadContent; virtual;
    Procedure ProcessMultiPart(Stream : TStream; Const Boundary : String;SL:TStrings); virtual;
    Procedure ProcessQueryString(Const FQueryString : String; SL:TStrings); virtual;
    procedure ProcessURLEncoded(Stream : TStream;SL:TStrings); virtual;
    Function RequestUploadDir : String; virtual;
    Function GetTempUploadFileName(Const AName, AFileName : String; ASize : Int64) : String; virtual;
    // This will free any TUPloadedFile.Streams that may exist, as they may lock the files and thus prevent them
    Procedure DeleteTempUploadedFiles; virtual;

    Procedure InitRequestVars; virtual;
    procedure InitContentRequestVars; virtual;
    procedure InitHeaderRequestVars; virtual;

    Procedure InitPostVars; virtual;
    Procedure InitGetVars; virtual;
    Procedure InitContent(const AContent : String);

    procedure ProcessStreamingContent(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    function DerriveStreamingContentType(): TStreamingContentType;
    procedure ProcessStreamingURLEncoded(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    procedure ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    // ProcessStreamingSetContent collects all data and stores it into Content
    procedure ProcessStreamingSetContent(const State: TContentStreamingState; const Buf; const Size: Integer); virtual;
    procedure HandleStreamingUnknownEncoding(const State: TContentStreamingState; const Buf; const Size: Integer);
    Property ContentRead : Boolean Read FContentRead Write FContentRead;
  Public
    Type
      TConnectionIDAllocator = Procedure(out aID : String) of object;
    class var IDAllocator : TConnectionIDAllocator;
  public
    Class Var DefaultRequestUploadDir : String;
    constructor Create; override;
    destructor destroy; override;
    Function GetNextPathInfo : String;
    Function ToString: ansistring; override;
    Property RequestID : String Read FRequestID;
    Property RouteParams[AParam : String] : String Read GetRP Write SetRP;
    Property ReturnedPathInfo : String Read FReturnedPathInfo Write FReturnedPathInfo;
    Property LocalPathPrefix : string Read GetLocalPathPrefix;
    Property CommandLine : String Read FCommandLine;
    Property Command : String read FCommand;
    Property URI : String Index Ord(hvURL) read GetHTTPVariable Write SetHTTPVariable;                // Uniform Resource Identifier
    Property QueryString : String Index Ord(hvQuery) read GetHTTPVariable Write SetHTTPVariable;
    Property HeaderLine : String read GetFirstHeaderLine;
    Property Files : TUploadedFiles Read FFiles;
    Property HandleGetOnPost : Boolean Read FHandleGetOnPost Write FHandleGetOnPost;
    Property OnUnknownEncoding : TOnUnknownEncodingEvent Read FOnUnknownEncoding Write FOnUnknownEncoding;
    Property OnStreamEncodingEvent: TOnStreamEncodingEvent read FOnStreamEncodingEvent write FOnStreamEncodingEvent;
    Property IfMatch : String Index ord(hhIfMatch) Read GetHeaderValue Write SetHeaderValue;
    Property IfNoneMatch : String  Index ord(hhIfNoneMatch) Read GetHeaderValue Write SetHeaderValue;
    Property IfRange : String  Index ord(hhIfRange) Read GetHeaderValue Write SetHeaderValue;
    Property IfUnModifiedSince : String  Index ord(hhIfUnmodifiedSince) Read GetHeaderValue Write SetHeaderValue;
    Property ContentRange : String Index ord(hhContentRange) Read GetHeaderValue Write SetHeaderValue;
    Property TE : String Index ord(hhTE) Read GetHeaderValue Write SetHeaderValue;
    Property Upgrade : String Index ord(hhUpgrade) Read GetHeaderValue Write SetHeaderValue;
    property KeepFullContents: Boolean read FKeepFullContents write FKeepFullContents;
  end;


  { TResponse }

  TResponse = class(THttpHeader)
  private
    FContents: TStrings;
    FContentStream : TStream;
    FCode: Integer;
    FCodeText: String;
    FFreeContentStream: Boolean;
    FHeadersSent: Boolean;
    FContentSent: Boolean;
    FRequest : TRequest;
    FCookies : TCookies;
    function GetContent: RawByteString;
    procedure SetContent(const AValue: RawByteString);
    procedure SetContents(AValue: TStrings);
    procedure SetContentStream(const AValue: TStream);
    procedure SetFirstHeaderLine(const line: String);
    function  GetFirstHeaderLine: String;
    procedure ContentsChanged(Sender : TObject);
  Protected
    Procedure DoSendHeaders(Headers : TStrings); virtual; abstract;
    Procedure DoSendContent; virtual; abstract;
    Procedure CollectHeaders(Headers : TStrings); virtual;
  public
    constructor Create(ARequest : TRequest); overload;
    destructor destroy; override;
    Procedure SendContent;
    Procedure SendHeaders;
    Procedure SendResponse; // Delphi compatibility
    Procedure SendRedirect(const TargetURL:String);
    Function ToString: ansistring; override;
    // Set Code and CodeText. Send content if aSend=True
    Procedure SetStatus(aStatus : Cardinal; aSend : Boolean = False);
    Property Request : TRequest Read FRequest;
    Property Code: Integer Read FCode Write FCode;
    Property CodeText: String Read FCodeText Write FCodeText;
    Property Age : String  Index Ord(hhAge) Read GetHeaderValue Write SetHeaderValue;
    Property Allow : String  Index Ord(hhAllow) Read GetHeaderValue Write SetHeaderValue;
    Property CacheControl : String Index Ord(hhCacheControl) Read GetHeaderValue Write SetHeaderValue;
    Property ContentLocation : String Index Ord(hhContentLocation) Read GetHeaderValue Write SetHeaderValue;
    Property ContentMD5 : String Index Ord(hhContentMD5) Read GetHeaderValue Write SetHeaderValue;
    Property ContentRange : String Index Ord(hhContentRange) Read GetHeaderValue Write SetHeaderValue;
    Property ETag : String  Index Ord(hhEtag) Read GetHeaderValue Write SetHeaderValue;
    Property ProxyAuthenticate : String Index Ord(hhProxyAuthenticate) Read GetHeaderValue Write SetHeaderValue;
    Property RetryAfter : String  Index Ord(hhRetryAfter) Read GetHeaderValue Write SetHeaderValue;
    Property FirstHeaderLine : String Read GetFirstHeaderLine Write SetFirstHeaderLine;
    Property ContentStream : TStream Read FContentStream Write SetContentStream;
    Property Content : RawByteString Read GetContent Write SetContent;
    property Contents : TStrings read FContents Write SetContents;
    Property HeadersSent : Boolean Read FHeadersSent;
    Property ContentSent : Boolean Read FContentSent;
    property Cookies: TCookies read FCookies;
    Property FreeContentStream : Boolean Read FFreeContentStream Write FFreeContentStream;
  end;
  
  { TSessionVariable }


  { TCustomSession }
  TSessionState = (ssNew,ssExpired,ssActive,ssResponseInitialized);
  TSessionStates = set of TSessionState;

  TCustomSession = Class(TComponent)
  Private
    FOnSessionStateChange: TNotifyEvent;
    FSessionCookie: String;
    FSessionCookiePath: String;
    FStates: TSessionStates;
    FTimeOut: Integer;
    Procedure SetSessionState(aValue : TSessionStates);
  Protected
    Procedure AddToSessionState(aValue : TSessionState);
    Procedure RemoveFromSessionState(aValue : TSessionState);
    // Can be overridden to provide custom behaviour.
    procedure SetSessionCookie(const AValue: String); virtual;
    procedure SetSessionCookiePath(const AValue: String); virtual;
    // When called, generates a new GUID. Override to retrieve GUID from cookie/URL/...
    Function GetSessionID : String; virtual;
    // These must be overridden to actually store/retrieve variables.
    Function GetSessionVariable(const VarName : String) : String; Virtual; abstract;
    procedure SetSessionVariable(const VarName : String; const AValue: String);Virtual;abstract;
  Public
    Constructor Create(AOwner : TComponent); override;
    // Init session from request.
    Procedure InitSession(ARequest : TRequest; OnNewSession,OnExpired : TNotifyEvent); virtual;
    // Init response from session (typically, add cookie to response).
    Procedure InitResponse(AResponse : TResponse); virtual;
    // Update response from session (typically, change cookie to response and write session data).
    Procedure UpdateResponse(AResponse : TResponse); virtual; Abstract;
    // Remove variable from list of variables.
    Procedure RemoveVariable(const VariableName : String); virtual; abstract;
    // Terminate session
    Procedure Terminate; virtual; abstract;
    // checks if session variable exists
    Function SessionVariableExists(const VarName : String) : Boolean; Virtual; abstract;
    // Session timeout in minutes
    Property TimeOutMinutes : Integer Read FTimeOut Write FTimeOut default 15;
    // ID of this session.
    Property SessionID : String Read GetSessionID;
    // Name of cookie used when tracing session. (may or may not be used)
    property SessionCookie : String Read FSessionCookie Write SetSessionCookie;
    // Path of cookie used when tracing session. (may or may not be used)
    Property SessionCookiePath : String Read FSessionCookiePath write SetSessionCookiePath;
    // Variables, tracked in session.
    Property Variables[VarName : String] : String Read GetSessionVariable Write SetSessionVariable;
    // Session state
    Property SessionState : TSessionStates Read FStates;
    // Called when state changes
    Property OnSessionStateChange : TNotifyEvent Read FOnSessionStateChange Write FOnSessionStateChange;
  end;

  TRequestEvent = Procedure (Sender: TObject; ARequest : TRequest) of object;
  TResponseEvent = Procedure (Sender: TObject; AResponse : TResponse) of object;

  { EHTTP }

  EHTTP = Class(Exception)
  private
    FStatusCode: Integer;
    FStatusText: String;
    function GetStatusCode: Integer;virtual;
  Public
    // These are transformed to the HTTP status code and text. Helpcontext is taken as the default for statuscode.
    Property StatusCode : Integer Read GetStatusCode Write FStatusCode;
    Property StatusText : String Read FStatusText Write FStatusText;
  end;

  HTTPError = EHTTP;
  { CORS Support }

  TCORSOption = (coAllowCredentials,   // Set Access-Control-Allow-Credentials header
                 coEmptyDomainToOrigin // If allowedOrigins is empty, try to determine origin from request and echo that
                 );
  TCORSOptions = Set of TCORSOption;

  THandleCORSOption = (hcDetect, // Detect OPTIONS request, send full headers
                       hcFull,   // Force sending full headers
                       hcHumanReadable, // Human readable result
                       hcSend    // In case of full headers, send response
                       );
  THandleCORSOptions = set of THandleCORSOption;

  { TCORSSupport }

  TCORSSupport = Class(TPersistent)
  private
    FAllowedHeaders: String;
    FAllowedMethods: String;
    FAllowedOrigins: String;
    FMaxAge: Integer;
    FEnabled: Boolean;
    FOptions: TCORSOptions;
    procedure SetAllowedMethods(const AValue: String);
  Public
    Constructor Create; virtual;
    function ResolvedCORSAllowedOrigins(aRequest: TRequest): String; virtual;
    // Handle CORS headers. Returns TRUE if the full headers were added.
    Function HandleRequest(aRequest: TRequest; aResponse: TResponse; aOptions : THandleCORSOptions = [hcDetect]) : Boolean; virtual;
    Procedure Assign(Source : TPersistent); override;
  Published
    // Enable CORS Support ? if False, the HandleRequest will exit at once
    Property Enabled : Boolean Read FEnabled Write FEnabled;
    // Options that control the behaviour
    Property Options : TCORSOptions Read FOptions Write FOptions;
    // Allowed methods
    Property AllowedMethods : String Read FAllowedMethods Write SetAllowedMethods;
    // Domains that are allowed to use this RPC service
    Property AllowedOrigins: String Read FAllowedOrigins  Write FAllowedOrigins;
    // Domains that are allowed to use this RPC service
    Property AllowedHeaders: String Read FAllowedHeaders Write FAllowedHeaders;
    // Access-Control-Max-Age header value. Set to zero not to send the header
    Property MaxAge : Integer Read FMaxAge Write FMaxAge;
  end;


Function HTTPDecode(const AStr: String): String;
Function HTTPEncode(const AStr: String): String;
Function IncludeHTTPPathDelimiter(const AStr: String): String;

Var
  // Default classes used when instantiating the collections.
  UploadedFilesClass : TUploadedFilesClass = TUploadedFiles;
  UploadedFileClass : TUploadedFileClass = TUploadedFile;
  MimeItemsClass : TMimeItemsClass = TStreamingMimeItems;
  MimeItemClass : TMimeItemClass = nil;

Const
  DefaultAllowedHeaders = 'x-requested-with, content-type, authorization';
  DefaultAllowedOrigins = '*';
  DefaultAllowedMethods = 'GET, PUT, POST, OPTIONS, HEAD';

//Procedure Touch(Const AName : String);

implementation

uses
{$ifdef CGIDEBUG}
  dbugintf,
{$endif}
  strutils;

Resourcestring
  SErrContentAlreadySent        = 'HTTP Response content was already sent';
  SErrHeadersAlreadySent        = 'HTTP headers were already sent';
  SErrInternalUploadedFileError = 'Internal uploaded file configuration error';
  SErrNoSuchUploadedFile        = 'No such uploaded file : "%s"';
  SErrUnknownCookie             = 'Unknown cookie: "%s"';
  SErrNoRequestMethod           = 'No REQUEST_METHOD passed from server.';

const
   hexTable = '0123456789ABCDEF';

{ ---------------------------------------------------------------------
  Auxiliary functions
  ---------------------------------------------------------------------}
Procedure Touch(Const AName : String);

begin
//  FileClose(FileCreate('/tmp/touch-'+StringReplace(AName,'/','_',[rfReplaceAll])));
end;

Function GetFieldNameIndex(const AName : String) : Integer;

var
  Name: String;
begin
  Name := UpperCase(AName);
  Result:=NoHTTPFields;
  While (Result>0) and (UpperCase(HTTPFieldNames[Result])<>Name) do
    Dec(Result);
  If Result>0 then
    Result:=HTTPFieldIndexes[Result];
end;

Function HTTPDecode(const AStr: String): String;

begin
  Result:=httpProtocol.HTTPDecode(AStr);
end;

Function HTTPEncode(const AStr: String): String;

begin
  Result:=httpProtocol.HTTPEncode(AStr);
end;

Function IncludeHTTPPathDelimiter(const AStr: String): String;

begin
  Result:=httpProtocol.IncludeHTTPPathDelimiter(AStr);
end;

{ -------------------------------------------------------------------
  THTTPMimeItem, default used by TRequest to process Multipart-encoded data.
  -------------------------------------------------------------------}

Type
  { THTTPMimeItem }

  THTTPMimeItem = Class(TMimeItem)
  private
    FData : Array[0..5] of string;
    FHeadersProcessed: Boolean;
    FBuffer: string;
    FStream: TStream;
    FDataSize: Int64;
  protected
    Procedure SetHeader(AIndex: Integer; Const AValue: String); override;
    function GetDataSize: Int64; override;
    function GetHeader(AIndex: Integer): String; override;
    function GetIsFile: Boolean; override;
  public
    destructor Destroy; override;
    Procedure Process(Stream : TStream); override;
    Procedure ProcessStreaming(const State: TContentStreamingState; const Buf; const Size: Integer); override;
  end;

  { THTTPStreamingMimeItem }
  THTTPStreamingMimeItem = Class(THTTPMimeItem)
  protected
    function GetDataSize: Int64; override;
  end;

function THTTPStreamingMimeItem.GetDataSize: Int64;
begin
  if GetIsFile then
    Result:=FDataSize
  else
    Result:=Length(Data);
end;


{ TStreamingMimeItems }

procedure TStreamingMimeItems.ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer);
var
  bl: SizeInt;
  p: SizeInt;
  BufEnd: SizeInt;
  LeadingLineEndMissing: Boolean;
begin
  // The length of the boundary, including the leading CR/LF, '--' and trailing '--' or
  // CR/LF.
  bl := Length(FBoundary)+6;
  LeadingLineEndMissing:=False;
  if State=cssStart then
    begin
    FMimeEndFound := False;
    FAtStart := True;
    end;

  // Allocate enough memory to hold the buffer-size, and the lenght of the
  // boundary (bl). To be able to find a boundary-string at which is divided between
  // two calls to this function, the last bl-amount of characters at the end of
  // the buffer, are stored to be handled in the next call to this function.
  SetLength(FBuffer, Size+bl);
  if Size > 0 then
    System.Move(Buf, FBuffer[FBufferCount+1], Size);

  BufEnd := FBufferCount+1+Size;

  FBufferCount := 1;
  repeat
  if FAtStart and CompareMem(@FBuffer[1], PChar('--'+FBoundary), Length(FBoundary)+2) then
    begin
    // Sometimes a mime-message (mistakenly) does not start with CR/LF.
    p := 1;
    LeadingLineEndMissing := True;
    end
  else
    p := Pos(#13#10'--'+FBoundary, FBuffer, FBufferCount);
  if (P > 0) and (P < Size) then
    begin
    if Assigned(FCurrentItem) then
      begin
      FCurrentItem.ProcessStreaming(cssEnd, FBuffer[FBufferCount], P-FBufferCount);
      FCurrentItem := Nil;
      end
    else
      begin
      if FAtStart and (P > 1) then
        // Add the preamble to the content
        FPreamble := Copy(FBuffer, FBufferCount, P-1);
      end;
    FAtStart := False;
    Inc(P, bl);
    if LeadingLineEndMissing then
      begin
      Dec(P, 2);
      LeadingLineEndMissing := False;
      end;
    FBufferCount := P;
    if (Copy(FBuffer,p-2,2)='--') then
      FMimeEndFound := True;
    end;
  if not Assigned(FCurrentItem) and not FMimeEndFound then
    begin
    FCurrentItem := Add as TMimeItem;
    FCurrentItem.ProcessStreaming(cssStart, FBuffer[p], 0)
    end
  until (P < 1) or FMimeEndFound;

  if Assigned(FCurrentItem) then
    begin
    if state<>cssEnd then
      begin
      // Call FCurrentItem.ProcessStreaming with the current buffer, excluding
      // the last bl bytes. Keep those at the start of FBuffer, to be handled
      // in the next call to this function.
      FCurrentItem.ProcessStreaming(cssData, FBuffer[FBufferCount], BufEnd-FBufferCount-bl);
      System.Move(FBuffer[BufEnd-bl], FBuffer[1], bl);
      FBufferCount := bl;
      end
    else
      begin
      // This function won't be called again. Call FCurrentItem.ProcessStreaming
      // with the complete remaining buffer.
      FCurrentItem.ProcessStreaming(cssEnd, FBuffer[FBufferCount], BufEnd-FBufferCount+bl);
      FBufferCount := 0;
      end;
    end
  else
    FBufferCount := 0;
end;

class function TStreamingMimeItems.SupportsStreamingProcessing: Boolean;
begin
  Result := True;
end;

procedure TStreamingMimeItems.SetBoundary(const AValue: string);
begin
  if Length(FBuffer) > 0 then
    Raise Exception.Create('It is not possible to adapt the binary when the evaluation of streaming data has already been started.');
  inherited SetBoundary(AValue);
end;

{ TCORSSupport }

procedure TCORSSupport.SetAllowedMethods(const AValue: String);

var
  V : String;

begin
  V:=UpperCase(aValue);
  if FAllowedMethods=V then Exit;
  FAllowedMethods:=V;
end;

constructor TCORSSupport.Create;
begin
  FOptions:=[coAllowCredentials,coEmptyDomainToOrigin];
  AllowedHeaders:=DefaultAllowedHeaders;
  AllowedOrigins:=DefaultAllowedOrigins;
  AllowedMethods:=DefaultAllowedMethods;
end;

procedure TCORSSupport.Assign(Source: TPersistent);

Var
  CS : TCORSSupport absolute source;

begin
  if (Source is TPersistent) then
    begin
    Enabled:=CS.Enabled;
    Options:=CS.Options;
    AllowedHeaders:=CS.AllowedHeaders;
    AllowedOrigins:=CS.AllowedOrigins;
    AllowedMethods:=CS.AllowedMethods;
    MaxAge:=CS.MaxAge;
    end
  else
  inherited Assign(Source);
end;

function TCORSSupport.ResolvedCORSAllowedOrigins(aRequest : TRequest): String;

Var
  URl : String;
  uri : TURI;

begin
  Result:=FAllowedOrigins;
  if Result='' then
    begin
    // Sent with CORS request
    Result:=aRequest.GetCustomHeader('Origin');
    if (Result='') and (coEmptyDomainToOrigin in Options) then
      begin
      // Fallback
      URL:=aRequest.Referer;
      if (URL<>'') then
        begin
        uri:=ParseURI(URL,'http',0);
        Result:=Format('%s://%s',[URI.Protocol,URI.Host]);
        if (URI.Port<>0) then
          Result:=Result+':'+IntToStr(URI.Port);
        end;
      end;
    end;
  if Result='' then
    Result:='*';
end;

function TCORSSupport.HandleRequest(aRequest: TRequest; aResponse: TResponse; aOptions: THandleCORSOptions): Boolean;

Var
  Full : Boolean;

begin
  Result:=False;
  if Not Enabled then
    exit;
  Full:=(hcFull in aOptions) or ((hcDetect in aOptions) and SameText(aRequest.Method,'OPTIONS'));
  With aResponse do
    begin
    SetCustomHeader('Access-Control-Allow-Origin',ResolvedCORSAllowedOrigins(aRequest));
    if (coAllowCredentials in Options) then
      SetCustomHeader('Access-Control-Allow-Credentials','true');
    if Full then
      begin
      SetCustomHeader('Access-Control-Allow-Methods',AllowedMethods);
      SetCustomHeader('Access-Control-Allow-Headers',AllowedHeaders);
      if MaxAge>0 then
        SetCustomHeader('Access-Control-Max-Age',IntToStr(MaxAge));
      if (hcSend in aOptions) then
        begin
        SetStatus(200,True);
        Result:=True;
        end;
      end;
    end;
end;

{ EHTTP }

function EHTTP.GetStatusCode: Integer;
begin
  Result:=FStatusCode;
  if Result=0 then
    Result:=HelpContext;
end;


procedure THTTPMimeItem.SetHeader(AIndex: Integer; const AValue: String);
begin
  FData[AIndex]:=Avalue;
end;

function THTTPMimeItem.GetDataSize: int64;
begin
  Result:=Length(Data);
end;

function THTTPMimeItem.GetHeader(AIndex: Integer): String;
begin
  Result:=FData[AIndex];
end;

function THTTPMimeItem.GetIsFile: Boolean;
begin
  Result:=inherited GetIsFile;
end;

procedure THTTPMimeItem.Process(Stream: TStream);

  Function GetLine(Var S : String) : String;

  Var
    P : Integer;

  begin
    P:=Pos(#13#10,S);
    If (P<>0) then
      begin
      Result:=Copy(S,1,P-1);
      Delete(S,1,P+1);
      end;
  end;

  Function GetWord(Var S : String) : String;

  Var
    I,len : Integer;
    Quoted : Boolean;
    C : Char;

  begin
    len:=length(S);
    quoted:=false;
    Result:='';
    for i:=1 to len do
      Begin
      c:=S[i];
      if (c='"') then
        Quoted:=Not Quoted
      else
        begin
        if not (c in [' ','=',';',':']) or Quoted then
          Result:=Result+C;
        if (c in [';',':','=']) and (not quoted) then
          begin
          Delete(S,1,I);
          Exit;
          end;
        end;
      end;
     S:='';
  end;

Var
  Line : String;
  len : integer;
  S : string;
  D : String;

begin
  {$ifdef CGIDEBUG}SendMethodEnter('THTTPMimeItem.Process');{$ENDIF}
  If Stream is TStringStream then
    D:=TStringStream(Stream).Datastring
  else
    begin
    SetLength(D,Stream.Size);
    Stream.ReadBuffer(D[1],Stream.Size);
    end;
  Line:=GetLine(D);
  While (Line<>'') do
    begin
    {$ifdef CGIDEBUG}SendDebug('Process data line: '+line);{$ENDIF}
    S:=GetWord(Line);
    While (S<>'') do
      begin
      ProcessHeader(lowercase(S),GetWord(Line));
      S:=GetWord(Line);
      end;
    Line:=GetLine(D);
    end;
  // Now D contains the rest of the data, plus a CR/LF. Strip the CR/LF
  Len:=Length(D);
  If (len>2) then
    begin
    FDataSize := Len-2;
    Data:=Copy(D,1,FDataSize)
    end
  else
    Data:='';
  {$ifdef CGIDEBUG}SendMethodExit('THTTPMimeItem.Process');{$ENDIF}
end;

procedure THTTPMimeItem.ProcessStreaming(const State: TContentStreamingState; const Buf; const Size: Integer);

  Function GetLine(Var S : String) : String;

  Var
    P : Integer;

  begin
    P:=Pos(#13#10,S);
    If (P<>0) then
      begin
      Result:=Copy(S,1,P-1);
      Delete(S,1,P+1);
      end;
  end;

  Function GetWord(Var S : String) : String;

  Var
    I,len : Integer;
    Quoted : Boolean;
    C : Char;

  begin
    len:=length(S);
    quoted:=false;
    Result:='';
    for i:=1 to len do
      Begin
      c:=S[i];
      if (c='"') then
        Quoted:=Not Quoted
      else
        begin
        if not (c in [' ','=',';',':']) or Quoted then
          Result:=Result+C;
        if (c in [';',':','=']) and (not quoted) then
          begin
          Delete(S,1,I);
          Exit;
          end;
        end;
      end;
     S:='';
  end;

  procedure AddData(const Buf; Size: SizeInt);
  var
    S: string;
    i: SizeInt;
    Files: TUploadedFiles;
  begin
    if Size > 0 then
      begin
      if GetIsFile then
        begin
        // Stream directly to file
        if not Assigned(FStream) then
          begin
          Files := (Collection as TMimeItems).Files;
          if Assigned(Files) then
            FLocalFilename := Files.GetTempUploadFileName(Name, FileName, -1)
          else
            FLocalFilename := GetTempFileName('', '');
          FStream := TFileStream.Create(FLocalFilename, fmCreate);
          FDataSize := 0;
          end;

        FStream.Write(Buf, Size);
        Inc(FDataSize, Size);
        end
      else
        begin
        S := Data;
        i := Length(S);
        SetLength(S, i+Size);
        Move(Buf, S[i+1], Size);
        Data := S;
        end;
      end;
  end;

var
  i: SizeInt;
  Line, S: string;
begin
  if not FHeadersProcessed then
    begin
    if Size>0 then
      begin
      i := Length(FBuffer);
      SetLength(FBuffer, i + Size);
      Move(Buf, FBuffer[i+1], Size);
      if Copy(FBuffer, 1, 2) = #13#10 then
        i := 3
      else
        i := Pos(#13#10#13#10, FBuffer)+4;
      if i <> 4 then
        begin
        // The full headers are in the buffer now.
        Line:=GetLine(FBuffer);
        While (Line<>'') do
          begin
          {$ifdef CGIDEBUG}SendDebug('Process data line: '+line);{$ENDIF}
          S:=GetWord(Line);
          While (S<>'') do
            begin
            ProcessHeader(lowercase(S),GetWord(Line));
            S:=GetWord(Line);
            end;
          Line:=GetLine(FBuffer);
          end;
        FHeadersProcessed := True;

        AddData(FBuffer[1], Length(FBuffer));
        end;
      end;
    end
  else
    AddData(Buf, Size);

  if State=cssEnd then
    begin
    if GetIsFile then
      FreeAndNil(FStream);
    end;
end;

destructor THTTPMimeItem.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------
  THTTPHeader
  ---------------------------------------------------------------------}

function THTTPHeader.GetFieldCount: Integer;


Var
  h : THeader;

begin
  Result:=0;
  For H in THeader do
    If HeaderIsSet(H) then
      Inc(Result);
  Inc(Result,Ord(FVariables[hvXRequestedWith]<>''));
  Inc(Result,Ord(FVariables[hvSetCookie]<>''));
  Inc(Result,Ord(FVariables[hvCookie]<>''));
end;

function THTTPHeader.GetContentLength: Integer;
begin
  Result:=StrToIntDef(GetHeader(hhContentLength),0);
end;

procedure THTTPHeader.SetContentLength(Value: Integer);
begin
  SetHeader(hhContentLength,IntToStr(Value));
end;


function THTTPHeader.GetFieldOrigin(AIndex: Integer; out H: THeader;
  Out V: THTTPVAriableType): Boolean;


begin
  V:=hvUnknown;
  H:=Succ(hhUnknown);
  While (H<=High(THeader)) and (AIndex>=0) do
    begin
    If (GetHeader(H)<>'') then
      Dec(AIndex);
    H:=Succ(H);
    end;
  Result:=(AIndex<0);
  if Result then
    begin
    H:=Pred(H);
    Exit;
    end;
  h:=hhUnknown;
  if (AIndex>=0) then
    begin
    H:=hhUnknown;
    V:=hvXRequestedWith;
    if (FVariables[V]<>'') then
      Dec(AIndex);
    end;
  if (AIndex>=0) then
    begin
    V:=hvSetCookie;
    if (FVariables[V]<>'') then
      Dec(AIndex);
    end;
  if (AIndex>=0) then
    begin
    V:=hvCookie;
    if (FVariables[V]<>'') then
      Dec(AIndex);
    end;
  Result:=(AIndex<0);
  if not Result then V:=hvUnknown
end;

function THTTPHeader.GetServerPort: Word;
begin
  Result:=StrToIntDef(GetHTTPVariable(hvServerPort),0);
end;

procedure THTTPHeader.SetHTTPVariable(AIndex: Integer; const AValue: String);
begin
  if (AIndex>=0) and (Aindex<=Ord(High(THTTPVariableType))) then
    SetHTTPVariable(THTTPVariableType(AIndex),AValue);
end;

procedure THTTPHeader.SetHTTPVariable(AVariable: THTTPVariableType; const AValue: String);
begin
//  Touch(GetEnumName(TypeInfo(THTTPVariableType),Ord(AVariable))+'='+AValue);
  if FVariables[AVariable]=AValue then
    exit;
  FVariables[AVariable]:=AValue;
  if (AVariable=hvCookie) and (AValue<>'') then
    ParseCookies;
end;

procedure THTTPHeader.SetServerPort(AValue: Word);

begin
  SetHTTPVariable(hvServerPort,IntToStr(AValue));
end;
    
function THTTPHeader.GetSetFieldValue(Index: Integer): String;

Var
  H : THeader;
  V : THTTPVariableType;

begin
  if GetFieldOrigin(Index,H,V) then
    begin
    if H<>hhUnknown then
      Result:=GetHeader(H)
    else if V<>hVUnknown then
      Result:=GetHTTPVariable(V);
    end;
end;

function THTTPHeader.GetHeaderValue(AIndex: Integer): String;
begin
  if (AIndex>=0) and (AIndex<=Ord(High(THeader))) then
    Result:=GetHeader(THeader(AIndex))
  else
    Result:='';
end;

procedure THTTPHeader.SetHeaderValue(AIndex: Integer; const AValue: String);
begin
  if (AIndex>=0) and (AIndex<=Ord(High(THeader))) then
    SetHeader(THeader(AIndex),AValue);
end;

function THTTPHeader.GetHTTPVariable(AVariable: THTTPVariableType): String;

begin
  Result:=FVariables[AVariable];
end;

type
  TParseState =
    (psStart, psContentType, psSearchParam, psParam, psSearchParamEqual, psSearchParamValue, psParamValueQuoted, psParamValue);

Class Function THTTPHeader.ParseContentType(const AContentType: String; Parameters: TStrings): String;
var
  len: Integer;
  ind: Integer;
  state: TParseState;
  start: Integer;
  paramname: string;
  paramvalue: string;
begin
  // See rfc1341, Content-Type
  Result := '';
  len := Length(AContentType);
  if len=0 then
    Exit;

  ind := 1;
  state := psStart;
  while ind <= len do
    begin
    case state of
      psStart:
        begin
        if not (AContentType[ind] in [' ']) then
          begin
          state := psContentType;
          start := ind;
          end;
        end;
      psContentType:
        begin
        if (AContentType[ind] in [' ', ';']) then
          begin
            Result := Copy(AContentType, start, ind-start);
          if not Assigned(Parameters) then
            Exit;
          state := psSearchParam;
          end;
        if (ind = len) then
          begin
          Result := Copy(AContentType, start, ind-start+1);
          end;
        end;
      psSearchParam:
        begin
        if not (AContentType[ind] in [' ', ';']) then
          begin
          state := psParam;
          start := ind;
          end;
        end;
      psParam:
        begin
        if (AContentType[ind] in [' ', '=']) then
          begin
            paramname := Copy(AContentType, start, ind-start);
          if AContentType[ind] = '=' then
            state := psSearchParamValue
          else
            state := psSearchParamEqual
          end;
        end;
      psSearchParamEqual:
        begin
        if (AContentType[ind] = '=') then
          state := psSearchParamValue;
        end;
      psSearchParamValue:
        begin
        if (AContentType[ind] = '"') then
          begin
          state := psParamValueQuoted;
          start := ind +1;
          end
        else if (AContentType[ind] <> ' ') then
          begin
          state := psParamValue;
          start := ind;
          end;
        end;
      psParamValue:
        begin
        if (AContentType[ind] in [' ', ';']) then
          begin
          paramvalue := Copy(AContentType, start, ind-start);
          Parameters.Values[paramname] := paramvalue;

          state := psSearchParam;
          end
        else if (ind = len) then
          begin
          paramvalue := Copy(AContentType, start, ind-start+1);
          Parameters.Values[paramname] := paramvalue;
          end
        end;
      psParamValueQuoted:
        begin
        if AContentType[ind] = '"' then
          begin
          paramvalue := Copy(AContentType, start, ind-start);
          Parameters.Values[paramname] := paramvalue;

          state := psSearchParam;
          end
        else if (ind = len) then
          begin
          paramvalue := Copy(AContentType, start, ind-start+1);
          Parameters.Values[paramname] := paramvalue;
          end
        end;
    end;

    inc(ind);
    end;
end;

function THTTPHeader.GetHTTPVariable(AIndex: Integer): String;
begin
  if (AIndex>=0) and (AIndex<=Ord(High(THTTPVariableType))) then
    Result:=GetHTTPVariable(THTTPVariableType(AIndex))
  else
    Result:='';
end;

class function THTTPHeader.IndexToHTTPHeader(AIndex: Integer): THeader;

Const
  IDX : Array[THeader] of Integer =
      (-1,
       1,2,3,4,
       -1,-1,-1,5,-1,
       6,7,8,
       9,-1,-1,-1,
       10,12,-1,13,-1,
       14,34,-1,15,26,
       -1,-1,16,17,-1,
       18,-1,-1,-1,19,
       20,21,-1,-1,
       -1,-1,23,-1,
       -1,-1,24);

begin
  Result:=High(THeader);
  While (Result>hhUnknown) and (IDX[Result]<>AIndex) do
    Result:=Pred(Result);
end;

class function THTTPHeader.IndexToHTTPVariable(AIndex: Integer
  ): THTTPVariableType;

Const
  IDX : Array[THTTPVariableType] of Integer =
      (-1,
       0,31,11,22,36,
       25,26,27,28,29,
       30,32,33,35);

begin
  Result:=High(THTTPVariableType);
  While (Result>hvUnknown) and (IDX[Result]<>AIndex) do
    Result:=Pred(Result);
end;

function THTTPHeader.GetSetField(AIndex: Integer): String;

Var
  H : THeader;
  V : THTTPVariableType;

begin
  if GetFieldOrigin(AIndex,H,V) then
    if H<>hhUnknown then
      Result:=HTTPHeaderNames[H]+': '+GetHeader(H)
    else if V<>hVUnknown then
      Result:=GetVariableHeaderName(V)+': '+GetHTTPVariable(V);
end;

function THTTPHeader.GetCustomHeaders: TStringList;
begin
  If FCustomHeaders=Nil then
    FCustomHeaders:=TStringList.Create;
  Result:=FCustomHeaders;
end;

function THTTPHeader.GetSetFieldName(AIndex: Integer): String;

Var
  H : THeader;
  V : THTTPVariableType;

begin
  if GetFieldOrigin(AIndex,H,V) then
    if H<>hhUnknown then
      Result:=HTTPHeaderNames[H]
    else
      Result:=GetVariableHeaderName(V);
end;


function THTTPHeader.GetFieldValue(Index: Integer): String;

Var
  H : THeader;
  V : THTTPVariableType;

begin
  Result:='';
  H:=IndexToHTTPHeader(Index);
  if (H<>hhUnknown) then
    Result:=GetHeader(H)
  else
    begin
    V:=IndexToHTTPVariable(Index);
    if V<>hvUnknown then
      Result:=GetHTTPVariable(V)
    end;
end;

procedure THTTPHeader.SetCookieFields(const AValue: TStrings);
begin
  FCookieFields.Assign(AValue);
end;


procedure THTTPHeader.SetFieldValue(Index: Integer; const Value: String);


Var
  H : THeader;
  V : THTTPVariableType;

begin
  H:=IndexToHTTPHeader(Index);
  if (H<>hhUnknown) then
    SetHeader(H,Value)
  else
    begin
    V:=IndexToHTTPVariable(Index);
    if V<>hvUnknown then
      SetHTTPVariable(V,Value)
    end;
(* if (Index>=1) and (Index<=NoHTTPFields) then
    begin
    FFields[Index]:=Value;
    If (Index=11) then
    end
  else
    case Index of
      0  : FHTTPVersion:=Value;
      25 : ; // Property PathInfo : String index 25 read GetFieldValue Write SetFieldValue;
      26 : ; // Property PathTranslated : String Index 26 read GetFieldValue Write SetFieldValue;
      27 : ; // Property RemoteAddress : String Index 27 read GetFieldValue Write SetFieldValue;
      28 : ; // Property RemoteHost : String Index 28 read  GetFieldValue Write SetFieldValue;
      29 : ; // Property ScriptName : String Index 29 read  GetFieldValue Write SetFieldValue;
      30 : ; // Property ServerPort : Word Read GetServerPort; // Index 30 in TRequest
      36 : FHTTPXRequestedWith:=Value;
    end;
*)
end;

procedure THTTPHeader.ParseFirstHeaderLine(const line: String);
begin
  // Do nothing.
end;

procedure THTTPHeader.ParseCookies;

Var
  P : Integer;
  S,C : String;
  
begin
{$ifdef cgidebug}  SendMethodEnter('Parsecookies');{$endif}
  FCookieFields.Clear;
  S:=Cookie;
  While (S<>'') do
    begin
    P:=Pos(';',S);
    If (P=0) then
      P:=length(S)+1;
    C:=Copy(S,1,P-1);
    While (P<Length(S)) and (S[P+1]=' ') do
      Inc(P);
    System.Delete(S,1,P);
    FCookieFields.Add(HTTPDecode(C));
    end;
{$ifdef cgidebug}  SendMethodExit('Parsecookies done');{$endif}
end;

constructor THTTPHeader.Create;
begin
  FCookieFields:=TStringList.Create;
  FQueryFields:=TStringList.Create;
  FContentFields:=TStringList.Create;
  FHttpVersion := '1.1';
end;

destructor THTTPHeader.Destroy;

begin
  FreeAndNil(FCustomHeaders);
  FreeAndNil(FContentFields);
  FreeAndNil(FQueryFields);
  FreeAndNil(FCookieFields);
  inherited Destroy;
end;


function THTTPHeader.HeaderIsSet(AHeader: THeader): Boolean;
begin
  Result:=(FFields[AHeader]<>'');
end;

function THTTPHeader.GetHeader(AHeader: THeader): String;
begin
  Result:=FFields[AHeader];
end;

procedure THTTPHeader.SetHeader(AHeader: THeader; const AValue: String);
begin
//  Touch(GetEnumName(TypeInfo(THEader),ORd(AHeader))+'='+AValue);
  FFields[AHeader]:=AValue;
end;


function THTTPHeader.GetFieldByName(const AName: String): String;

var
  H : THeader;

begin
  H:=HeaderType(aName);
    If (h<>hhUnknown) then
    Result:=GetHeader(h)
  else
    Result:=GetCustomHeader(AName);
end;

class function THTTPHeader.GetVariableHeaderName(AVariable: THTTPVariableType
  ): String;
begin
  Case AVariable of
    hvSetCookie : Result:=HeaderSetCookie;
    hvCookie : Result:=HeaderCookie;
    hvXRequestedWith : Result:=HeaderXRequestedWith;
  end;
end;

class function THTTPHeader.GetVariableHeaderType(Const aName: string): THTTPVariableType;

begin
  Case IndexText(aName,[FieldCookie,FieldSetCookie,FieldXRequestedWith]) of
    0 : Result:=hvCookie;
    1 : Result:=hvSetCookie;
    2 : Result:=hvXRequestedWith;
  else
    Result:=hvUnknown;
  end;
end;

function THTTPHeader.GetCustomHeader(const Name: String): String;
begin
  if Assigned(FCustomHeaders) then
    Result:=CustomHeaders.Values[Name]
  else
    Result:='';
end;

procedure THTTPHeader.SetCustomHeader(const Name, Value: String);
begin
  if GetCustomHeader(Name) = '' then
    CustomHeaders.Add(Name + '=' + Value)
  else
    CustomHeaders.Values[Name] := Value;
end;

function THTTPHeader.LoadFromStream(Stream: TStream; IncludeCommand: Boolean
  ): integer;

Var
  S : TStrings;

begin
  S:=TStringList.Create;
  Try
    S.LoadFromStream(Stream);
    Result:=LoadFromStrings(S,IncludeCommand);
  Finally
    S.Free;
  end;
end;

function THTTPHeader.LoadFromStrings(Strings: TStrings; IncludeCommand: Boolean
  ): integer;

Var
  P  : Integer;
  S,VN : String;

begin
  Result:=0;
  if (Strings.Count>0) then
    begin
    if IncludeCommand then
      begin
      ParseFirstHeaderLine(Strings[0]);
      Inc(Result);
      end;
    While (Result<Strings.Count) and (Strings[Result]<>'') do
      begin
      S:=Strings[Result];
      P:=Pos(':',S);
      if (P<>0) then
        begin
        VN:=Copy(S,1,P-1);
        Delete(S,1,P);
        P:=GetFieldNameIndex(VN);
        If (P<>-1) then
          SetFieldValue(P,S);
        end;
      Inc(Result);
      end;
    end;
end;

procedure THTTPHeader.SetFieldByName(const AName, AValue: String);

var
  H : THeader;
  V : THTTPVariableType;

begin
  H:=HeaderType(aName);
  If (h<>hhUnknown) then
    SetHeader(H,aValue)
  else
    begin
    V:=GetVariableHeaderType(aName);
    if V<>hvUnknown then
      SetHTTPVariable(V,aValue)
    else
      SetCustomHeader(AName,AValue);
    end;
end;

{ ---------------------------------------------------------------------
  TMimeItems
  ---------------------------------------------------------------------}

function TMimeItems.GetP(AIndex : Integer): TMimeItem;
begin
  Result:=TMimeItem(Items[Aindex]);
end;

procedure TMimeItems.CreateUploadFiles(Files: TUploadedFiles; Vars : TStrings);

Var
  I : Integer;
  P : TMimeItem;
  Name,Value : String;

begin
  For I:=Count-1 downto 0 do
    begin
    P:=GetP(i);
    If (P.Name='') then
      P.Name:='DummyFileItem'+IntToStr(i);
      //Raise Exception.CreateFmt('Invalid multipart encoding: %s',[FI.Data]);
{$ifdef CGIDEBUG}
    With P Do
      begin
      SendSeparator;
      SendDebug  ('PMP item Name        : '+Name);
      SendDebug  ('PMP item Disposition : '+Disposition);
      SendDebug  ('PMP item FileName    : '+FileName);
      SendBoolean('PMP item IsFile      : ',IsFile);
      SendDebug  ('PMP item ContentType : '+ContentType);
      SendDebug  ('PMP item Description : '+Description);
      SendInteger('PMP item DLen        : ',Datasize);
      SendDebug  ('PMP item Data        : '+Data);
      end;
{$endif CGIDEBUG}
    Name:=P.Name;
    If Not P.IsFile Then
      Value:=P.Data
    else
      begin
      Value:=P.FileName;
      if SupportsStreamingProcessing then
        P.CreateUploadedFileStreaming(Files)
      else
        P.CreateUploadedFile(Files);
      end;
    Vars.Add(Name+'='+Value)
    end;
end;

function TMimeItem.GetIsFile: Boolean;
begin
  Result:=(FileName<>'');
end;

function TMimeItem.ProcessHeader(const AHeader, AValue: String): Boolean;

begin
  Result:=True;
  Case AHeader of
   'content-disposition' : Disposition:=Avalue;
   'name': Name:=Avalue;
   'filename' : FileName:=AValue;
   'content-description' :  description:=AValue;
   'content-type' : ContentType:=AValue;
  else
    Result:=False;
  end;
end;

Procedure TMimeItem.SaveToFile(Const AFileName: String);

Var
  D : String;
  F : TFileStream;

begin
  F:=TFileStream.Create(AFileName,fmCreate);
  Try
    D:=Data;
    F.Write(D[1],DataSize);
  finally
    F.Free;
  end;
end;

function TMimeItem.CreateUploadedFile(Files: TUploadedFiles): TUploadedFile;

Var
  J : Int64;
  D,LFN : String;

begin
  D:=Data;
  J:=DataSize;
  if (J=0){zero lenght file} or
     ((J=2)and (D=#13#10)){empty files come as a simple empty line} then
    LFN:='' //No tmp file will be created for empty files
  else
    begin
    LFN:=Files.GetTempUploadFileName(Name,FileName,J);
    SaveToFile(LFN);
    FLocalFilename := LFN;
    end;
  Result := CreateFile(Files);
end;

function TMimeItem.CreateFile(Files: TUploadedFiles): TUploadedFile;
begin
  Result:=Nil;
  if (FLocalFileName<>'') then
   begin
   Result:=Files.Add as TUploadedFile;
   with Result do
     begin
     FieldName:=Self.Name;
     FileName:=Self.FileName;
     ContentType:=Self.ContentType;
     Disposition:=Self.Disposition;
     Size:=Self.Datasize;
     LocalFileName:=self.FLocalFileName;
     Description:=Self.Description;
     end;
   end;
end;

function TMimeItem.CreateUploadedFileStreaming(Files: TUploadedFiles): TUploadedFile;
begin
  if FLocalFilename='' then
    // Even though this class supports streaming procesing of data, does not
    // mean it is being used that way. In those cases the non-streaming file-
    // creation has to take place: (For example, CGI does not use the
    // streaming capabilities (may 2021))
    Result:=CreateUploadedFile(Files)
  else
    Result:=CreateFile(Files);
end;


{
  This needs MASSIVE improvements for large files.
  Best would be to do this directly from the input stream
  and save the files at once if needed. (e.g. when a
  certain size is reached.)
}

procedure TMimeItems.FormSplit(var Cnt : String; const boundary: String);

// Splits the form into items
var
  Sep : string;
  Clen,slen, p:longint;
  FI : TMimeItem;
  S : TStringStream;

begin
  {$ifdef CGIDEBUG}SendMethodEnter('TMimeItems.FormSplit');{$ENDIF}
  FBoundary := boundary;

  Sep:='--'+boundary+#13+#10;
  Slen:=length(Sep);
  CLen:=Pos('--'+Boundary+'--',Cnt);
  // Cut last marker
  Cnt:=Copy(Cnt,1,Clen-1);
  // Cut first marker
  system.Delete(Cnt,1,Slen);
  Clen:=Length(Cnt);
  While Clen>0 do
    begin
    P:=pos(Sep,Cnt);
    If (P=0) then
      P:=CLen+1;
    S:=TStringStream.Create(Copy(Cnt,1,P-1));
    try
      FI:=Add as TMimeItem;
      FI.Process(S)
    finally
      S.Free;
    end;
    system.delete(Cnt,1,P+SLen-1);
    CLen:=Length(Cnt);
    end;
  {$ifdef CGIDEBUG}SendMethodExit('TMimeItems.FormSplit');{$ENDIF}
end;

Function TMimeItems.First: TMimeItem;
begin
  If Count = 0 then
    Result := Nil
  else
    Result := Parts[0];
end;

Function TMimeItems.Last: TMimeItem;
begin
  If Count = 0 then
    Result := nil
  else
    Result := Parts[Count - 1];
end;

class function TMimeItems.SupportsStreamingProcessing: Boolean;
begin
  Result := False;
end;

procedure TMimeItems.SetBoundary(const AValue: string);
begin
  FBoundary := AValue;
end;

procedure TMimeItems.ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer);
begin
  raise Exception.Create('Streaming processing of data not supported');
end;

{ -------------------------------------------------------------------
  TRequest
  -------------------------------------------------------------------}
  
constructor TRequest.Create;
begin
  inherited create;
  FHandleGetOnPost:=True;
  FFiles:=CreateUploadedFiles;
  FFiles.FRequest:=Self;
  FLocalPathPrefix:='-';
  AllocateRequestID;
end;

function TRequest.CreateUploadedFiles: TUploadedFiles;

Var
  CC : TUploadedFilesClass;
  CI : TUploadedFileClass;

begin
  CC:=UploadedFilesClass;
  CI:=UploadedFileClass;
  if (CC=Nil) then
    CC:=TUploadedFiles;
  if (CI=Nil) then
    CI:=TUploadedFile;
  Result:=CC.Create(CI);
end;

function TRequest.CreateMimeItems: TMimeItems;

Var
  CC : TMimeItemsClass;
  CI : TMimeItemClass;

begin
  CC:=MimeItemsClass;
  CI:=MimeItemClass;
  if (CC=Nil) then
    CC:=TMimeItems;
  if (CI=Nil) then
    CI:=TMimeItem;
  Result:=CC.Create(CI);
  Result.Files := Files;
end;

destructor TRequest.destroy;
begin
  FreeAndNil(FRouteParams);
  FreeAndNil(FFiles);
  FreeAndNil(FMimeItems);
  inherited destroy;
end;

function TRequest.GetNextPathInfo: String;

Var
  P : String;
  i : Integer;
  
begin
  P:=PathInfo;
{$ifdef CGIDEBUG}SendDebug(Format('Pathinfo: "%s" "%s"',[P,FReturnedPathInfo]));{$ENDIF}
  if (P <> '') and (P[length(P)] = '/') then
    Delete(P, length(P), 1);//last char is '/'
  If (P<>'') and (P[1]='/') then
    Delete(P,1,1);
  Delete(P,1,Length(IncludeHTTPPathDelimiter(FReturnedPathInfo)));
 {$ifdef CGIDEBUG}SendDebug(Format('Pathinfo: "%s" "%s"',[P,FReturnedPathInfo]));{$ENDIF}
  I:=Pos('/',P);
  If (I=0) then
    I:=Length(P)+1;
  Result:=Copy(P,1,I-1);
  FReturnedPathInfo:=IncludeHTTPPathDelimiter(FReturnedPathInfo)+Result;
 {$ifdef CGIDEBUG}SendDebug(Format('Pathinfo: "%s" "%s" : %s',[P,FReturnedPathInfo,Result]));{$ENDIF}
end;

function TRequest.ToString: ansistring;
begin
  Result:='['+RequestID+'] : '+URL;
end;

procedure TRequest.ParseFirstHeaderLine(const line: String);
var
  i: Integer;
begin
  FCommandLine := line;
  i := Pos(' ', line);
  FCommand := UpperCase(Copy(line, 1, i - 1));
  Method:=FCommand;
  URI := Copy(line, i + 1, Length(line));

  // Extract HTTP version
  i := Pos(' ', URI);
  if i > 0 then
  begin
    FHttpVersion := Copy(URI, i + 1, Length(URI));
    URI := Copy(URI, 1, i - 1);
    FHttpVersion := Copy(HttpVersion, Pos('/', HttpVersion) + 1, Length(HttpVersion));
  end;

  // Extract query string
  i := Pos('?', URI);
  if i > 0 then
  begin
    Query:= Copy(URI, i + 1, Length(URI));
    URI := Copy(URI, 1, i - 1);
  end;
end;

function TRequest.GetLocalPathPrefix: string;
var
  pi: String;
  i: Cardinal;
begin
  if FLocalPathPrefix='-' then
    begin
    pi := PathInfo;
    FLocalPathPrefix := '';
    i := 0;
    repeat
    i := PosEx('/',PI,i+1);
    if i > 0 then
      FLocalPathPrefix := FLocalPathPrefix + '../';
    until i=0;
    end;
  result := FLocalPathPrefix;
end;


function TRequest.GetFirstHeaderLine: String;
begin
  Result := Command + ' ' + URI;
  if Length(HttpVersion) > 0 then
    Result := Result + ' HTTP/' + HttpVersion;
end;

function TRequest.GetRP(const AParam : String): String;
begin
  if Assigned(FRouteParams) then
    Result:=FRouteParams.Values[AParam]
  else
    Result:='';
end;

procedure TRequest.SetRP(const AParam : String; const AValue: String);
begin
  if (AValue<>GetRP(AParam)) And ((AValue<>'')<>Assigned(FRouteParams)) then
    FRouteParams:=TStringList.Create;
  if (AValue<>'') and Assigned(FRouteParams) then
    FRouteParams.Values[AParam]:=AValue;
end;

procedure TRequest.AllocateRequestID;
begin
  if Assigned(IDAllocator) then
    IDAllocator(FRequestID);
  if FRequestID='' then
{$IFDEF CPU64}
    FRequestID:=IntToStr(InterlockedIncrement64(_RequestCount));
{$ELSE}
    FRequestID:=IntToStr(InterlockedIncrement(_RequestCount));
{$ENDIF}
end;

function TRequest.AllowReadContent: Boolean;
begin
  Result:=True;
end;

procedure TRequest.HandleUnknownEncoding(const AContentType: String;
  Stream: TStream);
begin
  If Assigned(FOnUnknownEncoding) then
    FOnUnknownEncoding(Self,AContentType,Stream);
end;

procedure TRequest.ReadContent;
begin
  // Implement in descendents
end;

procedure TRequest.ProcessQueryString(const FQueryString: String; SL: TStrings);


var
  queryItem : String;
  delimiter : Char;
  aString : String;
  aSepStr : String;
  aPos    : Integer;
  aLenStr : Integer;
  aLenSep : Integer;

  function hexConverter(h1, h2 : Char) : Char;

  var
    B : Byte;

  begin
    B:=(Pos(upcase(h1),hexTable)-1)*16;
    B:=B+Pos(upcase(h2),hexTable)-1;
    Result:=chr(B);
  end;


  procedure InitToken(aStr, aSep : String);

  begin
    aString := aStr;
    aSepStr := aSep;
    aPos    := 1;
    aLenStr := Length(aString);
    aLenSep := Length(aSepStr);
  end;

  function NextToken(out aToken : String; out aSepChar : Char) : Boolean;

  var
    i : Integer;
    j : Integer;
    BoT : Integer;
    EoT : Integer;
    isSep : Boolean;

  begin
    if aPos > aLenStr then Exit(false);
    Result := true;    
    BoT:=aPos;
    EoT:=aPos;
    for i:=aPos to aLenStr do
      begin
      IsSep := false;
      for j := 1 to aLenSep do
        begin
        if aString[i] = aSepStr[j] then
          begin
          IsSep := true;
          Break;
          end;
        end;
      if IsSep then
        begin
        EoT  := i;
        aPos := i + 1;
        aSepChar := aString[i];
        Break;
        end
      else
        begin
        if i = aLenStr then
          begin
          EoT  := i+1;
          aPos := i+1;
          Break;
          end;
        end;
      end;
    aToken := Copy(aString, BoT, EoT - BoT);
  end;


begin
{$ifdef CGIDEBUG}SendMethodEnter('ProcessQueryString');{$endif CGIDEBUG}
  InitToken(FQueryString, '&');
  while NextToken(QueryItem, delimiter) do
    begin
    if (QueryItem<>'') then
      begin
      QueryItem:=HTTPDecode(QueryItem);
      SL.Add(QueryItem);
      end;
    end;
{$ifdef CGIDEBUG}SendMethodExit('ProcessQueryString');{$endif CGIDEBUG}
end;

function TRequest.RequestUploadDir: String;

begin
  Result:=DefaultRequestUploadDir;
end;

function TRequest.GetTempUploadFileName(const AName, AFileName: String;
  ASize: Int64): String;

Var
  D : String;

begin
  D:=RequestUploadDir;
  if (D='') then
    D:=GetTempDir; // Note that this may require a TEMP environment variable to be set by the webserver.
  Result:=GetTempFileName(D, 'CGI');
end;

procedure TRequest.DeleteTempUploadedFiles;
begin
  FFiles.DeleteTempUploadedFiles;
end;

procedure TRequest.InitHeaderRequestVars;

var
  R : String;

begin
{$ifdef CGIDEBUG}
  SendMethodEnter('TRequest.InitHeaderRequestVars');
{$endif}
  R:=Method;
  if (R='') then
    Raise EHTTP.CreateHelp(SErrNoRequestMethod,400);
  // Always process QUERYSTRING.
  InitGetVars;
{$ifdef CGIDEBUG}
  SendMethodExit('TRequest.InitHeaderRequestVars');
{$endif}
end;

procedure TRequest.InitContentRequestVars;

var
  R : String;

begin
{$ifdef CGIDEBUG}
  SendMethodEnter('TRequest.InitContentRequestVars');
{$endif}
  R:=Method;
  // POST and PUT, force post var treatment.
  // To catch other methods we do not treat specially, we'll do the same if contentlength>0
  if (CompareText(R,'POST')=0) or (CompareText(R,'PUT')=0) or (ContentLength>0) then
    InitPostVars;
{$ifdef CGIDEBUG}
  SendMethodExit('TRequest.InitContentRequestVars');
{$endif}
end;


procedure TRequest.InitRequestVars;

begin
  InitHeaderRequestVars;
  InitContentRequestVars;
end;

Type
  TCapacityStream = Class(TMemoryStream)
  Public
    Property Capacity;
  end;

procedure TRequest.InitPostVars;

Var
  M  : TCapacityStream;
  Cl : Integer;
  CT : String;

begin
{$ifdef CGIDEBUG}
  SendMethodEnter('InitPostVars');
{$endif}
  CL:=ContentLength;
  if (CL<>0) and (Length(Content)>0) then
    begin
    M:=TCapacityStream.Create;
    Try
      M.Capacity:=Cl;
      M.WriteBuffer(Content[1], Cl);
      M.Position:=0;
      CT:=ContentType;
      FStreamingContentType := DerriveStreamingContentType;
      case FStreamingContentType of
        sctMultipart:       ProcessMultiPart(M, CT, ContentFields);
        sctFormUrlEncoded:  ProcessUrlEncoded(M, ContentFields);
      else
        HandleUnknownEncoding(CT,M)
      end;
    finally
      M.Free;
    end;
    end;
{$ifdef CGIDEBUG}
  SendMethodExit('InitPostVars');
{$endif}
end;

procedure TRequest.InitGetVars;
Var
  FQueryString : String;

begin
{$ifdef CGIDEBUG}
  SendMethodEnter('InitGetVars');
{$endif}
  FQueryString:=QueryString;
  If (FQueryString<>'') then
    ProcessQueryString(FQueryString, QueryFields);
{$ifdef CGIDEBUG}
  SendMethodExit('InitGetVars');
{$endif}
end;

procedure TRequest.InitContent(const AContent: String);
begin
  FVariables[hvContent]:=AContent;
  FContentRead:=True;
end;


procedure TRequest.ProcessMultiPart(Stream: TStream; const Boundary: String;
  SL: TStrings);

Var
  L : TMimeItems;
  B : String;
  S : String;
  ST: TStringList;

begin
{$ifdef CGIDEBUG} SendMethodEnter('ProcessMultiPart');{$endif CGIDEBUG}
  ST := TStringList.Create;
  try
    ParseContentType(Boundary, ST);
    B := ST.Values['boundary'];
  finally
    ST.Free;
  end;

  L:=CreateMimeItems;
  Try
    if Stream is TStringStream then
      S:=TStringStream(Stream).DataString
    else
      begin
      SetLength(S,Stream.Size);
      If Length(S)>0 then
        if Stream is TCustomMemoryStream then
          // Faster.
          Move(TCustomMemoryStream(Stream).Memory^,S[1],Length(S))
        else
          begin
          Stream.Read(S[1],Length(S));
          Stream.Position:=0;
          end;
      end;
    L.FormSplit(S,B);
    L.CreateUploadFiles(Files,SL);
  Finally
    L.Free;
  end;
{$ifdef CGIDEBUG}  SendMethodExit('ProcessMultiPart');{$endif CGIDEBUG}
end;

procedure TRequest.ProcessURLEncoded(Stream: TStream; SL: TStrings);

var
  S : String;

begin
  S:='';
{$ifdef CGIDEBUG} SendMethodEnter('ProcessURLEncoded');{$endif CGIDEBUG}
  SetLength(S,Stream.Size); // Skip added Null.
  Stream.ReadBuffer(S[1],Stream.Size);
{$ifdef CGIDEBUG}SendDebugFmt('Query string : %s',[s]);{$endif CGIDEBUG}
  ProcessQueryString(S,SL);
{$ifdef CGIDEBUG} SendMethodEnter('ProcessURLEncoded');{$endif CGIDEBUG}
end;

procedure TRequest.ProcessStreamingContent(const State: TContentStreamingState; const Buf; const Size: Integer);
begin
  if state = cssStart then
    FStreamingContentType := DerriveStreamingContentType;
  case FStreamingContentType of
    sctMultipart:       ProcessStreamingMultiPart(State, Buf, Size);
    sctFormUrlEncoded:  ProcessStreamingUrlEncoded(State, Buf, Size);
  else
    HandleStreamingUnknownEncoding(State, Buf, Size)
  end;
  HandleStreamEncoding(State, Buf, Size);
end;

function TRequest.DerriveStreamingContentType(): TStreamingContentType;
var
  CT: string;
begin
  CT:=Uppercase(ParseContentType(ContentType, nil));
  if CT='MULTIPART/FORM-DATA' then
    Result := sctMultipart
  else if CT='APPLICATION/X-WWW-FORM-URLENCODED' then
    Result := sctFormUrlEncoded
  else
    Result := sctUnknown
end;

procedure TRequest.ProcessStreamingMultiPart(const State: TContentStreamingState; const Buf; const Size: Integer);
Var
  ST: TStrings;
  S: String;
begin
{$ifdef CGIDEBUG} SendMethodEnter('ProcessStreamingMultiPart');{$endif CGIDEBUG}
  if State=cssStart then
    begin
    ST := TStringList.Create;
    try
      ParseContentType(ContentType, ST);
      FMimeItems := CreateMimeItems;
      FMimeItems.Boundary := ST.Values['boundary'];
    finally
      ST.Free;
    end;
    end;

  if FKeepFullContents or not FMimeItems.SupportsStreamingProcessing then
    ProcessStreamingSetContent(State, Buf, Size);

  if FMimeItems.SupportsStreamingProcessing then
    FMimeItems.ProcessStreamingMultiPart(State, Buf, Size);

  if State=cssEnd then
    begin
    FMimeItems.CreateUploadFiles(Files, ContentFields);
    if not FMimeItems.SupportsStreamingProcessing then
      begin
      S := Content;
      FMimeItems.FormSplit(S, FMimeItems.Boundary);
      FMimeItems.CreateUploadFiles(Files, ContentFields);
      end
    else if not FKeepFullContents then
      Content := FMimeItems.Preamble;
    FreeAndNil(FMimeItems);
    FContentRead := True;
    end;
end;

procedure TRequest.ProcessStreamingURLEncoded(const State: TContentStreamingState; const Buf; const Size: Integer);
begin
  // This implementation simply collects the contents, and then parses this
  // content.
  // ToDo: replace this with some code that really parses the content
  // block-by-block.
  ProcessStreamingSetContent(State, Buf, Size);
  if state=cssEnd then
    begin
    ProcessQueryString(Content, ContentFields);
    if not KeepFullContents then
      Content := '';
    end;
end;

procedure TRequest.HandleStreamingUnknownEncoding(const State: TContentStreamingState; const Buf; const Size: Integer);
var
  S: TStream;
begin
  ProcessStreamingSetContent(State, Buf, Size);
  if Assigned(FOnUnknownEncoding) then
    begin
    if state=cssEnd then
      begin
      try
        S := TStringStream.Create(Content);
        FOnUnknownEncoding(Self,ContentType,nil);
      finally
        S.Free;
      end;
      end;
    end;
end;

procedure TRequest.ProcessStreamingSetContent(const State: TContentStreamingState; const Buf; const Size: Integer);
var
  CL: LongInt;
begin
  {$ifdef CGIDEBUG} SendMethodEnter('ProcessStreamingSetContent');{$endif CGIDEBUG}
  if State=cssStart then
    begin
    // First time this code is called. Search for a content-length
    // header and use it as hint for the content-length.
    if HeaderIsSet(hhContentLength) and TryStrToInt(GetHeader(hhContentLength), CL) and (CL>0) then
      SetLength(FStreamingContent, CL);
    end;

  CL := FStreamingContentRead;
  FStreamingContentRead := CL+Size;
  if Length(FStreamingContent) < FStreamingContentRead then
    SetLength(FStreamingContent, FStreamingContentRead);
  if Size > 0 then
    Move(Buf, FStreamingContent[CL+1], Size);

  if State=cssEnd then
    begin
    SetLength(FStreamingContent, FStreamingContentRead);
    Content := FStreamingContent;
    FStreamingContent := '';
    end;
end;

procedure TRequest.HandleStreamEncoding(const State: TContentStreamingState; const Buf; const Size: Integer);
begin
  if Assigned(FOnStreamEncodingEvent) then
    FOnStreamEncodingEvent(Self, State, Buf, Size);
end;

{ ---------------------------------------------------------------------
  TUploadedFiles
  ---------------------------------------------------------------------}

function TUploadedFiles.GetFile(Index : Integer): TUploadedFile;
begin
  Result:=TUPloadedFile(Items[Index]);
end;

procedure TUploadedFiles.SetFile(Index : Integer; const AValue: TUploadedFile);
begin
  Items[Index]:=AValue;
end;

function TUploadedFiles.GetTempUploadFileName(const AName, AFileName: String;
  ASize: Int64): String;
begin
  If Assigned(FRequest) then
    Result:=FRequest.GetTempUploadFileName(AName,AFileName,ASize)
  else
    Result:=GetTempFileName;
end;

function TUploadedFiles.IndexOfFile(const AName: String): Integer;

begin
  Result:=Count-1;
  While (Result>=0) and (CompareText(Files[Result].FieldName,AName)<>0) do
    Dec(Result);
end;

function TUploadedFiles.FileByName(const AName: String): TUploadedFile;


begin
  Result:=FindFile(AName);
  If (Result=Nil) then
    Raise HTTPError.CreateFmt(SErrNoSuchUploadedFile,[AName]);
end;

Function TUploadedFiles.FindFile(const AName: String): TUploadedFile;

Var
  I : Integer;
  
begin
  I:=IndexOfFile(AName);
  If (I=-1) then
    Result:=Nil
  else
    Result:=Files[I];
end;

Procedure TUPloadedFiles.DeleteTempUploadedFiles;

var
  i: Integer;

begin
  //delete all temporary uploaded files created for this request if there are any
  for i := Count-1 downto 0 do
    Files[i].DeleteTempUploadedFile;
end;

Function TUploadedFiles.First: TUploadedFile;
begin
  If Count = 0 then
    Result := Nil
  else
    Result := Files[0];
end;

Function TUploadedFiles.Last: TUploadedFile;
begin
  If Count = 0 then
    Result := nil
  else
    Result := Files[Count - 1];
end;


{ ---------------------------------------------------------------------
  TUploadedFile
  ---------------------------------------------------------------------}

procedure TUploadedFile.DeleteTempUploadedFile;

begin
  if (FStream is TFileStream) then
    FreeStream;
  if (LocalFileName<>'') and FileExists(LocalFileName) then
    DeleteFile(LocalFileName);
end;


function TUploadedFile.GetStream: TStream;

begin
  If (FStream=Nil) then
    begin
    If (FLocalFileName='') then
      Raise HTTPError.Create(SErrInternalUploadedFileError);
    FStream:=TFileStream.Create(FLocalFileName,fmOpenRead or fmShareDenyWrite);
    end;
  Result:=FStream;
end;

Procedure TUploadedFile.FreeStream;

begin
  FreeAndNil(FStream);
end;

destructor TUploadedFile.Destroy;
begin
  FreeStream;
  Inherited;
end;

{ ---------------------------------------------------------------------
  TResponse
  ---------------------------------------------------------------------}

constructor TResponse.Create(ARequest : TRequest);
begin
  inherited Create;
  FRequest:=ARequest;
  SetStatus(200);
  ContentType:='text/html';
  FContents:=TStringList.Create;
  TStringList(FContents).OnChange:=@ContentsChanged;
  FCookies:=TCookies.Create(TCookie);
  FCustomHeaders:=TStringList.Create; // Destroyed in parent
end;

destructor TResponse.destroy;
begin
  if FreeContentStream then
    FreeAndNil(FContentStream);
  FreeAndNil(FCookies);
  FreeAndNil(FContents);
  inherited destroy;
end;


procedure TResponse.SendContent;
begin
  if ContentSent then
    Raise HTTPError.Create(SErrContentAlreadySent);
  if Not HeadersSent then
    SendHeaders;
  DoSendContent;
  FContentSent:=True;
end;

procedure TResponse.SendHeaders;

Var
  FHeaders  : TStringList;

begin
  if HeadersSent then
    Raise HTTPError.Create(SErrHeadersAlreadySent);
  FHeaders:=TStringList.Create;
  CollectHeaders(FHeaders);
  With Fheaders do
  If (Count>0) and (Strings[Count-1]<>'') then
    Add('');
  Try
    DoSendHeaders(FHeaders);
    FHeadersSent:=True;
  Finally
    FHeaders.Free;
  end;
end;

procedure TResponse.SendResponse;
begin
  SendContent;
end;


procedure TResponse.SendRedirect(const TargetURL: String);
begin
  Location := TargetURL;
  if FHttpVersion = '1.1' then
    begin
    Code := 307;// HTTP/1.1 307 HTTP_TEMPORARY_REDIRECT -> 'Temporary Redirect'
    CodeText := 'Temporary Redirect';
    end
  else
    begin
    Code := 302;// HTTP/1.0 302 HTTP_MOVED_TEMPORARILY -> 'Found'
    CodeText := 'Moved Temporarily';
    end;
end;

function TResponse.ToString: ansistring;
begin
  if assigned(Request) then
    Result:=Request.ToString
  else
    Result:='Unknown request';
  Result:=Result+': '+IntToStr(Code)+' '+CodeText;
end;

procedure TResponse.SetStatus(aStatus: Cardinal; aSend: Boolean = False);
begin
  Code:=aStatus;
  CodeText:=GetHTTPStatusText(aStatus);
  if aSend then
    SendContent;
end;

procedure TResponse.SetFirstHeaderLine(const line: String);
var
  i: Integer;
  s: String;
begin
  i := Pos('/', line);
  s := Copy(line, i + 1, Length(line));
  i := Pos(' ', s);
  FHttpVersion := Copy(s, 1, i - 1);
  s := Copy(s, i + 1, Length(s));
  i := Pos(' ', s);
  if i > 0 then begin
    FCodeText := Copy(s, i + 1, Length(s));
    s := Copy(s, 1, i - 1);
  end;
  FCode := StrToInt(s);
end;

procedure TResponse.SetContents(AValue: TStrings);
begin
  FContentStream:=Nil;
  FContents.Assign(AValue);
end;

function TResponse.GetContent: RawByteString;
begin
  Result:=Contents.Text;
end;

procedure TResponse.SetContent(const AValue: RawByteString);
begin
  if Assigned(FContentStream) then
    if FreeContentStream then
      FreeAndNil(FContentStream)
    else
      FContentStream:=Nil;
  FContents.Text:=AValue;
end;

procedure TResponse.SetContentStream(const AValue: TStream);
begin
  If (FContentStream<>AValue) then
    begin
    if (FContentStream<>Nil) and FreeContentStream then
      FreeAndNil(FContentStream);
    FContentStream:=AValue;
    If (FContentStream<>Nil) then
      ContentLength:=FContentStream.Size
    else
      ContentLength:=0;
    end;
end;

function TResponse.GetFirstHeaderLine: String;
begin
  Result := Format('HTTP/%s %d %s', [HttpVersion, Code, CodeText]);
end;

procedure TResponse.ContentsChanged(Sender: TObject);

Var
  I,L,LE : Integer;

begin
  L:=0;
  LE:=Length(LineEnding);
  For I:=0 to FContents.Count-1 do
    L:=L+Length(FContents[i])+LE;
  ContentLength:=L;
end;

procedure TResponse.CollectHeaders(Headers: TStrings);

Var
  I : Integer;
  H : THeader;
  N,V : String;

begin
  Headers.add(Format('Status: %d %s',[Code,CodeText]));
{$ifdef cgidebug}
  SendMethodEnter('Collectheaders');
  If Not Assigned(FCookies) then
    SendDebug('No cookies')
  else
    SendInteger('Nr of cookies',FCookies.Count);
{$endif}
  For I:=0 to FCookies.Count-1 do
    Headers.Add(HeaderSetCookie+': '+FCookies[i].AsString);
  For H in THeader do
    if (hdResponse in HTTPHeaderDirections[H]) and HeaderIsSet(H) then
      Headers.Add(HTTPHeaderNames[H]+': '+GetHeader(H));
  if Assigned(FCustomHeaders) then
    For I:=0 to FCustomHeaders.Count - 1 do
      begin
      FCustomHeaders.GetNameValue(I,N,V);
      if (V<>'') then
        Headers.Add(N+': '+V);
      end;
  Headers.Add('');
{$ifdef cgidebug} SendMethodExit('Collectheaders');{$endif}
end;


{ ---------------------------------------------------------------------
  TCookie
  ---------------------------------------------------------------------}

function TCookie.GetAsString: string;

  Procedure AddToResult(const S : String);
  
  begin
    Result:=Result+';'+S;
  end;

Const
  SSameSiteValues : Array[TSameSite] of string
                  = ('','None','Strict','Lax');

Var
  Y,M,D : Word;

begin
{$ifdef cgidebug}SendMethodEnter('TCookie.GetAsString');{$endif}
  try
    Result:=Format('%s=%s',[HTTPEncode(FName),HTTPEncode(FValue)]);
    if (Length(FDomain)>0) then
      AddToResult(Format(SCookieDomain,[FDomain]));
    if (Length(FPath)>0) then
      AddToResult(Format(SCookiePath,[FPath]));
    if (FExpires>-1) then
      begin
      DecodeDate(Expires,Y,M,D);
      AddToResult(Format(FormatDateTime(SCookieExpire,Expires),
                         [HTTPDays[DayOfWeek(Expires)],HTTPMonths[M]]));
      end;
    if FHttpOnly then
      AddToResult(SCookieHttpOnly);
    if FSecure then
      AddToResult(SCookieSecure);
    if FSameSite<>ssEmpty then
      AddToResult(SCookieSameSite+'='+SSameSiteValues[FSameSite]);
  except
{$ifdef cgidebug}
    On E : Exception do
      SendDebug('Exception in cookie AsString: '+E.Message)
{$endif}
  end;
{$ifdef cgidebug}SendMethodExit('TCookie.GetAsString');{$endif}
end;

constructor TCookie.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
  FExpires:=-1;
end;

procedure TCookie.Assign(Source: TPersistent);
begin
  if Source is TCookie then
    with TCookie(Source) do
      begin
      Self.FName:=Name;
      Self.FValue:=Value;
      Self.FDomain:=Domain;
      Self.FPath:=Path;
      Self.FExpires:=Expires;
      Self.FHttpOnly:=HttpOnly;
      Self.FSecure:=Secure;
      end
  else
    inherited Assign(Source);
end;

procedure TCookie.Expire;
begin
  FExpires := EncodeDate(1970, 1, 1);
end;

{ ---------------------------------------------------------------------
  TCookies
  ---------------------------------------------------------------------}

function TCookies.GetCookie(Index: Integer): TCookie;
begin
{$ifdef cgidebug}SendMethodExit('TCookies.GetCookie');{$endif}
  Result:=TCookie(inherited Items[Index]);
{$ifdef cgidebug}SendMethodExit('TCookies.GetCookie');{$endif}
end;

procedure TCookies.SetCookie(Index: Integer; Value: TCookie);
begin
  Items[Index]:=Value
end;

function TCookies.Add: TCookie;
begin
  Result:=TCookie(Inherited Add);
end;

function TCookies.CookieByName(const AName: String): TCookie;
begin
  Result:=FindCookie(AName);
  If (Result=Nil) then
    Raise HTTPError.CreateFmt(SErrUnknownCookie,[AName]);
end;

function TCookies.FindCookie(const AName: String): TCookie;
Var
  I : Integer;

begin
  I:=IndexOfCookie(AName);
  If (I=-1) then
    Result:=Nil
  else
    Result:=GetCookie(I);
end;

function TCookies.IndexOfCookie(const AName: String): Integer;

begin
  Result:=Count-1;
  While (Result>=0) and (CompareText(GetCookie(Result).Name,AName)<>0) do
    Dec(Result);
end;

{ ---------------------------------------------------------------------
  TCustomSession
  ---------------------------------------------------------------------}

procedure TCustomSession.SetSessionState(aValue: TSessionStates);

begin
  if FStates=aValue then exit;
  If Assigned(OnSessionStateChange) then
    OnSessionStateChange(Self);
  FStates:=AValue;
end;

procedure TCustomSession.AddToSessionState(aValue: TSessionState);

Var
  S: TSessionStates;

begin
  S:=SessionState;
  Include(S,AValue);
  SetSessionState(S);
end;

procedure TCustomSession.RemoveFromSessionState(aValue: TSessionState);
Var
  S: TSessionStates;

begin
  S:=SessionState;
  Exclude(S,AValue);
  SetSessionState(S);
end;

procedure TCustomSession.SetSessionCookie(const AValue: String);
begin
  FSessionCookie:=AValue;
end;

procedure TCustomSession.SetSessionCookiePath(const AValue: String);
begin
  FSessionCookiePath:=AValue;
end;

function TCustomSession.GetSessionID: String;

Var
  G : TGUID;

begin
  CreateGUID(G);
  Result:=GuiDToString(G);
  Result:=Copy(Result,2,36);
end;

constructor TCustomSession.Create(AOwner: TComponent);
begin
  FTimeOut:=DefaultTimeOut;
  inherited Create(AOwner);
  FStates:=[];
end;

procedure TCustomSession.InitResponse(AResponse: TResponse);
begin
  // do nothing
end;

procedure TCustomSession.InitSession(ARequest: TRequest; OnNewSession,
  OnExpired: TNotifyEvent);
begin
  // Do nothing
end;

initialization
  MimeItemClass:=THTTPStreamingMimeItem;
end.
