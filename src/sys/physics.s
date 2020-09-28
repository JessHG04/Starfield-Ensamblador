.include "cpctelera.h.s"

physics_move:
   ld          a, 0(ix)
   add   4(ix)
   ld    0(ix), a

   ret