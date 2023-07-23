{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses {$ifdef unix}cthreads,{$endif} fpmkunit;

Var
  P : TPackage;
  T : TTarget;
begin
  With Installer do
    begin
{$endif ALLPACKAGES}

    P:=AddPackage('libgc');
    P.ShortName:='lgc';
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.SourcePath.Add('src');
    P.IncludePath.Add('src');
    P.OSes := [linux];
    T:=P.Targets.AddUnit('gcmem.pp');
    P.ExamplePath.Add('examples');
    P.Targets.AddExampleProgram('testcmem.pp');
    P.Targets.AddExampleProgram('create_leak.pp');
{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
