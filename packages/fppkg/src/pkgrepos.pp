{
    This file is part of the fppkg package manager
    Copyright (c) 1999-2022 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit pkgrepos;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,Classes,
  fprepos,pkgoptions,
  pkgFppkg,
  fpmkunit;

procedure LoadLocalAvailableMirrors;
function LoadManifestFromFile(const AManifestFN:string):TFPPackage;
procedure FindInstalledPackages(ACompilerOptions:TCompilerOptions;showdups:boolean=true);
Procedure AddFPMakeAddIn(APackage: TFPPackage);
function  FindBrokenPackages(SL:TStrings):Boolean;
procedure CheckFPMakeDependencies;
procedure ListPackages(const ShowGlobalAndLocal: boolean);
procedure InitializeFppkg;

procedure SetDefaultRepositoryClass(ARepositoryClass: TFPRepositoryClass);

var
  AvailableMirrors    : TFPMirrors;
  GFPpkg: TpkgFppkg;


implementation

uses
  zipper,
  fpxmlrep,
  pkgglobals,
  pkgmessages,
  pkgPackagesStructure;

resourcestring
  SErrRepositoryClassAlreadyAssigned = 'Default repository class is already assigned.';

var
  RepositoryClass : TFPRepositoryClass;

procedure SetDefaultRepositoryClass(ARepositoryClass: TFPRepositoryClass);
begin
  if assigned(RepositoryClass) then
    raise exception.Create(SErrRepositoryClassAlreadyAssigned);
  RepositoryClass:=ARepositoryClass;
end;

function GetDefaultRepositoryClass: TFPRepositoryClass;
begin
  if not assigned(RepositoryClass) then
    SetDefaultRepositoryClass(TFPRepository);
  result := RepositoryClass;
end;

{*****************************************************************************
                           Mirror Selection
*****************************************************************************}

procedure LoadLocalAvailableMirrors;
begin
  GFPpkg.LoadLocalAvailableMirrors;
end;


function SelectRemoteMirror:string;
var
  i,j : Integer;
  Bucket,
  BucketCnt : Integer;
  M : TFPMirror;
begin
  Result:='';
  M:=nil;
  if assigned(AvailableMirrors) then
   begin
     // Create array for selection
     BucketCnt:=0;
     for i:=0 to AvailableMirrors.Count-1 do
       inc(BucketCnt,AvailableMirrors[i].Weight);
     // Select random entry
     Bucket:=Random(BucketCnt);
     M:=nil;
     for i:=0 to AvailableMirrors.Count-1 do
       begin
         for j:=0 to AvailableMirrors[i].Weight-1 do
           begin
             if Bucket=0 then
               begin
                 M:=AvailableMirrors[i];
                 break;
               end;
             Dec(Bucket);
           end;
         if assigned(M) then
           break;
       end;
    end;
  if assigned(M) then
    begin
      log(llInfo,SLogSelectedMirror,[M.Name]);
      Result:=M.URL;
    end
  else
    Error(SErrFailedToSelectMirror);
end;

{*****************************************************************************
                           Local Repository
*****************************************************************************}

function LoadManifestFromFile(const AManifestFN:string):TFPPackage;
var
  X : TFPXMLRepositoryHandler;
  NewPackages : TFPPackages;
  NewP : TFPPackage;
begin
  result:=nil;
  NewPackages:=TFPPackages.Create(TFPPackage);
  X:=TFPXMLRepositoryHandler.Create;
  try
    X.LoadFromXml(NewPackages,AManifestFN);
    if NewPackages.Count=1 then
      begin
        NewP:=NewPackages[0];
        result:=TFPPackage.Create(nil);
        // Copy contents
        result.Assign(NewP);
      end
    else
      Error(SErrManifestNoSinglePackage,[AManifestFN]);
  finally
    X.Free;
    NewPackages.Free;
  end;
end;


procedure FindInstalledPackages(ACompilerOptions:TCompilerOptions;showdups:boolean=true);
begin
  GFPpkg.ScanPackages;
end;


Procedure AddFPMakeAddIn(APackage: TFPPackage);
var
  SelectedDep, i: Integer;
begin
  SelectedDep := -1;
  for i := 0 to high(FPMKUnitDeps) do
    begin
      if FPMKUnitDeps[i].package = APackage.Name then
        begin
          log(llDebug,SLogUpdateFPMakeAddin,[APackage.Name]);
          SelectedDep := i;
          break;
        end;
    end;

  if SelectedDep = -1 then
    begin
      log(llDebug,SLogFoundFPMakeAddin,[APackage.Name]);
      setlength(FPMKUnitDeps,length(FPMKUnitDeps)+1);
      SelectedDep := high(FPMKUnitDeps);
    end;
  FPMKUnitDeps[SelectedDep].package:=APackage.Name;
  FPMKUnitDeps[SelectedDep].reqver:=APackage.Version.AsString;
  FPMKUnitDeps[SelectedDep].def:='HAS_PACKAGE_'+APackage.Name;
  FPMKUnitDeps[SelectedDep].PluginUnit:=APackage.FPMakePluginUnits;
  FPMKUnitDeps[SelectedDep].available:=true;
end;


function FindBrokenPackages(SL:TStrings):Boolean;
begin
  Result := GFPpkg.FindBrokenPackages(SL);
end;


procedure CheckFPMakeDependencies;
begin
  GFPpkg.ScanAvailablePackages;
end;


{*****************************************************************************
                           Local Available Repository
*****************************************************************************}

procedure ListPackages(const ShowGlobalAndLocal: boolean);

  procedure AddPackageToLine(APackage: TFPPackage; CheckIsBroken: Boolean; var Line: string);
  var
    PackageVersion: string;
    s: string;
  begin
    if Assigned(APackage) then
      begin
        PackageVersion := APackage.Version.AsString;
        if CheckIsBroken and GFPpkg.PackageIsBroken(APackage, s, nil) then
          PackageVersion := PackageVersion + ' (B)';
      end
    else
      PackageVersion := '-';
    Line :=  Line + Format(' %-14s', [PackageVersion])
  end;

var
  i,j : integer;
  SL : TStringList;
  PackageName : string;
  Repo: TFPRepository;
  Package: TFPPackage;
  Header: string;
  Line: string;
begin
  SL:=TStringList.Create;
  SL.Sorted:=true;
  SL.Duplicates:=dupIgnore;

  Header := Format('%-20s', ['Name']);
  for i:=0 to GFPpkg.RepositoryList.Count-1 do
    begin
      Repo := TFPRepository(GFPpkg.RepositoryList[i]);
      Header := Header + Format(' %-14s', [Repo.RepositoryName]);
      for j:=0 to Repo.PackageCount-1 do
        begin
          SL.Add(Repo.Packages[j].Name);
        end;
    end;
  if ShowGlobalAndLocal then
    WriteLn(Header)
  else
    Writeln(Format('%-20s %-14s %-14s',['Name','Installed','Available']));

  for i:=0 to SL.Count-1 do
    begin
      PackageName:=SL[i];
      if (PackageName<>CmdLinePackageName) and (PackageName<>CurrentDirPackageName) then
        begin
          Line:=Format('%-20s', [PackageName]);
          if ShowGlobalAndLocal then
            begin
              for j:=0 to GFPpkg.RepositoryList.Count-1 do
                begin
                  Repo := TFPRepository(GFPpkg.RepositoryList[j]);
                  Package := Repo.FindPackage(PackageName);
                  AddPackageToLine(Package, Repo.RepositoryType = fprtInstalled, Line);
                end
            end
          else
            begin
              Package := GFPpkg.FindPackage(PackageName, pkgpkInstalled);
              AddPackageToLine(Package, True, Line);
              Package := GFPpkg.FindPackage(PackageName, pkgpkAvailable);
              AddPackageToLine(Package, False, Line);
            end;
        end;
      WriteLn(Line);
    end;
  FreeAndNil(SL);
end;


procedure InitializeFppkg;
begin
  if Assigned(GFPpkg) then
    GFPpkg.Free;
  GFPpkg := TpkgFPpkg.Create(nil);
end;

initialization
  GFPpkg := nil;
  AvailableMirrors := nil;
finalization
  AvailableMirrors.Free;
  GFPpkg.Free;
end.
