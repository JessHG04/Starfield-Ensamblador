.include "cpctelera.h.s"
.area _DATA

.area _CODE

.globl cpct_disableFirmware_asm
.globl entityman_create
.globl rendersys_update

.globl entityman_getEntityArray_IX
.globl entityman_getNumEntities_A
.globl rendersys_init
.globl physics_move
.globl cpct_waitVSYNC_asm
.globl rendersys_clear

s:      .db 0x14, 0x14, 0x02, 0x02, 0xFF, 0x00, 26
st:     .db 0x28, 0x28, 0x02, 0x02, 0xFD, 0x00, 26
sta:    .db 0x42, 0x42, 0x02, 0x02, 0xFB, 0x00, 26
star:   .db 0x56, 0x56, 0x02, 0x02, 0xFD, 0x00, 26

ss:     .db 0x20, 0x15, 0x02, 0x02, 0xFA, 0x00, 26
sst:    .db 0x40, 0x35, 0x02, 0x02, 0xFD, 0x00, 26
ssta:   .db 0x60, 0x55, 0x02, 0x02, 0xFE, 0x00, 26
sstar:  .db 0x80, 0x75, 0x02, 0x02, 0xFC, 0x00, 26

sss:    .db 0x10, 0xA4, 0x02, 0x02, 0xFE, 0x00, 26
ssst:   .db 0x20, 0x30, 0x02, 0x02, 0xFD, 0x00, 26
sssta:  .db 0x30, 0x20, 0x02, 0x02, 0xFC, 0x00, 26
ssstar: .db 0x50, 0xB2, 0x02, 0x02, 0xFE, 0x00, 26

_main::
   call cpct_disableFirmware_asm

   ;;Init systems
   call rendersys_init

   ld    hl, #s
   call entityman_create
   ld    hl, #st
   call entityman_create
   ld    hl, #sta
   call entityman_create
   ld    hl, #star
   call entityman_create

   ld    hl, #ss
   call entityman_create
   ld    hl, #sst
   call entityman_create
   ld    hl, #ssta
   call entityman_create
   ld    hl, #sstar
   call entityman_create

   ld    hl, #sss
   call entityman_create
   ld    hl, #ssst
   call entityman_create
   ld    hl, #sssta
   call entityman_create
   ld    hl, #ssstar
   call entityman_create

loop:
   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call physics_move
   
   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call rendersys_update

   call cpct_waitVSYNC_asm
   jr    loop