.include "entity.h.s"
.include "cpctelera_functions.h.s"
.include "render.h.s"
entity_array::
    .ds max_entities*entity_size
ret

last_ent_ptr:: .dw #entity_array
num_entities:: .db 0


ent_getIXPtr:: 
    ld ix, #entity_array
ret

ent_getNumEntities:: 
    ld a, (num_entities)
ret


ent_generate::
    ld ix, #estrella
    call ent_create
ret
;;Genera entidades mientras se pueda
;;Destruye registro: a
ent_generator_update::
    call ent_getNumEntities
    cp #max_entities
    ret z
    call ent_generate
ret

;;Necesito un puntero con la primera direccion de la entidad a copiar (lo guardo en HL)
ent_create::
    ld de, (last_ent_ptr)
    ld bc, #entity_size

    ldir ;;Mete los valores a los que apunta hl en la direccion a la que apunta de, tantas veces como diga bc

    ;;Incremento el contador de entidades y guardo su valor
    ld a, (num_entities)
    inc a
    ld (num_entities), a

    ld hl, (last_ent_ptr)
    ld bc, #entity_size
    add hl, bc
    ld (last_ent_ptr), hl

ret

;;Necesito un puntero HL con la direccion del primer byte de la entidad
;;Destruye af, af', ademas de los registros de ent_draw
ent_move:: 
    ld a, e_x(ix)
    add a, e_vx(ix)
    ld e_x(ix), a
ret


ent_doForAll::
    ld  a, (num_entities)
    ld  ix, #entity_array
    ld  (metodo), hl 

buc:
    push af
    metodo = . + 1
    call ent_draw
    pop af
    ld bc, #entity_size
    add ix, bc 

    dec a
    jr nz, buc

    ret



;;REQUIERE PUNTERO AL PRIMER BYTE DEL ARRAY DE ENTIDADES EN IX
;;TAMBIEN REQUIERE EL NUMERO DE ENTIDADES EN EL REGISTRO A
random_y_forAll::
bucl:
    ex af, af'
    ld bc, #entity_size
    call cpct_getRandom_xsp40_u8_asm
    and #0xC8
    ld e_y(ix), a
    ex af, af'

    add ix, bc
    dec a
jr nz, bucl
ret



;;REQUIERE PUNTERO AL PRIMER BYTE DEL ARRAY DE ENTIDADES EN IX
;;TAMBIEN REQUIERE EL NUMERO DE ENTIDADES EN EL REGISTRO A
random_vx_forAll::
bucle:
    ex af, af'
    ld bc, #entity_size
    call cpct_getRandom_xsp40_u8_asm
    and #0x03
    add a, #0x01 ;;PARA QUE EL RESULTADO NUNCA SEA 0
    neg
    ld e_vx(ix), a
    ex af, af'

    add ix, bc
    dec a
jr nz, bucle
ret



;;SE LE PASA EL PUNTERO IX CON LA PRIMERA POSICION DEL ARRAY DE ENTIDADES
;;Y EL NUMERO DE ENTIDADES EN A
set_for_destruction::
destructionbuc:
    push af
    ld a, e_x(ix)
    cp #0x00
    jr z, _marcar
    cp #0x01
    jr z, _marcar
    cp #0x02
    jr z, _marcar
    cp #0x03
    jr z, _marcar
    cp #0x04
    jr z, _marcar
    cp #0x05
    jr z, _marcar
    ;;cp #0x50
    ;;jr z, _marcar

    jr nz, _seguir

_seguir:
    pop af
    dec a
    ret z
    ld bc, #entity_size
    add ix, bc
    jr destructionbuc

_marcar: 
    ;;ex af, af'
    ld e_vy(ix), #0x10
    jr _seguir

ret

ent_destroy::
_destroyloop:
    push af
    ld      a, e_vy(ix)
    cp      #0x10
    jr      z, _destroy
    jr      nz, _continuar
_destroy:
    ;;POS SI DA CERO ES QUE HAY QUE LIMPIAR DALE CARLA LIMPIA
    ld      e_color(ix), #0x00
    ld      e_vy(ix), #0x00
    ld      (last_ent_ptr), ix
    
    ld      hl, (num_entities)
    dec     hl
    ld      (num_entities), hl
    jr      _continuar
_continuar:
    pop     af
    dec     a
    ret     z

    ld      bc, #entity_size
    add     ix, bc
    jr      _destroyloop
    ret