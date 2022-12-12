; Copied from bank 10h (with two one-byte changes), assuming unused
SECTION "ROM Bank $021", ROMX[$4000], BANK[$21]
;{
colour21_initialPalettes:
;{
;       _________________________________________________ BG palette colour 0
;      |      ___________________________________________ Sprite palette colour 0
;      |     |       ____________________________________ BG palette colour 1
;      |     |      |      ______________________________ Sprite palette colour 1
;      |     |      |     |       _______________________ BG palette colour 2
;      |     |      |     |      |      _________________ Sprite palette colour 2
;      |     |      |     |      |     |       __________ BG palette colour 3
;      |     |      |     |      |     |      |      ____ Sprite palette colour 3
;      |     |      |     |      |     |      |     |
    dw $0000,$0000, $1DB1,$2B1D, $0066,$1124, $0022,$080A ; Palette 0
    dw $0000,$0000, $3B3F,$7D97, $227F,$4C11, $1573,$3C09 ; Palette 1
    dw $0000,$0000, $3AD5,$0069, $196C,$5E11, $0042,$0024 ; Palette 2
    dw $0000,$0000, $7ED2,$7FDB, $44E2,$520C, $1801,$1882 ; Palette 3
    dw $0000,$0000, $331F,$6FDF, $09F7,$029C, $00A9,$0C2D ; Palette 4
    dw $0000,$0000, $51BC,$0256, $3410,$1C70, $0406,$0C26 ; Palette 5
    dw $0000,$0000, $1ED5,$0295, $00E4,$1561, $0041,$0061 ; Palette 6
    dw $0000,$0000, $6339,$3BE8, $214B,$18D0, $0464,$0066 ; Palette 7
;}

colour21_4080: ; Seemingly unused
;{
    push hl
    push de
    push bc
    ld a, $01
    ldh [$FF4D], a
    stop
    call colour_40B0
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    ld de, colour_4100
    
    .code_4096
        ld a, [de]
        ldi [hl], a
        inc de
        ld a, h
        cp $D2
    jr nz, .code_4096
    ld a, $01
    ldh [$FF70], a
    pop bc
    pop de
    pop hl
    ret
;}

ds $A

colour21_40B0: ; Transfer all palettes
;{
    ld c, $00
    ld b, $00
    
    .loop
        ; BG colour [c] / 2 = [$D100 + [b]]
        push bc
        ld c, b
        ld b, $40 ; Was $D1
        ld a, [bc]
        ld d, a
        inc bc
        ld a, [bc]
        ld e, a
        pop bc
        ld hl, $FF68
        ld a, c
        ldi [hl], a
        ld a, d
        ld [hl], a
        ld hl, $FF68
        ld a, c
        inc a
        ldi [hl], a
        ld a, e
        ld [hl], a
        
        ; Sprite colour [c] / 2 = [$D100 + [b] + 2]
        inc b
        inc b
        push bc
        ld c, b
        ld b, $40 ; Was $D1
        ld a, [bc]
        ld d, a
        inc bc
        ld a, [bc]
        ld e, a
        pop bc
        ld hl, $FF6A
        ld a, c
        ldi [hl], a
        ld a, d
        ld [hl], a
        ld hl, $FF6A
        ld a, c
        inc a
        ldi [hl], a
        ld a, e
        ld [hl], a
        
        inc c
        inc c
        inc b
        inc b
        bit 6, c ; [c] < 40h
    jr z, .loop
    ret
;}

ds $F
;}

colour21_4100: ; Assuming unused
;{
    push bc
    push de
    push hl
    ld h, $C0
    ld l, $00
    ld b, $28

    .loop_A
        inc hl
        inc hl
        ld e, [hl]
        ld d, $D2
        inc hl
        ld a, [de]
        ld c, a
        ld a, [hl]
        and a, $F0
        add c
        ld [hl], a
        inc hl
        dec b
    jr nz, .loop_A
    
    call OAM_DMA
    ld a, [$D0FE]
    cp a, $00
    jr z, .else_A
        ld h, a
        jr .endIf_A
    .else_A
        ld h, $98
    .endIf_A
    
    ld a, [$D0FD]
    ld l, a
    ld b, $00

    .loop_B
        ld e, [hl]
        bit 7, e
        jr nz, .else_B
            ld d, $D3
            jr .endIf_B
        .else_B
            ld d, $D2
        .endIf_B
        
        ld a, [de]
        ld c, a
        ld a, $FF
        ldh [$FF4F], a
        ld [hl], c
        ld a, $FE
        ldh [$FF4F], a
        inc hl
        dec b
    jr nz, .loop_B
    
    ld a, h
    cp a, $A0
    jr nz, .endIf_C
        ld a, $98
    .endIf_C
    
    ld [$D0FE], a
    ld a, l
    ld [$D0FD], a
    pop hl
    pop de
    pop bc
    ret
;}
