(*
 * Copyright � 2007-2008 Peter Hutterer
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * Authors: Peter Hutterer, University of South Australia, NICTA
 *
 *)
{$IFNDEF FPC_DOTTEDUNITS}
unit xge;
{$ENDIF FPC_DOTTEDUNITS}

interface

{$PACKRECORDS C}

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.CTypes, Api.X11.X, Api.X11.Xlib;
{$ELSE FPC_DOTTEDUNITS}
uses
  ctypes, x, xlib;
{$ENDIF FPC_DOTTEDUNITS}

const
  libXge = 'Xext';

{ XGE Client interfaces }

//_XFUNCPROTOBEGIN

type
(**
 * Generic Event mask.
 * To be used whenever a list of masks per extension has to be provided.
 *
 * But, don't actually use the CARD{8,16,32} types.  We can't get them them
 * defined here without polluting the namespace.
 *)
  PXGenericEventMask = ^TXGenericEventMask;
  TXGenericEventMask = record
    extension: cuchar;
    pad0: cuchar;
    pad1: cushort;
    evmask: cuint;
  end;

function XGEQueryExtension(dpy: PDisplay; event_basep: Pcint; err_basep: Pcint): TBoolResult; cdecl; external libXge;
function XGEQueryVersion(dpy: PDisplay; major: Pcint; minor: Pcint): TBoolResult; cdecl; external libXge;

//_XFUNCPROTOEND

implementation
end.
