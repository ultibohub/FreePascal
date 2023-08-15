{!
	@file		AudioUnitCarbonView.h
 	@framework	AudioToolbox.framework
 	@copyright	(c) 2000-2015 Apple, Inc. All rights reserved.
	@abstract	Deprecated interfaces for using Carbon-based views of Audio Units.
}
{	  Pascal Translation:  Gorazd Krosl <gorazd_1957@yahoo.ca>, October 2009 }

{
    Modified for use with Free Pascal
    Version 308
    Please report any bugs to <gpc@microbizz.nl>
}

{$ifc not defined MACOSALLINCLUDE or not MACOSALLINCLUDE}
{$mode macpas}
{$modeswitch cblocks}
{$packenum 1}
{$macro on}
{$inline on}
{$calling mwpascal}

{$IFNDEF FPC_DOTTEDUNITS}
unit AudioUnitCarbonViews;
{$ENDIF FPC_DOTTEDUNITS}
interface
{$setc UNIVERSAL_INTERFACES_VERSION := $0400}
{$setc GAP_INTERFACES_VERSION := $0308}

{$ifc not defined USE_CFSTR_CONSTANT_MACROS}
    {$setc USE_CFSTR_CONSTANT_MACROS := TRUE}
{$endc}

{$ifc defined CPUPOWERPC and defined CPUI386}
	{$error Conflicting initial definitions for CPUPOWERPC and CPUI386}
{$endc}
{$ifc defined FPC_BIG_ENDIAN and defined FPC_LITTLE_ENDIAN}
	{$error Conflicting initial definitions for FPC_BIG_ENDIAN and FPC_LITTLE_ENDIAN}
{$endc}

{$ifc not defined __ppc__ and defined CPUPOWERPC32}
	{$setc __ppc__ := 1}
{$elsec}
	{$setc __ppc__ := 0}
{$endc}
{$ifc not defined __ppc64__ and defined CPUPOWERPC64}
	{$setc __ppc64__ := 1}
{$elsec}
	{$setc __ppc64__ := 0}
{$endc}
{$ifc not defined __i386__ and defined CPUI386}
	{$setc __i386__ := 1}
{$elsec}
	{$setc __i386__ := 0}
{$endc}
{$ifc not defined __x86_64__ and defined CPUX86_64}
	{$setc __x86_64__ := 1}
{$elsec}
	{$setc __x86_64__ := 0}
{$endc}
{$ifc not defined __arm__ and defined CPUARM}
	{$setc __arm__ := 1}
{$elsec}
	{$setc __arm__ := 0}
{$endc}
{$ifc not defined __arm64__ and defined CPUAARCH64}
  {$setc __arm64__ := 1}
{$elsec}
  {$setc __arm64__ := 0}
{$endc}

{$ifc defined cpu64}
  {$setc __LP64__ := 1}
{$elsec}
  {$setc __LP64__ := 0}
{$endc}


{$ifc defined __ppc__ and __ppc__ and defined __i386__ and __i386__}
	{$error Conflicting definitions for __ppc__ and __i386__}
{$endc}

{$ifc defined __ppc__ and __ppc__}
	{$setc TARGET_CPU_PPC := TRUE}
	{$setc TARGET_CPU_PPC64 := FALSE}
	{$setc TARGET_CPU_X86 := FALSE}
	{$setc TARGET_CPU_X86_64 := FALSE}
	{$setc TARGET_CPU_ARM := FALSE}
	{$setc TARGET_CPU_ARM64 := FALSE}
	{$setc TARGET_OS_MAC := TRUE}
	{$setc TARGET_OS_IPHONE := FALSE}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
	{$setc TARGET_OS_EMBEDDED := FALSE}
{$elifc defined __ppc64__ and __ppc64__}
	{$setc TARGET_CPU_PPC := FALSE}
	{$setc TARGET_CPU_PPC64 := TRUE}
	{$setc TARGET_CPU_X86 := FALSE}
	{$setc TARGET_CPU_X86_64 := FALSE}
	{$setc TARGET_CPU_ARM := FALSE}
	{$setc TARGET_CPU_ARM64 := FALSE}
	{$setc TARGET_OS_MAC := TRUE}
	{$setc TARGET_OS_IPHONE := FALSE}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
	{$setc TARGET_OS_EMBEDDED := FALSE}
{$elifc defined __i386__ and __i386__}
	{$setc TARGET_CPU_PPC := FALSE}
	{$setc TARGET_CPU_PPC64 := FALSE}
	{$setc TARGET_CPU_X86 := TRUE}
	{$setc TARGET_CPU_X86_64 := FALSE}
	{$setc TARGET_CPU_ARM := FALSE}
	{$setc TARGET_CPU_ARM64 := FALSE}
{$ifc defined iphonesim}
 	{$setc TARGET_OS_MAC := FALSE}
	{$setc TARGET_OS_IPHONE := TRUE}
	{$setc TARGET_IPHONE_SIMULATOR := TRUE}
{$elsec}
	{$setc TARGET_OS_MAC := TRUE}
	{$setc TARGET_OS_IPHONE := FALSE}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
{$endc}
	{$setc TARGET_OS_EMBEDDED := FALSE}
{$elifc defined __x86_64__ and __x86_64__}
	{$setc TARGET_CPU_PPC := FALSE}
	{$setc TARGET_CPU_PPC64 := FALSE}
	{$setc TARGET_CPU_X86 := FALSE}
	{$setc TARGET_CPU_X86_64 := TRUE}
	{$setc TARGET_CPU_ARM := FALSE}
	{$setc TARGET_CPU_ARM64 := FALSE}
{$ifc defined iphonesim}
 	{$setc TARGET_OS_MAC := FALSE}
	{$setc TARGET_OS_IPHONE := TRUE}
	{$setc TARGET_IPHONE_SIMULATOR := TRUE}
{$elsec}
	{$setc TARGET_OS_MAC := TRUE}
	{$setc TARGET_OS_IPHONE := FALSE}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
{$endc}
	{$setc TARGET_OS_EMBEDDED := FALSE}
{$elifc defined __arm__ and __arm__}
	{$setc TARGET_CPU_PPC := FALSE}
	{$setc TARGET_CPU_PPC64 := FALSE}
	{$setc TARGET_CPU_X86 := FALSE}
	{$setc TARGET_CPU_X86_64 := FALSE}
	{$setc TARGET_CPU_ARM := TRUE}
	{$setc TARGET_CPU_ARM64 := FALSE}
	{$setc TARGET_OS_MAC := FALSE}
	{$setc TARGET_OS_IPHONE := TRUE}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
	{$setc TARGET_OS_EMBEDDED := TRUE}
{$elifc defined __arm64__ and __arm64__}
	{$setc TARGET_CPU_PPC := FALSE}
	{$setc TARGET_CPU_PPC64 := FALSE}
	{$setc TARGET_CPU_X86 := FALSE}
	{$setc TARGET_CPU_X86_64 := FALSE}
	{$setc TARGET_CPU_ARM := FALSE}
	{$setc TARGET_CPU_ARM64 := TRUE}
{$ifc defined ios}
	{$setc TARGET_OS_MAC := FALSE}
	{$setc TARGET_OS_IPHONE := TRUE}
	{$setc TARGET_OS_EMBEDDED := TRUE}
{$elsec}
	{$setc TARGET_OS_MAC := TRUE}
	{$setc TARGET_OS_IPHONE := FALSE}
	{$setc TARGET_OS_EMBEDDED := FALSE}
{$endc}
	{$setc TARGET_IPHONE_SIMULATOR := FALSE}
{$elsec}
	{$error __ppc__ nor __ppc64__ nor __i386__ nor __x86_64__ nor __arm__ nor __arm64__ is defined.}
{$endc}

{$ifc defined __LP64__ and __LP64__ }
  {$setc TARGET_CPU_64 := TRUE}
{$elsec}
  {$setc TARGET_CPU_64 := FALSE}
{$endc}

{$ifc defined FPC_BIG_ENDIAN}
	{$setc TARGET_RT_BIG_ENDIAN := TRUE}
	{$setc TARGET_RT_LITTLE_ENDIAN := FALSE}
{$elifc defined FPC_LITTLE_ENDIAN}
	{$setc TARGET_RT_BIG_ENDIAN := FALSE}
	{$setc TARGET_RT_LITTLE_ENDIAN := TRUE}
{$elsec}
	{$error Neither FPC_BIG_ENDIAN nor FPC_LITTLE_ENDIAN are defined.}
{$endc}
{$setc ACCESSOR_CALLS_ARE_FUNCTIONS := TRUE}
{$setc CALL_NOT_IN_CARBON := FALSE}
{$setc OLDROUTINENAMES := FALSE}
{$setc OPAQUE_TOOLBOX_STRUCTS := TRUE}
{$setc OPAQUE_UPP_TYPES := TRUE}
{$setc OTCARBONAPPLICATION := TRUE}
{$setc OTKERNEL := FALSE}
{$setc PM_USE_SESSION_APIS := TRUE}
{$setc TARGET_API_MAC_CARBON := TRUE}
{$setc TARGET_API_MAC_OS8 := FALSE}
{$setc TARGET_API_MAC_OSX := TRUE}
{$setc TARGET_CARBON := TRUE}
{$setc TARGET_CPU_68K := FALSE}
{$setc TARGET_CPU_MIPS := FALSE}
{$setc TARGET_CPU_SPARC := FALSE}
{$setc TARGET_OS_UNIX := FALSE}
{$setc TARGET_OS_WIN32 := FALSE}
{$setc TARGET_RT_MAC_68881 := FALSE}
{$setc TARGET_RT_MAC_CFM := FALSE}
{$setc TARGET_RT_MAC_MACHO := TRUE}
{$setc TYPED_FUNCTION_POINTERS := TRUE}
{$setc TYPE_BOOL := FALSE}
{$setc TYPE_EXTENDED := FALSE}
{$setc TYPE_LONGLONG := TRUE}
{$IFDEF FPC_DOTTEDUNITS}
uses MacOsApi.MacTypes,MacOsApi.MacWindows,MacOsApi.HIObject,MacOsApi.QuickdrawTypes,MacOsApi.AUComponent,MacOsApi.Components;
{$ELSE FPC_DOTTEDUNITS}
uses MacTypes,MacWindows,HIObject,QuickdrawTypes,AUComponent,Components;
{$ENDIF FPC_DOTTEDUNITS}
{$endc} {not MACOSALLINCLUDE}

{$ifc TARGET_OS_MAC}
{$ALIGN MAC68K}


{!
	@header		AudioUnitCarbonView
	@abstract	This file defines interfaces for creating and event handling in carbon-based views of Audio Units.
}

{!
	@typedef	AudioUnitCarbonView
	@abstract	An audio unit Carbon view is of type ComponentInstance, defined by the Component Manager.
}
type
	AudioUnitCarbonView = ComponentInstance;

{!
	@enum		Carbon view component types and subtypes
	@constant	kAudioUnitCarbonViewComponentType
					The four AnsiChar-code type of a carbon-based view component
	@constant	kAUCarbonViewSubType_Generic
					The four AnsiChar-code subtype of a carbon-based view component
}
const
	kAudioUnitCarbonViewComponentType = FourCharCode('auvw');
	kAUCarbonViewSubType_Generic = FourCharCode('gnrc');


{!
	@enum		Carbon view events
	@constant	kAudioUnitCarbonViewEvent_MouseDownInControl
					The event type indicating that the mouse is pressed in a control
	@constant	kAudioUnitCarbonViewEvent_MouseUpInControl
					The event type indicating that the mouse is released in a control
}
const
	kAudioUnitCarbonViewEvent_MouseDownInControl = 0;
	kAudioUnitCarbonViewEvent_MouseUpInControl = 1;

{!
	@typedef	AudioUnitcarbViewEventID
	@abstract	Specifies an event passed to an AudioUnitCarbonViewEventListener callback.
}
type
	AudioUnitCarbonViewEventID = SInt32;

{!
	@typedef	AudioUnitCarbonViewEventListener
	@abstract	Defines a callback function that is called when certain events occur in an
				Audio Unit Carbon view, such as mouse-down and up events on a control.
				
	@param		inUserData
					A user-defined pointer that was passed to an AudioUnitCarbonViewSetEventListener callback.
	@param		inView
					The Audio unit Carbon vIew that generated the message.
	@param		inParameter
					The parameter associated with the control generating the message.
	@param		inEvent
					The type of event, as listed in Audio unit Carbon view events.
	@param		inEventParam
					Further information about the event, dependent on its type.
}
//#ifndef __LP64__
{$ifc not TARGET_CPU_64}
type
	AudioUnitCarbonViewEventListener = procedure( inUserData: UnivPtr; inView: AudioUnitCarbonView; const (*var*) inParameter: AudioUnitParameter; inEvent: AudioUnitCarbonViewEventID; inEventParam: {const} UnivPtr );
{$endc}

{!
	@function	AudioUnitCarbonViewCreate
	@abstract	A callback that tells an Audio unit Carbon view to open its user interface (user pane).
	@discussion	The host application specifies the audio unit which the view is to control. The host 
				also provides the window, parent control, and rectangle into which the Audio unit 
				Carbon view component (of type AudioUnitCarbonView) is to create itself.

				The host application is responsible for closing the component (by calling the
				CloseComponent function) before closing its window.
				
	@param		inView
					The view component instance.
	@param		inAudioUnit
					The audio unit component instance which the view is to control.
	@param		inWindow
					The Carbon window in which the user interface is to be opened.
	@param		inParentControl
					The Carbon control into which the user interface is to be embedded. 
					(This is typically the window's root control).
	@param		inLocation
					The host application's requested location for the view. The view should 
					always create itself at the specified location.
	@param		inSize
					The host application's requested size for the view. The view may choose a 
					different size for itself. The actual dimensions of the view are described 
					by the value of the outControl parameter.
	@param		outControl
					The Carbon control which contains the entire user interface for the view.
}
{$ifc not TARGET_CPU_64}
function AudioUnitCarbonViewCreate( inView: AudioUnitCarbonView; inAudioUnit: AudioUnit; inWindow: WindowRef; inParentControl: ControlRef; const inLocation: Float32PointPtr; const inSize: Float32PointPtr; var outControl: ControlRef ): OSStatus; external name '_AudioUnitCarbonViewCreate';
(* API_DEPRECATED("no longer supported", macos(10.2, 10.11)) API_UNAVAILABLE(ios, watchos, tvos) *)

{!
	@function	AudioUnitCarbonViewSetEventListener
	@abstract	Add an event listener to the carbon view.
	@deprecated	in Mac OS X version 10.4
	@discussion	Use the AUEventListener functions in <AudioToolbox/AudioUnitUtilities.h> instead.
	
	@param		inView
					The Carbon view component instance.
	@param		inCallback
					The event listener callback function.
	@param		inUserData
					A user data pointer passed to the callback.
}
function AudioUnitCarbonViewSetEventListener( inView: AudioUnitCarbonView; inCallback: AudioUnitCarbonViewEventListener; inUserData: UnivPtr ): OSStatus; external name '_AudioUnitCarbonViewSetEventListener';
(* __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2,__MAC_10_4, __IPHONE_NA, __IPHONE_NA) *)
{$endc}

{!
	@enum		Selectors for component calls
	@constant	kAudioUnitCarbonViewRange
					Range of selectors
	@constant	kAudioUnitCarbonViewCreateSelect
					Selector for creating the carbon view
	@constant	kAudioUnitCarbonViewSetEventListenerSelect
					Selector for setting the event listener callback
}
const
	kAudioUnitCarbonViewRange = $0300;	// range of selectors
	kAudioUnitCarbonViewCreateSelect = $0301;
	kAudioUnitCarbonViewSetEventListenerSelect = $0302;


{$endc}	{ TARGET_OS_MAC }{$ifc not defined MACOSALLINCLUDE or not MACOSALLINCLUDE}

end.
{$endc} {not MACOSALLINCLUDE}
