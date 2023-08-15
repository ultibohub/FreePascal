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

    P:=AddPackage('rsvg');
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.OSes := [beos,haiku,freebsd,netbsd,openbsd,linux,win32,win64,aix,dragonfly];
    // Do not build x11 on iPhone (=arm-darwin)
    if Defaults.CPU<>arm then
      P.OSes := P.OSes + [darwin];
    P.Version:='3.3.1';
    P.SourcePath.Add('src');
    P.IncludePath.Add('src');
    P.Dependencies.Add('gtk2');

  T:=P.Targets.AddUnit('rsvg.pas');


    P.NamespaceMap:='namespaces.lst';

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
