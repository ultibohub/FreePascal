{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

{$IFNDEF FPC_DOTTEDUNITS}
unit DefinedClassesCoreBluetooth;
{$ENDIF FPC_DOTTEDUNITS}
interface

type
  CBATTRequest = objcclass external;
  CBCentral = objcclass external;
  CBCentralManager = objcclass external;
  CBCharacteristic = objcclass external;
  CBDescriptor = objcclass external;
  CBMutableCharacteristic = objcclass external;
  CBMutableDescriptor = objcclass external;
  CBMutableService = objcclass external;
  CBPeripheral = objcclass external;
  CBPeripheralManager = objcclass external;
  CBService = objcclass external;
  CBUUID = objcclass external;
  CBCentralManagerDelegateProtocol = objcprotocol external name 'CBCentralManagerDelegate';
  CBPeripheralDelegateProtocol = objcprotocol external name 'CBPeripheralDelegate';
  CBPeripheralManagerDelegateProtocol = objcprotocol external name 'CBPeripheralManagerDelegate';

implementation
end.
