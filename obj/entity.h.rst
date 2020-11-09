ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;;;;;;;;;;;;;;;;;;;;;
                              2 ;;                  ;;
                              3 ;; PUBLIC FUNCTIONS ;;
                              4 ;;                  ;;
                              5 ;;;;;;;;;;;;;;;;;;;;;;
                              6 .globl entity_size
                              7 .globl max_entities
                              8 .globl ent_create
                              9 .globl ent_getIXPtr
                             10 .globl ent_getNumEntities
                             11 .globl ent_move
                             12 .globl estrella
                             13 .globl ent_generate
                             14 .globl ent_generator_update
                             15 .globl ent_doForAll
                             16 .globl random_vx_forAll
                             17 .globl random_y_forAll
                             18 .globl set_for_destruction
                             19 .globl ent_destroy
                             20 
                             21 ;;;;;;;;;;;;;;;;;;;;;;
                             22 ;;                  ;;
                             23 ;;    CONSTANTES    ;;
                             24 ;;                  ;;
                             25 ;;;;;;;;;;;;;;;;;;;;;;
                     0008    26 entity_size  == 8
                     0014    27 max_entities == 20
                     00A0    28 entity_array_size == entity_size*max_entities
                             29 
                             30 ;;Estas constantes son para luego utilizarlas con el registro ix
                     0000    31 e_x = 0
                     0001    32 e_y = 1
                     0002    33 e_w = 2
                     0003    34 e_h = 3
                     0004    35 e_vx = 4
                     0005    36 e_vy = 5
                     0006    37 e_color = 6
                             38 
                             39 ;;;;;;;;;;;;;;;;;;;;;;
                             40 ;;                  ;;
                             41 ;;      MACROS      ;;
                             42 ;;                  ;;
                             43 ;;;;;;;;;;;;;;;;;;;;;;
                             44 .macro DefineEntity _name, _x, _y, _w, _h, _vx, _vy, _color
                             45     _name::
                             46         .db _x
                             47         .db _y
                             48         .db _w
                             49         .db _h
                             50         .db _vx
                             51         .db _vy
                             52         .db _color
                             53 
                             54 .endm
                             55 
