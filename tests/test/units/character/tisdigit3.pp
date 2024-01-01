program tgetnumericvalue3;

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

function DumpStr(a : UnicodeString) : UnicodeString;
var
  i : Integer;
  s : UnicodeString;
begin
  s := '';
  for i := 1 to Length(a) do
    s := s + Format('#%x',[Word(a[i])]);
  Result := s; 
end;
    
procedure DoError(ACode : Integer; ACodePoint : UnicodeString); overload;
begin
  WriteLn('Error #',ACode,' ; String = ',DumpStr(ACodePoint));
  Halt(Acode);
end;         

var
  e : Integer;
  s, s2, s3 : UnicodeString;
  d : Double;
begin  
  e := 1; 
  s := UnicodeChar(Word($D801)) + UnicodeChar(Word($DCA1));
  d := 1;
  if (TCharacter.GetNumericValue(s,1) <> d) then begin
    WriteLn('s=',DumpStr(s),' ; TCharacter.GetNumericValue(s) = ',TCharacter.GetNumericValue(s,1));
    DoError(e,s);
  end;  

  Inc(e);
  s := UnicodeChar(Word($D801)) + UnicodeChar(Word($DCA3));
  d := 3;
  if (TCharacter.GetNumericValue(s,1) <> d) then begin
    WriteLn('s=',DumpStr(s),' ; TCharacter.GetNumericValue(s) = ',TCharacter.GetNumericValue(s,1));
    DoError(e,s);
  end;  
  
  WriteLn('ok');
end.

