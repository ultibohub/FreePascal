{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses {$ifdef unix}cthreads,{$endif} fpmkunit;
{$endif ALLPACKAGES}

procedure add_fcl_fpterm(const ADirectory: string);

Const
{copied from ../rtl-console/fpmake.pp}
  // All Unices have full set of KVM+Crt in unix/ except QNX which is not
  // in workable state atm.
  UnixLikes = AllUnixOSes -[QNX];

  WinEventOSes = [win32,win64];
  KVMAll       = [emx,go32v2,msdos,netware,netwlibc,os2,win32,win64,win16]+UnixLikes+AllAmigaLikeOSes;

  // all full KVMers have crt too
  CrtOSes      = KVMALL+[WatCom];
  KbdOSes      = KVMALL;
  VideoOSes    = KVMALL;
  MouseOSes    = KVMALL;
  TerminfoOSes = UnixLikes-[beos,haiku];

  rtl_consoleOSes =KVMALL+CrtOSes+TermInfoOSes;
{end of copied code}

  KVMAny       = KbdOSes+VideoOSes+MouseOSes;
  PtcKvmOSes   = [linux,win32,win64,go32v2,macosx,openbsd,freebsd];

  // OSes that have unix98pty and termio units
  UnixPtyOSes  = [linux];

Var
  P : TPackage;
  T : TTarget;

begin
  with Installer do
  begin
    P:=AddPackage('fcl-fpterm');
    P.Directory:=ADirectory;
    P.Version:='3.3.1';

    P.Author := 'Nikolay Nikolov';
    P.License := 'LGPL with modification, ';
    P.HomepageURL := 'https://sourceforge.net/projects/fpterm/';
    P.Description := 'Terminal emulator library, written in Free Pascal.';
    P.OSes := P.OSes - [embedded,nativent,msdos,win16,macosclassic,palmos,zxspectrum,msxdos,amstradcpc,sinclairql,ps1];

    P.SourcePath.Add('src');

    p.Dependencies.Add('rtl-console', KVMAny);
    p.Dependencies.Add('ptckvm', PtcKvmOSes);

    T:=P.Targets.AddUnit('system.terminal.base.pas');

    T:=P.Targets.AddUnit('system.terminal.view.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
      end;

    T:=P.Targets.AddUnit('system.terminal.model.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.view');
      end;

    T:=P.Targets.AddUnit('system.terminal.inputoutputconnection.pas');

    T:=P.Targets.AddUnit('system.terminal.pointingdeviceinput.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
      end;

    T:=P.Targets.AddUnit('system.terminal.logger.pas');

    T:=P.Targets.AddUnit('system.terminal.controller.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.model');
        AddUnit('system.terminal.logger');
      end;

    T:=P.Targets.AddUnit('system.terminal.keyboardinput.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
      end;

    T:=P.Targets.AddUnit('system.terminal.pas');
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.view');
        AddUnit('system.terminal.model');
        AddUnit('system.terminal.controller');
        AddUnit('system.terminal.inputoutputconnection');
        AddUnit('system.terminal.pointingdeviceinput');
        AddUnit('system.terminal.keyboardinput');
      end;

    T:=P.Targets.AddUnit('system.terminal.keyboardinput.keyboard.pas', KbdOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.keyboardinput');
      end;

    T:=P.Targets.AddUnit('system.terminal.pointingdeviceinput.mouse.pas', MouseOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.pointingdeviceinput');
      end;

    T:=P.Targets.AddUnit('system.terminal.view.video.base.pas', VideoOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.base');
        AddUnit('system.terminal.view');
      end;

    T:=P.Targets.AddUnit('system.terminal.view.video.pas', VideoOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.view.video.base');
      end;

    T:=P.Targets.AddUnit('system.terminal.kvm.pas', KVMALL);
    with T.Dependencies do
      begin
        AddUnit('system.terminal');
        AddUnit('system.terminal.view');
        AddUnit('system.terminal.keyboardinput');
        AddUnit('system.terminal.pointingdeviceinput');
        AddUnit('system.terminal.view.video');
        AddUnit('system.terminal.keyboardinput.keyboard');
        AddUnit('system.terminal.pointingdeviceinput.mouse');
      end;

    T:=P.Targets.AddUnit('system.terminal.view.video.ptc.kvm.pas', PtcKvmOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.view.video.base');
      end;

    T:=P.Targets.AddUnit('system.terminal.ptc.kvm.pas', PtcKvmOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal');
        AddUnit('system.terminal.view');
        AddUnit('system.terminal.keyboardinput');
        AddUnit('system.terminal.pointingdeviceinput');
        AddUnit('system.terminal.view.video.ptc.kvm');
        AddUnit('system.terminal.keyboardinput.keyboard');
        AddUnit('system.terminal.pointingdeviceinput.mouse');
      end;

    T:=P.Targets.AddUnit('system.terminal.pseudoterminal.unix.pas', UnixPtyOSes);

    T:=P.Targets.AddUnit('system.terminal.inputoutputconnection.unixpty.pas', UnixPtyOSes);
    with T.Dependencies do
      begin
        AddUnit('system.terminal.inputoutputconnection');
        AddUnit('system.terminal.pseudoterminal.unix');
      end;
  end;
end;

{$ifndef ALLPACKAGES}
begin
  add_fcl_fpterm('');
  Installer.Run;
end.
{$endif ALLPACKAGES}
