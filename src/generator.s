.include "entity.h.s"
.include "cpctelera_functions.h.s"
.include "cpctelera.h.s"
.include "render.h.s"

;;REQUIERE EL NUMERO DE ENTIDADES A CREAR EN EL REGISTRO A
generar::
bucle_generador:
   push af
   ld ix, #estrella
   ld hl, #estrella
   call ent_generator_update
   pop af
   dec a
   jp nz, bucle_generador
   ;; FIN DEL PINTADO DE 10 ESTRELLAS
ret