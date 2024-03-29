program testthreads;

{$mode objfpc}

uses
  sysutils,
  classes;

type
  TMyThread=class(TThread)
  private
    ch : AnsiChar;
  protected
    procedure Execute; override;
  public
    constructor Create(c:AnsiChar);
  end;

procedure TMyThread.Execute;
begin
  repeat
    write(ch);
  until Terminated;
end;


constructor TMyThread.Create(c:AnsiChar);
begin
  ch:=c;
  inherited Create(false);
end;

var
  t1,t2 : TMyThread;
begin
  t1:=TMyThread.Create('a');
  t2:=TMyThread.Create('b');
  readln;
  t2.Terminate;
  readln;
  t1.Terminate;
  readln;
  t2.Destroy;
  t1.Destroy;
end.
