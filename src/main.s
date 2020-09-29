.include "cpctelera.h.s"
.area _DATA

.area _CODE

.globl cpct_disableFirmware_asm
.globl entityman_create
.globl rendersys_update
.globl star
.globl entityman_getEntityArray_IX
.globl entityman_getNumEntities_A
.globl rendersys_init
.globl physics_move
.globl cpct_waitVSYNC_asm
.globl rendersys_clear

star:    .db 0x14, 0x01, 0x02, 0x02, 0xFF, 0x00, 0xF0
starr:   .db 0x28, 0x0B, 0x02, 0x02, 0XFF, 0x00, 0xFF
starrr:  .db 0x32, 0x15, 0x02, 0x02, 0XFF, 0x00, 0x0F

_main::
   call cpct_disableFirmware_asm

   ;;Init systems
   call rendersys_init

   ld    hl, #star
   call entityman_create

   ld    hl, #starr
   call entityman_create

   ld    hl, #starrr
   call entityman_create

loop:
   ;;call entityman_getEntityArray_IX
   ;;call entityman_getNumEntities_A
   ;;call rendersys_clear

   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call physics_move
   
   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call rendersys_update

   call cpct_waitVSYNC_asm
   jr    loop