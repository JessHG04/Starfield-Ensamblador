;;FUNCIONES DE DIBUJADO Y BORRADO DE ENTIDADES
.include "entity.h.s"
.include "cpctelera_functions.h.s"
.include "cpctelera.h.s"
.include "render.h.s"

;;CREA UNA PALETA CON COLORES BLANCO, AMARILLO Y NEGRO
palette:
    .db HW_BLACK            , HW_BRIGHT_YELLOW             , HW_BRIGHT_WHITE               , HW_BRIGHT_WHITE
    .db HW_BRIGHT_WHITE     , HW_BRIGHT_WHITE              , HW_BRIGHT_WHITE               , HW_BRIGHT_WHITE
    .db HW_BRIGHT_WHITE     , HW_BRIGHT_WHITE              , HW_BRIGHT_WHITE               , HW_BRIGHT_WHITE
    .db HW_BRIGHT_WHITE     , HW_BRIGHT_WHITE              , HW_BRIGHT_WHITE               , HW_BRIGHT_WHITE

;;CAMBIA EL MODO DE VÍDEO A 0, CARGA LA PALETA CREADA ANTERIORMENTE Y PINTA EL FONDO Y LOS BORDES
;;DESTRUYE C, HL, DE,     
render_init::
   ld c, #0
   call cpct_setVideoMode_asm
   ld hl, #palette
   ld de, #16
   call cpct_setPalette_asm
   cpctm_setBorder_asm HW_BLACK
ret

;;PINTA LAS ENTIDADES
ent_draw::
    
    ld      de, #CPCT_VMEM_START_ASM
    ld      c,  e_x(ix) 
    ld      b,  e_y(ix)  
    call cpct_getScreenPtr_asm 

    ex      de, hl
    ld a, e_color(ix)
    ld c, e_w(ix)
    ld b, e_h(ix)
    call cpct_drawSolidBox_asm

ret

;;BORRA LAS ENTIDADES (PINTANDO COLOR FONDO ENCIMA)
ent_clean::
    ld a, e_color(ix)
    ex af, af'          
    ld e_color(ix), #0
    
    call ent_draw

    ex af, af'
    ld e_color(ix), a   ;;Restaura el color original de la entidad
ret

