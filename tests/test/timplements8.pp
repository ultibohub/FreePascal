{$ifdef fpc}
{$mode objfpc}
{$endif fpc}
uses
  classes,uimplements8;

var
  o1 : to1;
  i1,i2 : IInterface;
begin
  o1:=to1.create;
  o1.fi:=TInterfacedObject.Create;
  i1:=o1;
  i1.QueryInterface(IInterface,i2);
  if i2=nil then
    halt(1);
  o1.fi:=nil;
  i1.QueryInterface(IInterface,i2);
  if i2=nil then
    halt(1);
  o1.free;
  i1.QueryInterface(IInterface,i2);
  if i2=nil then
    halt(1);
  writeln('ok');
end.
