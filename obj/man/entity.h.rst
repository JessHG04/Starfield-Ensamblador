ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1  ;;
                              2 ;; ENTITY MANAGER
                              3 ;;
                     0007     4 entity_size == 7 ;;X, Y, W, H, Vx, Vy, C
                     000C     5 max_entities == 12
                              6 
                              7 .globl entityman_getEntityArray_IX
                              8 .globl entityman_getNumEntities_A
                              9 .globl entityman_create
