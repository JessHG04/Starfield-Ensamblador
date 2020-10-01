.include "cpctelera.h.s"
.include "entity.h.s"

_num_entities::     .db 0x00, 0x00
_last_elem_ptr::    .dw _entity_array
_entity_array::
    .ds entity_size*max_entities

entityman_getEntityArray_IX::
    ld      ix, #_entity_array
    ret

entityman_getNumEntities_A::
    ld      a, (_num_entities)
    ret

;;INPUT
;;      HL: pointer to entity initializer byte
entityman_create::
   ex    de, hl

   ld     hl, (_num_entities)
   ld     a, #max_entities

   sub    l  ;;Comprueba que no se haya pasado del maximo que podemos tener
   ret     z

    ex    de, hl

   ld      de, (_last_elem_ptr)
   ld      bc, #entity_size
   ldir

   ld       a, (_num_entities)
   inc      a
   ld      (_num_entities), a

   ld      hl, (_last_elem_ptr)
   ld      bc, #entity_size
   add     hl, bc
   ld      (_last_elem_ptr), hl

   ret

