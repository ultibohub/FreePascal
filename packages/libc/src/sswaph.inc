
const
   SWAP_FLAG_PREFER = $8000;
   SWAP_FLAG_PRIO_MASK = $7fff;
   SWAP_FLAG_PRIO_SHIFT = 0;

function swapon(__path:PAnsiChar; __flags:longint):longint;cdecl;external clib name 'swapon';
function swapoff(__path:PAnsiChar):longint;cdecl;external clib name 'swapoff';

{ ---------------------------------------------------------------------
    Borland compatibility types
  ---------------------------------------------------------------------}

// Type
