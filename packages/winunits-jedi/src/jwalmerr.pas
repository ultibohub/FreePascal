{******************************************************************************}
{                                                                              }
{ Lan Manager Error API interface Unit for Object Pascal                       }
{                                                                              }
{ Portions created by Microsoft are Copyright (C) 1995-2001 Microsoft          }
{ Corporation. All Rights Reserved.                                            }
{                                                                              }
{ The original file is: lmerr.h, released November 2001. The original Pascal   }
{ code is: LmErr.pas, released Februari 2002. The initial developer of the     }
{ Pascal code is Marcel van Brakel (brakelm att chello dott nl).               }
{                                                                              }
{ Portions created by Marcel van Brakel are Copyright (C) 1999-2001            }
{ Marcel van Brakel. All Rights Reserved.                                      }
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ You may retrieve the latest version of this file at the Project JEDI         }
{ APILIB home page, located at http://jedi-apilib.sourceforge.net              }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

// $Id: JwaLmErr.pas,v 1.9 2007/09/05 11:58:50 dezipaitor Exp $
{$IFNDEF JWA_OMIT_SECTIONS}
{$IFNDEF FPC_DOTTEDUNITS}
unit JwaLmErr;
{$ENDIF FPC_DOTTEDUNITS}

{$WEAKPACKAGEUNIT}
{$ENDIF JWA_OMIT_SECTIONS}

{$HPPEMIT ''}
{$HPPEMIT '#include "lmerr.h"'}
{$HPPEMIT ''}

{$IFNDEF JWA_OMIT_SECTIONS}
{$I jediapilib.inc}

interface
{$ENDIF JWA_OMIT_SECTIONS}


{$IFNDEF JWA_IMPLEMENTATIONSECTION}

const
  NERR_Success = 0; // Success
  {$EXTERNALSYM NERR_Success}

// ERROR_ equates can be intermixed with NERR_ equates.

//    NERR_BASE is the base of error codes from network utilities,
//      chosen to avoid conflict with system and redirector error codes.
//      2100 is a value that has been assigned to us by system.

  NERR_BASE = 2100;
  {$EXTERNALSYM NERR_BASE}

//*INTERNAL_ONLY*

{**********WARNING *****************
 *See the comment in lmcons.h for  *
 *info on the allocation of errors *
 ***********************************}

{**********WARNING *****************
 *The range 2750-2799 has been     *
 *allocated to the IBM LAN Server  *
 ***********************************}

{**********WARNING *****************
 *The range 2900-2999 has been     *
 *reserved for Microsoft OEMs      *
 ***********************************}

// UNUSED BASE+0
// UNUSED BASE+1
  NERR_NetNotStarted = NERR_BASE + 2; // The workstation driver is not installed.
  {$EXTERNALSYM NERR_NetNotStarted}
  NERR_UnknownServer = NERR_BASE + 3; // The server could not be located.
  {$EXTERNALSYM NERR_UnknownServer}
  NERR_ShareMem      = NERR_BASE + 4; // An internal error occurred.  The network cannot access a shared memory segment.
  {$EXTERNALSYM NERR_ShareMem}

  NERR_NoNetworkResource = NERR_BASE + 5; // A network resource shortage occurred .
  {$EXTERNALSYM NERR_NoNetworkResource}
  NERR_RemoteOnly        = NERR_BASE + 6; // This operation is not supported on workstations.
  {$EXTERNALSYM NERR_RemoteOnly}
  NERR_DevNotRedirected  = NERR_BASE + 7; // The device is not connected.
  {$EXTERNALSYM NERR_DevNotRedirected}
// NERR_BASE+8 is used for ERROR_CONNECTED_OTHER_PASSWORD
// NERR_BASE+9 is used for ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT
// UNUSED BASE+10
// UNUSED BASE+11
// UNUSED BASE+12
// UNUSED BASE+13
  NERR_ServerNotStarted = NERR_BASE + 14; // The Server service is not started.
  {$EXTERNALSYM NERR_ServerNotStarted}
  NERR_ItemNotFound     = NERR_BASE + 15; // The queue is empty.
  {$EXTERNALSYM NERR_ItemNotFound}
  NERR_UnknownDevDir    = NERR_BASE + 16; // The device or directory does not exist.
  {$EXTERNALSYM NERR_UnknownDevDir}
  NERR_RedirectedPath   = NERR_BASE + 17; // The operation is invalid on a redirected resource.
  {$EXTERNALSYM NERR_RedirectedPath}
  NERR_DuplicateShare   = NERR_BASE + 18; // The name has already been shared.
  {$EXTERNALSYM NERR_DuplicateShare}
  NERR_NoRoom           = NERR_BASE + 19; // The server is currently out of the requested resource.
  {$EXTERNALSYM NERR_NoRoom}
// UNUSED BASE+20
  NERR_TooManyItems    = NERR_BASE + 21; // Requested addition of items exceeds the maximum allowed.
  {$EXTERNALSYM NERR_TooManyItems}
  NERR_InvalidMaxUsers = NERR_BASE + 22; // The Peer service supports only two simultaneous users.
  {$EXTERNALSYM NERR_InvalidMaxUsers}
  NERR_BufTooSmall     = NERR_BASE + 23; // The API return buffer is too small.
  {$EXTERNALSYM NERR_BufTooSmall}
// UNUSED BASE+24
// UNUSED BASE+25
// UNUSED BASE+26
  NERR_RemoteErr = NERR_BASE + 27; // A remote API error occurred.
  {$EXTERNALSYM NERR_RemoteErr}
// UNUSED BASE+28
// UNUSED BASE+29
// UNUSED BASE+30
  NERR_LanmanIniError = NERR_BASE + 31; // An error occurred when opening or reading the configuration file.
  {$EXTERNALSYM NERR_LanmanIniError}
// UNUSED BASE+32
// UNUSED BASE+33
// UNUSED BASE+34
// UNUSED BASE+35
  NERR_NetworkError           = NERR_BASE + 36; // A general network error occurred.
  {$EXTERNALSYM NERR_NetworkError}
  NERR_WkstaInconsistentState = NERR_BASE + 37;
  {$EXTERNALSYM NERR_WkstaInconsistentState}
    // The Workstation service is in an inconsistent state. Restart the computer before restarting the Workstation service.
  NERR_WkstaNotStarted   = NERR_BASE + 38; // The Workstation service has not been started.
  {$EXTERNALSYM NERR_WkstaNotStarted}
  NERR_BrowserNotStarted = NERR_BASE + 39; // The requested information is not available.
  {$EXTERNALSYM NERR_BrowserNotStarted}
  NERR_InternalError     = NERR_BASE + 40; // An internal Windows 2000 error occurred.
  {$EXTERNALSYM NERR_InternalError}
  NERR_BadTransactConfig = NERR_BASE + 41; // The server is not configured for transactions.
  {$EXTERNALSYM NERR_BadTransactConfig}
  NERR_InvalidAPI        = NERR_BASE + 42; // The requested API is not supported on the remote server.
  {$EXTERNALSYM NERR_InvalidAPI}
  NERR_BadEventName      = NERR_BASE + 43; // The event name is invalid.
  {$EXTERNALSYM NERR_BadEventName}
  NERR_DupNameReboot     = NERR_BASE + 44; // The computer name already exists on the network. Change it and restart the computer.
  {$EXTERNALSYM NERR_DupNameReboot}

//
//      Config API related
//              Error codes from BASE+45 to BASE+49

// UNUSED BASE+45
  NERR_CfgCompNotFound  = NERR_BASE + 46; // The specified component could not be found in the configuration information.
  {$EXTERNALSYM NERR_CfgCompNotFound}
  NERR_CfgParamNotFound = NERR_BASE + 47; // The specified parameter could not be found in the configuration information.
  {$EXTERNALSYM NERR_CfgParamNotFound}
  NERR_LineTooLong = NERR_BASE + 49; // A line in the configuration file is too long.
  {$EXTERNALSYM NERR_LineTooLong}

//
//      Spooler API related
//              Error codes from BASE+50 to BASE+79

  NERR_QNotFound        = NERR_BASE + 50; // The printer does not exist.
  {$EXTERNALSYM NERR_QNotFound}
  NERR_JobNotFound      = NERR_BASE + 51; // The print job does not exist.
  {$EXTERNALSYM NERR_JobNotFound}
  NERR_DestNotFound     = NERR_BASE + 52; // The printer destination cannot be found.
  {$EXTERNALSYM NERR_DestNotFound}
  NERR_DestExists       = NERR_BASE + 53; // The printer destination already exists.
  {$EXTERNALSYM NERR_DestExists}
  NERR_QExists          = NERR_BASE + 54; // The printer queue already exists.
  {$EXTERNALSYM NERR_QExists}
  NERR_QNoRoom          = NERR_BASE + 55; // No more printers can be added.
  {$EXTERNALSYM NERR_QNoRoom}
  NERR_JobNoRoom        = NERR_BASE + 56; // No more print jobs can be added.
  {$EXTERNALSYM NERR_JobNoRoom}
  NERR_DestNoRoom       = NERR_BASE + 57; // No more printer destinations can be added.
  {$EXTERNALSYM NERR_DestNoRoom}
  NERR_DestIdle         = NERR_BASE + 58; // This printer destination is idle and cannot accept control operations.
  {$EXTERNALSYM NERR_DestIdle}
  NERR_DestInvalidOp    = NERR_BASE + 59; // This printer destination request contains an invalid control function.
  {$EXTERNALSYM NERR_DestInvalidOp}
  NERR_ProcNoRespond    = NERR_BASE + 60; // The print processor is not responding.
  {$EXTERNALSYM NERR_ProcNoRespond}
  NERR_SpoolerNotLoaded = NERR_BASE + 61; // The spooler is not running.
  {$EXTERNALSYM NERR_SpoolerNotLoaded}
  NERR_DestInvalidState = NERR_BASE + 62; // This operation cannot be performed on the print destination in its current state.
  {$EXTERNALSYM NERR_DestInvalidState}
  NERR_QInvalidState    = NERR_BASE + 63; // This operation cannot be performed on the printer queue in its current state.
  {$EXTERNALSYM NERR_QInvalidState}
  NERR_JobInvalidState  = NERR_BASE + 64; // This operation cannot be performed on the print job in its current state.
  {$EXTERNALSYM NERR_JobInvalidState}
  NERR_SpoolNoMemory    = NERR_BASE + 65; // A spooler memory allocation failure occurred.
  {$EXTERNALSYM NERR_SpoolNoMemory}
  NERR_DriverNotFound   = NERR_BASE + 66; // The device driver does not exist.
  {$EXTERNALSYM NERR_DriverNotFound}
  NERR_DataTypeInvalid  = NERR_BASE + 67; // The data type is not supported by the print processor.
  {$EXTERNALSYM NERR_DataTypeInvalid}
  NERR_ProcNotFound     = NERR_BASE + 68; // The print processor is not installed.
  {$EXTERNALSYM NERR_ProcNotFound}

//
//      Service API related
//              Error codes from BASE+80 to BASE+99

  NERR_ServiceTableLocked  = NERR_BASE + 80; // The service database is locked.
  {$EXTERNALSYM NERR_ServiceTableLocked}
  NERR_ServiceTableFull    = NERR_BASE + 81; // The service table is full.
  {$EXTERNALSYM NERR_ServiceTableFull}
  NERR_ServiceInstalled    = NERR_BASE + 82; // The requested service has already been started.
  {$EXTERNALSYM NERR_ServiceInstalled}
  NERR_ServiceEntryLocked  = NERR_BASE + 83; // The service does not respond to control actions.
  {$EXTERNALSYM NERR_ServiceEntryLocked}
  NERR_ServiceNotInstalled = NERR_BASE + 84; // The service has not been started.
  {$EXTERNALSYM NERR_ServiceNotInstalled}
  NERR_BadServiceName      = NERR_BASE + 85; // The service name is invalid.
  {$EXTERNALSYM NERR_BadServiceName}
  NERR_ServiceCtlTimeout   = NERR_BASE + 86; // The service is not responding to the control function.
  {$EXTERNALSYM NERR_ServiceCtlTimeout}
  NERR_ServiceCtlBusy      = NERR_BASE + 87; // The service control is busy.
  {$EXTERNALSYM NERR_ServiceCtlBusy}
  NERR_BadServiceProgName  = NERR_BASE + 88; // The configuration file contains an invalid service program name.
  {$EXTERNALSYM NERR_BadServiceProgName}
  NERR_ServiceNotCtrl      = NERR_BASE + 89; // The service could not be controlled in its present state.
  {$EXTERNALSYM NERR_ServiceNotCtrl}
  NERR_ServiceKillProc     = NERR_BASE + 90; // The service ended abnormally.
  {$EXTERNALSYM NERR_ServiceKillProc}
  NERR_ServiceCtlNotValid  = NERR_BASE + 91; // The requested pause,continue, or stop is not valid for this service.
  {$EXTERNALSYM NERR_ServiceCtlNotValid}
  NERR_NotInDispatchTbl    = NERR_BASE + 92; // The service control dispatcher could not find the service name in the dispatch table.
  {$EXTERNALSYM NERR_NotInDispatchTbl}
  NERR_BadControlRecv      = NERR_BASE + 93; // The service control dispatcher pipe read failed.
  {$EXTERNALSYM NERR_BadControlRecv}
  NERR_ServiceNotStarting  = NERR_BASE + 94; // A thread for the new service could not be created.
  {$EXTERNALSYM NERR_ServiceNotStarting}

//
//      Wksta and Logon API related
//              Error codes from BASE+100 to BASE+118

  NERR_AlreadyLoggedOn   = NERR_BASE + 100; // This workstation is already logged on to the local-area network.
  {$EXTERNALSYM NERR_AlreadyLoggedOn}
  NERR_NotLoggedOn       = NERR_BASE + 101; // The workstation is not logged on to the local-area network.
  {$EXTERNALSYM NERR_NotLoggedOn}
  NERR_BadUsername       = NERR_BASE + 102; // The user name or group name parameter is invalid.
  {$EXTERNALSYM NERR_BadUsername}
  NERR_BadPassword       = NERR_BASE + 103; // The password parameter is invalid.
  {$EXTERNALSYM NERR_BadPassword}
  NERR_UnableToAddName_W = NERR_BASE + 104; // @W The logon processor did not add the message alias.
  {$EXTERNALSYM NERR_UnableToAddName_W}
  NERR_UnableToAddName_F = NERR_BASE + 105; // The logon processor did not add the message alias.
  {$EXTERNALSYM NERR_UnableToAddName_F}
  NERR_UnableToDelName_W = NERR_BASE + 106; // @W The logoff processor did not delete the message alias.
  {$EXTERNALSYM NERR_UnableToDelName_W}
  NERR_UnableToDelName_F = NERR_BASE + 107; // The logoff processor did not delete the message alias.
  {$EXTERNALSYM NERR_UnableToDelName_F}
// UNUSED BASE+108
  NERR_LogonsPaused        = NERR_BASE + 109; // Network logons are paused.
  {$EXTERNALSYM NERR_LogonsPaused}
  NERR_LogonServerConflict = NERR_BASE + 110; // A centralized logon-server conflict occurred.
  {$EXTERNALSYM NERR_LogonServerConflict}
  NERR_LogonNoUserPath     = NERR_BASE + 111; // The server is configured without a valid user path.
  {$EXTERNALSYM NERR_LogonNoUserPath}
  NERR_LogonScriptError    = NERR_BASE + 112; // An error occurred while loading or running the logon script.
  {$EXTERNALSYM NERR_LogonScriptError}
// UNUSED BASE+113
  NERR_StandaloneLogon     = NERR_BASE + 114; // The logon server was not specified.  Your computer will be logged on as STANDALONE.
  {$EXTERNALSYM NERR_StandaloneLogon}
  NERR_LogonServerNotFound = NERR_BASE + 115; // The logon server could not be found.
  {$EXTERNALSYM NERR_LogonServerNotFound}
  NERR_LogonDomainExists   = NERR_BASE + 116; // There is already a logon domain for this computer.
  {$EXTERNALSYM NERR_LogonDomainExists}
  NERR_NonValidatedLogon   = NERR_BASE + 117; // The logon server could not validate the logon.
  {$EXTERNALSYM NERR_NonValidatedLogon}

//
//      ACF API related (access, user, group)
//              Error codes from BASE+119 to BASE+149

  NERR_ACFNotFound          = NERR_BASE + 119; // The security database could not be found.
  {$EXTERNALSYM NERR_ACFNotFound}
  NERR_GroupNotFound        = NERR_BASE + 120; // The group name could not be found.
  {$EXTERNALSYM NERR_GroupNotFound}
  NERR_UserNotFound         = NERR_BASE + 121; // The user name could not be found.
  {$EXTERNALSYM NERR_UserNotFound}
  NERR_ResourceNotFound     = NERR_BASE + 122; // The resource name could not be found.
  {$EXTERNALSYM NERR_ResourceNotFound}
  NERR_GroupExists          = NERR_BASE + 123; // The group already exists.
  {$EXTERNALSYM NERR_GroupExists}
  NERR_UserExists           = NERR_BASE + 124; // The account already exists.
  {$EXTERNALSYM NERR_UserExists}
  NERR_ResourceExists       = NERR_BASE + 125; // The resource permission list already exists.
  {$EXTERNALSYM NERR_ResourceExists}
  NERR_NotPrimary           = NERR_BASE + 126; // This operation is only allowed on the primary domain controller of the domain.
  {$EXTERNALSYM NERR_NotPrimary}
  NERR_ACFNotLoaded         = NERR_BASE + 127; // The security database has not been started.
  {$EXTERNALSYM NERR_ACFNotLoaded}
  NERR_ACFNoRoom            = NERR_BASE + 128; // There are too many names in the user accounts database.
  {$EXTERNALSYM NERR_ACFNoRoom}
  NERR_ACFFileIOFail        = NERR_BASE + 129; // A disk I/O failure occurred.
  {$EXTERNALSYM NERR_ACFFileIOFail}
  NERR_ACFTooManyLists      = NERR_BASE + 130; // The limit of 64 entries per resource was exceeded.
  {$EXTERNALSYM NERR_ACFTooManyLists}
  NERR_UserLogon            = NERR_BASE + 131; // Deleting a user with a session is not allowed.
  {$EXTERNALSYM NERR_UserLogon}
  NERR_ACFNoParent          = NERR_BASE + 132; // The parent directory could not be located.
  {$EXTERNALSYM NERR_ACFNoParent}
  NERR_CanNotGrowSegment    = NERR_BASE + 133; // Unable to add to the security database session cache segment.
  {$EXTERNALSYM NERR_CanNotGrowSegment}
  NERR_SpeGroupOp           = NERR_BASE + 134; // This operation is not allowed on this special group.
  {$EXTERNALSYM NERR_SpeGroupOp}
  NERR_NotInCache           = NERR_BASE + 135; // This user is not cached in user accounts database session cache.
  {$EXTERNALSYM NERR_NotInCache}
  NERR_UserInGroup          = NERR_BASE + 136; // The user already belongs to this group.
  {$EXTERNALSYM NERR_UserInGroup}
  NERR_UserNotInGroup       = NERR_BASE + 137; // The user does not belong to this group.
  {$EXTERNALSYM NERR_UserNotInGroup}
  NERR_AccountUndefined     = NERR_BASE + 138; // This user account is undefined.
  {$EXTERNALSYM NERR_AccountUndefined}
  NERR_AccountExpired       = NERR_BASE + 139; // This user account has expired.
  {$EXTERNALSYM NERR_AccountExpired}
  NERR_InvalidWorkstation   = NERR_BASE + 140; // The user is not allowed to log on from this workstation.
  {$EXTERNALSYM NERR_InvalidWorkstation}
  NERR_InvalidLogonHours    = NERR_BASE + 141; // The user is not allowed to log on at this time.
  {$EXTERNALSYM NERR_InvalidLogonHours}
  NERR_PasswordExpired      = NERR_BASE + 142; // The password of this user has expired.
  {$EXTERNALSYM NERR_PasswordExpired}
  NERR_PasswordCantChange   = NERR_BASE + 143; // The password of this user cannot change.
  {$EXTERNALSYM NERR_PasswordCantChange}
  NERR_PasswordHistConflict = NERR_BASE + 144; // This password cannot be used now.
  {$EXTERNALSYM NERR_PasswordHistConflict}
  NERR_PasswordTooShort     = NERR_BASE + 145; // The password does not meet the password policy requirements. Check the minimum password length, password complexity and password history requirements.
  {$EXTERNALSYM NERR_PasswordTooShort}
  NERR_PasswordTooRecent    = NERR_BASE + 146; // The password of this user is too recent to change.
  {$EXTERNALSYM NERR_PasswordTooRecent}
  NERR_InvalidDatabase      = NERR_BASE + 147; // The security database is corrupted.
  {$EXTERNALSYM NERR_InvalidDatabase}
  NERR_DatabaseUpToDate     = NERR_BASE + 148; // No updates are necessary to this replicant network/local security database.
  {$EXTERNALSYM NERR_DatabaseUpToDate}
  NERR_SyncRequired         = NERR_BASE + 149; // This replicant database is outdated; synchronization is required.
  {$EXTERNALSYM NERR_SyncRequired}

//
//      Use API related
//              Error codes from BASE+150 to BASE+169

  NERR_UseNotFound    = NERR_BASE + 150; // The network connection could not be found.
  {$EXTERNALSYM NERR_UseNotFound}
  NERR_BadAsgType     = NERR_BASE + 151; // This asg_type is invalid.
  {$EXTERNALSYM NERR_BadAsgType}
  NERR_DeviceIsShared = NERR_BASE + 152; // This device is currently being shared.
  {$EXTERNALSYM NERR_DeviceIsShared}

//
//      Message Server related
//              Error codes BASE+170 to BASE+209

  NERR_NoComputerName     = NERR_BASE + 170; // The computer name could not be added as a message alias.  The name may already exist on the network.
  {$EXTERNALSYM NERR_NoComputerName}
  NERR_MsgAlreadyStarted  = NERR_BASE + 171; // The Messenger service is already started.
  {$EXTERNALSYM NERR_MsgAlreadyStarted}
  NERR_MsgInitFailed      = NERR_BASE + 172; // The Messenger service failed to start.
  {$EXTERNALSYM NERR_MsgInitFailed}
  NERR_NameNotFound       = NERR_BASE + 173; // The message alias could not be found on the network.
  {$EXTERNALSYM NERR_NameNotFound}
  NERR_AlreadyForwarded   = NERR_BASE + 174; // This message alias has already been forwarded.
  {$EXTERNALSYM NERR_AlreadyForwarded}
  NERR_AddForwarded       = NERR_BASE + 175; // This message alias has been added but is still forwarded.
  {$EXTERNALSYM NERR_AddForwarded}
  NERR_AlreadyExists      = NERR_BASE + 176; // This message alias already exists locally.
  {$EXTERNALSYM NERR_AlreadyExists}
  NERR_TooManyNames       = NERR_BASE + 177; // The maximum number of added message aliases has been exceeded.
  {$EXTERNALSYM NERR_TooManyNames}
  NERR_DelComputerName    = NERR_BASE + 178; // The computer name could not be deleted.
  {$EXTERNALSYM NERR_DelComputerName}
  NERR_LocalForward       = NERR_BASE + 179; // Messages cannot be forwarded back to the same workstation.
  {$EXTERNALSYM NERR_LocalForward}
  NERR_GrpMsgProcessor    = NERR_BASE + 180; // An error occurred in the domain message processor.
  {$EXTERNALSYM NERR_GrpMsgProcessor}
  NERR_PausedRemote       = NERR_BASE + 181; // The message was sent, but the recipient has paused the Messenger service.
  {$EXTERNALSYM NERR_PausedRemote}
  NERR_BadReceive         = NERR_BASE + 182; // The message was sent but not received.
  {$EXTERNALSYM NERR_BadReceive}
  NERR_NameInUse          = NERR_BASE + 183; // The message alias is currently in use. Try again later.
  {$EXTERNALSYM NERR_NameInUse}
  NERR_MsgNotStarted      = NERR_BASE + 184; // The Messenger service has not been started.
  {$EXTERNALSYM NERR_MsgNotStarted}
  NERR_NotLocalName       = NERR_BASE + 185; // The name is not on the local computer.
  {$EXTERNALSYM NERR_NotLocalName}
  NERR_NoForwardName      = NERR_BASE + 186; // The forwarded message alias could not be found on the network.
  {$EXTERNALSYM NERR_NoForwardName}
  NERR_RemoteFull         = NERR_BASE + 187; // The message alias table on the remote station is full.
  {$EXTERNALSYM NERR_RemoteFull}
  NERR_NameNotForwarded   = NERR_BASE + 188; // Messages for this alias are not currently being forwarded.
  {$EXTERNALSYM NERR_NameNotForwarded}
  NERR_TruncatedBroadcast = NERR_BASE + 189; // The broadcast message was truncated.
  {$EXTERNALSYM NERR_TruncatedBroadcast}
  NERR_InvalidDevice      = NERR_BASE + 194; // This is an invalid device name.
  {$EXTERNALSYM NERR_InvalidDevice}
  NERR_WriteFault         = NERR_BASE + 195; // A write fault occurred.
  {$EXTERNALSYM NERR_WriteFault}
// UNUSED BASE+196
  NERR_DuplicateName = NERR_BASE + 197; // A duplicate message alias exists on the network.
  {$EXTERNALSYM NERR_DuplicateName}
  NERR_DeleteLater   = NERR_BASE + 198; // @W This message alias will be deleted later.
  {$EXTERNALSYM NERR_DeleteLater}
  NERR_IncompleteDel = NERR_BASE + 199; // The message alias was not successfully deleted from all networks.
  {$EXTERNALSYM NERR_IncompleteDel}
  NERR_MultipleNets  = NERR_BASE + 200; // This operation is not supported on computers with multiple networks.
  {$EXTERNALSYM NERR_MultipleNets}

//
//      Server API related
//             Error codes BASE+210 to BASE+229

  NERR_NetNameNotFound        = NERR_BASE + 210; // This shared resource does not exist.
  {$EXTERNALSYM NERR_NetNameNotFound}
  NERR_DeviceNotShared        = NERR_BASE + 211; // This device is not shared.
  {$EXTERNALSYM NERR_DeviceNotShared}
  NERR_ClientNameNotFound     = NERR_BASE + 212; // A session does not exist with that computer name.
  {$EXTERNALSYM NERR_ClientNameNotFound}
  NERR_FileIdNotFound         = NERR_BASE + 214; // There is not an open file with that identification number.
  {$EXTERNALSYM NERR_FileIdNotFound}
  NERR_ExecFailure            = NERR_BASE + 215; // A failure occurred when executing a remote administration command.
  {$EXTERNALSYM NERR_ExecFailure}
  NERR_TmpFile                = NERR_BASE + 216; // A failure occurred when opening a remote temporary file.
  {$EXTERNALSYM NERR_TmpFile}
  NERR_TooMuchData            = NERR_BASE + 217; // The data returned from a remote administration command has been truncated to 64K.
  {$EXTERNALSYM NERR_TooMuchData}
  NERR_DeviceShareConflict    = NERR_BASE + 218; // This device cannot be shared as both a spooled and a non-spooled resource.
  {$EXTERNALSYM NERR_DeviceShareConflict}
  NERR_BrowserTableIncomplete = NERR_BASE + 219; // The information in the list of servers may be incorrect.
  {$EXTERNALSYM NERR_BrowserTableIncomplete}
  NERR_NotLocalDomain         = NERR_BASE + 220; // The computer is not active in this domain.
  {$EXTERNALSYM NERR_NotLocalDomain}
  NERR_IsDfsShare             = NERR_BASE + 221; // The share must be removed from the Distributed File System before it can be deleted.
  {$EXTERNALSYM NERR_IsDfsShare}

//
//      CharDev API related
//              Error codes BASE+230 to BASE+249

// UNUSED BASE+230
  NERR_DevInvalidOpCode  = NERR_BASE + 231; // The operation is invalid for this device.
  {$EXTERNALSYM NERR_DevInvalidOpCode}
  NERR_DevNotFound       = NERR_BASE + 232; // This device cannot be shared.
  {$EXTERNALSYM NERR_DevNotFound}
  NERR_DevNotOpen        = NERR_BASE + 233; // This device was not open.
  {$EXTERNALSYM NERR_DevNotOpen}
  NERR_BadQueueDevString = NERR_BASE + 234; // This device name list is invalid.
  {$EXTERNALSYM NERR_BadQueueDevString}
  NERR_BadQueuePriority  = NERR_BASE + 235; // The queue priority is invalid.
  {$EXTERNALSYM NERR_BadQueuePriority}
  NERR_NoCommDevs        = NERR_BASE + 237; // There are no shared communication devices.
  {$EXTERNALSYM NERR_NoCommDevs}
  NERR_QueueNotFound     = NERR_BASE + 238; // The queue you specified does not exist.
  {$EXTERNALSYM NERR_QueueNotFound}
  NERR_BadDevString      = NERR_BASE + 240; // This list of devices is invalid.
  {$EXTERNALSYM NERR_BadDevString}
  NERR_BadDev            = NERR_BASE + 241; // The requested device is invalid.
  {$EXTERNALSYM NERR_BadDev}
  NERR_InUseBySpooler    = NERR_BASE + 242; // This device is already in use by the spooler.
  {$EXTERNALSYM NERR_InUseBySpooler}
  NERR_CommDevInUse      = NERR_BASE + 243; // This device is already in use as a communication device.
  {$EXTERNALSYM NERR_CommDevInUse}

//
//      NetICanonicalize and NetIType and NetIMakeLMFileName
//      NetIListCanon and NetINameCheck
//              Error codes BASE+250 to BASE+269

  NERR_InvalidComputer = NERR_BASE + 251; // This computer name is invalid.
  {$EXTERNALSYM NERR_InvalidComputer}
// UNUSED BASE+252
// UNUSED BASE+253
  NERR_MaxLenExceeded = NERR_BASE + 254; // The string and prefix specified are too long.
  {$EXTERNALSYM NERR_MaxLenExceeded}
// UNUSED BASE+255
  NERR_BadComponent = NERR_BASE + 256; // This path component is invalid.
  {$EXTERNALSYM NERR_BadComponent}
  NERR_CantType     = NERR_BASE + 257; // Could not determine the type of input.
  {$EXTERNALSYM NERR_CantType}
// UNUSED BASE+258
// UNUSED BASE+259
  NERR_TooManyEntries = NERR_BASE + 262; // The buffer for types is not big enough.
  {$EXTERNALSYM NERR_TooManyEntries}

//
//      NetProfile
//              Error codes BASE+270 to BASE+276

  NERR_ProfileFileTooBig = NERR_BASE + 270; // Profile files cannot exceed 64K.
  {$EXTERNALSYM NERR_ProfileFileTooBig}
  NERR_ProfileOffset     = NERR_BASE + 271; // The start offset is out of range.
  {$EXTERNALSYM NERR_ProfileOffset}
  NERR_ProfileCleanup    = NERR_BASE + 272; // The system cannot delete current connections to network resources.
  {$EXTERNALSYM NERR_ProfileCleanup}
  NERR_ProfileUnknownCmd = NERR_BASE + 273; // The system was unable to parse the command line in this file.
  {$EXTERNALSYM NERR_ProfileUnknownCmd}
  NERR_ProfileLoadErr    = NERR_BASE + 274; // An error occurred while loading the profile file.
  {$EXTERNALSYM NERR_ProfileLoadErr}
  NERR_ProfileSaveErr    = NERR_BASE + 275; // @W Errors occurred while saving the profile file.  The profile was partially saved.
  {$EXTERNALSYM NERR_ProfileSaveErr}

//
//      NetAudit and NetErrorLog
//              Error codes BASE+277 to BASE+279

  NERR_LogOverflow    = NERR_BASE + 277; // Log file %1 is full.
  {$EXTERNALSYM NERR_LogOverflow}
  NERR_LogFileChanged = NERR_BASE + 278; // This log file has changed between reads.
  {$EXTERNALSYM NERR_LogFileChanged}
  NERR_LogFileCorrupt = NERR_BASE + 279; // Log file %1 is corrupt.
  {$EXTERNALSYM NERR_LogFileCorrupt}

//
//      NetRemote
//              Error codes BASE+280 to BASE+299

  NERR_SourceIsDir      = NERR_BASE + 280; // The source path cannot be a directory.
  {$EXTERNALSYM NERR_SourceIsDir}
  NERR_BadSource        = NERR_BASE + 281; // The source path is illegal.
  {$EXTERNALSYM NERR_BadSource}
  NERR_BadDest          = NERR_BASE + 282; // The destination path is illegal.
  {$EXTERNALSYM NERR_BadDest}
  NERR_DifferentServers = NERR_BASE + 283; // The source and destination paths are on different servers.
  {$EXTERNALSYM NERR_DifferentServers}
// UNUSED BASE+284
  NERR_RunSrvPaused = NERR_BASE + 285; // The Run server you requested is paused.
  {$EXTERNALSYM NERR_RunSrvPaused}
// UNUSED BASE+286
// UNUSED BASE+287
// UNUSED BASE+288
  NERR_ErrCommRunSrv = NERR_BASE + 289; // An error occurred when communicating with a Run server.
  {$EXTERNALSYM NERR_ErrCommRunSrv}
// UNUSED BASE+290
  NERR_ErrorExecingGhost = NERR_BASE + 291; // An error occurred when starting a background process.
  {$EXTERNALSYM NERR_ErrorExecingGhost}
  NERR_ShareNotFound     = NERR_BASE + 292; // The shared resource you are connected to could not be found.
  {$EXTERNALSYM NERR_ShareNotFound}
// UNUSED BASE+293
// UNUSED BASE+294

//
//  NetWksta.sys (redir) returned error codes.
//
//          NERR_BASE + (300-329)

  NERR_InvalidLana     = NERR_BASE + 300; // The LAN adapter number is invalid.
  {$EXTERNALSYM NERR_InvalidLana}
  NERR_OpenFiles       = NERR_BASE + 301; // There are open files on the connection.
  {$EXTERNALSYM NERR_OpenFiles}
  NERR_ActiveConns     = NERR_BASE + 302; // Active connections still exist.
  {$EXTERNALSYM NERR_ActiveConns}
  NERR_BadPasswordCore = NERR_BASE + 303; // This share name or password is invalid.
  {$EXTERNALSYM NERR_BadPasswordCore}
  NERR_DevInUse        = NERR_BASE + 304; // The device is being accessed by an active process.
  {$EXTERNALSYM NERR_DevInUse}
  NERR_LocalDrive      = NERR_BASE + 305; // The drive letter is in use locally.
  {$EXTERNALSYM NERR_LocalDrive}

//
//  Alert error codes.
//
//          NERR_BASE + (330-339)

  NERR_AlertExists       = NERR_BASE + 330; // The specified client is already registered for the specified event.
  {$EXTERNALSYM NERR_AlertExists}
  NERR_TooManyAlerts     = NERR_BASE + 331; // The alert table is full.
  {$EXTERNALSYM NERR_TooManyAlerts}
  NERR_NoSuchAlert       = NERR_BASE + 332; // An invalid or nonexistent alert name was raised.
  {$EXTERNALSYM NERR_NoSuchAlert}
  NERR_BadRecipient      = NERR_BASE + 333; // The alert recipient is invalid.
  {$EXTERNALSYM NERR_BadRecipient}
  NERR_AcctLimitExceeded = NERR_BASE + 334; // A user's session with this server has been deleted
  {$EXTERNALSYM NERR_AcctLimitExceeded}
                                                // because the user's logon hours are no longer valid.

//
//  Additional Error and Audit log codes.
//
//          NERR_BASE +(340-343)

  NERR_InvalidLogSeek = NERR_BASE + 340; // The log file does not contain the requested record number.
  {$EXTERNALSYM NERR_InvalidLogSeek}
// UNUSED BASE+341
// UNUSED BASE+342
// UNUSED BASE+343

//
//  Additional UAS and NETLOGON codes
//
//          NERR_BASE +(350-359)

  NERR_BadUasConfig       = NERR_BASE + 350; // The user accounts database is not configured correctly.
  {$EXTERNALSYM NERR_BadUasConfig}
  NERR_InvalidUASOp       = NERR_BASE + 351; // This operation is not permitted when the Netlogon service is running.
  {$EXTERNALSYM NERR_InvalidUASOp}
  NERR_LastAdmin          = NERR_BASE + 352; // This operation is not allowed on the last administrative account.
  {$EXTERNALSYM NERR_LastAdmin}
  NERR_DCNotFound         = NERR_BASE + 353; // Could not find domain controller for this domain.
  {$EXTERNALSYM NERR_DCNotFound}
  NERR_LogonTrackingError = NERR_BASE + 354; // Could not set logon information for this user.
  {$EXTERNALSYM NERR_LogonTrackingError}
  NERR_NetlogonNotStarted = NERR_BASE + 355; // The Netlogon service has not been started.
  {$EXTERNALSYM NERR_NetlogonNotStarted}
  NERR_CanNotGrowUASFile  = NERR_BASE + 356; // Unable to add to the user accounts database.
  {$EXTERNALSYM NERR_CanNotGrowUASFile}
  NERR_TimeDiffAtDC       = NERR_BASE + 357; // This server's clock is not synchronized with the primary domain controller's clock.
  {$EXTERNALSYM NERR_TimeDiffAtDC}
  NERR_PasswordMismatch   = NERR_BASE + 358; // A password mismatch has been detected.
  {$EXTERNALSYM NERR_PasswordMismatch}

//
//  Server Integration error codes.
//
//          NERR_BASE +(360-369)

  NERR_NoSuchServer       = NERR_BASE + 360; // The server identification does not specify a valid server.
  {$EXTERNALSYM NERR_NoSuchServer}
  NERR_NoSuchSession      = NERR_BASE + 361; // The session identification does not specify a valid session.
  {$EXTERNALSYM NERR_NoSuchSession}
  NERR_NoSuchConnection   = NERR_BASE + 362; // The connection identification does not specify a valid connection.
  {$EXTERNALSYM NERR_NoSuchConnection}
  NERR_TooManyServers     = NERR_BASE + 363; // There is no space for another entry in the table of available servers.
  {$EXTERNALSYM NERR_TooManyServers}
  NERR_TooManySessions    = NERR_BASE + 364; // The server has reached the maximum number of sessions it supports.
  {$EXTERNALSYM NERR_TooManySessions}
  NERR_TooManyConnections = NERR_BASE + 365; // The server has reached the maximum number of connections it supports.
  {$EXTERNALSYM NERR_TooManyConnections}
  NERR_TooManyFiles       = NERR_BASE + 366; // The server cannot open more files because it has reached its maximum number.
  {$EXTERNALSYM NERR_TooManyFiles}
  NERR_NoAlternateServers = NERR_BASE + 367; // There are no alternate servers registered on this server.
  {$EXTERNALSYM NERR_NoAlternateServers}
// UNUSED BASE+368
// UNUSED BASE+369

  NERR_TryDownLevel = NERR_BASE + 370; // Try down-level (remote admin protocol) version of API instead.
  {$EXTERNALSYM NERR_TryDownLevel}

//
//  UPS error codes.
//
//          NERR_BASE + (380-384)

  NERR_UPSDriverNotStarted = NERR_BASE + 380; // The UPS driver could not be accessed by the UPS service.
  {$EXTERNALSYM NERR_UPSDriverNotStarted}
  NERR_UPSInvalidConfig    = NERR_BASE + 381; // The UPS service is not configured correctly.
  {$EXTERNALSYM NERR_UPSInvalidConfig}
  NERR_UPSInvalidCommPort  = NERR_BASE + 382; // The UPS service could not access the specified Comm Port.
  {$EXTERNALSYM NERR_UPSInvalidCommPort}
  NERR_UPSSignalAsserted   = NERR_BASE + 383; // The UPS indicated a line fail or low battery situation. Service not started.
  {$EXTERNALSYM NERR_UPSSignalAsserted}
  NERR_UPSShutdownFailed   = NERR_BASE + 384; // The UPS service failed to perform a system shut down.
  {$EXTERNALSYM NERR_UPSShutdownFailed}

//
//  Remoteboot error codes.
//
//           NERR_BASE + (400-419)
//           Error codes 400 - 405 are used by RPLBOOT.SYS.
//           Error codes 403, 407 - 416 are used by RPLLOADR.COM,
//           Error code 417 is the alerter message of REMOTEBOOT (RPLSERVR.EXE).
//           Error code 418 is for when REMOTEBOOT can't start
//           Error code 419 is for a disallowed 2nd rpl connection
//

  NERR_BadDosRetCode      = NERR_BASE + 400; // The program below returned an MS-DOS error code:
  {$EXTERNALSYM NERR_BadDosRetCode}
  NERR_ProgNeedsExtraMem  = NERR_BASE + 401; // The program below needs more memory:
  {$EXTERNALSYM NERR_ProgNeedsExtraMem}
  NERR_BadDosFunction     = NERR_BASE + 402; // The program below called an unsupported MS-DOS function:
  {$EXTERNALSYM NERR_BadDosFunction}
  NERR_RemoteBootFailed   = NERR_BASE + 403; // The workstation failed to boot.
  {$EXTERNALSYM NERR_RemoteBootFailed}
  NERR_BadFileCheckSum    = NERR_BASE + 404; // The file below is corrupt.
  {$EXTERNALSYM NERR_BadFileCheckSum}
  NERR_NoRplBootSystem    = NERR_BASE + 405; // No loader is specified in the boot-block definition file.
  {$EXTERNALSYM NERR_NoRplBootSystem}
  NERR_RplLoadrNetBiosErr = NERR_BASE + 406; // NetBIOS returned an error: The NCB and SMB are dumped above.
  {$EXTERNALSYM NERR_RplLoadrNetBiosErr}
  NERR_RplLoadrDiskErr    = NERR_BASE + 407; // A disk I/O error occurred.
  {$EXTERNALSYM NERR_RplLoadrDiskErr}
  NERR_ImageParamErr      = NERR_BASE + 408; // Image parameter substitution failed.
  {$EXTERNALSYM NERR_ImageParamErr}
  NERR_TooManyImageParams = NERR_BASE + 409; // Too many image parameters cross disk sector boundaries.
  {$EXTERNALSYM NERR_TooManyImageParams}
  NERR_NonDosFloppyUsed   = NERR_BASE + 410; // The image was not generated from an MS-DOS diskette formatted with /S.
  {$EXTERNALSYM NERR_NonDosFloppyUsed}
  NERR_RplBootRestart     = NERR_BASE + 411; // Remote boot will be restarted later.
  {$EXTERNALSYM NERR_RplBootRestart}
  NERR_RplSrvrCallFailed  = NERR_BASE + 412; // The call to the Remoteboot server failed.
  {$EXTERNALSYM NERR_RplSrvrCallFailed}
  NERR_CantConnectRplSrvr = NERR_BASE + 413; // Cannot connect to the Remoteboot server.
  {$EXTERNALSYM NERR_CantConnectRplSrvr}
  NERR_CantOpenImageFile  = NERR_BASE + 414; // Cannot open image file on the Remoteboot server.
  {$EXTERNALSYM NERR_CantOpenImageFile}
  NERR_CallingRplSrvr     = NERR_BASE + 415; // Connecting to the Remoteboot server...
  {$EXTERNALSYM NERR_CallingRplSrvr}
  NERR_StartingRplBoot    = NERR_BASE + 416; // Connecting to the Remoteboot server...
  {$EXTERNALSYM NERR_StartingRplBoot}
  NERR_RplBootServiceTerm = NERR_BASE + 417; // Remote boot service was stopped; check the error log for the cause of the problem.
  {$EXTERNALSYM NERR_RplBootServiceTerm}
  NERR_RplBootStartFailed = NERR_BASE + 418; // Remote boot startup failed; check the error log for the cause of the problem.
  {$EXTERNALSYM NERR_RplBootStartFailed}
  NERR_RPL_CONNECTED      = NERR_BASE + 419; // A second connection to a Remoteboot resource is not allowed.
  {$EXTERNALSYM NERR_RPL_CONNECTED}

//
//  FTADMIN API error codes
//
//       NERR_BASE + (425-434)
//
//       (Currently not used in NT)
//

//
//  Browser service API error codes
//
//       NERR_BASE + (450-475)
//

  NERR_BrowserConfiguredToNotRun = NERR_BASE + 450; // The browser service was configured with MaintainServerList=No.
  {$EXTERNALSYM NERR_BrowserConfiguredToNotRun}

//
//  Additional Remoteboot error codes.
//
//          NERR_BASE + (510-550)

  NERR_RplNoAdaptersStarted      = NERR_BASE + 510; // Service failed to start since none of the network adapters started with this service.
  {$EXTERNALSYM NERR_RplNoAdaptersStarted}
  NERR_RplBadRegistry            = NERR_BASE + 511; // Service failed to start due to bad startup information in the registry.
  {$EXTERNALSYM NERR_RplBadRegistry}
  NERR_RplBadDatabase            = NERR_BASE + 512; // Service failed to start because its database is absent or corrupt.
  {$EXTERNALSYM NERR_RplBadDatabase}
  NERR_RplRplfilesShare          = NERR_BASE + 513; // Service failed to start because RPLFILES share is absent.
  {$EXTERNALSYM NERR_RplRplfilesShare}
  NERR_RplNotRplServer           = NERR_BASE + 514; // Service failed to start because RPLUSER group is absent.
  {$EXTERNALSYM NERR_RplNotRplServer}
  NERR_RplCannotEnum             = NERR_BASE + 515; // Cannot enumerate service records.
  {$EXTERNALSYM NERR_RplCannotEnum}
  NERR_RplWkstaInfoCorrupted     = NERR_BASE + 516; // Workstation record information has been corrupted.
  {$EXTERNALSYM NERR_RplWkstaInfoCorrupted}
  NERR_RplWkstaNotFound          = NERR_BASE + 517; // Workstation record was not found.
  {$EXTERNALSYM NERR_RplWkstaNotFound}
  NERR_RplWkstaNameUnavailable   = NERR_BASE + 518; // Workstation name is in use by some other workstation.
  {$EXTERNALSYM NERR_RplWkstaNameUnavailable}
  NERR_RplProfileInfoCorrupted   = NERR_BASE + 519; // Profile record information has been corrupted.
  {$EXTERNALSYM NERR_RplProfileInfoCorrupted}
  NERR_RplProfileNotFound        = NERR_BASE + 520; // Profile record was not found.
  {$EXTERNALSYM NERR_RplProfileNotFound}
  NERR_RplProfileNameUnavailable = NERR_BASE + 521; // Profile name is in use by some other profile.
  {$EXTERNALSYM NERR_RplProfileNameUnavailable}
  NERR_RplProfileNotEmpty        = NERR_BASE + 522; // There are workstations using this profile.
  {$EXTERNALSYM NERR_RplProfileNotEmpty}
  NERR_RplConfigInfoCorrupted    = NERR_BASE + 523; // Configuration record information has been corrupted.
  {$EXTERNALSYM NERR_RplConfigInfoCorrupted}
  NERR_RplConfigNotFound         = NERR_BASE + 524; // Configuration record was not found.
  {$EXTERNALSYM NERR_RplConfigNotFound}
  NERR_RplAdapterInfoCorrupted   = NERR_BASE + 525; // Adapter id record information has been corrupted.
  {$EXTERNALSYM NERR_RplAdapterInfoCorrupted}
  NERR_RplInternal               = NERR_BASE + 526; // An internal service error has occurred.
  {$EXTERNALSYM NERR_RplInternal}
  NERR_RplVendorInfoCorrupted    = NERR_BASE + 527; // Vendor id record information has been corrupted.
  {$EXTERNALSYM NERR_RplVendorInfoCorrupted}
  NERR_RplBootInfoCorrupted      = NERR_BASE + 528; // Boot block record information has been corrupted.
  {$EXTERNALSYM NERR_RplBootInfoCorrupted}
  NERR_RplWkstaNeedsUserAcct     = NERR_BASE + 529; // The user account for this workstation record is missing.
  {$EXTERNALSYM NERR_RplWkstaNeedsUserAcct}
  NERR_RplNeedsRPLUSERAcct       = NERR_BASE + 530; // The RPLUSER local group could not be found.
  {$EXTERNALSYM NERR_RplNeedsRPLUSERAcct}
  NERR_RplBootNotFound           = NERR_BASE + 531; // Boot block record was not found.
  {$EXTERNALSYM NERR_RplBootNotFound}
  NERR_RplIncompatibleProfile    = NERR_BASE + 532; // Chosen profile is incompatible with this workstation.
  {$EXTERNALSYM NERR_RplIncompatibleProfile}
  NERR_RplAdapterNameUnavailable = NERR_BASE + 533; // Chosen network adapter id is in use by some other workstation.
  {$EXTERNALSYM NERR_RplAdapterNameUnavailable}
  NERR_RplConfigNotEmpty         = NERR_BASE + 534; // There are profiles using this configuration.
  {$EXTERNALSYM NERR_RplConfigNotEmpty}
  NERR_RplBootInUse              = NERR_BASE + 535; // There are workstations, profiles or configurations using this boot block.
  {$EXTERNALSYM NERR_RplBootInUse}
  NERR_RplBackupDatabase         = NERR_BASE + 536; // Service failed to backup Remoteboot database.
  {$EXTERNALSYM NERR_RplBackupDatabase}
  NERR_RplAdapterNotFound        = NERR_BASE + 537; // Adapter record was not found.
  {$EXTERNALSYM NERR_RplAdapterNotFound}
  NERR_RplVendorNotFound         = NERR_BASE + 538; // Vendor record was not found.
  {$EXTERNALSYM NERR_RplVendorNotFound}
  NERR_RplVendorNameUnavailable  = NERR_BASE + 539; // Vendor name is in use by some other vendor record.
  {$EXTERNALSYM NERR_RplVendorNameUnavailable}
  NERR_RplBootNameUnavailable    = NERR_BASE + 540; // (boot name, vendor id) is in use by some other boot block record.
  {$EXTERNALSYM NERR_RplBootNameUnavailable}
  NERR_RplConfigNameUnavailable  = NERR_BASE + 541; // Configuration name is in use by some other configuration.
  {$EXTERNALSYM NERR_RplConfigNameUnavailable}

//*INTERNAL_ONLY*

//
//  Dfs API error codes.
//
//          NERR_BASE + (560-590)

  NERR_DfsInternalCorruption        = NERR_BASE + 560; // The internal database maintained by the DFS service is corrupt
  {$EXTERNALSYM NERR_DfsInternalCorruption}
  NERR_DfsVolumeDataCorrupt         = NERR_BASE + 561; // One of the records in the internal DFS database is corrupt
  {$EXTERNALSYM NERR_DfsVolumeDataCorrupt}
  NERR_DfsNoSuchVolume              = NERR_BASE + 562; // There is no DFS name whose entry path matches the input Entry Path
  {$EXTERNALSYM NERR_DfsNoSuchVolume}
  NERR_DfsVolumeAlreadyExists       = NERR_BASE + 563; // A root or link with the given name already exists
  {$EXTERNALSYM NERR_DfsVolumeAlreadyExists}
  NERR_DfsAlreadyShared             = NERR_BASE + 564; // The server share specified is already shared in the DFS
  {$EXTERNALSYM NERR_DfsAlreadyShared}
  NERR_DfsNoSuchShare               = NERR_BASE + 565; // The indicated server share does not support the indicated DFS namespace
  {$EXTERNALSYM NERR_DfsNoSuchShare}
  NERR_DfsNotALeafVolume            = NERR_BASE + 566; // The operation is not valid on this portion of the namespace
  {$EXTERNALSYM NERR_DfsNotALeafVolume}
  NERR_DfsLeafVolume                = NERR_BASE + 567; // The operation is not valid on this portion of the namespace
  {$EXTERNALSYM NERR_DfsLeafVolume}
  NERR_DfsVolumeHasMultipleServers  = NERR_BASE + 568; // The operation is ambiguous because the link has multiple servers
  {$EXTERNALSYM NERR_DfsVolumeHasMultipleServers}
  NERR_DfsCantCreateJunctionPoint   = NERR_BASE + 569; // Unable to create a link
  {$EXTERNALSYM NERR_DfsCantCreateJunctionPoint}
  NERR_DfsServerNotDfsAware         = NERR_BASE + 570; // The server is not DFS Aware
  {$EXTERNALSYM NERR_DfsServerNotDfsAware}
  NERR_DfsBadRenamePath             = NERR_BASE + 571; // The specified rename target path is invalid
  {$EXTERNALSYM NERR_DfsBadRenamePath}
  NERR_DfsVolumeIsOffline           = NERR_BASE + 572; // The specified DFS link is offline
  {$EXTERNALSYM NERR_DfsVolumeIsOffline}
  NERR_DfsNoSuchServer              = NERR_BASE + 573; // The specified server is not a server for this link
  {$EXTERNALSYM NERR_DfsNoSuchServer}
  NERR_DfsCyclicalName              = NERR_BASE + 574; // A cycle in the DFS name was detected
  {$EXTERNALSYM NERR_DfsCyclicalName}
  NERR_DfsNotSupportedInServerDfs   = NERR_BASE + 575; // The operation is not supported on a server-based DFS
  {$EXTERNALSYM NERR_DfsNotSupportedInServerDfs}
  NERR_DfsDuplicateService          = NERR_BASE + 576; // This link is already supported by the specified server-share
  {$EXTERNALSYM NERR_DfsDuplicateService}
  NERR_DfsCantRemoveLastServerShare = NERR_BASE + 577; // Can't remove the last server-share supporting this root or link
  {$EXTERNALSYM NERR_DfsCantRemoveLastServerShare}
  NERR_DfsVolumeIsInterDfs          = NERR_BASE + 578; // The operation is not supported for an Inter-DFS link
  {$EXTERNALSYM NERR_DfsVolumeIsInterDfs}
  NERR_DfsInconsistent              = NERR_BASE + 579; // The internal state of the DFS Service has become inconsistent
  {$EXTERNALSYM NERR_DfsInconsistent}
  NERR_DfsServerUpgraded            = NERR_BASE + 580; // The DFS Service has been installed on the specified server
  {$EXTERNALSYM NERR_DfsServerUpgraded}
  NERR_DfsDataIsIdentical           = NERR_BASE + 581; // The DFS data being reconciled is identical
  {$EXTERNALSYM NERR_DfsDataIsIdentical}
  NERR_DfsCantRemoveDfsRoot         = NERR_BASE + 582; // The DFS root cannot be deleted - Uninstall DFS if required
  {$EXTERNALSYM NERR_DfsCantRemoveDfsRoot}
  NERR_DfsChildOrParentInDfs        = NERR_BASE + 583; // A child or parent directory of the share is already in a DFS
  {$EXTERNALSYM NERR_DfsChildOrParentInDfs}
  NERR_DfsInternalError             = NERR_BASE + 590; // DFS internal error
  {$EXTERNALSYM NERR_DfsInternalError}

//
//  Net setup error codes.
//
//          NERR_BASE + (591-600)

  NERR_SetupAlreadyJoined           = NERR_BASE + 591; // This machine is already joined to a domain.
  {$EXTERNALSYM NERR_SetupAlreadyJoined}
  NERR_SetupNotJoined               = NERR_BASE + 592; // This machine is not currently joined to a domain.
  {$EXTERNALSYM NERR_SetupNotJoined}
  NERR_SetupDomainController        = NERR_BASE + 593; // This machine is a domain controller and cannot be unjoined from a domain.
  {$EXTERNALSYM NERR_SetupDomainController}
  NERR_DefaultJoinRequired          = NERR_BASE + 594; // The destination domain controller does not support creating machine accounts in OUs.
  {$EXTERNALSYM NERR_DefaultJoinRequired}
  NERR_InvalidWorkgroupName         = NERR_BASE + 595; // The specified workgroup name is invalid.
  {$EXTERNALSYM NERR_InvalidWorkgroupName}
  NERR_NameUsesIncompatibleCodePage = NERR_BASE + 596; // The specified computer name is incompatible with the default language used on the domain controller.
  {$EXTERNALSYM NERR_NameUsesIncompatibleCodePage}
  NERR_ComputerAccountNotFound      = NERR_BASE + 597; // The specified computer account could not be found.
  {$EXTERNALSYM NERR_ComputerAccountNotFound}
  NERR_PersonalSku                  = NERR_BASE + 598; // This version of Windows cannot be joined to a domain.
  {$EXTERNALSYM NERR_PersonalSku}

//
//  Some Password and account error results
//
//          NERR_BASE + (601 - 608)
//

  NERR_PasswordMustChange           = NERR_BASE  +  601;   // Password must change at next logon
  {$EXTERNALSYM NERR_PasswordMustChange}
  NERR_AccountLockedOut             = NERR_BASE  +  602;   // Account is locked out
  {$EXTERNALSYM NERR_AccountLockedOut}
  NERR_PasswordTooLong              = NERR_BASE  +  603;   // Password is too long
  {$EXTERNALSYM NERR_PasswordTooLong}
  NERR_PasswordNotComplexEnough     = NERR_BASE  +  604;   // Password doesn't meet the complexity policy
  {$EXTERNALSYM NERR_PasswordNotComplexEnough}
  NERR_PasswordFilterError          = NERR_BASE  +  605;   // Password doesn't meet the requirements of the filter dll's
  {$EXTERNALSYM NERR_PasswordFilterError}

//**********WARNING ****************
//The range 2750-2799 has been     *
//allocated to the IBM LAN Server  *
//*********************************

//**********WARNING ****************
//The range 2900-2999 has been     *
//reserved for Microsoft OEMs      *
//*********************************

//*END_INTERNAL*

  MAX_NERR = NERR_BASE + 899; // This is the last error in NERR range.
  {$EXTERNALSYM MAX_NERR}

//
// end of list
//
//    WARNING:  Do not exceed MAX_NERR; values above this are used by
//              other error code ranges (errlog.h, service.h, apperr.h).


{$ENDIF JWA_IMPLEMENTATIONSECTION}

{$IFNDEF JWA_OMIT_SECTIONS}
implementation
//uses ...
{$ENDIF JWA_OMIT_SECTIONS}

{$IFNDEF JWA_INTERFACESECTION}
//your implementation here
{$ENDIF JWA_INTERFACESECTION}


{$IFNDEF JWA_OMIT_SECTIONS}
end.
{$ENDIF JWA_OMIT_SECTIONS}


