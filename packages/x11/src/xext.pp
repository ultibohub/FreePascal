(*
 *
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
 *)

unit xext;

{$PACKRECORDS C}

interface

uses
  ctypes, xlib;

const
  libXext = 'Xext';
  X_EXTENSION_UNKNOWN = 'unknown';
  X_EXTENSION_MISSING = 'missing';

type
  XextErrorHandler = function(
    dpy: PDisplay;
    {_Xconst} ext_name: PAnsiChar;
    {_Xconst} reason: PAnsiChar
  ): cint; cdecl;

function XSetExtensionErrorHandler(
    handler: XextErrorHandler
): XextErrorHandler; cdecl; external libXext;

function XMissingExtension(
    dpy: PDisplay;
    {_Xconst} ext_name: PAnsiChar
): cint; cdecl; external libXext;

implementation

end.
