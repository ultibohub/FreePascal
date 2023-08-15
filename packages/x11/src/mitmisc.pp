(************************************************************

Copyright 1989, 1998  The Open Group

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of The Open Group shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from The Open Group.

********************************************************)

(* RANDOM CRUFT! THIS HAS NO OFFICIAL X CONSORTIUM OR X PROJECT TEAM BLESSING *)

{$IFNDEF FPC_DOTTEDUNITS}
unit mitmisc;
{$ENDIF FPC_DOTTEDUNITS}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.CTypes, Api.X11.Xlib;
{$ELSE FPC_DOTTEDUNITS}
uses
  ctypes, xlib;
{$ENDIF FPC_DOTTEDUNITS}

const
  libXext = 'Xext';

{$I mitmiscconst.inc}

function XMITMiscQueryExtension(
    dpy: PDisplay;
    event_basep,
    error_basep: Pcint
): TBoolResult; cdecl; external libXext;

function XMITMiscSetBugMode(
    dpy: PDisplay;
    onOff: TBool
): TStatus; cdecl; external libXext;

function XMITMiscGetBugMode(
    dpy: PDisplay
): TBoolResult; cdecl; external libXext;

{ boolean overload for the TBool parameter }

function XMITMiscSetBugMode(
    dpy: PDisplay;
    onOff: Boolean
): TStatus;

implementation

function XMITMiscSetBugMode(
    dpy: PDisplay;
    onOff: Boolean
): TStatus;
begin
  XMITMiscSetBugMode := XMITMiscSetBugMode(dpy,Ord(onOff));
end;

end.
