{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses {$ifdef unix}cthreads,{$endif} fpmkunit;

Var
  T : TTarget;
  P : TPackage;
begin
  With Installer do
    begin
{$endif ALLPACKAGES}

    P:=AddPackage('fastcgi');
    P.ShortName := 'fcgi';
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';

    P.Author := 'FreePascal development team';
    P.License := 'LGPL with modification, ';
    P.HomepageURL := 'www.freepascal.org';
    P.Email := '';
    P.Description := 'FastCGI header translation to Pascal';
    P.NeedLibC:= false;
    P.OSes := AllUnixOSes+AllWindowsOSes+AllAmigaLikeOSes-[qnx]+[ultibo];

    P.SourcePath.Add('src');

    T:=P.Targets.AddUnit('fastcgi.pp');

    P.NamespaceMap:='namespaces.lst';

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
