{$ifndef ALLPACKAGES}
{$mode objfpc}{$H+}
program fpmake;

uses fpmkunit;

Const 
  SQLiteOSes      = AllUnixOSes+AllWindowsOSes-[qnx,win16];
  SQLite3OSes     = AllUnixOSes+AllWindowsOSes+[ultibo]-[qnx,win16];

Var
  P : TPackage;
  T : TTarget;
begin
  With Installer do
    begin
{$endif ALLPACKAGES}

    P:=AddPackage('sqlite');
    P.ShortName:='sqlt';
{$ifdef ALLPACKAGES}
    P.Directory:=ADirectory;
{$endif ALLPACKAGES}
    P.Version:='3.3.1';
    P.OSes := SQLiteOSes+SQLite3OSes;
    if Defaults.CPU=jvm then
      P.OSes := P.OSes - [java,android];

    P.SourcePath.Add('src');
    P.IncludePath.Add('src');

    T:=P.Targets.AddUnit('sqlite3db.pas',SQLite3OSes);
      with T.Dependencies do
        begin
          AddUnit('sqlite3');
        end;
    T:=P.Targets.AddUnit('sqlite3dyn.pp',SQLite3OSes-[ultibo]);
      with T.Dependencies do
        begin
          AddInclude('sqlite3.inc');
        end;
    T.ResourceStrings := True;
    T:=P.Targets.AddUnit('sqlite3.pp',SQLite3OSes);
      with T.Dependencies do
        begin
          AddInclude('sqlite3.inc');
          AddInclude('sqlite3ultibo.inc',[ultibo]);
        end;
    T:=P.Targets.AddUnit('sqlitedb.pas',SQLiteOSes);
      with T.Dependencies do
        begin
          AddUnit('sqlite');
        end;
    T:=P.Targets.AddUnit('sqlite.pp',SQLiteOSes);
    T:=P.Targets.AddUnit('sqlite3ext.pp',SQLite3OSes);
      with T.Dependencies do
        begin
          AddUnit('sqlite3');
        end;
 
    P.ExamplePath.Add('tests/');
    P.Targets.AddExampleProgram('testapiv3x.pp');
    P.Targets.AddExampleProgram('test.pas');
    // 'testapiv3x.README

{$ifndef ALLPACKAGES}
    Run;
    end;
end.
{$endif ALLPACKAGES}
