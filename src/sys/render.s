.include "cpctelera.h.s"

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl entity_size

rendersys_init::

    ret
;; INPUT
;;      IX: Pointer to first entity to render
;;      A: Number of entites to render
rendersys_update::

_renloop:
    push    af
    ld      de, #0xC000
    ld       c, 0(ix)   ;;X
    ld       b, 1(ix)   ;;Y
    call    cpct_getScreenPtr_asm

    ex      de, hl
    ld       a, 6(ix)   ;;Color
    ld       c, 2(ix)   ;;Width
    ld       b, 3(ix)   ;;Height
    call    cpct_drawSolidBox_asm

    pop     af
    dec     a
    ret     z

    ld      bc, #entity_size
    add     ix, bc
    jr _renloop
    ret