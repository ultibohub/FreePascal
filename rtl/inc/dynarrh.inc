{
    This file is part of the Free Pascal Run time library.
    Copyright (c) 1999-2005 by the Free Pascal development team

    This file contains type declarations necessary for the dynamic
    array routine helpers in syshelp.inc

    See the File COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


**********************************************************************}

type
  tdynarrayindex = sizeint;
  pdynarrayindex = ^tdynarrayindex;

  pdynarraytypeinfo = ^tdynarraytypeinfo;
  ppdynarraytypeinfo = ^pdynarraytypeinfo;
  tdynarraytypeinfo = packed record
    kind : TTypeKind;
    namelen : byte;
    { here the chars follow, we've to skip them }
    elesize : sizeint;
    eletype : ppdynarraytypeinfo;
    vartype : longint;
  end;
  
procedure DynArraySetLength(var a: Pointer; typeInfo: Pointer; dimCnt: SizeInt; lengthVec: PSizeInt);
function DynArraySize(a : pointer): tdynarrayindex;
procedure DynArrayClear(var a: Pointer; typeInfo: Pointer);
function DynArrayDim(typeInfo: Pointer): Integer;
function DynArrayBounds(a: Pointer; typeInfo: Pointer): TBoundArray;
procedure DynArrayAssign(var dest: Pointer; src: Pointer; typeInfo: pointer);


function IsDynArrayRectangular(a: Pointer; typeInfo: Pointer): Boolean;
function DynArrayIndex(a: Pointer; const indices: array of SizeInt; typeInfo: Pointer): Pointer;

procedure fpc_dynarray_rangecheck(p : pointer;i : tdynarrayindex); compilerproc;
