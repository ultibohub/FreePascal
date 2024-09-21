{ %target=darwin,linux,freebsd,solaris,beos,haiku,aix,android }
{ %NEEDLIBRARY }
{ %delfiles=tw12704a }

{$mode delphi}
program MainApp;

uses
  sysutils
{$if (FPC_FULLVERSION<=30301) and defined(linux)}
  ,initc
{$endif (FPC_FULLVERSION<=30301) and defined(linux)}
;

const
{$ifdef windows}
  libname='tw12704a.dll';
{$else}
  libname='tw12704a';
  {$linklib tw12704a}
{$endif}

procedure testsignals; cdecl; external libname;

procedure initsignals;
var
  p: pointer;
  i: longint;
begin
  // check that standard signals are hooked
  for i:=RTL_SIGINT to RTL_SIGLAST do
    case i of
      RTL_SIGINT,
      RTL_SIGQUIT:
        if (InquireSignal(i) <> ssNotHooked) then
          halt(102);
      RTL_SIGFPE,
      RTL_SIGSEGV,
      RTL_SIGILL,
      RTL_SIGBUS:
        if (InquireSignal(i) <> ssHooked) then
          halt(103);
      else
        halt(104);
    end;

  // unhook sigbus
  UnhookSignal(RTL_SIGBUS);
end;

begin
  initsignals;
  testsignals
end.
