{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses {$ifdef unix}cthreads,{$endif} fpmkunit;
{$endif ALLPACKAGES}

procedure add_rtl_console(const ADirectory: string);

Const
  // All Unices have full set of KVM+Crt in unix/ except QNX which is not
  // in workable state atm.
  UnixLikes = AllUnixOSes -[QNX];

  WinEventOSes = [win32,win64];
  KVMAll       = [emx,go32v2,msdos,netware,netwlibc,os2,win32,win64,win16,ultibo]+UnixLikes+AllAmigaLikeOSes;

  // all full KVMers have crt too
  CrtOSes      = KVMALL+[WatCom];
  KbdOSes      = KVMALL-[ultibo];
  VideoOSes    = KVMALL-[ultibo];
  MouseOSes    = KVMALL-[ultibo];
  TerminfoOSes = UnixLikes-[beos,haiku];

  rtl_consoleOSes =KVMALL+CrtOSes+TermInfoOSes;

Var
  P : TPackage;
  T : TTarget;

begin
  With Installer do
    begin
    P:=AddPackage('rtl-console');
    P.ShortName:='rtlc';
    P.Directory:=ADirectory;
    P.Version:='3.3.1';
    P.Author := 'FPC core team, Pierre Mueller, Peter Vreman';
    P.License := 'LGPL with modification, ';
    P.HomepageURL := 'www.freepascal.org';
    P.OSes:=Rtl_ConsoleOSes;
    if Defaults.CPU=jvm then
      P.OSes := P.OSes - [java,android];

    P.Email := '';
    P.Description := 'Rtl-console, console abstraction';
    P.NeedLibC:= false;
    P.Dependencies.Add('rtl-extra'); // linux,android gpm.
    P.Dependencies.Add('rtl-unicode');
    P.Dependencies.Add('morphunits',[morphos]);
    P.Dependencies.Add('arosunits',[aros]);
    if Defaults.CPU=m68k then
      P.Dependencies.Add('amunits',[amiga]);
    if Defaults.CPU=powerpc then
      P.Dependencies.Add('os4units',[amiga]);
    P.SourcePath.Add('src/inc');
    P.SourcePath.Add('src/$(OS)');
    P.SourcePath.Add('src/darwin',[iphonesim,ios]);
    P.SourcePath.Add('src/unix',AllUnixOSes);
    P.SourcePath.Add('src/os2commn',[os2,emx]);
    P.SourcePath.Add('src/amicommon',AllAmigaLikeOSes);
    P.SourcePath.Add('src/win',WinEventOSes);

    P.IncludePath.Add('src/inc');
    P.IncludePath.Add('src/unix',AllUnixOSes);
    P.IncludePath.add('src/amicommon',AllAmigaLikeOSes);
    P.IncludePath.Add('src/$(OS)');
    P.IncludePath.Add('src/darwin',[iphonesim,ios]);

    T:=P.Targets.AddUnit('winevent.pp',WinEventOSes);

    T:=P.Targets.AddUnit('keyboard.pp',KbdOSes);
    with T.Dependencies do
      begin
        AddInclude('keybrdh.inc');
        AddInclude('keyboard.inc');
        AddInclude('keyscan.inc',AllUnixOSes);
        AddUnit   ('winevent',[win32,win64]);
        AddInclude('nwsys.inc',[netware]);
        AddUnit   ('mouse',AllUnixOSes);
        AddUnit   ('video',[win16]);
        AddUnit   ('unixkvmbase',AllUnixOSes);
      end;

    T:=P.Targets.AddUnit('mouse.pp',MouseOSes);
    with T.Dependencies do
     begin
       AddInclude('mouseh.inc');
       AddInclude('mouse.inc');
       AddUnit   ('winevent',[win32,win64]);
       AddUnit   ('video',[go32v2,msdos] + AllUnixOSes);
     end;

    T:=P.Targets.AddUnit('video.pp',VideoOSes);
    with T.Dependencies do
     begin
       AddInclude('videoh.inc');
       AddInclude('video.inc');
       AddInclude('videodata.inc',AllAmigaLikeOSes);
       AddInclude('nwsys.inc',[netware]);
       AddUnit   ('mouse',[go32v2,msdos]);
       AddUnit   ('unixkvmbase',AllUnixOSes);
     end;

    // Alternate versions for Ultibo to resolve name conflict
    T:=P.Targets.AddUnit('consolekeyboard.pp',[ultibo]);
    with T.Dependencies do
      begin
        AddInclude('keybrdh.inc');
        AddInclude('keyboard.inc');
      end;
     
    T:=P.Targets.AddUnit('consolemouse.pp',[ultibo]);
    with T.Dependencies do
     begin
       AddInclude('mouseh.inc');
       AddInclude('mouse.inc');
     end;
     
    T:=P.Targets.AddUnit('consolevideo.pp',[ultibo]);
    with T.Dependencies do
     begin
       AddInclude('videoh.inc');
       AddInclude('video.inc');
     end;

    T:=P.Targets.AddUnit('crt.pp',CrtOSes);
    with T.Dependencies do
     begin
       AddInclude('crth.inc');
       AddInclude('crt.inc');
       AddInclude('nwsys.inc',[netware]);
       AddUnit   ('video',[win16]);
       AddUnit   ('keyboard',[win16]);
     end;

    T:=P.Targets.AddUnit('vidcrt.pp', AllAmigaLikeOSes);
    with T.Dependencies do
     begin
       AddInclude('crth.inc');
       AddInclude('crt.inc');
       AddUnit   ('video', AllAmigaLikeOSes);
       AddUnit   ('keyboard', AllAmigaLikeOSes);
       AddUnit   ('mouse', AllAmigaLikeOSes);
     end;

    T:=P.Targets.AddUnit('vesamode.pp',[go32v2,msdos]);
    with T.Dependencies do
     begin
       AddUnit('video');
       AddUnit('mouse');
     end;

    T:=P.Targets.AddUnit('unixkvmbase.pp',AllUnixOSes);

    P.NamespaceMap:='namespaces.lst';
  end
end;

{$ifndef ALLPACKAGES}
begin
  add_rtl_console('');
  Installer.Run;
end.
{$endif ALLPACKAGES}

