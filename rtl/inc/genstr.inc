{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Carl-Eric Codere,
    member of the Free Pascal development team.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$ifndef FPC_UNIT_HAS_STREND}
 Function StrEnd(P: PAnsiChar): PAnsiChar;
 begin
   StrEnd := P;
   if Assigned(StrEnd) then
     Inc(StrEnd, IndexByte(StrEnd^, -1, 0));
 end;
{$endif FPC_UNIT_HAS_STREND}


{$ifndef FPC_UNIT_HAS_STRCOPY}
{ Beware, the naive implementation (copying bytes forward until zero
  is encountered) will end up in undefined behavior if source and dest
  happen to overlap. So do it in a bit more reliable way.
  Also this implementation should not need per-platform optimization,
  given that IndexByte and Move are optimized. }
 Function StrCopy(Dest, Source:PAnsiChar): PAnsiChar;
 var
   counter : SizeInt;
 Begin
   counter := IndexByte(Source^,-1,0);
   { counter+1 will move zero terminator }
   Move(Source^,Dest^,counter+1);
   StrCopy := Dest;
 end;
{$endif FPC_UNIT_HAS_STRCOPY}



{$ifndef FPC_UNIT_HAS_STRUPPER}
 function StrUpper(P: PAnsiChar): PAnsiChar;
 var
  counter: SizeInt;
 begin
   counter := 0;
   while (P[counter] <> #0) do
   begin
     if P[Counter] in [#97..#122,#128..#255] then
        P[counter] := Upcase(P[counter]);
     Inc(counter);
   end;
   StrUpper := P;
 end;
{$endif FPC_UNIT_HAS_STRUPPER}


{$ifndef FPC_UNIT_HAS_STRLOWER}
 function StrLower(P: PAnsiChar): PAnsiChar;
 var
  counter: SizeInt;
 begin
   counter := 0;
   while (P[counter] <> #0) do
   begin
     if P[counter] in [#65..#90] then
        P[Counter] := chr(ord(P[Counter]) + 32);
     Inc(counter);
   end;
   StrLower := P;
 end;
{$endif FPC_UNIT_HAS_STRLOWER}



{$ifndef FPC_UNIT_HAS_STRSCAN}
 function StrScan(P: PAnsiChar; C: AnsiChar): PAnsiChar;
   Begin
     dec(P);
     repeat
       inc(P);
     until (P^ = #0) or (P^ = C);
     if (P^ = #0) and (C <> #0) then
       P := nil;
     StrScan := P;
   end;
{$endif FPC_UNIT_HAS_STRSCAN}


{$ifndef FPC_UNIT_HAS_STRISCAN}
 function StrIScan(P: PAnsiChar; C: AnsiChar): PAnsiChar;
   Var
     count: SizeInt;
     UC: AnsiChar;
  Begin
   UC := upcase(C);
   count := 0;
   { As in Borland Pascal , if looking for NULL return null }
   if UC = #0 then
   begin
     StrIScan := @(P[StrLen(P)]);
     exit;
   end;
   { Find first matching character of Ch in Str }
   while P[count] <> #0 do
   begin
     if UC = upcase(P[count]) then
      begin
          StrIScan := @(P[count]);
          exit;
      end;
     Inc(count);
   end;
   { nothing found. }
   StrIScan := nil;
 end;
{$endif FPC_UNIT_HAS_STRSCAN}


{$ifndef FPC_UNIT_HAS_STRRSCAN}
 function StrRScan(P: PAnsiChar; C: AnsiChar): PAnsiChar;
 Begin
   StrRScan := P + IndexByte(P^, -1, 0);
   { As in Borland Pascal , if looking for NULL return null }
   if C = #0 then
     exit;
   while (StrRScan <> P) and (StrRScan[-1] <> C) do
     dec(StrRScan);
   if StrRScan = P then
     StrRScan := nil
   else
     dec(StrRScan);
 end;
{$endif FPC_UNIT_HAS_STRRSCAN}


{$ifndef FPC_UNIT_HAS_STRRISCAN}
 function StrRIScan(P: PAnsiChar; C: AnsiChar): PAnsiChar;
 Var
  count: SizeInt;
  index: SizeInt;
  UC: AnsiChar;
 Begin
   UC := upcase(C);
   count := Strlen(P);
   { As in Borland Pascal , if looking for NULL return null }
   if UC = #0 then
   begin
     StrRIScan := @(P[count]);
     exit;
   end;
   Dec(count);
   for index := count downto 0 do
   begin
     if UC = upcase(P[index]) then
      begin
          StrRIScan := @(P[index]);
          exit;
      end;
   end;
   { nothing found. }
   StrRIScan := nil;
 end;
{$endif FPC_UNIT_HAS_STRRSCAN}


{$ifndef FPC_UNIT_HAS_STRECOPY}
  Function StrECopy(Dest, Source: PAnsiChar): PAnsiChar;
 { Equivalent to the following:                                          }
 {  strcopy(Dest,Source);                                                }
 {  StrECopy := StrEnd(Dest);                                            }
 var
   counter : SizeInt;
 Begin
   counter := IndexByte(Source^,-1,0);
   { counter+1 will move zero terminator }
   Move(Source^,Dest^,counter+1);
   StrECopy := Dest+counter;
 end;
{$endif FPC_UNIT_HAS_STRECOPY}


{$ifndef FPC_UNIT_HAS_STRLCOPY}
 Function StrLCopy(Dest,Source: PAnsiChar; MaxLen: SizeInt): PAnsiChar;
  var
   nmove: SizeInt;
  Begin
    { To be compatible with BP, on a null string, put two nulls }
    If Source[0] = #0 then
      unaligned(PUint16(Dest)^):=0
    else
      begin
        if MaxLen < 0 then MaxLen := 0; { Paranoia. }
        nmove := IndexByte(Source^,MaxLen,0) + 1;
        if nmove = 0 then
          begin
            nmove := MaxLen;
            Dest[MaxLen] := #0;
          end;
        Move(Source^,Dest^,nmove);
      end;
    StrLCopy := Dest;
  end;
{$endif FPC_UNIT_HAS_STRLCOPY}


{$ifndef FPC_UNIT_HAS_STRCOMP}
 function StrComp(Str1, Str2 : PAnsiChar): SizeInt;
     var
      counter: SizeInt;
      sample: char;
     Begin
       counter := -1;
       repeat
         inc(counter);
         sample := str1[counter];
       until (sample = #0) or (sample <> str2[counter]);
       StrComp := ord(sample) - ord(str2[counter]);
     end;
{$endif FPC_UNIT_HAS_STRCOMP}


{$ifndef FPC_UNIT_HAS_STRICOMP}
     function StrIComp(Str1, Str2 : PAnsiChar): SizeInt;
     Begin
       dec(Str1);
       dec(Str2);
       repeat
         inc(Str1);
         inc(Str2);
         StrIComp := ord(Str1^) - ord(Str2^);
         if Str1^ = #0 then break;
         if StrIComp = 0 then continue;
         StrIComp := ord(UpCase(Str1^)) - ord(UpCase(Str2^));
         if StrIComp <> 0 then break; { Making it the loop condition might be suboptimal because of “continue”. }
       until false;
     end;
{$endif FPC_UNIT_HAS_STRICOMP}


{$ifndef FPC_UNIT_HAS_STRLCOMP}
     function StrLComp(Str1, Str2 : PAnsiChar; L: SizeInt): SizeInt;
     Begin
       while (L > 0) and (Str1^ <> #0) and (Str1^ = Str2^) do
         begin
           inc(Str1);
           inc(Str2);
           dec(L);
         end;
       if L <= 0 then StrLComp := 0 else StrLComp := ord(Str1^) - ord(Str2^);
     end;
{$endif FPC_UNIT_HAS_STRLCOMP}


{$ifndef FPC_UNIT_HAS_STRLICOMP}
     function StrLIComp(Str1, Str2 : PAnsiChar; L: SizeInt): SizeInt;
     Begin
       dec(Str1);
       dec(Str2);
       inc(L);
       StrLIComp := 0;
       Repeat
         dec(L);
         if L <= 0 then break;
         inc(Str1);
         inc(Str2);
         StrLIComp := ord(Str1^) - ord(Str2^);
         if Str1^ = #0 then break;
         if StrLIComp = 0 then continue;
         StrLIComp := ord(UpCase(Str1^)) - ord(UpCase(Str2^));
         if StrLIComp <> 0 then break; { Making it the loop condition might be suboptimal because of “continue”. }
       until false;
     end;
{$endif FPC_UNIT_HAS_STRLICOMP}
