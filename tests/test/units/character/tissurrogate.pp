program tissurrogate;

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

procedure DoError(ACode : Integer); overload;
begin
  WriteLn('Error #',ACode);
  Halt(Acode);
end;         
    
procedure DoError(ACode : Integer; ACodePoint : Integer); overload;
begin
  WriteLn('Error #',ACode,' ; CodePoint = ',IntToHex(ACodePoint,4));
  Halt(Acode);
end;          
    
procedure DoError(ACode : Integer; ACodePoint : UnicodeChar); overload;
begin
  WriteLn('Error #',ACode,' ; CodePoint = ',IntToHex(Ord(ACodePoint),4));
  Halt(Acode);
end;         

var
  e, i , k: Integer;
  uc : UnicodeChar;
begin  
  e := 1;
  for i := $D800 to $DFFF do begin
    uc := UnicodeChar(i);
    if not TCharacter.IsSurrogate(uc) then
      DoError(e,uc);
  end;

  Inc(e);
  for i := Low(Word) to High(Word) do begin
    uc := UnicodeChar(i);
    if (TCharacter.GetUnicodeCategory(uc) = TUnicodeCategory.ucSurrogate) then begin
      if not TCharacter.IsSurrogate(uc) then
        DoError(e,uc);
    end;
  end;

  Inc(e);
  for i := Low(Word) to High(Word) do begin
    if (i < $D800) or (i > $DFFF) then begin
      uc := UnicodeChar(i);
      if TCharacter.IsSurrogate(uc) then
        DoError(e,uc);
    end;
  end;

  WriteLn('ok');
end.
