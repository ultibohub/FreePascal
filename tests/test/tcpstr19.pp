{ %skiptarget=android }
program tcpstr19;

// test conversions from and to rawbytestring
// test that copy function returns the same def as argument
// this test can be only run with the compiler built right now on the
// same system

{$if defined(go32v2) or defined(wasi)}
  {$define USE_INTERNAL_UNICODE}
{$endif}

{$ifdef USE_INTERNAL_UNICODE}
  {$define USE_FPWIDESTRING_UNIT}
  {$define USE_UNICODEDUCET_UNIT}
  {$define USE_CPALL_UNIT}
{$endif}

{$APPTYPE CONSOLE}
{$ifdef fpc}
  {$MODE DELPHIUNICODE}
{$endif}

uses
{$ifndef USE_INTERNAL_UNICODE}
{$ifdef unix}
  {$ifdef darwin}iosxwstr{$else}cwstring{$endif},
{$endif}
{$endif ndef USE_INTERNAL_UNICODE}
{$ifdef USE_UNICODEDUCET_UNIT}
  unicodeducet,
{$endif}
{$ifdef USE_FPWIDESTRING_UNIT}
  fpwidestring,
{$endif}
{$ifdef USE_CPALL_UNIT}
  cpall,
{$endif}
  SysUtils;

var
  S: AnsiString;
  R: RawByteString;
begin
  S := UTF8Encode('Test');
  if StringCodePage(S) <> CP_UTF8 then
    halt(1);
  S := Copy('Test', 1, 2);
  if StringCodePage(S) <> DefaultSystemCodePage then
    halt(2);
  if StringCodePage(Copy(UTF8Encode('Test'), 1, 2)) <> CP_UTF8 then
    halt(3);
  R := 'Test';
{$if not defined(FPC_CROSSCOMPILING) and not defined(FPC_CPUCROSSCOMPILING)}
  if StringCodePage(R) <> DefaultSystemCodePage then
    halt(4);
{$endif}
end.
