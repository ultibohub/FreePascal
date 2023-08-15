{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

{$IFNDEF FPC_DOTTEDUNITS}
unit DefinedClassesSecurityInterface;
{$ENDIF FPC_DOTTEDUNITS}
interface

type
  SFAuthorizationPluginView = objcclass external;
  SFAuthorizationView = objcclass external;
  SFCertificatePanel = objcclass external;
  SFCertificateTrustPanel = objcclass external;
  SFCertificateView = objcclass external;
  SFChooseIdentityPanel = objcclass external;
  SFKeychainSavePanel = objcclass external;
  SFKeychainSettingsPanel = objcclass external;

type
  SFAnimatedLockButton = objcclass external;
  SFAuthorizationViewDelegate = objcclass external;
  SFAutoLockTextValue = objcclass external;

implementation
end.
