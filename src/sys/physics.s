.include "physics.h.s"
.include "man/entity.h.s"
.include "render.h.s"
.include "cpctelera.h.s"

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