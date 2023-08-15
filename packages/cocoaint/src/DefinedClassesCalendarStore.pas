{$mode delphi}
{$modeswitch objectivec1}
{$modeswitch cvar}
{$packrecords c}

{$IFNDEF FPC_DOTTEDUNITS}
unit DefinedClassesCalendarStore;
{$ENDIF FPC_DOTTEDUNITS}
interface

type
  CalAlarm = objcclass external;
  CalAttendee = objcclass external;
  CalCalendar = objcclass external;
  CalCalendarItem = objcclass external;
  CalCalendarStore = objcclass external;
  CalEvent = objcclass external;
  CalNthWeekDay = objcclass external;
  CalRecurrenceEnd = objcclass external;
  CalRecurrenceRule = objcclass external;
  CalTask = objcclass external;

type
  NSColor = objcclass external;

implementation
end.
