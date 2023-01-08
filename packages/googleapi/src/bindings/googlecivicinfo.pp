unit googlecivicinfo;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAdministrationRegion = Class;
  TAdministrativeBody = Class;
  TCandidate = Class;
  TChannel = Class;
  TContest = Class;
  TDivisionSearchResponse = Class;
  TDivisionSearchResult = Class;
  TElection = Class;
  TElectionOfficial = Class;
  TElectionsQueryResponse = Class;
  TElectoralDistrict = Class;
  TGeographicDivision = Class;
  TOffice = Class;
  TOfficial = Class;
  TPollingLocation = Class;
  TRepresentativeInfoData = Class;
  TRepresentativeInfoResponse = Class;
  TSimpleAddressType = Class;
  TSource = Class;
  TVoterInfoResponse = Class;
  TAdministrationRegionArray = Array of TAdministrationRegion;
  TAdministrativeBodyArray = Array of TAdministrativeBody;
  TCandidateArray = Array of TCandidate;
  TChannelArray = Array of TChannel;
  TContestArray = Array of TContest;
  TDivisionSearchResponseArray = Array of TDivisionSearchResponse;
  TDivisionSearchResultArray = Array of TDivisionSearchResult;
  TElectionArray = Array of TElection;
  TElectionOfficialArray = Array of TElectionOfficial;
  TElectionsQueryResponseArray = Array of TElectionsQueryResponse;
  TElectoralDistrictArray = Array of TElectoralDistrict;
  TGeographicDivisionArray = Array of TGeographicDivision;
  TOfficeArray = Array of TOffice;
  TOfficialArray = Array of TOfficial;
  TPollingLocationArray = Array of TPollingLocation;
  TRepresentativeInfoDataArray = Array of TRepresentativeInfoData;
  TRepresentativeInfoResponseArray = Array of TRepresentativeInfoResponse;
  TSimpleAddressTypeArray = Array of TSimpleAddressType;
  TSourceArray = Array of TSource;
  TVoterInfoResponseArray = Array of TVoterInfoResponse;
  //Anonymous types, using auto-generated names
  TRepresentativeInfoDataTypedivisions = Class;
  TRepresentativeInfoResponseTypedivisions = Class;
  TAdministrationRegionTypesourcesArray = Array of TSource;
  TAdministrativeBodyTypeelectionOfficialsArray = Array of TElectionOfficial;
  TCandidateTypechannelsArray = Array of TChannel;
  TContestTypecandidatesArray = Array of TCandidate;
  TContestTypesourcesArray = Array of TSource;
  TDivisionSearchResponseTyperesultsArray = Array of TDivisionSearchResult;
  TElectionsQueryResponseTypeelectionsArray = Array of TElection;
  TOfficeTypesourcesArray = Array of TSource;
  TOfficialTypeaddressArray = Array of TSimpleAddressType;
  TOfficialTypechannelsArray = Array of TChannel;
  TPollingLocationTypesourcesArray = Array of TSource;
  TRepresentativeInfoDataTypeofficesArray = Array of TOffice;
  TRepresentativeInfoDataTypeofficialsArray = Array of TOfficial;
  TRepresentativeInfoResponseTypeofficesArray = Array of TOffice;
  TRepresentativeInfoResponseTypeofficialsArray = Array of TOfficial;
  TVoterInfoResponseTypecontestsArray = Array of TContest;
  TVoterInfoResponseTypedropOffLocationsArray = Array of TPollingLocation;
  TVoterInfoResponseTypeearlyVoteSitesArray = Array of TPollingLocation;
  TVoterInfoResponseTypeotherElectionsArray = Array of TElection;
  TVoterInfoResponseTypepollingLocationsArray = Array of TPollingLocation;
  TVoterInfoResponseTypestateArray = Array of TAdministrationRegion;
  
  { --------------------------------------------------------------------
    TAdministrationRegion
    --------------------------------------------------------------------}
  
  TAdministrationRegion = Class(TGoogleBaseObject)
  Private
    FelectionAdministrationBody : TAdministrativeBody;
    Fid : String;
    Flocal_jurisdiction : TAdministrationRegion;
    Fname : String;
    Fsources : TAdministrationRegionTypesourcesArray;
  Protected
    //Property setters
    Procedure SetelectionAdministrationBody(AIndex : Integer; const AValue : TAdministrativeBody); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocal_jurisdiction(AIndex : Integer; const AValue : TAdministrationRegion); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsources(AIndex : Integer; const AValue : TAdministrationRegionTypesourcesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property electionAdministrationBody : TAdministrativeBody Index 0 Read FelectionAdministrationBody Write SetelectionAdministrationBody;
    Property id : String Index 8 Read Fid Write Setid;
    Property local_jurisdiction : TAdministrationRegion Index 16 Read Flocal_jurisdiction Write Setlocal_jurisdiction;
    Property name : String Index 24 Read Fname Write Setname;
    Property sources : TAdministrationRegionTypesourcesArray Index 32 Read Fsources Write Setsources;
  end;
  TAdministrationRegionClass = Class of TAdministrationRegion;
  
  { --------------------------------------------------------------------
    TAdministrativeBody
    --------------------------------------------------------------------}
  
  TAdministrativeBody = Class(TGoogleBaseObject)
  Private
    FabsenteeVotingInfoUrl : String;
    FballotInfoUrl : String;
    FcorrespondenceAddress : TSimpleAddressType;
    FelectionInfoUrl : String;
    FelectionOfficials : TAdministrativeBodyTypeelectionOfficialsArray;
    FelectionRegistrationConfirmationUrl : String;
    FelectionRegistrationUrl : String;
    FelectionRulesUrl : String;
    FhoursOfOperation : String;
    Fname : String;
    FphysicalAddress : TSimpleAddressType;
    Fvoter_services : TStringArray;
    FvotingLocationFinderUrl : String;
  Protected
    //Property setters
    Procedure SetabsenteeVotingInfoUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetballotInfoUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcorrespondenceAddress(AIndex : Integer; const AValue : TSimpleAddressType); virtual;
    Procedure SetelectionInfoUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetelectionOfficials(AIndex : Integer; const AValue : TAdministrativeBodyTypeelectionOfficialsArray); virtual;
    Procedure SetelectionRegistrationConfirmationUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetelectionRegistrationUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SetelectionRulesUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure SethoursOfOperation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetphysicalAddress(AIndex : Integer; const AValue : TSimpleAddressType); virtual;
    Procedure Setvoter_services(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetvotingLocationFinderUrl(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property absenteeVotingInfoUrl : String Index 0 Read FabsenteeVotingInfoUrl Write SetabsenteeVotingInfoUrl;
    Property ballotInfoUrl : String Index 8 Read FballotInfoUrl Write SetballotInfoUrl;
    Property correspondenceAddress : TSimpleAddressType Index 16 Read FcorrespondenceAddress Write SetcorrespondenceAddress;
    Property electionInfoUrl : String Index 24 Read FelectionInfoUrl Write SetelectionInfoUrl;
    Property electionOfficials : TAdministrativeBodyTypeelectionOfficialsArray Index 32 Read FelectionOfficials Write SetelectionOfficials;
    Property electionRegistrationConfirmationUrl : String Index 40 Read FelectionRegistrationConfirmationUrl Write SetelectionRegistrationConfirmationUrl;
    Property electionRegistrationUrl : String Index 48 Read FelectionRegistrationUrl Write SetelectionRegistrationUrl;
    Property electionRulesUrl : String Index 56 Read FelectionRulesUrl Write SetelectionRulesUrl;
    Property hoursOfOperation : String Index 64 Read FhoursOfOperation Write SethoursOfOperation;
    Property name : String Index 72 Read Fname Write Setname;
    Property physicalAddress : TSimpleAddressType Index 80 Read FphysicalAddress Write SetphysicalAddress;
    Property voter_services : TStringArray Index 88 Read Fvoter_services Write Setvoter_services;
    Property votingLocationFinderUrl : String Index 96 Read FvotingLocationFinderUrl Write SetvotingLocationFinderUrl;
  end;
  TAdministrativeBodyClass = Class of TAdministrativeBody;
  
  { --------------------------------------------------------------------
    TCandidate
    --------------------------------------------------------------------}
  
  TCandidate = Class(TGoogleBaseObject)
  Private
    FcandidateUrl : String;
    Fchannels : TCandidateTypechannelsArray;
    Femail : String;
    Fname : String;
    ForderOnBallot : String;
    Fparty : String;
    Fphone : String;
    FphotoUrl : String;
  Protected
    //Property setters
    Procedure SetcandidateUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setchannels(AIndex : Integer; const AValue : TCandidateTypechannelsArray); virtual;
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetorderOnBallot(AIndex : Integer; const AValue : String); virtual;
    Procedure Setparty(AIndex : Integer; const AValue : String); virtual;
    Procedure Setphone(AIndex : Integer; const AValue : String); virtual;
    Procedure SetphotoUrl(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property candidateUrl : String Index 0 Read FcandidateUrl Write SetcandidateUrl;
    Property channels : TCandidateTypechannelsArray Index 8 Read Fchannels Write Setchannels;
    Property email : String Index 16 Read Femail Write Setemail;
    Property name : String Index 24 Read Fname Write Setname;
    Property orderOnBallot : String Index 32 Read ForderOnBallot Write SetorderOnBallot;
    Property party : String Index 40 Read Fparty Write Setparty;
    Property phone : String Index 48 Read Fphone Write Setphone;
    Property photoUrl : String Index 56 Read FphotoUrl Write SetphotoUrl;
  end;
  TCandidateClass = Class of TCandidate;
  
  { --------------------------------------------------------------------
    TChannel
    --------------------------------------------------------------------}
  
  TChannel = Class(TGoogleBaseObject)
  Private
    Fid : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property _type : String Index 8 Read F_type Write Set_type;
  end;
  TChannelClass = Class of TChannel;
  
  { --------------------------------------------------------------------
    TContest
    --------------------------------------------------------------------}
  
  TContest = Class(TGoogleBaseObject)
  Private
    FballotPlacement : String;
    Fcandidates : TContestTypecandidatesArray;
    Fdistrict : TElectoralDistrict;
    FelectorateSpecifications : String;
    Fid : String;
    Flevel : TStringArray;
    FnumberElected : String;
    FnumberVotingFor : String;
    Foffice : String;
    FprimaryParty : String;
    FreferendumBallotResponses : TStringArray;
    FreferendumBrief : String;
    FreferendumConStatement : String;
    FreferendumEffectOfAbstain : String;
    FreferendumPassageThreshold : String;
    FreferendumProStatement : String;
    FreferendumSubtitle : String;
    FreferendumText : String;
    FreferendumTitle : String;
    FreferendumUrl : String;
    Froles : TStringArray;
    Fsources : TContestTypesourcesArray;
    Fspecial : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetballotPlacement(AIndex : Integer; const AValue : String); virtual;
    Procedure Setcandidates(AIndex : Integer; const AValue : TContestTypecandidatesArray); virtual;
    Procedure Setdistrict(AIndex : Integer; const AValue : TElectoralDistrict); virtual;
    Procedure SetelectorateSpecifications(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlevel(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetnumberElected(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnumberVotingFor(AIndex : Integer; const AValue : String); virtual;
    Procedure Setoffice(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprimaryParty(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumBallotResponses(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetreferendumBrief(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumConStatement(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumEffectOfAbstain(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumPassageThreshold(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumProStatement(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumSubtitle(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumText(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumTitle(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreferendumUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Setroles(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setsources(AIndex : Integer; const AValue : TContestTypesourcesArray); virtual;
    Procedure Setspecial(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property ballotPlacement : String Index 0 Read FballotPlacement Write SetballotPlacement;
    Property candidates : TContestTypecandidatesArray Index 8 Read Fcandidates Write Setcandidates;
    Property district : TElectoralDistrict Index 16 Read Fdistrict Write Setdistrict;
    Property electorateSpecifications : String Index 24 Read FelectorateSpecifications Write SetelectorateSpecifications;
    Property id : String Index 32 Read Fid Write Setid;
    Property level : TStringArray Index 40 Read Flevel Write Setlevel;
    Property numberElected : String Index 48 Read FnumberElected Write SetnumberElected;
    Property numberVotingFor : String Index 56 Read FnumberVotingFor Write SetnumberVotingFor;
    Property office : String Index 64 Read Foffice Write Setoffice;
    Property primaryParty : String Index 72 Read FprimaryParty Write SetprimaryParty;
    Property referendumBallotResponses : TStringArray Index 80 Read FreferendumBallotResponses Write SetreferendumBallotResponses;
    Property referendumBrief : String Index 88 Read FreferendumBrief Write SetreferendumBrief;
    Property referendumConStatement : String Index 96 Read FreferendumConStatement Write SetreferendumConStatement;
    Property referendumEffectOfAbstain : String Index 104 Read FreferendumEffectOfAbstain Write SetreferendumEffectOfAbstain;
    Property referendumPassageThreshold : String Index 112 Read FreferendumPassageThreshold Write SetreferendumPassageThreshold;
    Property referendumProStatement : String Index 120 Read FreferendumProStatement Write SetreferendumProStatement;
    Property referendumSubtitle : String Index 128 Read FreferendumSubtitle Write SetreferendumSubtitle;
    Property referendumText : String Index 136 Read FreferendumText Write SetreferendumText;
    Property referendumTitle : String Index 144 Read FreferendumTitle Write SetreferendumTitle;
    Property referendumUrl : String Index 152 Read FreferendumUrl Write SetreferendumUrl;
    Property roles : TStringArray Index 160 Read Froles Write Setroles;
    Property sources : TContestTypesourcesArray Index 168 Read Fsources Write Setsources;
    Property special : String Index 176 Read Fspecial Write Setspecial;
    Property _type : String Index 184 Read F_type Write Set_type;
  end;
  TContestClass = Class of TContest;
  
  { --------------------------------------------------------------------
    TDivisionSearchResponse
    --------------------------------------------------------------------}
  
  TDivisionSearchResponse = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fresults : TDivisionSearchResponseTyperesultsArray;
  Protected
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setresults(AIndex : Integer; const AValue : TDivisionSearchResponseTyperesultsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property results : TDivisionSearchResponseTyperesultsArray Index 8 Read Fresults Write Setresults;
  end;
  TDivisionSearchResponseClass = Class of TDivisionSearchResponse;
  
  { --------------------------------------------------------------------
    TDivisionSearchResult
    --------------------------------------------------------------------}
  
  TDivisionSearchResult = Class(TGoogleBaseObject)
  Private
    Faliases : TStringArray;
    Fname : String;
    FocdId : String;
  Protected
    //Property setters
    Procedure Setaliases(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetocdId(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property aliases : TStringArray Index 0 Read Faliases Write Setaliases;
    Property name : String Index 8 Read Fname Write Setname;
    Property ocdId : String Index 16 Read FocdId Write SetocdId;
  end;
  TDivisionSearchResultClass = Class of TDivisionSearchResult;
  
  { --------------------------------------------------------------------
    TElection
    --------------------------------------------------------------------}
  
  TElection = Class(TGoogleBaseObject)
  Private
    FelectionDay : String;
    Fid : String;
    Fname : String;
    FocdDivisionId : String;
  Protected
    //Property setters
    Procedure SetelectionDay(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetocdDivisionId(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property electionDay : String Index 0 Read FelectionDay Write SetelectionDay;
    Property id : String Index 8 Read Fid Write Setid;
    Property name : String Index 16 Read Fname Write Setname;
    Property ocdDivisionId : String Index 24 Read FocdDivisionId Write SetocdDivisionId;
  end;
  TElectionClass = Class of TElection;
  
  { --------------------------------------------------------------------
    TElectionOfficial
    --------------------------------------------------------------------}
  
  TElectionOfficial = Class(TGoogleBaseObject)
  Private
    FemailAddress : String;
    FfaxNumber : String;
    Fname : String;
    FofficePhoneNumber : String;
    Ftitle : String;
  Protected
    //Property setters
    Procedure SetemailAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure SetfaxNumber(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetofficePhoneNumber(AIndex : Integer; const AValue : String); virtual;
    Procedure Settitle(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property emailAddress : String Index 0 Read FemailAddress Write SetemailAddress;
    Property faxNumber : String Index 8 Read FfaxNumber Write SetfaxNumber;
    Property name : String Index 16 Read Fname Write Setname;
    Property officePhoneNumber : String Index 24 Read FofficePhoneNumber Write SetofficePhoneNumber;
    Property title : String Index 32 Read Ftitle Write Settitle;
  end;
  TElectionOfficialClass = Class of TElectionOfficial;
  
  { --------------------------------------------------------------------
    TElectionsQueryResponse
    --------------------------------------------------------------------}
  
  TElectionsQueryResponse = Class(TGoogleBaseObject)
  Private
    Felections : TElectionsQueryResponseTypeelectionsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setelections(AIndex : Integer; const AValue : TElectionsQueryResponseTypeelectionsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property elections : TElectionsQueryResponseTypeelectionsArray Index 0 Read Felections Write Setelections;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TElectionsQueryResponseClass = Class of TElectionsQueryResponse;
  
  { --------------------------------------------------------------------
    TElectoralDistrict
    --------------------------------------------------------------------}
  
  TElectoralDistrict = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fname : String;
    Fscope : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setscope(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property name : String Index 8 Read Fname Write Setname;
    Property scope : String Index 16 Read Fscope Write Setscope;
  end;
  TElectoralDistrictClass = Class of TElectoralDistrict;
  
  { --------------------------------------------------------------------
    TGeographicDivision
    --------------------------------------------------------------------}
  
  TGeographicDivision = Class(TGoogleBaseObject)
  Private
    FalsoKnownAs : TStringArray;
    Fname : String;
    FofficeIndices : TintegerArray;
  Protected
    //Property setters
    Procedure SetalsoKnownAs(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetofficeIndices(AIndex : Integer; const AValue : TintegerArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property alsoKnownAs : TStringArray Index 0 Read FalsoKnownAs Write SetalsoKnownAs;
    Property name : String Index 8 Read Fname Write Setname;
    Property officeIndices : TintegerArray Index 16 Read FofficeIndices Write SetofficeIndices;
  end;
  TGeographicDivisionClass = Class of TGeographicDivision;
  
  { --------------------------------------------------------------------
    TOffice
    --------------------------------------------------------------------}
  
  TOffice = Class(TGoogleBaseObject)
  Private
    FdivisionId : String;
    Flevels : TStringArray;
    Fname : String;
    FofficialIndices : TintegerArray;
    Froles : TStringArray;
    Fsources : TOfficeTypesourcesArray;
  Protected
    //Property setters
    Procedure SetdivisionId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlevels(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetofficialIndices(AIndex : Integer; const AValue : TintegerArray); virtual;
    Procedure Setroles(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setsources(AIndex : Integer; const AValue : TOfficeTypesourcesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property divisionId : String Index 0 Read FdivisionId Write SetdivisionId;
    Property levels : TStringArray Index 8 Read Flevels Write Setlevels;
    Property name : String Index 16 Read Fname Write Setname;
    Property officialIndices : TintegerArray Index 24 Read FofficialIndices Write SetofficialIndices;
    Property roles : TStringArray Index 32 Read Froles Write Setroles;
    Property sources : TOfficeTypesourcesArray Index 40 Read Fsources Write Setsources;
  end;
  TOfficeClass = Class of TOffice;
  
  { --------------------------------------------------------------------
    TOfficial
    --------------------------------------------------------------------}
  
  TOfficial = Class(TGoogleBaseObject)
  Private
    Faddress : TOfficialTypeaddressArray;
    Fchannels : TOfficialTypechannelsArray;
    Femails : TStringArray;
    Fname : String;
    Fparty : String;
    Fphones : TStringArray;
    FphotoUrl : String;
    Furls : TStringArray;
  Protected
    //Property setters
    Procedure Setaddress(AIndex : Integer; const AValue : TOfficialTypeaddressArray); virtual;
    Procedure Setchannels(AIndex : Integer; const AValue : TOfficialTypechannelsArray); virtual;
    Procedure Setemails(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setparty(AIndex : Integer; const AValue : String); virtual;
    Procedure Setphones(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetphotoUrl(AIndex : Integer; const AValue : String); virtual;
    Procedure Seturls(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property address : TOfficialTypeaddressArray Index 0 Read Faddress Write Setaddress;
    Property channels : TOfficialTypechannelsArray Index 8 Read Fchannels Write Setchannels;
    Property emails : TStringArray Index 16 Read Femails Write Setemails;
    Property name : String Index 24 Read Fname Write Setname;
    Property party : String Index 32 Read Fparty Write Setparty;
    Property phones : TStringArray Index 40 Read Fphones Write Setphones;
    Property photoUrl : String Index 48 Read FphotoUrl Write SetphotoUrl;
    Property urls : TStringArray Index 56 Read Furls Write Seturls;
  end;
  TOfficialClass = Class of TOfficial;
  
  { --------------------------------------------------------------------
    TPollingLocation
    --------------------------------------------------------------------}
  
  TPollingLocation = Class(TGoogleBaseObject)
  Private
    Faddress : TSimpleAddressType;
    FendDate : String;
    Fid : String;
    Fname : String;
    Fnotes : String;
    FpollingHours : String;
    Fsources : TPollingLocationTypesourcesArray;
    FstartDate : String;
    FvoterServices : String;
  Protected
    //Property setters
    Procedure Setaddress(AIndex : Integer; const AValue : TSimpleAddressType); virtual;
    Procedure SetendDate(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnotes(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpollingHours(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsources(AIndex : Integer; const AValue : TPollingLocationTypesourcesArray); virtual;
    Procedure SetstartDate(AIndex : Integer; const AValue : String); virtual;
    Procedure SetvoterServices(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property address : TSimpleAddressType Index 0 Read Faddress Write Setaddress;
    Property endDate : String Index 8 Read FendDate Write SetendDate;
    Property id : String Index 16 Read Fid Write Setid;
    Property name : String Index 24 Read Fname Write Setname;
    Property notes : String Index 32 Read Fnotes Write Setnotes;
    Property pollingHours : String Index 40 Read FpollingHours Write SetpollingHours;
    Property sources : TPollingLocationTypesourcesArray Index 48 Read Fsources Write Setsources;
    Property startDate : String Index 56 Read FstartDate Write SetstartDate;
    Property voterServices : String Index 64 Read FvoterServices Write SetvoterServices;
  end;
  TPollingLocationClass = Class of TPollingLocation;
  
  { --------------------------------------------------------------------
    TRepresentativeInfoDataTypedivisions
    --------------------------------------------------------------------}
  
  TRepresentativeInfoDataTypedivisions = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TRepresentativeInfoDataTypedivisionsClass = Class of TRepresentativeInfoDataTypedivisions;
  
  { --------------------------------------------------------------------
    TRepresentativeInfoData
    --------------------------------------------------------------------}
  
  TRepresentativeInfoData = Class(TGoogleBaseObject)
  Private
    Fdivisions : TRepresentativeInfoDataTypedivisions;
    Foffices : TRepresentativeInfoDataTypeofficesArray;
    Fofficials : TRepresentativeInfoDataTypeofficialsArray;
  Protected
    //Property setters
    Procedure Setdivisions(AIndex : Integer; const AValue : TRepresentativeInfoDataTypedivisions); virtual;
    Procedure Setoffices(AIndex : Integer; const AValue : TRepresentativeInfoDataTypeofficesArray); virtual;
    Procedure Setofficials(AIndex : Integer; const AValue : TRepresentativeInfoDataTypeofficialsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property divisions : TRepresentativeInfoDataTypedivisions Index 0 Read Fdivisions Write Setdivisions;
    Property offices : TRepresentativeInfoDataTypeofficesArray Index 8 Read Foffices Write Setoffices;
    Property officials : TRepresentativeInfoDataTypeofficialsArray Index 16 Read Fofficials Write Setofficials;
  end;
  TRepresentativeInfoDataClass = Class of TRepresentativeInfoData;
  
  { --------------------------------------------------------------------
    TRepresentativeInfoResponseTypedivisions
    --------------------------------------------------------------------}
  
  TRepresentativeInfoResponseTypedivisions = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TRepresentativeInfoResponseTypedivisionsClass = Class of TRepresentativeInfoResponseTypedivisions;
  
  { --------------------------------------------------------------------
    TRepresentativeInfoResponse
    --------------------------------------------------------------------}
  
  TRepresentativeInfoResponse = Class(TGoogleBaseObject)
  Private
    Fdivisions : TRepresentativeInfoResponseTypedivisions;
    Fkind : String;
    FnormalizedInput : TSimpleAddressType;
    Foffices : TRepresentativeInfoResponseTypeofficesArray;
    Fofficials : TRepresentativeInfoResponseTypeofficialsArray;
  Protected
    //Property setters
    Procedure Setdivisions(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypedivisions); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnormalizedInput(AIndex : Integer; const AValue : TSimpleAddressType); virtual;
    Procedure Setoffices(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypeofficesArray); virtual;
    Procedure Setofficials(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypeofficialsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property divisions : TRepresentativeInfoResponseTypedivisions Index 0 Read Fdivisions Write Setdivisions;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property normalizedInput : TSimpleAddressType Index 16 Read FnormalizedInput Write SetnormalizedInput;
    Property offices : TRepresentativeInfoResponseTypeofficesArray Index 24 Read Foffices Write Setoffices;
    Property officials : TRepresentativeInfoResponseTypeofficialsArray Index 32 Read Fofficials Write Setofficials;
  end;
  TRepresentativeInfoResponseClass = Class of TRepresentativeInfoResponse;
  
  { --------------------------------------------------------------------
    TSimpleAddressType
    --------------------------------------------------------------------}
  
  TSimpleAddressType = Class(TGoogleBaseObject)
  Private
    Fcity : String;
    Fline1 : String;
    Fline2 : String;
    Fline3 : String;
    FlocationName : String;
    Fstate : String;
    Fzip : String;
  Protected
    //Property setters
    Procedure Setcity(AIndex : Integer; const AValue : String); virtual;
    Procedure Setline1(AIndex : Integer; const AValue : String); virtual;
    Procedure Setline2(AIndex : Integer; const AValue : String); virtual;
    Procedure Setline3(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlocationName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstate(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzip(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property city : String Index 0 Read Fcity Write Setcity;
    Property line1 : String Index 8 Read Fline1 Write Setline1;
    Property line2 : String Index 16 Read Fline2 Write Setline2;
    Property line3 : String Index 24 Read Fline3 Write Setline3;
    Property locationName : String Index 32 Read FlocationName Write SetlocationName;
    Property state : String Index 40 Read Fstate Write Setstate;
    Property zip : String Index 48 Read Fzip Write Setzip;
  end;
  TSimpleAddressTypeClass = Class of TSimpleAddressType;
  
  { --------------------------------------------------------------------
    TSource
    --------------------------------------------------------------------}
  
  TSource = Class(TGoogleBaseObject)
  Private
    Fname : String;
    Fofficial : boolean;
  Protected
    //Property setters
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setofficial(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property name : String Index 0 Read Fname Write Setname;
    Property official : boolean Index 8 Read Fofficial Write Setofficial;
  end;
  TSourceClass = Class of TSource;
  
  { --------------------------------------------------------------------
    TVoterInfoResponse
    --------------------------------------------------------------------}
  
  TVoterInfoResponse = Class(TGoogleBaseObject)
  Private
    Fcontests : TVoterInfoResponseTypecontestsArray;
    FdropOffLocations : TVoterInfoResponseTypedropOffLocationsArray;
    FearlyVoteSites : TVoterInfoResponseTypeearlyVoteSitesArray;
    Felection : TElection;
    Fkind : String;
    FmailOnly : boolean;
    FnormalizedInput : TSimpleAddressType;
    FotherElections : TVoterInfoResponseTypeotherElectionsArray;
    FpollingLocations : TVoterInfoResponseTypepollingLocationsArray;
    FprecinctId : String;
    Fstate : TVoterInfoResponseTypestateArray;
  Protected
    //Property setters
    Procedure Setcontests(AIndex : Integer; const AValue : TVoterInfoResponseTypecontestsArray); virtual;
    Procedure SetdropOffLocations(AIndex : Integer; const AValue : TVoterInfoResponseTypedropOffLocationsArray); virtual;
    Procedure SetearlyVoteSites(AIndex : Integer; const AValue : TVoterInfoResponseTypeearlyVoteSitesArray); virtual;
    Procedure Setelection(AIndex : Integer; const AValue : TElection); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmailOnly(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetnormalizedInput(AIndex : Integer; const AValue : TSimpleAddressType); virtual;
    Procedure SetotherElections(AIndex : Integer; const AValue : TVoterInfoResponseTypeotherElectionsArray); virtual;
    Procedure SetpollingLocations(AIndex : Integer; const AValue : TVoterInfoResponseTypepollingLocationsArray); virtual;
    Procedure SetprecinctId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstate(AIndex : Integer; const AValue : TVoterInfoResponseTypestateArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property contests : TVoterInfoResponseTypecontestsArray Index 0 Read Fcontests Write Setcontests;
    Property dropOffLocations : TVoterInfoResponseTypedropOffLocationsArray Index 8 Read FdropOffLocations Write SetdropOffLocations;
    Property earlyVoteSites : TVoterInfoResponseTypeearlyVoteSitesArray Index 16 Read FearlyVoteSites Write SetearlyVoteSites;
    Property election : TElection Index 24 Read Felection Write Setelection;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property mailOnly : boolean Index 40 Read FmailOnly Write SetmailOnly;
    Property normalizedInput : TSimpleAddressType Index 48 Read FnormalizedInput Write SetnormalizedInput;
    Property otherElections : TVoterInfoResponseTypeotherElectionsArray Index 56 Read FotherElections Write SetotherElections;
    Property pollingLocations : TVoterInfoResponseTypepollingLocationsArray Index 64 Read FpollingLocations Write SetpollingLocations;
    Property precinctId : String Index 72 Read FprecinctId Write SetprecinctId;
    Property state : TVoterInfoResponseTypestateArray Index 80 Read Fstate Write Setstate;
  end;
  TVoterInfoResponseClass = Class of TVoterInfoResponse;
  
  { --------------------------------------------------------------------
    TDivisionsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TDivisionsResource, method Search
  
  TDivisionsSearchOptions = Record
    query : String;
  end;
  
  TDivisionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Search(AQuery : string  = '') : TDivisionSearchResponse;
    Function Search(AQuery : TDivisionssearchOptions) : TDivisionSearchResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TElectionsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TElectionsResource, method VoterInfoQuery
  
  TElectionsVoterInfoQueryOptions = Record
    address : String;
    electionId : int64;
    officialOnly : boolean;
  end;
  
  TElectionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function ElectionQuery : TElectionsQueryResponse;
    Function VoterInfoQuery(AQuery : string  = '') : TVoterInfoResponse;
    Function VoterInfoQuery(AQuery : TElectionsvoterInfoQueryOptions) : TVoterInfoResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TRepresentativesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TRepresentativesResource, method RepresentativeInfoByAddress
  
  TRepresentativesRepresentativeInfoByAddressOptions = Record
    address : String;
    includeOffices : boolean;
    levels : String;
    roles : String;
  end;
  
  
  //Optional query Options for TRepresentativesResource, method RepresentativeInfoByDivision
  
  TRepresentativesRepresentativeInfoByDivisionOptions = Record
    levels : String;
    recursive : boolean;
    roles : String;
  end;
  
  TRepresentativesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function RepresentativeInfoByAddress(AQuery : string  = '') : TRepresentativeInfoResponse;
    Function RepresentativeInfoByAddress(AQuery : TRepresentativesrepresentativeInfoByAddressOptions) : TRepresentativeInfoResponse;
    Function RepresentativeInfoByDivision(ocdId: string; AQuery : string  = '') : TRepresentativeInfoData;
    Function RepresentativeInfoByDivision(ocdId: string; AQuery : TRepresentativesrepresentativeInfoByDivisionOptions) : TRepresentativeInfoData;
  end;
  
  
  { --------------------------------------------------------------------
    TCivicinfoAPI
    --------------------------------------------------------------------}
  
  TCivicinfoAPI = Class(TGoogleAPI)
  Private
    FDivisionsInstance : TDivisionsResource;
    FElectionsInstance : TElectionsResource;
    FRepresentativesInstance : TRepresentativesResource;
    Function GetDivisionsInstance : TDivisionsResource;virtual;
    Function GetElectionsInstance : TElectionsResource;virtual;
    Function GetRepresentativesInstance : TRepresentativesResource;virtual;
  Public
    //Override class functions with API info
    Class Function APIName : String; override;
    Class Function APIVersion : String; override;
    Class Function APIRevision : String; override;
    Class Function APIID : String; override;
    Class Function APITitle : String; override;
    Class Function APIDescription : String; override;
    Class Function APIOwnerDomain : String; override;
    Class Function APIOwnerName : String; override;
    Class Function APIIcon16 : String; override;
    Class Function APIIcon32 : String; override;
    Class Function APIdocumentationLink : String; override;
    Class Function APIrootUrl : string; override;
    Class Function APIbasePath : string;override;
    Class Function APIbaseURL : String;override;
    Class Function APIProtocol : string;override;
    Class Function APIservicePath : string;override;
    Class Function APIbatchPath : String;override;
    Class Function APIAuthScopes : TScopeInfoArray;override;
    Class Function APINeedsAuth : Boolean;override;
    Class Procedure RegisterAPIResources; override;
    //Add create function for resources
    Function CreateDivisionsResource(AOwner : TComponent) : TDivisionsResource;virtual;overload;
    Function CreateDivisionsResource : TDivisionsResource;virtual;overload;
    Function CreateElectionsResource(AOwner : TComponent) : TElectionsResource;virtual;overload;
    Function CreateElectionsResource : TElectionsResource;virtual;overload;
    Function CreateRepresentativesResource(AOwner : TComponent) : TRepresentativesResource;virtual;overload;
    Function CreateRepresentativesResource : TRepresentativesResource;virtual;overload;
    //Add default on-demand instances for resources
    Property DivisionsResource : TDivisionsResource Read GetDivisionsInstance;
    Property ElectionsResource : TElectionsResource Read GetElectionsInstance;
    Property RepresentativesResource : TRepresentativesResource Read GetRepresentativesInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAdministrationRegion
  --------------------------------------------------------------------}


Procedure TAdministrationRegion.SetelectionAdministrationBody(AIndex : Integer; const AValue : TAdministrativeBody); 

begin
  If (FelectionAdministrationBody=AValue) then exit;
  FelectionAdministrationBody:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrationRegion.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrationRegion.Setlocal_jurisdiction(AIndex : Integer; const AValue : TAdministrationRegion); 

begin
  If (Flocal_jurisdiction=AValue) then exit;
  Flocal_jurisdiction:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrationRegion.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrationRegion.Setsources(AIndex : Integer; const AValue : TAdministrationRegionTypesourcesArray); 

begin
  If (Fsources=AValue) then exit;
  Fsources:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAdministrationRegion.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'sources' : SetLength(Fsources,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAdministrativeBody
  --------------------------------------------------------------------}


Procedure TAdministrativeBody.SetabsenteeVotingInfoUrl(AIndex : Integer; const AValue : String); 

begin
  If (FabsenteeVotingInfoUrl=AValue) then exit;
  FabsenteeVotingInfoUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetballotInfoUrl(AIndex : Integer; const AValue : String); 

begin
  If (FballotInfoUrl=AValue) then exit;
  FballotInfoUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetcorrespondenceAddress(AIndex : Integer; const AValue : TSimpleAddressType); 

begin
  If (FcorrespondenceAddress=AValue) then exit;
  FcorrespondenceAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetelectionInfoUrl(AIndex : Integer; const AValue : String); 

begin
  If (FelectionInfoUrl=AValue) then exit;
  FelectionInfoUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetelectionOfficials(AIndex : Integer; const AValue : TAdministrativeBodyTypeelectionOfficialsArray); 

begin
  If (FelectionOfficials=AValue) then exit;
  FelectionOfficials:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetelectionRegistrationConfirmationUrl(AIndex : Integer; const AValue : String); 

begin
  If (FelectionRegistrationConfirmationUrl=AValue) then exit;
  FelectionRegistrationConfirmationUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetelectionRegistrationUrl(AIndex : Integer; const AValue : String); 

begin
  If (FelectionRegistrationUrl=AValue) then exit;
  FelectionRegistrationUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetelectionRulesUrl(AIndex : Integer; const AValue : String); 

begin
  If (FelectionRulesUrl=AValue) then exit;
  FelectionRulesUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SethoursOfOperation(AIndex : Integer; const AValue : String); 

begin
  If (FhoursOfOperation=AValue) then exit;
  FhoursOfOperation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetphysicalAddress(AIndex : Integer; const AValue : TSimpleAddressType); 

begin
  If (FphysicalAddress=AValue) then exit;
  FphysicalAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.Setvoter_services(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fvoter_services=AValue) then exit;
  Fvoter_services:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAdministrativeBody.SetvotingLocationFinderUrl(AIndex : Integer; const AValue : String); 

begin
  If (FvotingLocationFinderUrl=AValue) then exit;
  FvotingLocationFinderUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAdministrativeBody.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'electionofficials' : SetLength(FelectionOfficials,ALength);
  'voter_services' : SetLength(Fvoter_services,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TCandidate
  --------------------------------------------------------------------}


Procedure TCandidate.SetcandidateUrl(AIndex : Integer; const AValue : String); 

begin
  If (FcandidateUrl=AValue) then exit;
  FcandidateUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.Setchannels(AIndex : Integer; const AValue : TCandidateTypechannelsArray); 

begin
  If (Fchannels=AValue) then exit;
  Fchannels:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.SetorderOnBallot(AIndex : Integer; const AValue : String); 

begin
  If (ForderOnBallot=AValue) then exit;
  ForderOnBallot:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.Setparty(AIndex : Integer; const AValue : String); 

begin
  If (Fparty=AValue) then exit;
  Fparty:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.Setphone(AIndex : Integer; const AValue : String); 

begin
  If (Fphone=AValue) then exit;
  Fphone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TCandidate.SetphotoUrl(AIndex : Integer; const AValue : String); 

begin
  If (FphotoUrl=AValue) then exit;
  FphotoUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TCandidate.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'channels' : SetLength(Fchannels,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TChannel
  --------------------------------------------------------------------}


Procedure TChannel.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TChannel.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TChannel.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TContest
  --------------------------------------------------------------------}


Procedure TContest.SetballotPlacement(AIndex : Integer; const AValue : String); 

begin
  If (FballotPlacement=AValue) then exit;
  FballotPlacement:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setcandidates(AIndex : Integer; const AValue : TContestTypecandidatesArray); 

begin
  If (Fcandidates=AValue) then exit;
  Fcandidates:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setdistrict(AIndex : Integer; const AValue : TElectoralDistrict); 

begin
  If (Fdistrict=AValue) then exit;
  Fdistrict:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetelectorateSpecifications(AIndex : Integer; const AValue : String); 

begin
  If (FelectorateSpecifications=AValue) then exit;
  FelectorateSpecifications:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setlevel(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flevel=AValue) then exit;
  Flevel:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetnumberElected(AIndex : Integer; const AValue : String); 

begin
  If (FnumberElected=AValue) then exit;
  FnumberElected:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetnumberVotingFor(AIndex : Integer; const AValue : String); 

begin
  If (FnumberVotingFor=AValue) then exit;
  FnumberVotingFor:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setoffice(AIndex : Integer; const AValue : String); 

begin
  If (Foffice=AValue) then exit;
  Foffice:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetprimaryParty(AIndex : Integer; const AValue : String); 

begin
  If (FprimaryParty=AValue) then exit;
  FprimaryParty:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumBallotResponses(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FreferendumBallotResponses=AValue) then exit;
  FreferendumBallotResponses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumBrief(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumBrief=AValue) then exit;
  FreferendumBrief:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumConStatement(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumConStatement=AValue) then exit;
  FreferendumConStatement:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumEffectOfAbstain(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumEffectOfAbstain=AValue) then exit;
  FreferendumEffectOfAbstain:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumPassageThreshold(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumPassageThreshold=AValue) then exit;
  FreferendumPassageThreshold:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumProStatement(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumProStatement=AValue) then exit;
  FreferendumProStatement:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumSubtitle(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumSubtitle=AValue) then exit;
  FreferendumSubtitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumText(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumText=AValue) then exit;
  FreferendumText:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumTitle(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumTitle=AValue) then exit;
  FreferendumTitle:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.SetreferendumUrl(AIndex : Integer; const AValue : String); 

begin
  If (FreferendumUrl=AValue) then exit;
  FreferendumUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setroles(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Froles=AValue) then exit;
  Froles:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setsources(AIndex : Integer; const AValue : TContestTypesourcesArray); 

begin
  If (Fsources=AValue) then exit;
  Fsources:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Setspecial(AIndex : Integer; const AValue : String); 

begin
  If (Fspecial=AValue) then exit;
  Fspecial:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TContest.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TContest.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TContest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'candidates' : SetLength(Fcandidates,ALength);
  'level' : SetLength(Flevel,ALength);
  'referendumballotresponses' : SetLength(FreferendumBallotResponses,ALength);
  'roles' : SetLength(Froles,ALength);
  'sources' : SetLength(Fsources,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDivisionSearchResponse
  --------------------------------------------------------------------}


Procedure TDivisionSearchResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDivisionSearchResponse.Setresults(AIndex : Integer; const AValue : TDivisionSearchResponseTyperesultsArray); 

begin
  If (Fresults=AValue) then exit;
  Fresults:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDivisionSearchResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'results' : SetLength(Fresults,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDivisionSearchResult
  --------------------------------------------------------------------}


Procedure TDivisionSearchResult.Setaliases(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Faliases=AValue) then exit;
  Faliases:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDivisionSearchResult.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDivisionSearchResult.SetocdId(AIndex : Integer; const AValue : String); 

begin
  If (FocdId=AValue) then exit;
  FocdId:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDivisionSearchResult.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'aliases' : SetLength(Faliases,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TElection
  --------------------------------------------------------------------}


Procedure TElection.SetelectionDay(AIndex : Integer; const AValue : String); 

begin
  If (FelectionDay=AValue) then exit;
  FelectionDay:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElection.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElection.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElection.SetocdDivisionId(AIndex : Integer; const AValue : String); 

begin
  If (FocdDivisionId=AValue) then exit;
  FocdDivisionId:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TElectionOfficial
  --------------------------------------------------------------------}


Procedure TElectionOfficial.SetemailAddress(AIndex : Integer; const AValue : String); 

begin
  If (FemailAddress=AValue) then exit;
  FemailAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectionOfficial.SetfaxNumber(AIndex : Integer; const AValue : String); 

begin
  If (FfaxNumber=AValue) then exit;
  FfaxNumber:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectionOfficial.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectionOfficial.SetofficePhoneNumber(AIndex : Integer; const AValue : String); 

begin
  If (FofficePhoneNumber=AValue) then exit;
  FofficePhoneNumber:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectionOfficial.Settitle(AIndex : Integer; const AValue : String); 

begin
  If (Ftitle=AValue) then exit;
  Ftitle:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TElectionsQueryResponse
  --------------------------------------------------------------------}


Procedure TElectionsQueryResponse.Setelections(AIndex : Integer; const AValue : TElectionsQueryResponseTypeelectionsArray); 

begin
  If (Felections=AValue) then exit;
  Felections:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectionsQueryResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TElectionsQueryResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'elections' : SetLength(Felections,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TElectoralDistrict
  --------------------------------------------------------------------}


Procedure TElectoralDistrict.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectoralDistrict.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TElectoralDistrict.Setscope(AIndex : Integer; const AValue : String); 

begin
  If (Fscope=AValue) then exit;
  Fscope:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TGeographicDivision
  --------------------------------------------------------------------}


Procedure TGeographicDivision.SetalsoKnownAs(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FalsoKnownAs=AValue) then exit;
  FalsoKnownAs:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGeographicDivision.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TGeographicDivision.SetofficeIndices(AIndex : Integer; const AValue : TintegerArray); 

begin
  If (FofficeIndices=AValue) then exit;
  FofficeIndices:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TGeographicDivision.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'alsoknownas' : SetLength(FalsoKnownAs,ALength);
  'officeindices' : SetLength(FofficeIndices,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOffice
  --------------------------------------------------------------------}


Procedure TOffice.SetdivisionId(AIndex : Integer; const AValue : String); 

begin
  If (FdivisionId=AValue) then exit;
  FdivisionId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOffice.Setlevels(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flevels=AValue) then exit;
  Flevels:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOffice.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOffice.SetofficialIndices(AIndex : Integer; const AValue : TintegerArray); 

begin
  If (FofficialIndices=AValue) then exit;
  FofficialIndices:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOffice.Setroles(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Froles=AValue) then exit;
  Froles:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOffice.Setsources(AIndex : Integer; const AValue : TOfficeTypesourcesArray); 

begin
  If (Fsources=AValue) then exit;
  Fsources:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOffice.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'levels' : SetLength(Flevels,ALength);
  'officialindices' : SetLength(FofficialIndices,ALength);
  'roles' : SetLength(Froles,ALength);
  'sources' : SetLength(Fsources,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOfficial
  --------------------------------------------------------------------}


Procedure TOfficial.Setaddress(AIndex : Integer; const AValue : TOfficialTypeaddressArray); 

begin
  If (Faddress=AValue) then exit;
  Faddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Setchannels(AIndex : Integer; const AValue : TOfficialTypechannelsArray); 

begin
  If (Fchannels=AValue) then exit;
  Fchannels:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Setemails(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Femails=AValue) then exit;
  Femails:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Setparty(AIndex : Integer; const AValue : String); 

begin
  If (Fparty=AValue) then exit;
  Fparty:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Setphones(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fphones=AValue) then exit;
  Fphones:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.SetphotoUrl(AIndex : Integer; const AValue : String); 

begin
  If (FphotoUrl=AValue) then exit;
  FphotoUrl:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOfficial.Seturls(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Furls=AValue) then exit;
  Furls:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOfficial.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'address' : SetLength(Faddress,ALength);
  'channels' : SetLength(Fchannels,ALength);
  'emails' : SetLength(Femails,ALength);
  'phones' : SetLength(Fphones,ALength);
  'urls' : SetLength(Furls,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TPollingLocation
  --------------------------------------------------------------------}


Procedure TPollingLocation.Setaddress(AIndex : Integer; const AValue : TSimpleAddressType); 

begin
  If (Faddress=AValue) then exit;
  Faddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.SetendDate(AIndex : Integer; const AValue : String); 

begin
  If (FendDate=AValue) then exit;
  FendDate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.Setnotes(AIndex : Integer; const AValue : String); 

begin
  If (Fnotes=AValue) then exit;
  Fnotes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.SetpollingHours(AIndex : Integer; const AValue : String); 

begin
  If (FpollingHours=AValue) then exit;
  FpollingHours:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.Setsources(AIndex : Integer; const AValue : TPollingLocationTypesourcesArray); 

begin
  If (Fsources=AValue) then exit;
  Fsources:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.SetstartDate(AIndex : Integer; const AValue : String); 

begin
  If (FstartDate=AValue) then exit;
  FstartDate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPollingLocation.SetvoterServices(AIndex : Integer; const AValue : String); 

begin
  If (FvoterServices=AValue) then exit;
  FvoterServices:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TPollingLocation.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'sources' : SetLength(Fsources,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TRepresentativeInfoDataTypedivisions
  --------------------------------------------------------------------}


Class Function TRepresentativeInfoDataTypedivisions.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TRepresentativeInfoData
  --------------------------------------------------------------------}


Procedure TRepresentativeInfoData.Setdivisions(AIndex : Integer; const AValue : TRepresentativeInfoDataTypedivisions); 

begin
  If (Fdivisions=AValue) then exit;
  Fdivisions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoData.Setoffices(AIndex : Integer; const AValue : TRepresentativeInfoDataTypeofficesArray); 

begin
  If (Foffices=AValue) then exit;
  Foffices:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoData.Setofficials(AIndex : Integer; const AValue : TRepresentativeInfoDataTypeofficialsArray); 

begin
  If (Fofficials=AValue) then exit;
  Fofficials:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRepresentativeInfoData.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'offices' : SetLength(Foffices,ALength);
  'officials' : SetLength(Fofficials,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TRepresentativeInfoResponseTypedivisions
  --------------------------------------------------------------------}


Class Function TRepresentativeInfoResponseTypedivisions.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TRepresentativeInfoResponse
  --------------------------------------------------------------------}


Procedure TRepresentativeInfoResponse.Setdivisions(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypedivisions); 

begin
  If (Fdivisions=AValue) then exit;
  Fdivisions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoResponse.SetnormalizedInput(AIndex : Integer; const AValue : TSimpleAddressType); 

begin
  If (FnormalizedInput=AValue) then exit;
  FnormalizedInput:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoResponse.Setoffices(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypeofficesArray); 

begin
  If (Foffices=AValue) then exit;
  Foffices:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRepresentativeInfoResponse.Setofficials(AIndex : Integer; const AValue : TRepresentativeInfoResponseTypeofficialsArray); 

begin
  If (Fofficials=AValue) then exit;
  Fofficials:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRepresentativeInfoResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'offices' : SetLength(Foffices,ALength);
  'officials' : SetLength(Fofficials,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSimpleAddressType
  --------------------------------------------------------------------}


Procedure TSimpleAddressType.Setcity(AIndex : Integer; const AValue : String); 

begin
  If (Fcity=AValue) then exit;
  Fcity:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.Setline1(AIndex : Integer; const AValue : String); 

begin
  If (Fline1=AValue) then exit;
  Fline1:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.Setline2(AIndex : Integer; const AValue : String); 

begin
  If (Fline2=AValue) then exit;
  Fline2:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.Setline3(AIndex : Integer; const AValue : String); 

begin
  If (Fline3=AValue) then exit;
  Fline3:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.SetlocationName(AIndex : Integer; const AValue : String); 

begin
  If (FlocationName=AValue) then exit;
  FlocationName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.Setstate(AIndex : Integer; const AValue : String); 

begin
  If (Fstate=AValue) then exit;
  Fstate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSimpleAddressType.Setzip(AIndex : Integer; const AValue : String); 

begin
  If (Fzip=AValue) then exit;
  Fzip:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSource
  --------------------------------------------------------------------}


Procedure TSource.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSource.Setofficial(AIndex : Integer; const AValue : boolean); 

begin
  If (Fofficial=AValue) then exit;
  Fofficial:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TVoterInfoResponse
  --------------------------------------------------------------------}


Procedure TVoterInfoResponse.Setcontests(AIndex : Integer; const AValue : TVoterInfoResponseTypecontestsArray); 

begin
  If (Fcontests=AValue) then exit;
  Fcontests:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetdropOffLocations(AIndex : Integer; const AValue : TVoterInfoResponseTypedropOffLocationsArray); 

begin
  If (FdropOffLocations=AValue) then exit;
  FdropOffLocations:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetearlyVoteSites(AIndex : Integer; const AValue : TVoterInfoResponseTypeearlyVoteSitesArray); 

begin
  If (FearlyVoteSites=AValue) then exit;
  FearlyVoteSites:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.Setelection(AIndex : Integer; const AValue : TElection); 

begin
  If (Felection=AValue) then exit;
  Felection:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetmailOnly(AIndex : Integer; const AValue : boolean); 

begin
  If (FmailOnly=AValue) then exit;
  FmailOnly:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetnormalizedInput(AIndex : Integer; const AValue : TSimpleAddressType); 

begin
  If (FnormalizedInput=AValue) then exit;
  FnormalizedInput:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetotherElections(AIndex : Integer; const AValue : TVoterInfoResponseTypeotherElectionsArray); 

begin
  If (FotherElections=AValue) then exit;
  FotherElections:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetpollingLocations(AIndex : Integer; const AValue : TVoterInfoResponseTypepollingLocationsArray); 

begin
  If (FpollingLocations=AValue) then exit;
  FpollingLocations:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.SetprecinctId(AIndex : Integer; const AValue : String); 

begin
  If (FprecinctId=AValue) then exit;
  FprecinctId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVoterInfoResponse.Setstate(AIndex : Integer; const AValue : TVoterInfoResponseTypestateArray); 

begin
  If (Fstate=AValue) then exit;
  Fstate:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TVoterInfoResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'contests' : SetLength(Fcontests,ALength);
  'dropofflocations' : SetLength(FdropOffLocations,ALength);
  'earlyvotesites' : SetLength(FearlyVoteSites,ALength);
  'otherelections' : SetLength(FotherElections,ALength);
  'pollinglocations' : SetLength(FpollingLocations,ALength);
  'state' : SetLength(Fstate,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDivisionsResource
  --------------------------------------------------------------------}


Class Function TDivisionsResource.ResourceName : String;

begin
  Result:='divisions';
end;

Class Function TDivisionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcivicinfoAPI;
end;

Function TDivisionsResource.Search(AQuery : string = '') : TDivisionSearchResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'divisions';
  _Methodid   = 'civicinfo.divisions.search';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TDivisionSearchResponse) as TDivisionSearchResponse;
end;


Function TDivisionsResource.Search(AQuery : TDivisionssearchOptions) : TDivisionSearchResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'query',AQuery.query);
  Result:=Search(_Q);
end;



{ --------------------------------------------------------------------
  TElectionsResource
  --------------------------------------------------------------------}


Class Function TElectionsResource.ResourceName : String;

begin
  Result:='elections';
end;

Class Function TElectionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcivicinfoAPI;
end;

Function TElectionsResource.ElectionQuery : TElectionsQueryResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'elections';
  _Methodid   = 'civicinfo.elections.electionQuery';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,'',Nil,TElectionsQueryResponse) as TElectionsQueryResponse;
end;

Function TElectionsResource.VoterInfoQuery(AQuery : string = '') : TVoterInfoResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'voterinfo';
  _Methodid   = 'civicinfo.elections.voterInfoQuery';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TVoterInfoResponse) as TVoterInfoResponse;
end;


Function TElectionsResource.VoterInfoQuery(AQuery : TElectionsvoterInfoQueryOptions) : TVoterInfoResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'address',AQuery.address);
  AddToQuery(_Q,'electionId',AQuery.electionId);
  AddToQuery(_Q,'officialOnly',AQuery.officialOnly);
  Result:=VoterInfoQuery(_Q);
end;



{ --------------------------------------------------------------------
  TRepresentativesResource
  --------------------------------------------------------------------}


Class Function TRepresentativesResource.ResourceName : String;

begin
  Result:='representatives';
end;

Class Function TRepresentativesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcivicinfoAPI;
end;

Function TRepresentativesResource.RepresentativeInfoByAddress(AQuery : string = '') : TRepresentativeInfoResponse;

Const
  _HTTPMethod = 'GET';
  _Path       = 'representatives';
  _Methodid   = 'civicinfo.representatives.representativeInfoByAddress';

begin
  Result:=ServiceCall(_HTTPMethod,_Path,AQuery,Nil,TRepresentativeInfoResponse) as TRepresentativeInfoResponse;
end;


Function TRepresentativesResource.RepresentativeInfoByAddress(AQuery : TRepresentativesrepresentativeInfoByAddressOptions) : TRepresentativeInfoResponse;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'address',AQuery.address);
  AddToQuery(_Q,'includeOffices',AQuery.includeOffices);
  AddToQuery(_Q,'levels',AQuery.levels);
  AddToQuery(_Q,'roles',AQuery.roles);
  Result:=RepresentativeInfoByAddress(_Q);
end;

Function TRepresentativesResource.RepresentativeInfoByDivision(ocdId: string; AQuery : string = '') : TRepresentativeInfoData;

Const
  _HTTPMethod = 'GET';
  _Path       = 'representatives/{ocdId}';
  _Methodid   = 'civicinfo.representatives.representativeInfoByDivision';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['ocdId',ocdId]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TRepresentativeInfoData) as TRepresentativeInfoData;
end;


Function TRepresentativesResource.RepresentativeInfoByDivision(ocdId: string; AQuery : TRepresentativesrepresentativeInfoByDivisionOptions) : TRepresentativeInfoData;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'levels',AQuery.levels);
  AddToQuery(_Q,'recursive',AQuery.recursive);
  AddToQuery(_Q,'roles',AQuery.roles);
  Result:=RepresentativeInfoByDivision(ocdId,_Q);
end;



{ --------------------------------------------------------------------
  TCivicinfoAPI
  --------------------------------------------------------------------}

Class Function TCivicinfoAPI.APIName : String;

begin
  Result:='civicinfo';
end;

Class Function TCivicinfoAPI.APIVersion : String;

begin
  Result:='v2';
end;

Class Function TCivicinfoAPI.APIRevision : String;

begin
  Result:='20150820';
end;

Class Function TCivicinfoAPI.APIID : String;

begin
  Result:='civicinfo:v2';
end;

Class Function TCivicinfoAPI.APITitle : String;

begin
  Result:='Google Civic Information API';
end;

Class Function TCivicinfoAPI.APIDescription : String;

begin
  Result:='An API for accessing civic information.';
end;

Class Function TCivicinfoAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TCivicinfoAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TCivicinfoAPI.APIIcon16 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-16.gif';
end;

Class Function TCivicinfoAPI.APIIcon32 : String;

begin
  Result:='http://www.google.com/images/icons/product/search-32.gif';
end;

Class Function TCivicinfoAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/civic-information';
end;

Class Function TCivicinfoAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TCivicinfoAPI.APIbasePath : string;

begin
  Result:='/civicinfo/v2/';
end;

Class Function TCivicinfoAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/civicinfo/v2/';
end;

Class Function TCivicinfoAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TCivicinfoAPI.APIservicePath : string;

begin
  Result:='civicinfo/v2/';
end;

Class Function TCivicinfoAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TCivicinfoAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,0);
  
end;

Class Function TCivicinfoAPI.APINeedsAuth : Boolean;

begin
  Result:=False;
end;

Class Procedure TCivicinfoAPI.RegisterAPIResources;

begin
  TAdministrationRegion.RegisterObject;
  TAdministrativeBody.RegisterObject;
  TCandidate.RegisterObject;
  TChannel.RegisterObject;
  TContest.RegisterObject;
  TDivisionSearchResponse.RegisterObject;
  TDivisionSearchResult.RegisterObject;
  TElection.RegisterObject;
  TElectionOfficial.RegisterObject;
  TElectionsQueryResponse.RegisterObject;
  TElectoralDistrict.RegisterObject;
  TGeographicDivision.RegisterObject;
  TOffice.RegisterObject;
  TOfficial.RegisterObject;
  TPollingLocation.RegisterObject;
  TRepresentativeInfoDataTypedivisions.RegisterObject;
  TRepresentativeInfoData.RegisterObject;
  TRepresentativeInfoResponseTypedivisions.RegisterObject;
  TRepresentativeInfoResponse.RegisterObject;
  TSimpleAddressType.RegisterObject;
  TSource.RegisterObject;
  TVoterInfoResponse.RegisterObject;
end;


Function TCivicinfoAPI.GetDivisionsInstance : TDivisionsResource;

begin
  if (FDivisionsInstance=Nil) then
    FDivisionsInstance:=CreateDivisionsResource;
  Result:=FDivisionsInstance;
end;

Function TCivicinfoAPI.CreateDivisionsResource : TDivisionsResource;

begin
  Result:=CreateDivisionsResource(Self);
end;


Function TCivicinfoAPI.CreateDivisionsResource(AOwner : TComponent) : TDivisionsResource;

begin
  Result:=TDivisionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCivicinfoAPI.GetElectionsInstance : TElectionsResource;

begin
  if (FElectionsInstance=Nil) then
    FElectionsInstance:=CreateElectionsResource;
  Result:=FElectionsInstance;
end;

Function TCivicinfoAPI.CreateElectionsResource : TElectionsResource;

begin
  Result:=CreateElectionsResource(Self);
end;


Function TCivicinfoAPI.CreateElectionsResource(AOwner : TComponent) : TElectionsResource;

begin
  Result:=TElectionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TCivicinfoAPI.GetRepresentativesInstance : TRepresentativesResource;

begin
  if (FRepresentativesInstance=Nil) then
    FRepresentativesInstance:=CreateRepresentativesResource;
  Result:=FRepresentativesInstance;
end;

Function TCivicinfoAPI.CreateRepresentativesResource : TRepresentativesResource;

begin
  Result:=CreateRepresentativesResource(Self);
end;


Function TCivicinfoAPI.CreateRepresentativesResource(AOwner : TComponent) : TRepresentativesResource;

begin
  Result:=TRepresentativesResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TCivicinfoAPI.RegisterAPI;
end.
