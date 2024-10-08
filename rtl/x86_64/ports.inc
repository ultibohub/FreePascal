{
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by Michael Van Canneyt
    member of the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{ to give easy port access like tp with port[] }

procedure tport.writeport(p : Longint;data : byte);inline;

begin
  fpc_x86_outportb(p,data)
end;

function tport.readport(p : Longint) : byte;inline;

begin
  readport := fpc_x86_inportb(p);
end;

procedure tportw.writeport(p : longint;data : word);inline;

begin
  fpc_x86_outportw(p,data)
end;

function tportw.readport(p : longint) : word;inline;

begin
  readport := fpc_x86_inportw(p);
end;

procedure tportl.writeport(p : longint;data : longint);inline;

begin
  fpc_x86_outportl(p,data)
end;

function tportl.readport(p : longint) : longint;inline;

begin
  readPort := fpc_x86_inportl(p);
end;
