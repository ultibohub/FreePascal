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
    P:=AddPackage('fcl-hash');
    P.ShortName:='fclh';

{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}

    P.Author := 'Free Pascal development team';
    P.License := 'LGPL with modification, ';
    P.HomepageURL := 'www.freepascal.org';
    P.Email := '';
    P.Description := 'Several hash and cryptography algorithms requiring classes.';
    P.NeedLibC:= false;
    P.OSes:=P.OSes-[embedded,win16,macosclassic,palmos,zxspectrum,msxdos,amstradcpc,sinclairql,msdos,human68k,ps1,wasip2];
    if Defaults.CPU=jvm then
      P.OSes := P.OSes - [java,android];

    P.Dependencies.Add('rtl-objpas');
    P.Dependencies.Add('rtl-extra');
    P.Dependencies.Add('fcl-base');
    P.Dependencies.Add('hash');

    P.Version:='3.3.1';
    T:=P.Targets.AddUnit('src/fpecc.pp');
    T:=P.Targets.AddUnit('src/fphashutils.pp');
    T.Dependencies.AddUnit('fpecc');
    T:=P.Targets.AddUnit('src/fpsha256.pp');
    T.Dependencies.AddUnit('fphashutils');
    T.Dependencies.AddInclude('src/sha256x86.inc', [i386,x86_64], AllOSes);
    T:=P.Targets.AddUnit('src/fpsha512.pp');
    T.Dependencies.AddUnit('fphashutils');
    T:=P.Targets.AddUnit('src/fpasn.pp');
    T.Dependencies.AddUnit('fphashutils');
    T:=P.Targets.AddUnit('src/fppem.pp');
    T.Dependencies.AddUnit('fphashutils');
    T.Dependencies.AddUnit('fpasn');
    T:=P.Targets.AddUnit('src/fpecdsa.pp');
    T.Dependencies.AddUnit('fphashutils');
    T.Dependencies.AddUnit('fpecc');
    T.Dependencies.AddUnit('fpsha256');
    T:=P.Targets.AddUnit('src/fptlsbigint.pas');
    T:=P.Targets.AddUnit('src/fprsa.pas');
    T:=P.Targets.AddUnit('src/onetimepass.pp');
    
    T:=P.Targets.AddExampleunit('examples/demosha256.pp');
    T:=P.Targets.AddExampleunit('examples/sha256performancetest.pas');
    // md5.ref

    P.NamespaceMap:='namespaces.lst';

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
