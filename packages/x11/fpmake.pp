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

    P:=AddPackage('x11');
    P.Description := 'Interface units for X Window GUI libraries (X11).';
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.OSes:=[beos,haiku,freebsd,solaris,netbsd,openbsd,linux,os2,emx,aix,dragonfly];
    // Do not build x11 on iPhone (=arm-darwin)
    if Defaults.CPU<>arm then
      P.OSes := P.OSes + [darwin];
    P.SourcePath.Add('src');
    P.IncludePath.Add('src');

    T:=P.Targets.AddUnit('cursorfont.pp');
    T:=P.Targets.AddUnit('keysym.pp');
    T:=P.Targets.AddUnit('deckeysym.pp');
    T:=P.Targets.AddUnit('hpkeysym.pp');
    T:=P.Targets.AddUnit('sunkeysym.pp');
    T:=P.Targets.AddUnit('xf86keysym.pp');
    T:=P.Targets.AddUnit('xatom.pp');
    T:=P.Targets.AddUnit('xcms.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xf86dga.pp');
      with T.Dependencies do
        begin
          AddInclude('xf86dga1.inc');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xf86vmode.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xinerama.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xi.pp');
    T:=P.Targets.AddUnit('xi2.pp');
    T:=P.Targets.AddUnit('xinput.pp');
      with T.Dependencies do
        begin
          AddUnit('x');
          AddUnit('xlib');
          AddUnit('xi');
        end;
    T:=P.Targets.AddUnit('xge.pp');
      with T.Dependencies do
        begin
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xfixes.pp');
      with T.Dependencies do
        begin
          AddUnit('x');
          AddUnit('xlib');
          AddInclude('xfixeswire.inc');
        end;
    T:=P.Targets.AddUnit('xinput2.pp');
      with T.Dependencies do
        begin
          AddUnit('x');
          AddUnit('xlib');
          AddUnit('xi2');
          AddUnit('xge');
          AddUnit('xfixes');
        end;
    T:=P.Targets.AddUnit('xkblib.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
          AddUnit('xkb');
        end;
    T:=P.Targets.AddUnit('xkb.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
          AddUnit('xi');
        end;
    T:=P.Targets.AddUnit('xlib.pp');
    T:=P.Targets.AddUnit('x.pp');
    T:=P.Targets.AddUnit('xrandr.pp');
      with T.Dependencies do
        begin
          AddInclude('randr.inc');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xrender.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xresource.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xshm.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xutil.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
          AddUnit('keysym');
        end;
    T:=P.Targets.AddUnit('xvlib.pp');
      with T.Dependencies do
        begin
          AddUnit('xlib');
          AddUnit('xshm');
        end;
    T:=P.Targets.AddUnit('xv.pp');
    T:=P.Targets.AddUnit('fontconfig.pas');
    T.Dependencies.AddUnit('xlib');
    T:=P.Targets.AddUnit('xft.pas');
    T.Dependencies.AddUnit('xlib');
    T.Dependencies.AddUnit('xrender');
    T.Dependencies.AddUnit('fontconfig');
    T:=P.Targets.AddUnit('xext.pp');
    T.Dependencies.AddUnit('xlib');
    T:=P.Targets.AddUnit('mitmisc.pp');
      with T.Dependencies do
        begin
          AddInclude('mitmiscconst.inc');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('shape.pp');
      with T.Dependencies do
        begin
          AddInclude('shapeconst.inc');
          AddUnit('x');
          AddUnit('xlib');
          AddUnit('xutil');
        end;
    T:=P.Targets.AddUnit('xevi.pp');
      with T.Dependencies do
        begin
          AddInclude('evi.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xlbx.pp');
      with T.Dependencies do
        begin
          AddInclude('lbx.inc');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xag.pp');
      with T.Dependencies do
        begin
          AddInclude('ag.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xcup.pp');
      with T.Dependencies do
        begin
          AddInclude('cup.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xdbe.pp');
      with T.Dependencies do
        begin
          AddInclude('dbe.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xmd.pp');
    T:=P.Targets.AddUnit('dpms.pp');
      with T.Dependencies do
        begin
          AddInclude('dpmsconst.inc');
          AddUnit('xlib');
          AddUnit('xmd');
        end;
    T:=P.Targets.AddUnit('multibuf.pp');
      with T.Dependencies do
        begin
          AddInclude('multibufconst.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('security.pp');
      with T.Dependencies do
        begin
          AddInclude('secur.inc');
          AddInclude('xauth.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('sync.pp');
      with T.Dependencies do
        begin
          AddInclude('syncconst.inc');
          AddUnit('x');
          AddUnit('xlib');
        end;
    T:=P.Targets.AddUnit('xtestext1.pp');
      with T.Dependencies do
        begin
          AddInclude('xtestext1const.inc');
          AddUnit('x');
          AddUnit('xlib');
          AddUnit('xmd');
        end;

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
