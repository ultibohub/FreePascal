{

    This file is part of the Free Pascal run time library.
    Copyright (c) 2021 by the Free Pascal development team.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

  fpc_in_wasm32_memory_size = fpc_in_cpu_first;
  fpc_in_wasm32_memory_grow = fpc_in_cpu_first+1;
  fpc_in_wasm32_unreachable = fpc_in_cpu_first+2;
