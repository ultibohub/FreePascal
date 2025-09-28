{ based on string/tester.c of glibc 2.3.6

* Tester for string functions.
   Copyright (C) 1995-2000, 2001, 2003 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
   02110-1301 USA.  */
}

{$ifdef fpc}
{$mode delphi}
{$endif fpc}
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
{$endif not USE_INTERNAL_UNICODE}
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
  teststr: string;
  goterror: boolean;

procedure check(b: boolean; testnr: longint);
begin
  if not (b) then
    begin
      writeln(teststr,' error nr ',testnr);
      goterror:=true;
    end;
end;

procedure teststricomp;
begin
  teststr:='stricomp';
  check(stricomp('a', 'a') = 0, 1);
  check(stricomp('a', 'A') = 0, 2);
  check(stricomp('A', 'a') = 0, 3);
  check(stricomp('a', 'b') < 0, 4);
  check(stricomp('c', 'b') > 0, 5);
  check(stricomp('abc', 'AbC') = 0, 6);
  check(stricomp('0123456789', '0123456789') = 0, 7);
  check(stricomp('', '0123456789') < 0, 8);
  check(stricomp('AbC', '') > 0, 9);
  check(stricomp('AbC', 'A') > 0, 10);
  check(stricomp('AbC', 'Ab') > 0, 11);
  check(stricomp('AbC', 'ab') > 0, 12);
  check(stricomp('Ab'#0'C', 'ab'#0) = 0, 13);
end;


procedure teststrlcomp;
begin
  teststr:='strlcomp';
  check (strlcomp ('', '', 0) = 0, 1); { Trivial case. }
  check (strlcomp ('a', 'a', 1) = 0, 2);       { Identity. }
  check (strlcomp ('abc', 'abc', 3) = 0, 3);   { Multicharacter. }
  check (strlcomp ('abc'#0, 'abcd', 4) < 0, 4);   { Length unequal. }
  check (strlcomp ('abcd', 'abc'#0, 4) > 0, 5);
  check (strlcomp ('abcd', 'abce', 4) < 0, 6);  { Honestly unequal. }
  check (strlcomp ('abce', 'abcd', 4) > 0, 7);
  check (strlcomp ('abce', 'abcd', 3) = 0, 10); { Count limited. }
  check (strlcomp ('abce', 'abc', 3) = 0, 11);  { Count = length. }
  check (strlcomp ('abcd', 'abce', 4) < 0, 12);  { Nudging limit. }
  check (strlcomp ('abc', 'def', 0) = 0, 13);   { Zero count. }
  check (strlcomp ('abc'#0'e', 'abc'#0'd', 5) = 0, 14);
end;


procedure teststrcomp;
begin
  teststr:='strcomp';
  check (strcomp ('', '') = 0, 1);              { Trivial case. }
  check (strcomp ('a', 'a') = 0, 2);            { Identity. }
  check (strcomp ('abc', 'abc') = 0, 3);        { Multicharacter. }
  check (strcomp ('abc', 'abcd') < 0, 4);        { Length mismatches. }
  check (strcomp ('abcd', 'abc') > 0, 5);
  check (strcomp ('abcd', 'abce') < 0, 6);       { Honest miscompares. }
  check (strcomp ('abce', 'abcd') > 0, 7);
  check (strcomp ('abc'#0'e', 'abc'#0'd') = 0, 8);
end;


procedure teststrlicomp;
begin
  teststr:='strlicomp';
  check(strlicomp('a', 'a', 1) = 0, 1);
  check(strlicomp('a', 'A', 1) = 0, 2);
  check(strlicomp('A', 'a', 1) = 0, 3);
  check(strlicomp('a', 'b', 1) < 0, 4);
  check(strlicomp('c', 'b', 1) > 0, 5);
  check(strlicomp('abc', 'AbC', 3) = 0, 6);
  check(strlicomp('0123456789', '0123456789', 10) = 0, 7);
  check(strlicomp(#0'123456789', #0'123456799', 10) = 0, 8);
  check(strlicomp(#0'bD', #0'bC', 3) = 0, 9);
  check(strlicomp('AbC', 'A'#0#0,3) > 0, 10);
  check(strlicomp('AbC', 'Ab'#0, 3) > 0, 11);
  check(strlicomp('AbC', 'ab'#0, 3) > 0, 12);
  check(strlicomp('0123456789', 'AbC', 0) = 0, 13);
  check(strlicomp('AbC', 'abc', 1) = 0, 14);
  check(strlicomp('AbC', 'abc', 2) = 0, 15);
  check(strlicomp('AbC', 'abc', 3) = 0, 16);
  check(strlicomp('AbC', 'abcd', 3) = 0, 17);
  check(strlicomp('AbCc', 'abcd', 4) < 0, 18);
  check(strlicomp('ADC', 'abcd', 1) = 0, 19);
  check(strlicomp('ADC', 'abcd', 2) > 0, 20);
  check(strlicomp('abc'#0'e', 'abc'#0'd', 5) = 0, 21);
end;


begin
  goterror:=false;
  teststricomp;
  teststrlcomp;
  teststrcomp;
  teststrlicomp;
  if goterror then
    halt(1);
end.
