.include "cpctelera.h.s"
.include "entity.h.s"

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_setVideoMode_asm

rendersys_init::
    ld      c, #0x00
    call cpct_setVideoMode_asm
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

rendersys_update_one::
    ld      de, #0xC000
    ld       c, 0(ix)   ;;X
    ld       b, 1(ix)   ;;Y
    call    cpct_getScreenPtr_asm

    ex      de, hl
    ld       a, 6(ix)   ;;Color
    ld       c, 2(ix)   ;;Width
    ld       b, 3(ix)   ;;Height
    call    cpct_drawSolidBox_asm
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Elimina (en plan limpia bro, no destruye tu vida) a una entidad
;; Registros destruidos: AF, BC, DE, HL
;; Entrada: ix -> Puntero a entidad
;;          a -> Numero total de entidades
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;rendersys_clear::
;;_rendcloop:
;;    push        af  
;;    ld               a, 6(ix)  
;;    ex              af, af'     
;;    ld           6(ix), #0x00
;;    pop         af              
;;    push        af
;;    push        ix
;;    call      entityman_getEntityArray_IX
;;    call      entityman_getNumEntities_A
;;    call      rendersys_update ;;Vuelve otro A
    
;;    pop         ix
;;    pop         af      
;;    ex              af, af' 
;;    ld           6(ix), a

;;    ex              af, af' 
;;    dec         a 
;;    ret z

;;    ld      bc, #entity_size
;;    add     ix, bc
;;    jr _rendcloop
;;    ret

rendersys_clear::
    ld               a, 6(ix)  
    ex              af, af'    
    ld           6(ix), #0x00
    ;;push ix
    ;;call      entityman_getEntityArray_IX
    ;;call      entityman_getNumEntities_A
    call      rendersys_update_one ;;Vuelve otro A
    ;;pop ix
    ex          af, af'
    ld      6(ix),a
