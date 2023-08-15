{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

{$IFNDEF FPC_DOTTEDUNITS}
unit DefinedClassesOSAKit;
{$ENDIF FPC_DOTTEDUNITS}
interface

type
  OSALanguage = objcclass external;
  OSALanguageInstance = objcclass external;
  OSAScript = objcclass external;
  OSAScriptController = objcclass external;
  OSAScriptView = objcclass external;

type
  OSALanguageInstancePrivate = objcclass external;
  OSALanguagePrivate = objcclass external;
  OSAScriptControllerPrivate = objcclass external;
  OSAScriptPrivate = objcclass external;
  OSAScriptViewPrivate = objcclass external;

implementation
end.
