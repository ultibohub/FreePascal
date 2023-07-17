program testapiv3x;

{$APPTYPE CONSOLE}
{$MODE DELPHI}

uses sqlite3, sysutils;

const
 DBFILE='dbtest.db';

var
 rc       : Integer;
 db       : Psqlite3;
 sql      : ansistring;
 pzErrMsg : PAnsiChar;
 
function MyCallback(_para1:pointer; plArgc:longint; argv:PPAnsiChar; argcol:PPAnsiChar):longint; cdecl;
var i: Integer;
    PVal, PName: ^PAnsiChar;
begin
 PVal:=argv;
 PName:=argcol;
 for i:=0 to plArgc-1 do begin
  writeln(Format('%s = ''%s'''#13, [PName^, PVal^]));
  inc(PVal);
  inc(PName);
 end;
 writeln(#13);
 Result:=0;
end;

begin
  writeln(Format('SQLite version : %d',[sqlite3_libversion_number]));
  rc := sqlite3_open(PAnsiChar(DBFILE), @db);
  try
   if rc<>SQLITE_OK then begin
    writeln(Format('Can''t open database: %s',[DBFILE]));
   end;

   sql:= 'DROP TABLE Test;';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));

   sql:='CREATE TABLE Test(No integer, name varchar(32),shortname varchar(32), age integer);';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));
   
   sql:='INSERT INTO Test VALUES(1,''hi'', ''by'', -1);';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   Writeln('Inserting row');
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));

   SQL := 'INSERT INTO Test VALUES(2,''dualcore'', ''runwell'',-1);';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   Writeln('Inserting row') ;
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));

   SQL := 'INSERT INTO Test VALUES(3,''Hello'', ''World'',NULL);';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   Writeln('Inserting row') ;
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));

   SQL := 'INSERT INTO Test VALUES(4,''just a little'', ''test'',-1);';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   Writeln('Inserting row') ;
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));

   SQL := 'select * from Test;';
   rc:=sqlite3_exec(db, PAnsiChar(sql), @MyCallback, nil, @pzErrMsg);
   if( rc<>SQLITE_OK )
   then writeln(Format('SQL error: %s', [pzErrMsg^]));
  finally sqlite3_close(db); end;

{$ifdef Windows}
  writeln('Hit enter to exit');
  Readln;
{$endif}

end.


