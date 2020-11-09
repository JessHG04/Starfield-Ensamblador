
.include "cpctelera.h.s"
.include "cpctelera_functions.h.s"
.include "entity.h.s"
.include "render.h.s"
.include "generator.h.s"

.area _DATA
.area _CODE

;; DefineEntity _name,     _x,      _y,      _w,      _h,      _vx,     _vy,     _color
DefineEntity estrella,     0x49,    0x00,    0x02,    0x02,    0x00,    0x00,    HW_BRIGHT_WHITE 


_main::
   
   call cpct_disableFirmware_asm  
   call render_init ;;INICIA LA PALETA DE COLORES, DEFINE EL COLOR NEGRO DE FONDO Y EL COLOR BLANCO DE LAS ESTRELLAS
  
   ;;Genera tantas estrellas como se indique en el registro a
   ld a, #0x1E
   call generar
   


   ;;GENERO VELOCIDADES RANDOM PARA TODOS
   call ent_getNumEntities
   call ent_getIXPtr
   call random_vx_forAll

   ;;GENERO POSICIONES EN Y RANDOM PARA TODOS
   call ent_getNumEntities
   call ent_getIXPtr
   call random_y_forAll
   
loop:
   
   ld hl, #ent_clean
   call ent_doForAll
   ld hl, #ent_move
   call ent_doForAll
   ld hl, #ent_draw
   call ent_doForAll
   

   call ent_getNumEntities
   call ent_getIXPtr
   call set_for_destruction
   call ent_destroy

   ld a, #0x1E
   call generar

   call cpct_waitVSYNC_asm
   
   jr    loop