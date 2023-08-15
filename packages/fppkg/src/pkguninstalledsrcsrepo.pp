{
    This file is part of the fppkg package manager
    Copyright (c) 1999-2022 by the Free Pascal development team

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$IFNDEF FPC_DOTTEDUNITS}
unit pkgUninstalledSrcsRepo;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes,
  System.SysUtils,
  Fpmkunit,
  FpPkg.Options,
  FpPkg.Package,
  FpPkg.Globals,
  FpPkg.Messages,
  FpPkg.Repos,
  FpPkg.PackageRepos,
  FpPkg.Handler,
  FpPkg.Packages.Structure;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes,
  SysUtils,
  fpmkunit,
  pkgoptions,
  pkgFppkg,
  pkgglobals,
  pkgmessages,
  fprepos,
  pkgrepos,
  pkghandler,
  pkgPackagesStructure;
{$ENDIF FPC_DOTTEDUNITS}

type

  { TFppkgUninstalledSourceRepositoryOptionSection }

  TFppkgUninstalledSourceRepositoryOptionSection = class(TFppkgRepositoryOptionSection)
  protected
    class function GetKey: string; override;
  public
    function GetRepositoryType: TFPRepositoryType; override;
  end;

  { TFPUninstalledSourcesAvailablePackagesStructure }

  TFPUninstalledSourcesAvailablePackagesStructure = class(TFPCustomFileSystemPackagesStructure)
  public
    class function GetRepositoryOptionSectionClass: TFppkgRepositoryOptionSectionClass; override;
    procedure InitializeWithOptions(ARepoOptionSection: TFppkgRepositoryOptionSection; AnOptions: TFppkgOptions; ACompilerOptions: TCompilerOptions); override;

    function AddPackagesToRepository(ARepository: TFPRepository): Boolean; override;
    function GetBuildPathDirectory(APackage: TFPPackage): string; override;
  end;


  { TFppkgUninstalledRepositoryOptionSection }

  TFppkgUninstalledRepositoryOptionSection = class(TFppkgRepositoryOptionSection)
  private
    FSourceRepositoryName: string;
  protected
    class function GetKey: string; override;
  public
    procedure AddKeyValue(const AKey, AValue: string); override;
    procedure LogValues(ALogLevel: TLogLevel); override;
    function GetRepositoryType: TFPRepositoryType; override;
    procedure SaveToStrings(AStrings: TStrings); override;
    property SourceRepositoryName: string read FSourceRepositoryName write FSourceRepositoryName;
  end;

  { TFPUninstalledSourcesPackagesStructure }

  TFPUninstalledSourcesPackagesStructure = class(TFPCustomFileSystemPackagesStructure)
  private
    FSourceRepositoryName: string;
    FLinkedRepositoryName: string;
  public
    class function GetRepositoryOptionSectionClass: TFppkgRepositoryOptionSectionClass; override;
    procedure InitializeWithOptions(ARepoOptionSection: TFppkgRepositoryOptionSection; AnOptions: TFppkgOptions; ACompilerOptions: TCompilerOptions); override;

    function AddPackagesToRepository(ARepository: TFPRepository): Boolean; override;
    function IsInstallationNeeded(APackage: TFPPackage): TFPInstallationNeeded; override;
    function GetBaseInstallDir: string; override;
    function GetConfigFileForPackage(APackage: TFPPackage): string; override;
    property SourceRepositoryName: string read FSourceRepositoryName write FSourceRepositoryName;
  end;


implementation

const
  KeySourceRepository  = 'SourceRepository';
  SLogSourceRepository = '  SourceRepository:%s';
  KeySrcRepositorySection = 'UninstalledSourceRepository';
  KeyUninstalledRepository = 'UninstalledRepository';
  KeyRepositorySection = 'Repository';

{ TFPUninstalledSourcesPackagesStructure }

class function TFPUninstalledSourcesPackagesStructure.GetRepositoryOptionSectionClass: TFppkgRepositoryOptionSectionClass;
begin
  Result := TFppkgUninstalledRepositoryOptionSection;
end;

procedure TFPUninstalledSourcesPackagesStructure.InitializeWithOptions(
  ARepoOptionSection: TFppkgRepositoryOptionSection; AnOptions: TFppkgOptions;
  ACompilerOptions: TCompilerOptions);
var
  RepoOptionSection: TFppkgUninstalledRepositoryOptionSection;
begin
  inherited InitializeWithOptions(ARepoOptionSection, AnOptions, ACompilerOptions);
  RepoOptionSection := ARepoOptionSection as TFppkgUninstalledRepositoryOptionSection;
  path := RepoOptionSection.Path;
  SourceRepositoryName := RepoOptionSection.SourceRepositoryName;
  FLinkedRepositoryName := RepoOptionSection.RepositoryName;
end;

function TFPUninstalledSourcesPackagesStructure.AddPackagesToRepository(ARepository: TFPRepository): Boolean;

var
  SRD : TSearchRec;
  SRF : TSearchRec;
  P  : TFPPackage;
  UD : String;
begin
  Result:=false;
  log(llDebug,SLogFindInstalledPackages,[Path]);
  if FindFirst(Path+AllFiles,faDirectory,SRD)=0 then
    begin
      repeat
          // Try new .fpm-file
          UD:=Path+SRD.Name+PathDelim;

          if FindFirst(UD+'*'+FpmkExt,faAnyFile,SRF)=0 then
            begin
              repeat
                AddPackageToRepository(ARepository, ChangeFileExt(SRF.Name,''), UD+SRF.Name);
              until FindNext(SRF)<>0;
            end;
          FindClose(SRF);
      until FindNext(SRD)<>0;
    end;
  FindClose(SRD);

  Result:=true;
end;

function TFPUninstalledSourcesPackagesStructure.IsInstallationNeeded(APackage: TFPPackage): TFPInstallationNeeded;
begin
  if (APackage.Repository.RepositoryName=SourceRepositoryName) or
    (Assigned(APackage.Repository.DefaultPackagesStructure) and (APackage.Repository.DefaultPackagesStructure.InstallRepositoryName=FLinkedRepositoryName)) then
    Result := fpinNoInstallationNeeded
  else
    Result := fpinInstallationImpossible;
end;

function TFPUninstalledSourcesPackagesStructure.GetBaseInstallDir: string;
begin
  Result := Path;
end;

function TFPUninstalledSourcesPackagesStructure.GetConfigFileForPackage(APackage: TFPPackage): string;
begin
  if APackage.SourcePath<>'' then
    Result := IncludeTrailingPathDelimiter(APackage.SourcePath)
  else
    Result := IncludeTrailingPathDelimiter(GetBaseInstallDir)+APackage.Name+PathDelim;

  Result := Result +APackage.Name+'-'+FCompilerOptions.CompilerTarget+FpmkExt;
end;

{ TFppkgUninstalledRepositoryOptionSection }

class function TFppkgUninstalledRepositoryOptionSection.GetKey: string;
begin
  Result := KeyUninstalledRepository;
end;

procedure TFppkgUninstalledRepositoryOptionSection.AddKeyValue(const AKey, AValue: string);
begin
   if SameText(AKey,KeySourceRepository) then
    SourceRepositoryName := AValue
  else
    inherited AddKeyValue(AKey, AValue);
end;

procedure TFppkgUninstalledRepositoryOptionSection.LogValues(ALogLevel: TLogLevel);
begin
  inherited LogValues(ALogLevel);
  log(ALogLevel,SLogSourceRepository,[FSourceRepositoryName]);
end;

function TFppkgUninstalledRepositoryOptionSection.GetRepositoryType: TFPRepositoryType;
begin
  Result := fprtInstalled;
end;

procedure TFppkgUninstalledRepositoryOptionSection.SaveToStrings(AStrings: TStrings);
begin
  inherited SaveToStrings(AStrings);
   if SourceRepositoryName<>'' then
     AStrings.Add(KeySourceRepository+'='+SourceRepositoryName);
end;

{ TFppkgUninstalledSourceRepositoryOptionSection }

class function TFppkgUninstalledSourceRepositoryOptionSection.GetKey: string;
begin
  Result := KeySrcRepositorySection;
end;

function TFppkgUninstalledSourceRepositoryOptionSection.GetRepositoryType: TFPRepositoryType;
begin
  Result := fprtAvailable;
end;

{ TFPUninstalledSourcesPackagesStructure }

class function TFPUninstalledSourcesAvailablePackagesStructure.GetRepositoryOptionSectionClass: TFppkgRepositoryOptionSectionClass;
begin
  Result := TFppkgUninstalledSourceRepositoryOptionSection;
end;

procedure TFPUninstalledSourcesAvailablePackagesStructure.InitializeWithOptions(
  ARepoOptionSection: TFppkgRepositoryOptionSection; AnOptions: TFppkgOptions;
  ACompilerOptions: TCompilerOptions);
begin
  inherited InitializeWithOptions(ARepoOptionSection, AnOptions, ACompilerOptions);
  path := TFppkgUninstalledSourceRepositoryOptionSection(ARepoOptionSection).Path;
end;

function TFPUninstalledSourcesAvailablePackagesStructure.AddPackagesToRepository(ARepository: TFPRepository): Boolean;

var
  SR : TSearchRec;
  AManifestFile, AFPMakeFile: String;
  i: Integer;
  TempPackagesStructure: TFPTemporaryDirectoryPackagesStructure;
  TempRepo: TFPRepository;
  PackageName: string;
  PackageManager: TpkgFppkg;
begin
  Result:=false;

  TempPackagesStructure := TFPTemporaryDirectoryPackagesStructure.Create(Owner);
  TempPackagesStructure.InitializeWithOptions(nil, FOptions, FCompilerOptions);
  TempRepo := TFPRepository.Create(Owner);
  TempRepo.RepositoryName := 'TempScanUninstPackages';
  TempRepo.Description := 'Temp list of packages during scanning of source-packages';
  TempRepo.RepositoryType := fprtAvailable;
  TempRepo.DefaultPackagesStructure := TempPackagesStructure;
  TempPackagesStructure.AddPackagesToRepository(TempRepo);

  if Owner is TPkgFppkg then
    PackageManager := TPkgfppkg(owner)
  else
    PackageManager := GFPpkg;

  if Assigned(PackageManager) then
    PackageManager.RepositoryList.Add(TempRepo);
  try
    log(llDebug,SLogFindInstalledPackages,[Path]);
    if FindFirst(Path+AllFiles,faDirectory,SR)=0 then
      begin
        repeat
          if ((SR.Attr and faDirectory)=faDirectory) and (SR.Name<>'.') and (SR.Name<>'..') then
            begin
              AFPMakeFile := Path+SR.Name+PathDelim+FPMakePPFile;
              if FileExistsLog(AFPMakeFile) then
                begin
                  AManifestFile := Path+SR.Name+PathDelim+ManifestFile;
                  if not FileExists(AManifestFile) or (FileAge(AManifestFile) < FileAge(AFPMakeFile)) then
                    begin
                      // (Re-)create manifest
                      if assigned(PackageManager) then
                        begin
                          try
                            TempPackagesStructure.SetTempPath(Path+SR.Name);
                            PackageName :=  SR.Name + '_create_manifest';
                            TempPackagesStructure.TempPackageName := PackageName;
                            {$IFDEF FPC_DOTTEDUNITS}FpPkg.Handler{$ELSE}pkghandler{$ENDIF}.ExecuteAction(PackageName,'fpmakemanifest',PackageManager);
                          except
                            on E: Exception do
                              begin
                              log(llWarning, SLogFailedToCreateManifest ,[AFPMakeFile, E.Message]);
                                Continue;
                              end;
                          end;
                        end
                      else
                        begin
                          log(llError, SLogFailedToCreateManifest ,[AFPMakeFile, 'No packagemanager available']);
                        end;
                    end;
                  ARepository.AddPackagesFromManifestFile(AManifestFile);
                  for i := 0 to ARepository.PackageCount -1 do
                    if ARepository.Packages[i].SourcePath = '' then
                      ARepository.Packages[i].SourcePath := SR.Name;
                end
            end;
        until FindNext(SR)<>0;
      end;
    FindClose(SR);
  finally
    if Assigned(PackageManager) then
      PackageManager.RepositoryList.Remove(TempRepo);
    TempRepo.Free;
    TempPackagesStructure.Free;
  end;
  for i := 0 to ARepository.PackageCount -1 do
    ARepository.Packages[i].PackagesStructure := Self;

  Result:=true;
end;

function TFPUninstalledSourcesAvailablePackagesStructure.GetBuildPathDirectory(APackage: TFPPackage): string;
begin
  if APackage.SourcePath<>'' then
    Result := Path+APackage.SourcePath
  else
    Result := Path+APackage.Name
end;

initialization
  TFPCustomPackagesStructure.RegisterPackagesStructureClass(TFPUninstalledSourcesAvailablePackagesStructure);
  TFPCustomPackagesStructure.RegisterPackagesStructureClass(TFPUninstalledSourcesPackagesStructure);
end.

