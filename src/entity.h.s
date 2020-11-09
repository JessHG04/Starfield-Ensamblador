;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;; PUBLIC FUNCTIONS ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;
.globl entity_size
.globl max_entities
.globl ent_create
.globl ent_getIXPtr
.globl ent_getNumEntities
.globl ent_move
.globl estrella
.globl ent_generate
.globl ent_generator_update
.globl ent_doForAll
.globl random_vx_forAll
.globl random_y_forAll
.globl set_for_destruction
.globl ent_destroy

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;    CONSTANTES    ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;
entity_size  == 8
max_entities == 20
entity_array_size == entity_size*max_entities

;;Estas constantes son para luego utilizarlas con el registro ix
e_x = 0
e_y = 1
e_w = 2
e_h = 3
e_vx = 4
e_vy = 5
e_color = 6

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;      MACROS      ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEntity _name, _x, _y, _w, _h, _vx, _vy, _color
    _name::
        .db _x
        .db _y
        .db _w
        .db _h
        .db _vx
        .db _vy
        .db _color

.endm

