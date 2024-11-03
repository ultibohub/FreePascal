{ %NOTE=This test requires a C library }

{$mode objfpc}

uses
  strings, ctypes;

{$ifdef FPC_HAS_TYPE_EXTENDED}
{$define TEST_EXTENDED}
{$endif FPC_HAS_TYPE_EXTENDED}

{$ifdef beos}
  {it seems that BeOS doesn't support extended...}
  {$undef TEST_EXTENDED}
{$endif beos}

{$if defined(cpux86_64) and defined(android) and (sizeof(clongdouble)<>16)}
  // On x86_64-android long double is 128-bit. There is no support for 128-bit floats in FPC yet.
  {$undef TEST_EXTENDED}
{$endif}

{$ifdef WINDOWS}
const
{$ifdef wince}
  CrtLib = 'coredll.dll';
{$else}
  { the msvcrt.dll doesn't support extended because MS-C doesn't }
  {$undef TEST_EXTENDED}
  CrtLib = 'msvcrt.dll';
{$endif}

procedure printf(const formatstr : pchar; const args : array of const);cdecl; external CrtLib name 'printf';
procedure sprintf(p : pchar;const formatstr : pchar; const args : array of const);cdecl; external CrtLib name 'sprintf';
const
  int64prefix='I64';
{$else}
{$linklib c}
procedure printf(const formatstr : pchar; const args : array of const);cdecl; external;
procedure sprintf(p : pchar;const formatstr : pchar; const args : array of const);cdecl; external;
const
  int64prefix='ll';
{$endif}

const
{$ifdef macos}
  lineending = #13;
{$else}
  lineending = #10;
{$endif}


type
 THandle = longint;
const
  l : longint = 45;
  ll : int64 = 345;
  s : pchar = 'Enclosed text';
  s2 : pchar = 'next';
  si : single = 32.12;
  d : double = 45.45;
  e : cextended = 74.74;
  p : pchar = nil;
  has_errors : boolean = false;

begin
  getmem(p,500);

  Writeln('Testing C printf function called from FPC code');
//  printf('Simple test without arg'+lineending,[]);
  Writeln('Testing with single pchar argument');
  printf('Text containing "%s" text'+lineending,[s]);
  sprintf(p,'Text containing "%s" text'+lineending,[s]);
  if strpos(p,'g "Enclosed text" ')=nil then
    begin
      writeln('The output of sprintf for pchar is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single longint argument');
  printf('Text containing longint: %d'+lineending,[l]);
  sprintf(p,'Text containing longint: %d'+lineending,[l]);
  if strpos(p,'longint: 45')=nil then
    begin
      writeln('The output of sprintf for longint is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single int64 argument');
  printf('Text containing int64: %'+int64prefix+'d'+lineending,[ll]);
  sprintf(p,'Text containing int64: %'+int64prefix+'d'+lineending,[ll]);
  if strpos(p,'int64: 345')=nil then
    begin
      writeln('The output of sprintf for int64 is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single single argument');
  printf('Text containing single: %f'+lineending,[si]);
  sprintf(p,'Text containing single: %f'+lineending,[si]);
  if strpos(p,'single: 32.1')=nil then
    begin
      writeln('The output of sprintf for double is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single double argument');
  printf('Text containing double: %lf'+lineending,[d]);
  sprintf(p,'Text containing double: %lf'+lineending,[d]);
  if strpos(p,'double: 45.4')=nil then
    begin
      writeln('The output of sprintf for double is wrong: ',p);
      has_errors:=true;
    end;

{$ifdef TEST_EXTENDED}
  printf('Text containing long double: %Lf'+lineending,[e]);
  sprintf(p,'Text containing long double: %Lf'+lineending,[e]);
  if strpos(p,'long double: 74.7')=nil then
    begin
      writeln('The output of sprintf for long double is wrong:',p);
      has_errors:=true;
    end;
{$endif TEST_EXTENDED}

  Writeln('Testing with combined pchar argument');
  printf('Text containing "%s" and "%s" text'+lineending,[s,s2]);
  sprintf(p,'Text containing "%s" and "%s" text'+lineending,[s,s2]);
  if strpos(p,'g "Enclosed text" and "next"')=nil then
    begin
      writeln('The output of sprintf for two pchars is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single longint argument and pchar');
  printf('Text containing longint: %d"%s"'+lineending,[l,s2]);
  sprintf(p,'Text containing longint: %d"%s"'+lineending,[l,s2]);
  if strpos(p,'longint: 45"next"')=nil then
    begin
      writeln('The output of sprintf for longint is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single int64 argument and pchar');
  printf('Text containing int64: %'+int64prefix+'d"%s"'+lineending,[ll,s2]);
  sprintf(p,'Text containing int64: %'+int64prefix+'d"%s"'+lineending,[ll,s2]);
  if strpos(p,'int64: 345"next"')=nil then
    begin
      writeln('The output of sprintf for int64 is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single single argument');
  printf('Text containing single: %f"%s"'+lineending,[si,s2]);
  sprintf(p,'Text containing single: %f"%s"'+lineending,[si,s2]);
  if (strpos(p,'single: 32.1')=nil) or
     (strpos(p,'"next"')=nil) then
    begin
      writeln('The output of sprintf for double is wrong: ',p);
      has_errors:=true;
    end;

  Writeln('Testing with single double argument');
  printf('Text containing double: %lf"%s"'+lineending,[d,s2]);
  sprintf(p,'Text containing double: %lf"%s"'+lineending,[d,s2]);
  if (strpos(p,'double: 45.4')=nil) or
     (strpos(p,'"next"')=nil) then
    begin
      writeln('The output of sprintf for double is wrong: ',p);
      has_errors:=true;
    end;

{$ifdef TEST_EXTENDED}
  printf('Text containing long double: %Lf"%s"'+lineending,[e,s2]);
  sprintf(p,'Text containing long double: %Lf"%s"'+lineending,[e,s2]);
  if (strpos(p,'long double: 74.7')=nil) or
     (strpos(p,'"next"')=nil) then
    begin
      writeln('The output of sprintf for long double is wrong:',p);
      has_errors:=true;
    end;
{$endif TEST_EXTENDED}

  if has_errors then
    halt(1);
end.
