{	CFTimeZone.h
	Copyright (c) 1998-2013, Apple Inc. All rights reserved.
}
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
unit CFTimeZone;
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
uses MacOsApi.MacTypes,MacOsApi.CFBase,MacOsApi.CFArray,MacOsApi.CFData,MacOsApi.CFDate,MacOsApi.CFDictionary,MacOsApi.CFLocale,MacOsApi.CFString;
{$ELSE FPC_DOTTEDUNITS}
uses MacTypes,CFBase,CFArray,CFData,CFDate,CFDictionary,CFLocale,CFString;
{$ENDIF FPC_DOTTEDUNITS}
{$endc} {not MACOSALLINCLUDE}

{$ALIGN POWER}


function CFTimeZoneGetTypeID: CFTypeID; external name '_CFTimeZoneGetTypeID';

function CFTimeZoneCopySystem: CFTimeZoneRef; external name '_CFTimeZoneCopySystem';

procedure CFTimeZoneResetSystem; external name '_CFTimeZoneResetSystem';

function CFTimeZoneCopyDefault: CFTimeZoneRef; external name '_CFTimeZoneCopyDefault';

procedure CFTimeZoneSetDefault( tz: CFTimeZoneRef ); external name '_CFTimeZoneSetDefault';

function CFTimeZoneCopyKnownNames: CFArrayRef; external name '_CFTimeZoneCopyKnownNames';

function CFTimeZoneCopyAbbreviationDictionary: CFDictionaryRef; external name '_CFTimeZoneCopyAbbreviationDictionary';

procedure CFTimeZoneSetAbbreviationDictionary( dict: CFDictionaryRef ); external name '_CFTimeZoneSetAbbreviationDictionary';

function CFTimeZoneCreate( allocator: CFAllocatorRef; name: CFStringRef; data: CFDataRef ): CFTimeZoneRef; external name '_CFTimeZoneCreate';

function CFTimeZoneCreateWithTimeIntervalFromGMT( allocator: CFAllocatorRef; ti: CFTimeInterval ): CFTimeZoneRef; external name '_CFTimeZoneCreateWithTimeIntervalFromGMT';

function CFTimeZoneCreateWithName( allocator: CFAllocatorRef; name: CFStringRef; tryAbbrev: Boolean ): CFTimeZoneRef; external name '_CFTimeZoneCreateWithName';

function CFTimeZoneGetName( tz: CFTimeZoneRef ): CFStringRef; external name '_CFTimeZoneGetName';

function CFTimeZoneGetData( tz: CFTimeZoneRef ): CFDataRef; external name '_CFTimeZoneGetData';

function CFTimeZoneGetSecondsFromGMT( tz: CFTimeZoneRef; at: CFAbsoluteTime ): CFTimeInterval; external name '_CFTimeZoneGetSecondsFromGMT';

function CFTimeZoneCopyAbbreviation( tz: CFTimeZoneRef; at: CFAbsoluteTime ): CFStringRef; external name '_CFTimeZoneCopyAbbreviation';

function CFTimeZoneIsDaylightSavingTime( tz: CFTimeZoneRef; at: CFAbsoluteTime ): Boolean; external name '_CFTimeZoneIsDaylightSavingTime';

function CFTimeZoneGetDaylightSavingTimeOffset( tz: CFTimeZoneRef; at: CFAbsoluteTime ): CFTimeInterval; external name '_CFTimeZoneGetDaylightSavingTimeOffset';
(* CF_AVAILABLE_STARTING(10_5, 2_0) *)

function CFTimeZoneGetNextDaylightSavingTimeTransition( tz: CFTimeZoneRef; at: CFAbsoluteTime ): CFAbsoluteTime; external name '_CFTimeZoneGetNextDaylightSavingTimeTransition';
(* CF_AVAILABLE_STARTING(10_5, 2_0) *)

type
	CFTimeZoneNameStyle = CFIndex;

const
	kCFTimeZoneNameStyleStandard = 0;
	kCFTimeZoneNameStyleShortStandard = 1;
	kCFTimeZoneNameStyleDaylightSaving = 2;
	kCFTimeZoneNameStyleShortDaylightSaving = 3;
	kCFTimeZoneNameStyleGeneric = 4;
	kCFTimeZoneNameStyleShortGeneric = 5;

function CFTimeZoneCopyLocalizedName( tz: CFTimeZoneRef; style: CFTimeZoneNameStyle; locale: CFLocaleRef ): CFStringRef; external name '_CFTimeZoneCopyLocalizedName';
(* CF_AVAILABLE_STARTING(10_5, 2_0) *)

var kCFTimeZoneSystemTimeZoneDidChangeNotification: CFStringRef; external name '_kCFTimeZoneSystemTimeZoneDidChangeNotification'; (* attribute const *)
(* CF_AVAILABLE_STARTING(10_5, 2_0) *)


{$ifc not defined MACOSALLINCLUDE or not MACOSALLINCLUDE}

end.
{$endc} {not MACOSALLINCLUDE}
