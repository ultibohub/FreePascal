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

    P:=AddPackage('gnutls');
    P.Dependencies.Add('fcl-net');
    P.ShortName:='gtls';
    P.Description := 'Interface units for GNU TLS libraries supporting SSL-encrypted network communication.';
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.SourcePath.Add('src');
    P.OSes := AllUnixOSes+AllWindowsOSes-[qnx];
    if Defaults.CPU=jvm then
      P.OSes := P.OSes - [java,android];
    T:=P.Targets.AddUnit('gnutls.pp');
    T:=P.Targets.AddUnit('gnutlssockets.pp');
      T.Dependencies.AddUnit('gnutls');
    P.ExamplePath.Add('examples');
    P.Targets.AddExampleProgram('testgnutls.pp');
    P.Targets.AddExampleProgram('privkey.pp');
    P.Targets.AddExampleProgram('srvcacert.pp');
    
{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
