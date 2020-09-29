.include "cpctelera.h.s"

.globl entity_size
.globl rendersys_clear
.globl rendersys_update_one
;; INPUT
;;      IX: Pointer to first entity to render
;;      A: Number of entites to render
;;physics_move::
;;_phyloop:
;;   push     af
;;   call     rendersys_clear
;;   ld        a, 0(ix)
;;   add   4(ix)
;;   ld    0(ix), a
;;   pop      af
;;   dec       a
;;   ret       z

;;   ld      bc, #entity_size
;;   add     ix, bc
;;   jr _phyloop
;;   ret

physics_move::
_phyloop:
   push     af
   ;;call     rendersys_clear

   ;;RENDER CLEAR
   ld               a, 6(ix)  
   ex              af, af'    
   ld           6(ix), #0x00
   call      rendersys_update_one ;;Vuelve otro A
   ex          af, af'
   ld      6(ix),a
   ;;;;;;;;;;;;
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