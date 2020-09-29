.include "cpctelera.h.s"

.globl entity_size
.globl rendersys_clear
;; INPUT
;;      IX: Pointer to first entity to render
;;      A: Number of entites to render
physics_move::
_phyloop:
   push     af
   call     rendersys_clear
   ld        a, 0(ix)
   add   4(ix)
   ld    0(ix), a
   pop      af
   dec       a
   ret       z

   ld      bc, #entity_size
   add     ix, bc
   jr _phyloop
   ret