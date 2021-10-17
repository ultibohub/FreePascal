{ %opt=-gh }
{$ifdef go32v2}
  {$define USE_INTERNAL_UNICODE}
{$endif}

{$ifdef USE_INTERNAL_UNICODE}
  {$define USE_FPWIDESTRING_UNIT}
  {$define USE_UNICODEDUCET_UNIT}
  {$define USE_CPALL_UNIT}
{$endif}

program outpar;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef mswindows}{$apptype console}{$endif}
uses
 {$ifdef FPC}
  {$ifdef unix}
   cthreads,
   {$ifndef USE_INTERNAL_UNICODE}
    {$ifdef darwin}iosxwstr{$else}cwstring{$endif},
   {$endif ndef USE_INTERNAL_UNICODE}
  {$endif}
 {$endif}
 {$ifdef USE_UNICODEDUCET_UNIT}
  unicodeducet,
 {$endif}
 {$ifdef USE_FPWIDESTRING_UNIT}
  fpwidestring,
 {$endif}
 {$ifdef USE_CPALL_UNIT}
  cpall,
 {$endif}
 sysutils;
{$ifndef FPC}
type
 sizeint = integer;
 psizeint = ^sizeint;
{$endif}

procedure testproc(out str);
begin
 ansistring(str):= '';
end;

var
 str1,str2: ansistring;

begin
 setlength(str1,5);
 move('abcde',str1[1],5);
 str2:= str1;
 testproc(str2);
 if StringRefCount(str1) <> 1 then
   Halt(1);
 if str1<>'abcde' then
   Halt(2);  
end.
