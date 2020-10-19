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

;;physics_move::
;;_phyloop:
;;   push     af
;;   ;;call     rendersys_clear
;;
;;   ;;RENDER CLEAR
;;   ld               a, 6(ix)  
;;   ex              af, af'    
;;   ld           6(ix), #0x00
;;   call      rendersys_update_one ;;Vuelve otro A
;;   ex             af, af'
;;   ld          6(ix),a
;;   ;;;;;;;;;;;;
;;   ld              a, 0(ix)
;;   add   4(ix)
;;   jr              c, _carry
;;   jr             nc, _seguir
;;_seguir:
;;   ld    0(ix), a
;;   pop      af
;;   dec       a
;;   ret       z
;;
;;   ld      bc, #entity_size
;;   add     ix, bc
;;   jr _phyloop
;;   ret
;;_carry:
;;   ex    af, af'
;;   ld    5(ix), #0x10
;;   ex    af, af'
;;   jr    _seguir

physics_move::
_phyloop:
   push     af
   ;;call     rendersys_clear

   ;;RENDER CLEAR
   ld               a, 6(ix)  
   ex              af, af'    
   ld           6(ix), #0x00
   call      rendersys_update_one ;;Vuelve otro A
   ex             af, af'
   ld          6(ix),a
   ;;;;;;;;;;;;
   ld              a, 0(ix)
   add   4(ix)
   ld    0(ix), a
   cp       #0x00
   jr              z, _carry
   cp       #0x50
   jr              z, _carry
   ;;cp       #0xA0
   ;;jr              z, _carry
   ;;cp       #0xF0
   ;;jr              z, _carry
   ;;cp       #0x40
   ;;jr              z, _carry
   ;;cp       #0x90
   ;;jr              z, _carry
   ;;cp       #0xE0
   ;;jr              z, _carry
   ;;cp       #0x30
   ;;jr              z, _carry
   ;;cp       #0x80
   ;;jr              z, _carry
   ;;cp       #0xD0
   ;;jr              z, _carry
   ;;cp       #0x20
   ;;jr              z, _carry
   ;;cp       #0x70
   ;;jr              z, _carry
   ;;cp       #0xC0
   ;;jr              z, _carry
   ;;cp       #0x10
   ;;jr              z, _carry
   ;;cp       #0x60
   ;;jr              z, _carry
   ;;cp       #0xB0
   ;;jr              z, _carry
   jr             nc, _seguir
_seguir:
   pop      af
   dec       a
   ret       z

   ld      bc, #entity_size
   add     ix, bc
   jr _phyloop
   ret
_carry:
   ex    af, af'
   ld    5(ix), #0x10
   ex    af, af'
   jr    _seguir