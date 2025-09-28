{ %skiptarget=win32,win64,wince,os2,emx,go32v2,msdos }
{ This test is only useful if the local codepage is utf-8 which
  usually not the case on windows (and never can be the case on OS/2)
}
{$codepage utf-8}

{$mode objfpc}
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

{$i+}

var
  t: text;
  w: widestring;
  u: unicodestring;
  a: ansistring;
  wc: widechar;

begin
  assign(t,'twide3.txt');
  rewrite(t);
  writeln(t,'łóżka');
  close(t);
  reset(t);

  try
    read(t,wc);
    if wc<>'ł' then
      raise Exception.create('wrong widechar read: '+inttostr(ord(wc))+'<>'+inttostr(ord('ł')));
  except
    close(t);
//    erase(t);
    raise;
  end;

  reset(t);
  try
    readln(t,a);
    w:=a;
    if (w<>'łóżka') then
      raise Exception.create('wrong ansistring read');
  except
    close(t);
    erase(t);
    raise;
  end;

  reset(t);
  try
    readln(t,w);
    if (w<>'łóżka') then
      raise Exception.create('wrong widestring read');
  except
    close(t);
    erase(t);
    raise;
  end;

  reset(t);
  try
    readln(t,u);
    if (u<>'łóżka') then
      raise Exception.create('wrong unicodestring read');
  finally
    close(t);
    erase(t);
  end;

  readstr(u,a);
  if u<>a then
    raise Exception.create('wrong readstr(u,a)');
  readstr(w,a);
  if w<>u then
    raise Exception.create('wrong readstr(w,a)');
end.
