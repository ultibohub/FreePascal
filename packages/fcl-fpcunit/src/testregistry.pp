{
    This file is part of the Free Component Library (FCL)
    Copyright (c) 2004 by Dean Zobec, Michael Van Canneyt

    Port to Free Pascal of the JUnit framework.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit testregistry;

{$mode objfpc}
{$h+}

interface

uses
  fpcunit, testdecorator;
  
type

  TTestDecoratorClass = class of TTestDecorator;


procedure RegisterTest(ATestClass: TTestCaseClass); overload;
procedure RegisterTest(const ASuitePath: String; ATestClass: TTestCaseClass); overload;
procedure RegisterTest(const ASuitePath: String; ATest: TTest); overload;

procedure RegisterTests(ATests: Array of TTestCaseClass);
procedure RegisterTests(const ASuitePath: String; ATests: Array of TTestCaseClass);

procedure RegisterTest(aSuite: TTestSuite);
procedure RegisterTest(const aSuitePath : String; aSuite: TTestSuite);


procedure RegisterTestDecorator(ADecoratorClass: TTestDecoratorClass; ATestClass: TTestCaseClass);

function NumberOfRegisteredTests: longint;

function GetTestRegistry: TTestSuite;

implementation
uses
  Classes
  ;

var
  FTestRegistry: TTestSuite;

function GetTestRegistry: TTestSuite;
begin
  if not Assigned(FTestRegistry) then
    FTestRegistry := TTestSuite.Create;
  Result := FTestRegistry;
end;

procedure RegisterTestInSuite(ARootSuite: TTestSuite; const APath: string; ATest: TTest);
var
  i: Integer;
  lTargetSuite: TTestSuite;
  lCurrentTest: TTest;
  lSuiteName: String;
  lPathRemainder: String;
  lDotPos: Integer;

begin
  if APath = '' then
  begin
    // end recursion
    ARootSuite.AddTest(ATest);
  end
  else
  begin
    // Split the path on the dot (.)
    lDotPos := Pos('.', APath);
    if (lDotPos <= 0) then lDotPos := Pos('\', APath);
    if (lDotPos <= 0) then lDotPos := Pos('/', APath);
    if (lDotPos > 0) then
    begin
      lSuiteName := Copy(APath, 1, lDotPos - 1);
      lPathRemainder := Copy(APath, lDotPos + 1, length(APath) - lDotPos);
    end
    else
    begin
      lSuiteName := APath;
      lPathRemainder := '';
    end;

    // Check to see if the path already exists
    lTargetSuite := nil;
    I:=0;
    While (lTargetSuite=Nil) and (I<ARootSuite.ChildTestCount) do
      begin
      lCurrentTest:= ARootSuite.Test[i];
      if lCurrentTest is TTestSuite then
        if (lCurrentTest.TestName = lSuiteName) then
          lTargetSuite := TTestSuite(lCurrentTest);
      Inc(I);
      end;  { if }

    if not Assigned(lTargetSuite) then
    begin
      lTargetSuite := TTestSuite.Create(lSuiteName);
      ARootSuite.AddTest(lTargetSuite);
    end;

    RegisterTestInSuite(lTargetSuite, lPathRemainder, ATest);
  end;  { if  else }
end;

procedure RegisterTest(ATestClass: TTestCaseClass);
begin
  GetTestRegistry.AddTestSuiteFromClass(ATestClass);
end;

procedure RegisterTest(const ASuitePath: String; ATestClass: TTestCaseClass);
begin
  RegisterTestInSuite(GetTestRegistry, ASuitePath, TTestSuite.Create(ATestClass));
end;

procedure RegisterTest(const ASuitePath: String; ATest: TTest);
begin
  RegisterTestInSuite(GetTestRegistry, ASuitePath, ATest);
end;

procedure RegisterTestDecorator(ADecoratorClass: TTestDecoratorClass; ATestClass: TTestCaseClass);
begin
  GetTestRegistry.AddTest(ADecoratorClass.Create(TTestSuite.Create(ATestClass)));
end;

procedure RegisterTests(ATests: Array of TTestCaseClass);
var
  i: integer;
begin
  for i := Low(ATests) to High(ATests) do
    if Assigned(ATests[i]) then
    begin
      RegisterTest(ATests[i]);
    end;
end;

procedure RegisterTests(const ASuitePath: String; ATests: Array of TTestCaseClass);
var
  i: integer;
begin
  for i := Low(ATests) to High(ATests) do
    if Assigned(ATests[i]) then
    begin
      RegisterTest(ASuitePath,ATests[i]);
    end;
end;

procedure RegisterTest(aSuite: TTestSuite);
begin
  GetTestRegistry.AddTest(aSuite);
end;

procedure RegisterTest(const aSuitePath: String; aSuite: TTestSuite);
begin
  RegisterTestInSuite(GetTestRegistry, aSuitePath, aSuite);
end;


function NumberOfRegisteredTests: longint;
begin
  Result := GetTestRegistry.CountTestCases;
end;

initialization
  FTestRegistry := nil;
finalization
  FTestRegistry.Free;
end.
