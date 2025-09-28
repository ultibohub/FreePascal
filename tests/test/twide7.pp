{$codepage utf-8}

{$if defined(go32v2) or defined(wasi)}
  {$define USE_INTERNAL_UNICODE}
{$endif}

{$ifdef USE_INTERNAL_UNICODE}
  {$define USE_FPWIDESTRING_UNIT}
  {$define USE_UNICODEDUCET_UNIT}
  {$define USE_CPALL_UNIT}
{$endif}
uses
 {$ifndef USE_INTERNAL_UNICODE}
  {$ifdef unix}
   {$ifdef darwin}iosxwstr{$else}cwstring{$endif},
  {$endif unix}
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
  sysutils;

procedure testwcmp;
var
  w1,w2: widestring;
  s: ansistring;
begin
  w1:='aécde';
  { filter unsupported characters }
  s:=w1;
  w1:=s;
  w2:=w1;

  if (w1<>w2) then
    halt(1);
  w1[2]:='f';
  if (w1=w2) or
     WideSameStr(w1,w2) or
     (WideCompareText(w1,w2)=0) or
     (WideCompareStr(w1,w2)<0) or
     (WideCompareStr(w2,w1)>0) then
    halt(2);
  w1[2]:=#0;
  w2[2]:=#0;
  if (w1<>w2) or
     not WideSameStr(w1,w2) or
     (WideCompareStr(w1,w2)<>0) or
     (WideCompareText(w1,w2)<>0) then
    halt(3);
  w1[3]:='m';
  if WideSameStr(w1,w2) or
     (WideCompareText(w1,w2)=0) or
     (WideCompareStr(w1,w2)<0) or
     (WideCompareStr(w2,w1)>0) then
    halt(4);
end;


begin
  testwcmp;
end.
