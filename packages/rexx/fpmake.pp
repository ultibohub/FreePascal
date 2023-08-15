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

    P:=AddPackage('rexx');
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.SourcePath.Add('src');
    P.Oses:=[emx,os2];
    p.Targets.AddUnit('rexxsaa.pp');

    P.Sources.AddSrc('readme.txt');

    P.ExamplePath.Add('examples');
    P.Targets.AddExampleProgram('callrexx.pas');
    // 'backward.fnc


    P.NamespaceMap:='namespaces.lst';

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}


