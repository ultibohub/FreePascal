{ %OPT=-O- }

var
  d1,d2,d3 : double;

begin
  d1:=0.0;
  d2:=-0.0;
  d3:=-d1+d2;
  writeln(d3);
  if (d3<>0.0) or not(TDoubleRec(d3).Sign) then
    halt(1);
  d3:=d2+-d1;
  writeln(d3);
  if (d3<>0.0) or not(TDoubleRec(d3).Sign) then
    halt(2);
  d3:=d2--d1;
  writeln(d3);
  if (d3<>0.0) or (TDoubleRec(d3).Sign) then
    halt(3);

  d1:=1.0;
  d2:=1.0;
  d3:=-d2*-d1;
  writeln(d3);
  if (d3<>1.0) or (TDoubleRec(d3).Sign) then
    halt(4);

  d3:=-d2/-d1;
  writeln(d3);
  if (d3<>1.0) or (TDoubleRec(d3).Sign) then
    halt(5);

  d1:=1.0;
  d2:=1.0;
  d3:=-(d2-d1);
  writeln(d3);
  if (d3<>0.0) or not(TDoubleRec(d3).Sign) then
    halt(6);

  d1:=-0.0;
  d3:=--d1;
  writeln(d3);
  if (d3<>0.0) or not(TDoubleRec(d3).Sign) then
    halt(7);

  d1:=1.0;
  d2:=2.0;
  d3:=-(d2*-d1);
  writeln(d3);
  if (d3<>2.0) or (TDoubleRec(d3).Sign) then
    halt(8);

  d1:=1.0;
  d2:=2.0;
  d3:=-(-d2*d1);
  writeln(d3);
  if (d3<>2.0) or (TDoubleRec(d3).Sign) then
    halt(9);

  d1:=1.0;
  d2:=2.0;
  d3:=-(d2/-d1);
  writeln(d3);
  if (d3<>2.0) or (TDoubleRec(d3).Sign) then
    halt(10);

  d1:=1.0;
  d2:=2.0;
  d3:=-(-d2/d1);
  writeln(d3);
  if (d3<>2.0) or (TDoubleRec(d3).Sign) then
    halt(11);

  writeln('ok');
end.
