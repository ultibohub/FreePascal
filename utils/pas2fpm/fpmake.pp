{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses 
  {$ifdef unix}
  cthreads,
  {$endif}
  fpmkunit;
{$endif ALLPACKAGES}

procedure add_pas2fpm(const ADirectory: string);

Var
  P : TPackage;
  T : TTarget;

begin
  With Installer do
    begin
    P:=AddPackage('utils-pas2fpm');
    p.ShortName:='p2fm';
    P.OSes:=AllOSes-[embedded,msdos,win16,macosclassic,palmos,zxspectrum,msxdos,amstradcpc,sinclairql,wasip1,wasip1threads,wasip2,human68k,ps1];
    if Defaults.CPU=jvm then
      P.OSes := P.OSes - [java,android];

    P.Author := 'Free Pascal Team';
    P.License := 'LGPL with modification';
    P.HomepageURL := 'www.freepascal.org';
    P.Description := 'Generate fpmake.pp for Pascal source.';
    P.Email := '';
    P.NeedLibC:= false;

    P.Directory:=ADirectory;
    P.Version:='3.3.1';
    P.Dependencies.Add('fcl-base');
    P.Dependencies.Add('fcl-passrc');

    T:=P.Targets.AddProgram('pas2fpm.pp');
    end;
end;

{$ifndef ALLPACKAGES}
begin
  add_pas2fpm('');
  Installer.Run;
end.
{$endif ALLPACKAGES}




