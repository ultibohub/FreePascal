{ %skiptarget=msdos,go32v2 }
{ %norun }
{ %NOTE=This test requires an installed zlib1 shared library }
{ simple compilation test }
uses
  popuperr,
  zlib;
begin
  writeln(zlibVersion);
end.
