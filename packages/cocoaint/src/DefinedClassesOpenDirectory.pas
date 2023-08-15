{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

{$IFNDEF FPC_DOTTEDUNITS}
unit DefinedClassesOpenDirectory;
{$ENDIF FPC_DOTTEDUNITS}
interface

type
  ODAttributeMap = objcclass external;
  ODConfiguration = objcclass external;
  ODMappings = objcclass external;
  ODModuleEntry = objcclass external;
  ODNode = objcclass external;
  ODQuery = objcclass external;
  ODRecord = objcclass external;
  ODRecordMap = objcclass external;
  ODSession = objcclass external;
  ODQueryDelegateProtocol = objcprotocol external name 'ODQueryDelegate';

type
  SFAuthorization = objcclass external;

implementation
end.
