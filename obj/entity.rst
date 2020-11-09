ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "entity.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              2 .include "cpctelera_functions.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;
                              2 ;;                  ;;
                              3 ;; PUBLIC FUNCTIONS ;;
                              4 ;;                  ;;
                              5 ;;;;;;;;;;;;;;;;;;;;;;
                              6 
                              7 .globl cpct_disableFirmware_asm
                              8 .globl cpct_getScreenPtr_asm
                              9 .globl cpct_setDrawCharM1_asm
                             10 .globl cpct_drawStringM1_asm
                             11 .globl cpct_drawSolidBox_asm
                             12 .globl CPCT_VMEM_START_ASM
                             13 .globl cpct_waitVSYNC_asm
                             14 .globl cpct_getRandom_xsp40_u8_asm
                             15 .globl cpct_setVideoMode_asm
                             16 .globl cpct_setPalette_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              3 .include "render.h.s"
                              1 ;;;;;;;;;;;;;;;;;;;;;;
                              2 ;;                  ;;
                              3 ;; PUBLIC FUNCTIONS ;;
                              4 ;;                  ;;
                              5 ;;;;;;;;;;;;;;;;;;;;;;
                              6 
                              7 .globl render_init
                              8 .globl palette
                              9 .globl ent_draw
                             10 .globl ent_clean
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



   4000                       4 entity_array::
   4000                       5     .ds max_entities*entity_size
   40A0 C9            [10]    6 ret
                              7 
   40A1 00 40                 8 last_ent_ptr:: .dw #entity_array
   40A3 00                    9 num_entities:: .db 0
                             10 
                             11 
   40A4                      12 ent_getIXPtr:: 
   40A4 DD 21 00 40   [14]   13     ld ix, #entity_array
   40A8 C9            [10]   14 ret
                             15 
   40A9                      16 ent_getNumEntities:: 
   40A9 3A A3 40      [13]   17     ld a, (num_entities)
   40AC C9            [10]   18 ret
                             19 
                             20 
   40AD                      21 ent_generate::
   40AD DD 21 90 41   [14]   22     ld ix, #estrella
   40B1 CD BF 40      [17]   23     call ent_create
   40B4 C9            [10]   24 ret
                             25 ;;Genera entidades mientras se pueda
                             26 ;;Destruye registro: a
   40B5                      27 ent_generator_update::
   40B5 CD A9 40      [17]   28     call ent_getNumEntities
   40B8 FE 14         [ 7]   29     cp #max_entities
   40BA C8            [11]   30     ret z
   40BB CD AD 40      [17]   31     call ent_generate
   40BE C9            [10]   32 ret
                             33 
                             34 ;;Necesito un puntero con la primera direccion de la entidad a copiar (lo guardo en HL)
   40BF                      35 ent_create::
   40BF ED 5B A1 40   [20]   36     ld de, (last_ent_ptr)
   40C3 01 08 00      [10]   37     ld bc, #entity_size
                             38 
   40C6 ED B0         [21]   39     ldir ;;Mete los valores a los que apunta hl en la direccion a la que apunta de, tantas veces como diga bc
                             40 
                             41     ;;Incremento el contador de entidades y guardo su valor
   40C8 3A A3 40      [13]   42     ld a, (num_entities)
   40CB 3C            [ 4]   43     inc a
   40CC 32 A3 40      [13]   44     ld (num_entities), a
                             45 
   40CF 2A A1 40      [16]   46     ld hl, (last_ent_ptr)
   40D2 01 08 00      [10]   47     ld bc, #entity_size
   40D5 09            [11]   48     add hl, bc
   40D6 22 A1 40      [16]   49     ld (last_ent_ptr), hl
                             50 
   40D9 C9            [10]   51 ret
                             52 
                             53 ;;Necesito un puntero HL con la direccion del primer byte de la entidad
                             54 ;;Destruye af, af', ademas de los registros de ent_draw
   40DA                      55 ent_move:: 
   40DA DD 7E 00      [19]   56     ld a, e_x(ix)
   40DD DD 86 04      [19]   57     add a, e_vx(ix)
   40E0 DD 77 00      [19]   58     ld e_x(ix), a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   40E3 C9            [10]   59 ret
                             60 
                             61 
   40E4                      62 ent_doForAll::
   40E4 3A A3 40      [13]   63     ld  a, (num_entities)
   40E7 DD 21 00 40   [14]   64     ld  ix, #entity_array
   40EB 22 F0 40      [16]   65     ld  (metodo), hl 
                             66 
   40EE                      67 buc:
   40EE F5            [11]   68     push af
                     00F0    69     metodo = . + 1
   40EF CD 01 42      [17]   70     call ent_draw
   40F2 F1            [10]   71     pop af
   40F3 01 08 00      [10]   72     ld bc, #entity_size
   40F6 DD 09         [15]   73     add ix, bc 
                             74 
   40F8 3D            [ 4]   75     dec a
   40F9 20 F3         [12]   76     jr nz, buc
                             77 
   40FB C9            [10]   78     ret
                             79 
                             80 
                             81 
                             82 ;;REQUIERE PUNTERO AL PRIMER BYTE DEL ARRAY DE ENTIDADES EN IX
                             83 ;;TAMBIEN REQUIERE EL NUMERO DE ENTIDADES EN EL REGISTRO A
   40FC                      84 random_y_forAll::
   40FC                      85 bucl:
   40FC 08            [ 4]   86     ex af, af'
   40FD 01 08 00      [10]   87     ld bc, #entity_size
   4100 CD D1 42      [17]   88     call cpct_getRandom_xsp40_u8_asm
   4103 E6 C8         [ 7]   89     and #0xC8
   4105 DD 77 01      [19]   90     ld e_y(ix), a
   4108 08            [ 4]   91     ex af, af'
                             92 
   4109 DD 09         [15]   93     add ix, bc
   410B 3D            [ 4]   94     dec a
   410C 20 EE         [12]   95 jr nz, bucl
   410E C9            [10]   96 ret
                             97 
                             98 
                             99 
                            100 ;;REQUIERE PUNTERO AL PRIMER BYTE DEL ARRAY DE ENTIDADES EN IX
                            101 ;;TAMBIEN REQUIERE EL NUMERO DE ENTIDADES EN EL REGISTRO A
   410F                     102 random_vx_forAll::
   410F                     103 bucle:
   410F 08            [ 4]  104     ex af, af'
   4110 01 08 00      [10]  105     ld bc, #entity_size
   4113 CD D1 42      [17]  106     call cpct_getRandom_xsp40_u8_asm
   4116 E6 03         [ 7]  107     and #0x03
   4118 C6 01         [ 7]  108     add a, #0x01 ;;PARA QUE EL RESULTADO NUNCA SEA 0
   411A ED 44         [ 8]  109     neg
   411C DD 77 04      [19]  110     ld e_vx(ix), a
   411F 08            [ 4]  111     ex af, af'
                            112 
   4120 DD 09         [15]  113     add ix, bc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   4122 3D            [ 4]  114     dec a
   4123 20 EA         [12]  115 jr nz, bucle
   4125 C9            [10]  116 ret
                            117 
                            118 
                            119 
                            120 ;;SE LE PASA EL PUNTERO IX CON LA PRIMERA POSICION DEL ARRAY DE ENTIDADES
                            121 ;;Y EL NUMERO DE ENTIDADES EN A
   4126                     122 set_for_destruction::
   4126                     123 destructionbuc:
   4126 F5            [11]  124     push af
   4127 DD 7E 00      [19]  125     ld a, e_x(ix)
   412A FE 00         [ 7]  126     cp #0x00
   412C 28 20         [12]  127     jr z, _marcar
   412E FE 01         [ 7]  128     cp #0x01
   4130 28 1C         [12]  129     jr z, _marcar
   4132 FE 02         [ 7]  130     cp #0x02
   4134 28 18         [12]  131     jr z, _marcar
   4136 FE 03         [ 7]  132     cp #0x03
   4138 28 14         [12]  133     jr z, _marcar
   413A FE 04         [ 7]  134     cp #0x04
   413C 28 10         [12]  135     jr z, _marcar
   413E FE 05         [ 7]  136     cp #0x05
   4140 28 0C         [12]  137     jr z, _marcar
                            138     ;;cp #0x50
                            139     ;;jr z, _marcar
                            140 
   4142 20 00         [12]  141     jr nz, _seguir
                            142 
   4144                     143 _seguir:
   4144 F1            [10]  144     pop af
   4145 3D            [ 4]  145     dec a
   4146 C8            [11]  146     ret z
   4147 01 08 00      [10]  147     ld bc, #entity_size
   414A DD 09         [15]  148     add ix, bc
   414C 18 D8         [12]  149     jr destructionbuc
                            150 
   414E                     151 _marcar: 
                            152     ;;ex af, af'
   414E DD 36 05 10   [19]  153     ld e_vy(ix), #0x10
   4152 18 F0         [12]  154     jr _seguir
                            155 
   4154 C9            [10]  156 ret
                            157 
   4155                     158 ent_destroy::
   4155                     159 _destroyloop:
   4155 F5            [11]  160     push af
   4156 DD 7E 05      [19]  161     ld      a, e_vy(ix)
   4159 FE 10         [ 7]  162     cp      #0x10
   415B 28 02         [12]  163     jr      z, _destroy
   415D 20 15         [12]  164     jr      nz, _continuar
   415F                     165 _destroy:
                            166     ;;POS SI DA CERO ES QUE HAY QUE LIMPIAR DALE CARLA LIMPIA
   415F DD 36 06 00   [19]  167     ld      e_color(ix), #0x00
   4163 DD 36 05 00   [19]  168     ld      e_vy(ix), #0x00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   4167 DD 22 A1 40   [20]  169     ld      (last_ent_ptr), ix
                            170     
   416B 2A A3 40      [16]  171     ld      hl, (num_entities)
   416E 2B            [ 6]  172     dec     hl
   416F 22 A3 40      [16]  173     ld      (num_entities), hl
   4172 18 00         [12]  174     jr      _continuar
   4174                     175 _continuar:
   4174 F1            [10]  176     pop     af
   4175 3D            [ 4]  177     dec     a
   4176 C8            [11]  178     ret     z
                            179 
   4177 01 08 00      [10]  180     ld      bc, #entity_size
   417A DD 09         [15]  181     add     ix, bc
   417C 18 D7         [12]  182     jr      _destroyloop
   417E C9            [10]  183     ret
