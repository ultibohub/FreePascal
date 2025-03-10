{
    This file is part of the Free Pascal run time library.
    Copyright (c) 2013 by Free Pascal development team

    This file implements all the base types and limits required
    for a minimal POSIX compliant subset required to port the compiler
    to a new OS.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{Platform specific information}
type
  THandle = LongInt;
  TThreadID = Pointer;
  TOSTimestamp = LongInt;

  PRTLCriticalSection = ^TRTLCriticalSection;
  TRTLCriticalSection = record
    Locked: LongInt; // integer so we can use wait32.
    Count: LongInt; // Number of times locked.
    Waiters : LongInt; // Number of waiters
    Kind : LongInt; // Kind of mutex, Equals Ord(TMutexKind)
    Owner : TThreadID;  // Owner thread (who holds the lock)
    Creator : TThreadID;  // Creator thread
    Destroying : Boolean; // Set when notifying that we're destroying the mutex.
  end;
