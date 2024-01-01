program tiswhitespace;

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

procedure CheckItems(AItems : array of Word; ADoCheck : Boolean; AError : Integer); overload;
var
  q : Integer;
  locItem : UnicodeChar;
begin
  for q := Low(AItems) to High(AItems) do begin
    locItem := UnicodeChar(AItems[q]);
    if TCharacter.IsWhiteSpace(locItem) <> ADoCheck then
      DoError(AError,locItem);
  end;
end;

procedure CheckItems(AItems : array of UnicodeChar; ADoCheck : Boolean; AError : Integer); overload;
var
  q : Integer;
  locItem : UnicodeChar;
begin
  for q := Low(AItems) to High(AItems) do begin
    locItem := AItems[q];
    if TCharacter.IsWhiteSpace(locItem) <> ADoCheck then
      DoError(AError,locItem);
  end;
end;

procedure CheckItems(AStart, AEnd : Word; ADoCheck : Boolean; AError : Integer); overload;
var
  q : Integer;
  locItem : UnicodeChar;
begin
  for q := AStart to AEnd do begin
    locItem := UnicodeChar(q);
    if TCharacter.IsWhiteSpace(locItem) <> ADoCheck then
      DoError(AError,locItem);
  end;
end;

var
  e, i , k: Integer;
  uc : UnicodeChar;
begin  
  e := 1;
  { According to:
    https://en.wikipedia.org/wiki/Unicode_character_property
    Unicode char $180E, Mongolian Vowel Separator
    was considered as a space separator but is
    in the Other,Format category since Unicode version 6.3.0
    thus $180E is removed here. }
  CheckItems([$0020,$1680],True,e);
  CheckItems($2000,$200A,True,e);
  CheckItems([$202F,$205F,$3000],True,e);
  CheckItems([$2028,$2029],True,e);
  CheckItems($0009,$000D,True,e);
  CheckItems([$0085,$00A0],True,e);

  Inc(e);
  for i := Low(Word) to High(Word) do begin
    { Skip all surrogate values }
    if (i>=HIGH_SURROGATE_BEGIN) and (i<=LOW_SURROGATE_END) then continue;
    uc := UnicodeChar(i);
    if (TCharacter.GetUnicodeCategory(uc) in
        [ TUnicodeCategory.ucSpaceSeparator,
          TUnicodeCategory.ucLineSeparator,
          TUnicodeCategory.ucParagraphSeparator
        ]
       )
    then begin
      if not TCharacter.IsWhiteSpace(uc) then
        DoError(e,uc);
    end;
  end;

  WriteLn('ok');
end.
