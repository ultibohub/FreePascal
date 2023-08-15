{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses 
  {$ifdef unix}cthreads, cwstring,{$endif}
  fpmkunit;

Var
  P : TPackage;
  T : TTarget;
begin
  With Installer do
    begin
{$endif ALLPACKAGES}

    P:=AddPackage('uuid');
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.SourcePath.Add('src');
    P.OSes := [linux];
    P.Dependencies.Add('rtl-extra');

    T:=P.Targets.AddUnit('libuuid.pp');
    T:=P.Targets.AddUnit('macuuid.pp');

    P.Sources.AddSrc('README.txt');

    P.ExamplePath.Add('examples');
    P.Targets.AddExampleProgram('testlibuid.pp');
    P.Targets.AddExampleProgram('testuid.pp');
    P.Sources.AddExampleFiles('examples/*',P.Directory,false,'.');

    P.NamespaceMap:='namespaces.lst';

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
