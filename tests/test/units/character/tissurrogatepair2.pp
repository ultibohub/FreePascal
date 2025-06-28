program tissurrogatepair2;

{$ifdef FPC}
  {$mode objfpc}
  {$H+}
  {$PACKENUM 1}
{$endif fpc} 

{$ifndef FPC}
  {$APPTYPE CONSOLE}    
{$endif}
  
uses     
  SysUtils,
  unicodedata,character;
    
{$ifndef FPC}
  type UnicodeChar = WideChar;   
{$endif}

const
  { test only a spare grid, else the test runs too long (testing all combinations means dist=1) }
  dist = 8;
    
procedure DoError(ACode : Integer; ACodePoint1, ACodePoint2 : Integer); overload;
begin
  WriteLn(
    'Error #',ACode,
    ' ; CodePoint1 = ',IntToHex(ACodePoint1,4),
    ' ; CodePoint2 = ',IntToHex(ACodePoint2,4)
  );
  Halt(Acode);
end;

var
  e, i , j: Integer;
  count : int64;
  s : UnicodeString;
begin
  s := 'azerty12345';
  e := 1;
  count:=0;
  for i := HIGH_SURROGATE_BEGIN to HIGH_SURROGATE_END do begin
    for j := LOW_SURROGATE_BEGIN to LOW_SURROGATE_END do begin
      s[3] := UnicodeChar(i);
      s[4] := UnicodeChar(j);
      if not TCharacter.IsSurrogatePair(s,3) then
        DoError(e,i,j);
      inc(count);
    end;
  end;

  Inc(e);
  for i := Low(Word) to High(Word) div dist do begin
    if (i*dist < HIGH_SURROGATE_BEGIN) or (i*dist > HIGH_SURROGATE_END) then begin
      for j := Low(Word) to High(Word) div dist do begin
        if (j*dist < LOW_SURROGATE_BEGIN) or (j*dist > LOW_SURROGATE_END) then begin
          s[5] := UnicodeChar(i*dist);
          s[6] := UnicodeChar(j*dist);
          if TCharacter.IsSurrogatePair(s,5) then
            DoError(e,i*dist,j*dist);
          inc(count);
        end;
      end;
    end;
  end;

  WriteLn('ok, count=',count);
end.
