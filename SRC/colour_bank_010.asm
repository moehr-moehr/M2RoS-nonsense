SECTION "ROM Bank $010", ROMX[$4000], BANK[$10]

colour_initialPalettes:
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

colour_4080: ; Seemingly unused
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

colour_40B0: ; Transfer all palettes
;{
    ld c, $00
    ld b, $00
    
    .loop
        ; BG colour [c] / 2 = [$D100 + [b]]
        push bc
        ld c, b
        ld b, colour_palettes >> 8
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
        ld b, colour_palettes >> 8
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

colour_4100: ; Used by seemingly unused routine $4080
;{
db $06, $03, $05, $01, $07, $02, $00, $04, $00, $00, $00, $00, $DF, $6F, $DF, $6F
db $9C, $02, $9C, $02, $2D, $0C, $2D, $0C
;}

colour_init: ; Called by boot routine
;{
    push hl
    push de
    push bc
    
    ; Enable double speed mode
    ld hl, rKEY1
    bit 7, [hl]
    jr nz, .endIf
        set 0, [hl]
        xor a
        ldh [rIF], a
        ldh [rIE], a
        ld a, P1F_4 | P1F_5
        ldh [rP1], a
        stop
    .endIf
    
    ; Set initial colour palettes
    ld hl, colour_initialPalettes
    ld de, colour_palettes
    ld bc, $0080
    call copyToVram
    ld hl, colour_initialPalettes
    ld de, colour_D180
    ld bc, $0080
    call copyToVram
    call colour_40B0 ; Transfer all palettes
    
    ld a, $00
    ld [colour_D446], a
    xor a
    ld [colour_maxVblankHandlerDuration], a
    ld [colour_D442], a
    ld [colour_D444], a
    ld [colour_D448], a
    ld [colour_D44A], a
    ld [colour_D44B], a
    ld a, $80
    ld [colour_D44C], a
    ld [colour_D445], a
    pop bc
    pop de
    pop hl
    ret
;}

colour_416E: ; Called by game over text loading
;{
    push bc
    push de
    call colour_restoreBank_blockCopy_setBank10
    pop hl
    pop bc
;}

colour_4175:
;{
    .loop
        ld e, [hl]
        ld a, e
        sub $80
        ld d, $69 ; (69h is D2h / 2)
        rl d
        ld a, $FF
        ldh [$FF4F], a
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        dec bc
        ld a, b
        or c
    jr nz, .loop
    ret
;}

colour_418C: ; Assigns colour palettes to sprites
;{
    ld d, colour_D200 >> 8
    ld hl, $C000 ; OAM pointer
    ld a, [samusTopOamOffset] ; Start of enemy OAM
    ld b, a
    
    .loop_A
        ; If reached enemy OAM: break
        ld a, l
        cp b
            jr z, .break_A
            
        ; c = [$D200 + [sprite tile number]]
        inc l
        inc l
        ldi a, [hl]
        ld e, a
        ld a, [de]
        ld c, a
        
        ; If sprite palette = 1:
        ;     If [c] != 3:
        ;         c = 3
        ;     Else:
        ;         c = 1
        ld a, [hl]
        bit 4, a
        jr z, .endIf_A
            ld a, c
            cp $03
            jr z, .else_B
                ld c, $03
                jr .endIf_B
            .else_B
                ld c, $01
                jr .endIf_B
            .endIf_B
        .endIf_A
        
        ; Sprite colour palette = [c]
        ; hl += 4
        ld a, [hl]
        and $F0
        or c
        ldi [hl], a
    jr .loop_A
    .break_A
    
    ldh a, [hOamBufferIndex]
    ld b, a
    
    .loop_B
        ; If reached end of OAM: break
        ld a, l
        cp b
            ret z
            
        ; c = [$D200 + [sprite tile number]]
        inc l
        inc l
        ldi a, [hl]
        ld e, a
        ld a, [de]
        ld c, a
        
        ; If sprite colour palette = 0:
        ld a, [hl]
        and $07
        ld a, [hl]
        jr nz, .endIf_C
            ; If sprite palette = 1:
            ;     If [c] != 3:
            ;         c = 3
            ;     Else:
            ;         c = 1
            bit 4, a
            jr z, .endIf_D
                ld a, c
                cp $03
                jr z, .else_E
                    ld c, $03
                    jr .endIf_E
                .else_E
                    ld c, $01
                    jr .endIf_E
                .endIf_E
            .endIf_D
            
            ; Sprite colour palette = [c]
            ld a, [hl]
            and $F0
            or c
        .endIf_C
        
        ldi [hl], a
    jr .loop_B
    
    ret ; Dead code
;}

colour_41E3: ; Called by draw credits line
;{
    ld a, [pTilemapDestLow]
    ld l, a
    ld a, [pTilemapDestHigh]
    ld h, a
    ld bc, $0014
    jp colour_4175
;}

colour_41F1:
;{
    ld a, $00
    ld [colour_D446], a
    
    ; If [VRAM transfer size] = 0: return
    ; If varia suit pickup animation active: return
    ; bc = min([VRAM transfer size], 40h)
    ; de = [VRAM transfer destination address]
    ; hl = [VRAM transfer source address]
    ld hl, hVramTransfer.sizeLow + 1
    ldd a, [hl]
    ld b, a
    ldd a, [hl]
    ld c, a
    or b
        jr z, .return
    ld a, [variaAnimationFlag]
    or a
        jr nz, .return
    ldd a, [hl]
    ld d, a
    ldd a, [hl]
    ld e, a
    ld h, [hl]
    ldh a, [hVramTransfer.srcAddrLow]
    ld l, a
    ld a, c
    sub $40
    ld a, b
    sbc a, $00
    jr c, .endIf_A
        ld bc, $0040
    .endIf_A

    ; Transfer [bc] bytes from [hl] to $D380
    ld a, c
    ld [colour_D447], a
    push de
    push hl
    ld de, colour_D380
    call colour_setVramTransferSrcBank_blockCopy_setBank10
    pop hl
    pop de
    ld a, [colour_D447]
    ld c, a
    
    ; If $9800 <= [VRAM transfer destination address] < $A000 (tilemap):
    ;     Go to $4245
    ; If $8000 <= [VRAM transfer destination address] < $9800 (tiles):
    ;     Execute $3F9F
    ldh a, [hVramTransfer.destAddrHigh]
    sub $80
    jr c, .endIf_B
        sub $18
        jr c, .else_C
            cp $08
                jr c, .vramTilemapTransfer
                
            jr .endIf_C
        .else_C
            call colour_3F9F ; Copy the first byte of each tile from VRAM transfer source address with ROM bank + 20h to the $D200..$D37F region
        .endIf_C
    .endIf_B

    ld a, $02
    ld [colour_D446], a
    jr .return

    .vramTilemapTransfer
    ld a, $01
    ld [colour_D446], a
    
    ; hl = $D380
    ld d, $69 ; (69h is D2h / 2)
    ld hl, $D380

    .loop
        ; [hl] + 40h = [$D280 + 80h + ±[[hl]]]
        ; hl += 1
        ; bc -= 1
        ; loop if [bc] != 0
        
        ld e, [hl]
        ld a, e
        sub $80
        rl d
        ld a, [de]
        set 6, l
        ldi [hl], a
        res 6, l
        rr d
        dec bc
        ld a, b
        or c
    jr nz, .loop

    .return
    ret
;}

colour_4263:
;{
    db $93, $93, $A3, $A7, $E7, $EB, $FB, $FF, $FF
;}

colour_426C: ; Handle brightness
;{
    ; If [$D44C] = [$D44B]: return
    ld a, [colour_D44C]
    ld b, a
    ld a, [colour_D44B]
    cp b
        ret z
    
    ; a = [$D44B] * 4
    add a, a
    add a, a
    call colour_458A ; Brightness calculations
    
    ; $D44C = [$D44B]
    ld a, [colour_D44B]
    ld [colour_D44C], a
    
    ; BG palette / sprite palette 0 = [$4263 + [$D44C]]
    ld hl, colour_4263
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl]
    ld [bg_palette], a
    ld [ob_palette0], a
    ret
;}

colour_428F: ; Process queen tilemap update
;{
    ld a, [queen_footFrame]
    or a
        jr z, .noFootUpdate
    ld b, a
    ld a, [queen_footAnimCounter]
    or a
        jr nz, .noFootUpdate
    
    ; Foot tilemap update
    ;{
        ; If not resuming previous foot tilemap update:
        ;     hl = $70CA
        ;     c = Ch
        ;     colour_D451 = $7134
        ; Else:
        ;     hl = $70C4
        ;     c = 10h
        ;     colour_D451 = $7124
        ; colour_D450 = 0
        ld a, b
        and $80
        jr nz, .else_A
            ld hl, $70CA
            ld de, $7134
            ld c, $0C
            jr .endif_A
        .else_A
            ld hl, $70C4
            ld de, $7124
            ld c, $10
        .endif_A
        ld a, e
        ld [colour_D451], a
        ld a, d
        ld [colour_D452], a
        xor a
        ld [colour_D450], a
        
        ; hl = [[hl] + (([queen_footFrame] & 7Fh) - 1) * 2] (tilemap source address)
        ld a, b
        and $7F
        dec a
        add a, a
        ld e, a
        ld d, $00
        add hl, de
        ldi a, [hl]
        ld h, [hl]
        ld l, a
        jr .merge
    ;}
    
    .queenHeaderTilemapPointers ; Low bytes (upper byte is $6F)
    db colour_queen_headFrameA & $FF, colour_queen_headFrameB & $FF, colour_queen_headFrameC & $FF
    
    .noFootUpdate
    ; colour_D452 = 0
    ; If no head update:
    ;     colour_D453 = 0
    ;     Return
    xor a
    ld [colour_D452], a
    ld a, [queen_headFrameNext]
    or a
    jr nz, .endIf_B
        ld [colour_D453], a
        ret
    .endIf_B
    
    ; Head tilemap update
    ;{
        ; If [queen_headFrameNext] < 4:
        ;     hl = $6F00 + [$42CD + [queen_headFrameNext] - 1] (tilemap source address)
        ;     de = $9C00
        ; Else:
        ;     hl = [queen_headSrc] (from big endian) (tilemap source address)
        ;     de = $9C00 + [queen_headDest]
        cp $04
        jr nc, .else_C
            ld hl, .queenHeaderTilemapPointers
            dec a
            ld e, a
            ld d, $00
            add hl, de
            ld l, [hl]
            ld h, $6F
            ld de, $9C00
            jr .endIf_C
        .else_C
            ld hl, queen_headDest
            ldi a, [hl]
            ld e, a
            ldi a, [hl]
            ld d, a
            ld l, [hl]
            ld h, d
            ld d, $9C
        .endIf_C
        
        ; colour_D44F = [de]
        ; c = 12h
        ld a, e
        ld [colour_D44F], a
        ld a, d
        ld [colour_D450], a
        ld c, $12
    ;}
    
    .merge
    ; a = colour_D453 = [c] (size)
    ; de = $D420 (destination)
    ld a, c
    ld [colour_D453], a
    ld de, colour_D420
    ld b, $69 ; (69h is D2h / 2)
    
    .loop
        ; [de++] = [$D280 + 80h + ±[[hl++]]]
        ; If [--a] != 0: loop
        push af
        ldi a, [hl]
        ld c, a
        sub $80
        rl b
        ld a, [bc]
        ld [de], a
        inc e
        srl b
        ldi a, [hl]
        ld c, a
        sub $80
        rl b
        ld a, [bc]
        ld [de], a
        inc e
        srl b
        pop af
        sub $02
    jr nz, .loop
    ret
;}

colour_432D: ; Update colour palettes and colour VRAM ready for v-blank
;{
    push bc
    push de
    push hl
    call colour_41F1
    call colour_418C ; Assigns colour palettes to sprites
    
    ; d = 1 (potential value for $D449)
    ; e = 0 (potential value for $D44B, darkness level)
    ld de, $0100
    ldh a, [gameMode]
    cp $04 ; In-game
        jr z, .case_ingame
    cp $08 ; Paused
        jr z, .case_paused
    cp $01 ; Title screen
        jr z, .case_titleScreen
    cp $12 ; Reached the gunship
        jr z, .case_reachedTheGunship
    jr .endSwitch
    
.case_ingame
;{
    ld a, [colour_D445]
    cp $08 ; Paused
    jr z, .endIf_A
        ld a, [colour_D44B]
        ld e, a
    .endIf_A
    
    ld a, [queen_roomFlag]
    cp $11
        jr nz, .endSwitch
    
    ; In Metroid Queen's room    
    push de
    call colour_428F ; Process queen tilemap update
    pop de
    ld a, [queen_bodyPalette]
    cp $03
        jr nz, .endSwitch
    
    ; Hurt flash
    ld d, $83 ; Set colour 2 of BG palettes 2/5/6 to BG palette 3 colour 3
    jr .endSwitch
;}

.case_titleScreen
;{
    ld a, [bg_palette]
    cp $93
        jr z, .endSwitch
    
    ; Title screen flash
    ld d, $82 ; Set colour 0 of each BG palette to white
    jr .endSwitch
;}

.case_paused
;{
    ld a, [bg_palette]
    cp $93
        jr z, .endSwitch
    
    ; Screen dim
    ld e, $02
    jr .endSwitch
;}
    
.case_reachedTheGunship
;{
    ; e = 8 - ([timer] + 11h) / 20h
    ld a, [countdownTimerLow]
    add a, $11
    rra
    swap a
    and $0F
    cpl
    add a, $09
    ld e, a
;}
    
.endSwitch
    ld a, [colour_D448]
    cp d
        jr nz, .then_B
    ld a, [colour_D44C]
    cp e
        jr nz, .then_B
    jr .endIf_B
    .then_B
        ld a, $01
        ld [colour_D44A], a ; Flag to handle colour palette transfers in v-blank handler
        ld a, d
        ld [colour_D449], a
        ld a, e
        ld [colour_D44B], a ; Darkness level
    .endIf_B
    
    call colour_426C ; Handle brightness
    pop hl
    pop de
    pop bc
    ret
;}

colour_43B5: ; Called at end of frame (waiting for v-blank)
;{
    ; The functional part of this routine is just the call to $432D,
    ; the rest of it is profiling code

    ldh a, [rDIV]
    ld [colour_D443], a
    push bc
    
    ; $D442 = max([$D442], LCD Y)
    ld a, [colour_D442]
    ld b, a
    ldh a, [rLY]
    cp b
    jr c, .endif_A
        ld [colour_D442], a
    .endif_A

    call colour_432D ; Update colour palettes and colour VRAM ready for v-blank
    
    ; $D444 = min([$D444], [$FF04] - [$D443])
    ld a, [colour_D443]
    ld b, a
    ldh a, [rDIV]
    sub b
    ld b, a
    ld a, [colour_D444]
    cp b
    jr nc, .code_43DC
        ld a, b
        ld [colour_D444], a
    .code_43DC

    ; If v-blank handled (lag frame):
    ;     If LCD Y >= 144 (still in v-blank): go to .lagFrame
    ;     Else: go to .return
    ldh a, [hVBlankDoneFlag]
    or a
    jr z, .endif_B
        ldh a, [rLY]
        cp $90
            jr nc, .lagFrame
            
        jr .return
    .endif_B
    
    ; Wait until v-blank is handled
    .loop_halt
        ; If LCD Y >= 143 then just spin on v-blank handled flag
        ; Otherwise halt (for low power) and check if we were woken up by v-blank interrupt
        ldh a, [rLY]
        cp $8F
            jr nc, .endLoop_halt
            
        halt
        nop
        ldh a, [hVBlankDoneFlag]
        or a
            jr nz, .vblankHandled
        jr .loop_halt
    .endLoop_halt

    .loop_spin
        ldh a, [hVBlankDoneFlag]
        or a
    jr z, .loop_spin

    .vblankHandled
    ; Max v-blank handler duration = max([max v-blank handler duration], [$FF04] - [v-blank start time])
    ldh a, [rDIV]
    ld c, a
    ld a, [colour_vblankStartTime]
    cpl
    inc a
    add a, c
    ld c, a
    ld a, [colour_maxVblankHandlerDuration]
    cp c
    jr nc, .endif_C
        ld a, c
        ld [colour_maxVblankHandlerDuration], a
    .endif_C
        
    .lagFrame
    ; Wait until v-blank
    .loop_C
        ldh a, [rLY]
        cp $90
    jr nc, .loop_C

    .return
    ; Update previous game mode
    ldh a, [gameMode]
    ld [colour_D445], a
    
    pop bc
    ret
;}

colour_441E: ; Called at start of v-blank handler (instead of the DMG palette updates)
;{
    ldh a, [rDIV]
    ld [colour_vblankStartTime], a
    
    ; Overwritten code
    ld a, [bg_palette]
    ldh [rBGP], a
    ld a, [ob_palette0]
    ldh [rOBP0], a
    
    ld a, [mapUpdateFlag]
    or a
        jr nz, .return
    
    ld a, [colour_D44A]
    or a
        jr z, .return
    
    call colour_45A4 ; Handle colour palettes transfers
    xor a
    ld [colour_D44A], a
    
    .return
    ret
;}

colour_4441: ; Called by VRAM tile transfer
;{
    ld b, $00
    ld a, [$D447]
    ld c, a
    ld hl, $FFB1
    ld a, [hl]
    add a, c
    ldi [hl], a
    ld a, [hl]
    adc a, b
    ldi [hl], a
    ldi a, [hl]
    ld e, a
    ldi a, [hl]
    ld d, a
    ld a, [colour_D446]
    or a
        jr z, .code_4491
    
    dec a
    jr z, .code_445F
        jr .code_4475
    .code_445F
    
    push de
    ld hl, $D3C0
    ld a, $FF
    ldh [$FF4F], a
    
    .code_4467
    ldi a, [hl]
    ld [de], a
    inc de
    dec c
    jr nz, .code_4467
    xor a
    ldh [$FF4F], a
    pop de
    ld a, [$D447]
    ld c, a
    
    .code_4475
    ld hl, $D380
    
    .code_4478
    ldi a, [hl]
    ld [de], a
    inc de
    dec c
    jr nz, .code_4478
    ld hl, $FFB3
    ld a, e
    ldi [hl], a
    ld a, d
    ldi [hl], a
    ld a, [$D447]
    ld c, a
    ld a, [hl]
    sub c
    ldi [hl], a
    ld c, a
    ld a, [hl]
    sbc a, b
    ldi [hl], a
    ld b, a
    
    .code_4491
    ret
;}

colour_4492: ; Called by queue metatile transfer
;{
    push bc
    push de
    ld bc, tempMetatile
    ld d, $69 ; (69h is D2h / 2)
    
    .code_4499
        ld a, [bc]
        ldi [hl], a
        ld e, a
        sub $80
        rl d
        ld a, [de]
        ldi [hl], a
        inc bc
        srl d
        bit 2, c
    jr z, .code_4499
    
    pop de
    pop bc
    ret
;}

colour_44AC: ; Called by metatile transfer handler
;{
    push bc
    ld bc, $001F
    ld de, $DDFF
    
    .code_44B3
    inc de
    ld a, [de]
    ld l, a
    inc e
    ld a, [de]
    ld h, a
    and a
    jr z, .code_44EF
        inc de
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        xor a
        ldh [$FF4F], a
        add hl, bc
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        xor a
        ldh [$FF4F], a
    jr .code_44B3
    
    .code_44EF
    pop bc
    ret
;}

colour_44F1: ; $D100..7F = [$D180..FF] / (1 << [b]) or 0
;{
    ; Parameters:
        ; de = $D100 (darkened palettes)
        ; hl = $D180 (source palettes)
        ; b = (([$D44B] & Fh) + 1) / 2
        ; c = 40h (number of colours)
        
    ld a, b
    cp $04
        jr nc, .case_4
    
    ; $D100..7F = [$D180..FF]
    ; hl  = $D100
    ;{
    push bc
    push de
    .loop_A
        ldi a, [hl]
        ld [de], a
        inc de
        ldi a, [hl]
        ld [de], a
        inc de
        dec c
    jr nz, .loop_A
    pop hl
    pop bc
    ;}
    
    ; If [b] = 0: return
    ld a, b
    or a
        ret z
        
    cp $02
        jr z, .case_2
        jr nc, .case_3
        
.case_1
    ; $D100..7F = [$D100..7F] / 2 & (Fh | Fh << 5 | Fh << 10)
    ;{
    ld de, $F | $F << 5 | $F << 10
    .loop_B
        ldi a, [hl]
        ld b, a
        ld a, [hl]
        srl a
        rr b
        and d
        ldd [hl], a
        ld a, b
        and e
        ldi [hl], a
        inc l
        dec c
    jr nz, .loop_B
    ret
    ;}
    
.case_2
    ; $D100..7F = [$D100..7F] / 4 & (7 | 7 << 5 | 7 << 10)
    ;{
    ld de, 7 | 7 << 5 | 7 << 10
    .loop_C
        ldi a, [hl]
        ld b, a
        ld a, [hl]
        srl a
        rr b
        srl a
        rr b
        and d
        ldd [hl], a
        ld a, b
        and e
        ldi [hl], a
        inc l
        dec c
    jr nz, .loop_C
    ret
    ;}
    
.case_3
    ; $D100..7F = [$D100..7F] / 8 & (3 | 3 << 5 | 3 << 10)
    ;{
    ld de, 3 | 3 << 5 | 3 << 10
    .loop_D
        ldi a, [hl]
        ld b, a
        ld a, [hl]
        srl a
        rr b
        srl a
        rr b
        srl a
        rr b
        and d
        ldd [hl], a
        ld a, b
        and e
        ldi [hl], a
        inc l
        dec c
    jr nz, .loop_D
    ret
    ;}
    
.case_4
    ; $D100..7F = 0
    ;{
    ld l, e
    ld h, d
    .loop_E
        xor a
        ldi [hl], a
        ldi [hl], a
        dec c
    jr nz, .loop_E
    ret
    ;}
;}

colour_455D: ; Perform brightness calculations on $D180..FF to $D100..7F
;{
    ; Parameters:
        ; de = $D100
        ; hl = $D180
        ; b = [$D44B] & Fh
        
    ; If      1 <= [b] <= 2: 1/2 brightness of $D180..FF
    ; Else if 3 <= [b] <= 4: 1/4 brightness of $D180..FF
    ; Else if 5 <= [b] <= 6: 1/8 brightness of $D180..FF
    ; Else if [b] >= 7: $D100..7F = 0
    push bc
    push de
    inc b
    srl b
    ld c, $40
    call colour_44F1 ; $D100..7F = [$D180..FF] / (1 << [b]) or 0
    pop hl
    pop bc
    
    ; If [b] >= 7: return
    ; If [b] % 2 = 0: return
    ld a, b
    cp $07
        jr nc, .return
    and $01
        jr z, .return
        
    ; $D100..7F += [$D100..7F] / 2 & (Fh | Fh << 5 | Fh << 10)
    inc l
    .loop
        ldd a, [hl]
        srl a
        and ($F | $F << 5 | $F << 10) >> 8
        ld d, a
        ld a, [hl]
        ld e, a
        rr a
        and ($F | $F << 5 | $F << 10) & $FF
        add a, e
        ldi [hl], a
        ld a, [hl]
        adc a, d
        ldi [hl], a
        inc l
        bit 7, l
    jr z, .loop
    
    .return
    ret
;}

colour_458A: ; Brightness calculations
;{
    ; Parameters:
    ;     a: [$D44B] * 4
    
    ; de = $D100
    ; hl = $D180
    ; $D44A = 1
    ; b = [$D44B] & Fh
    ; c = 40h
    ld b, a
    ld de, colour_palettes
    ld hl, colour_D180
    ld a, $01
    ld [$D44A], a ; Flag to handle colour palette transfers in v-blank handler
    ld a, b
    srl a
    srl a
    and $0F
    ld b, a
    ld c, $40
    
    call colour_455D ; Perform brightness calculations on $D180..FF to $D100..7F
    ret
;}

colour_45A4: ; Handle colour palette transfers
;{
    ld a, [colour_D44A]
    or a
        ret z
    
    ld a, [colour_D449]
    cp $82
        jr z, .code_45E4
        
    cp $83
        jr z, .code_4611
    
    ld a, [colour_D448]
    ld b, a
    and $80
        jr z, .code_45C5
    
    ld a, b
    cp $82
        jr z, .code_460E
    
    cp $83
        jr z, .code_4632
    
; Transfer all colour palettes (from $D100..7F)
.code_45C5
;{
    ld a, $80
    ldh [$FF68], a
    ldh [$FF6A], a
    ld hl, colour_palettes
    ld de, $FF69
    ld bc, $FF6B
    
    .code_45D4
        ldi a, [hl]
        ld [de], a
        ldi a, [hl]
        ld [de], a
        ldi a, [hl]
        ld [bc], a
        ldi a, [hl]
        ld [bc], a
        ldh a, [$FF68]
        and $3F
    jr nz, .code_45D4
    
    jr .return
;}

; Set colour 0 of each BG palette to black or white
;{
    .code_45E4
    ld a, $FF
    
    .code_45E6
    ld hl, $FF68
    ld de, $FF69
    ld [hl], $80 | $00
    ld [de], a
    ld [de], a
    ld [hl], $80 | $08
    ld [de], a
    ld [de], a
    ld [hl], $80 | $10
    ld [de], a
    ld [de], a
    ld [hl], $80 | $18
    ld [de], a
    ld [de], a
    ld [hl], $80 | $20
    ld [de], a
    ld [de], a
    ld [hl], $80 | $28
    ld [de], a
    ld [de], a
    ld [hl], $80 | $30
    ld [de], a
    ld [de], a
    ld [hl], $80 | $38
    ld [de], a
    ld [de], a
    jr .return
    
    .code_460E
    xor a
    jr .code_45E6
;}

; Set colour 2 of BG palettes 2/5/6
;{
    ; Set colours to that of BG palette 3 colour 3
    .code_4611
    ld hl, .data_4644
    
    .code_4614
    ld de, $FF69
    ld b, $03
    
    .code_4619
        ldi a, [hl]
        ldh [$FF68], a
        ldi a, [hl]
        push hl
        ld h, colour_palettes >> 8
        ld l, a
        ld c, $03
        
        .code_4623
            ldi a, [hl]
            ld [de], a
            ldi a, [hl]
            ld [de], a
            inc l
            inc l
            dec c
        jr nz, .code_4623
        pop hl
        dec b
    jr nz, .code_4619
    jr .return
    
    ; Set colours normally
    .code_4632
    ld hl, .data_463E
    jr .code_4614
;}

.return
    ld a, [colour_D449]
    ld [colour_D448], a
    ret

.data_463E
    db $80 | $12, $12 * 2
    db $80 | $2A, $2A * 2
    db $80 | $32, $32 * 2

.data_4644
    db $80 | $12, $1B * 2
    db $80 | $2A, $1B * 2
    db $80 | $32, $1B * 2
;}

colour_464A: ; Called by door script processing
;{
    ld a,[hl]
    and $F0
    cp $E0
        ret nz
        
    ld a, [hl]
    and $0F
    or a
        ret nz
        
    ld a, [$D065]
    push af
    push bc
    push de
    inc hl
    ldi a, [hl]
    ld e, a
    ldi a, [hl]
    ld d, a
    ldi a, [hl]
    ld [$D065], a
    ldi a, [hl]
    ld c, a
    ldi a, [hl]
    ld b, a
    push hl
    push bc
    ldi a, [hl]
    ld b, [hl]
    ld c, a
    pop hl
    call $3FB5
    pop hl
    inc hl
    inc hl
    pop de
    pop bc
    pop af
    ld [$D065], a
    ret
;}

colour_467B: ; Credits
;{
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $20, $20
    db $20, $20, $53, $54, $41, $46, $46, $20, $20, $20, $20, $20, $20, $20, $20, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $20, $5E, $5E, $20, $54, $45, $41, $4D, $20, $4D
    db $45, $54, $52, $4F, $49, $44, $20, $5E, $5E, $20, $F1, $F1, $F1, $F1, $F1, $20
    db $50, $52, $4F, $44, $55, $43, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $F1, $F1, $20, $20, $47, $55, $4E, $50, $45, $49, $20, $59, $4F
    db $4B, $4F, $49, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $20, $44, $49, $52, $45, $43, $54, $4F, $52, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $20, $F1, $F1, $20, $20, $48, $49, $52, $4F, $4A, $49, $20, $4B
    db $49, $59, $4F, $54, $41, $4B, $45, $20, $20, $20, $F1, $F1, $20, $20, $48, $49
    db $52, $4F, $59, $55, $4B, $49, $20, $4B, $49, $4D, $55, $52, $41, $20, $20, $20
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $4D, $41, $49, $4E, $20, $50, $52, $4F
    db $47, $52, $41, $4D, $4D, $45, $52, $20, $20, $20, $20, $F1, $F1, $20, $20, $54
    db $41, $4B, $41, $48, $49, $52, $4F, $20, $48, $41, $52, $41, $44, $41, $20, $20
    db $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47, $52, $41, $4D
    db $4D, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $20, $20
    db $4D, $41, $53, $41, $52, $55, $20, $59, $41, $4D, $41, $4E, $41, $4B, $41, $20
    db $20, $20, $F1, $20, $20, $4D, $41, $53, $41, $4F, $20, $59, $41, $4D, $41, $4D
    db $4F, $54, $4F, $20, $20, $20, $20, $F1, $20, $20, $49, $53, $41, $4F, $20, $48
    db $49, $52, $41, $4E, $4F, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1
    db $F1, $F1, $20, $47, $52, $41, $50, $48, $49, $43, $20, $44, $45, $53, $49, $47
    db $4E, $45, $52, $20, $20, $20, $F1, $F1, $20, $20, $48, $49, $52, $4F, $4A, $49
    db $20, $4B, $49, $59, $4F, $54, $41, $4B, $45, $20, $20, $20, $F1, $20, $20, $48
    db $49, $52, $4F, $59, $55, $4B, $49, $20, $4B, $49, $4D, $55, $52, $41, $20, $20
    db $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47, $52, $41, $4D, $20
    db $41, $53, $53, $49, $53, $54, $41, $4E, $54, $20, $20, $F1, $F1, $20, $20, $59
    db $55, $5A, $55, $52, $55, $20, $4F, $47, $41, $57, $41, $20, $20, $20, $20, $20
    db $20, $F1, $20, $20, $4E, $4F, $42, $55, $48, $49, $52, $4F, $20, $4F, $5A, $41
    db $4B, $49, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $53, $4F, $55
    db $4E, $44, $20, $50, $52, $4F, $47, $52, $41, $4D, $4D, $45, $52, $20, $20, $20
    db $F1, $F1, $20, $20, $52, $59, $4F, $48, $4A, $49, $20, $59, $4F, $53, $48, $49
    db $54, $4F, $4D, $49, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $44, $45, $53
    db $49, $47, $4E, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $F1, $F1, $20, $20, $4D, $41, $4B, $4F, $54, $4F, $20, $4B, $41, $4E, $4F, $48
    db $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4D, $41, $53, $41, $46, $55, $4D
    db $49, $20, $53, $41, $4B, $41, $53, $48, $49, $54, $41, $F1, $20, $20, $54, $4F
    db $4D, $4F, $59, $4F, $53, $48, $49, $20, $59, $41, $4D, $41, $4E, $45, $20, $20
    db $F1, $20, $20, $54, $41, $4B, $45, $48, $49, $4B, $4F, $20, $48, $4F, $53, $4F
    db $4B, $41, $57, $41, $20, $F1, $20, $20, $59, $41, $53, $55, $4F, $20, $49, $4E
    db $4F, $55, $45, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1
    db $20, $44, $45, $42, $55, $47, $47, $45, $52, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $20, $F1, $F1, $20, $20, $4D, $41, $53, $41, $52, $55, $20, $4F
    db $4B, $41, $44, $41, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4B, $45, $4E
    db $4A, $49, $20, $4E, $49, $53, $48, $49, $5A, $41, $57, $41, $20, $20, $20, $F1
    db $20, $20, $48, $49, $52, $4F, $46, $55, $4D, $49, $20, $4D, $41, $54, $53, $55
    db $4F, $4B, $41, $20, $F1, $20, $20, $54, $4F, $48, $52, $55, $20, $4F, $48, $53
    db $41, $57, $41, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4B, $4F, $48, $54
    db $41, $20, $46, $55, $4B, $55, $49, $20, $20, $20, $20, $20, $20, $20, $F1, $20
    db $20, $4B, $45, $49, $53, $55, $4B, $45, $20, $54, $45, $52, $41, $53, $41, $4B
    db $49, $20, $20, $F1, $20, $20, $4B, $45, $4E, $49, $43, $48, $49, $20, $53, $55
    db $47, $49, $4E, $4F, $20, $20, $20, $20, $F1, $20, $20, $48, $49, $54, $4F, $53
    db $48, $49, $20, $59, $41, $4D, $41, $47, $41, $4D, $49, $20, $20, $F1, $20, $20
    db $4B, $41, $54, $53, $55, $59, $41, $20, $59, $41, $4D, $41, $4E, $4F, $20, $20
    db $20, $20, $F1, $20, $20, $59, $55, $4A, $49, $20, $48, $4F, $52, $49, $20, $20
    db $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $5E
    db $20, $46, $41, $4E, $20, $43, $4F, $4C, $4F, $52, $49, $5A, $41, $54, $49, $4F
    db $4E, $20, $5E, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $47, $52, $41, $50
    db $48, $49, $43, $20, $44, $45, $53, $49, $47, $4E, $45, $52, $20, $20, $20, $F1
    db $F1, $20, $20, $45, $4A, $52, $20, $54, $41, $49, $52, $4E, $45, $20, $20, $20
    db $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47
    db $52, $41, $4D, $4D, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1
    db $F1, $20, $20, $4A, $55, $53, $54, $49, $4E, $20, $4F, $4C, $42, $52, $41, $4E
    db $54, $5A, $20, $20, $20, $F1, $20, $20, $20, $20, $20, $20, $20, $20, $5E, $20
    db $51, $55, $41, $4E, $54, $41, $4D, $20, $5E, $20, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $20, $5E, $20, $53, $50, $45, $43, $49, $41, $4C, $20, $54, $48, $41
    db $4E, $4B, $53, $20, $5E, $20, $F1, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $54, $4F, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $20, $20, $54
    db $41, $4B, $45, $48, $49, $52, $4F, $20, $49, $5A, $55, $53, $48, $49, $20, $20
    db $20, $F1, $20, $20, $50, $48, $49, $4C, $20, $53, $41, $4E, $44, $48, $4F, $50
    db $20, $20, $20, $20, $20, $20, $F1, $20, $20, $54, $4F, $4E, $59, $20, $53, $54
    db $41, $4E, $43, $5A, $59, $4B, $20, $20, $20, $20, $20, $F1, $20, $20, $59, $55
    db $4B, $41, $20, $4E, $41, $4B, $41, $54, $41, $20, $20, $20, $20, $20, $20, $20
    db $F1, $20, $20, $48, $49, $52, $4F, $20, $59, $41, $4D, $41, $44, $41, $20, $20
    db $20, $20, $20, $20, $20, $F1, $20, $20, $44, $41, $4E, $20, $4F, $57, $53, $45
    db $4E, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $44, $59, $4C
    db $41, $4E, $20, $43, $55, $54, $48, $42, $45, $52, $54, $20, $20, $20, $20, $F1
    db $20, $20, $53, $41, $43, $48, $49, $45, $20, $49, $4E, $4F, $4B, $45, $20, $20
    db $20, $20, $20, $20, $F1, $20, $20, $41, $4E, $44, $20, $47, $42, $44, $45, $56
    db $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $50, $52, $45, $53, $45, $4E
    db $54, $45, $44, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $20, $20
    db $20, $20, $20, $42, $59, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $F1, $20, $20, $20, $20, $20, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $20, $20
    db $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $20, $20, $21, $22, $23, $20, $24
    db $25, $20, $26, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $27
    db $28, $29, $2A, $2B, $2C, $2D, $2E, $20, $20, $20, $20, $20, $20, $20, $F1, $F1
    db $F1, $F1, $F1, $20, $20, $54, $49, $4D, $45, $20, $20, $20, $1B, $20, $20, $20
    db $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F0, $00, $00, $76, $00, $76
    db $00, $76
;}

; Copied straight out of bank 3. Queen head and feet tilemaps are read from here, I assume the vast majority of it is unused
SECTION "colour_106FA2", ROMX[$6FA2], BANK[$10]
;{
; Queen head tilemaps
colour_queen_headFrameA: ; 03:6FA2
    db $BB, $B1, $B2, $B3, $B4, $FF
    db $C0, $C1, $C2, $C3, $C4, $FF
    db $D0, $D1, $D2, $D3, $D4, $D5
    db $FF, $FF, $E2, $E3, $E4, $E5
    db $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
colour_queen_headFrameB: ; 03:6FC6
    db $BB, $B1, $F5, $B8, $B9, $BA
    db $C0, $C1, $C7, $C8, $C9, $CA
    db $D0, $E6, $D7, $D8, $FF, $FF
    db $FF, $F6, $E7, $E8, $FF, $FF
    db $FF, $FF, $F7, $F8, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
colour_queen_headFrameC: ; 03:6FEA
    db $FF, $BC, $BD, $BE, $FF, $FF
    db $FF, $CB, $CC, $CD, $FF, $FF
    db $DA, $DB, $DC, $DD, $FF, $FF
    db $EA, $EB, $EC, $ED, $DE, $FF
    db $FA, $FB, $FC, $FD, $EE, $D9
    db $FF, $FF, $FF, $FF, $FF, $FF

colour_queen_drawHead: ;{
    .resume_A: ; 03:700E
        ld a, [queen_headDest]
        ld l, a
        ld a, [queen_headSrcHigh]
        ld d, a
        ld a, [queen_headSrcLow]
        ld e, a
        ld h, $9c
        jr .resume_B
.entry: ; 03:701E - Entry point
    ld a, [queen_headFrameNext]
    and a
        ret z
    cp $ff
        jr z, .resume_A

    ld de, queen_headFrameA
    cp $01
    jr z, .endIf
        ld de, queen_headFrameB
        cp $02
        jr z, .endIf
            ld de, queen_headFrameC
    .endIf:

    ld hl, $9c00
  .resume_B:
    ld c, $03 ; Draw only 3 rows per frame (split update into two frames)

    .drawLoop:
        ld b, $06
        .rowLoop:
            ld a, [de]
            ld [hl+], a
            inc de
            dec b
        jr nz, .rowLoop
    
        ld a, $1a
        add l
        ld l, a
        dec c
    jr nz, .drawLoop

    ld a, [queen_headFrameNext]
    cp $ff
    jr nz, .else
        ; Finished rendering
        xor a
        ld [queen_headFrameNext], a
        ret
    .else:
        ; Continue rendering next frame
        ld a, l
        ld [queen_headDest], a
        ld a, d
        ld [queen_headSrcHigh], a
        ld a, e
        ld [queen_headSrcLow], a
        ld a, $ff
        ld [queen_headFrameNext], a
        ret
;} end proc

; 03:706A - Rendering the Queen's feet
colour_queen_drawFeet: ;{
    ; Try drawing the head if the next frame is zero
    ld a, [queen_footFrame]
    and a
        jr z, queen_drawHead.entry
    ; Save frame to B
    ld b, a
    ; Try drawing the head if the animation delay is non-zero
    ld a, [queen_footAnimCounter]
    and a
    jr z, .endIf_A
        dec a
        ld [queen_footAnimCounter], a
            jr queen_drawHead.entry
    .endIf_A:

    ; Reload the animation counter
    ld a, $01
    ld [queen_footAnimCounter], a
    ; Select the front or back feet depending on the LSB of the animation frame
    ld a, b
    bit 7, a ; Bit 7 == 0 -> do the front foot, else do the rear foot
    ld hl, queen_frontFootPointers
    ld de, queen_frontFootOffsets
    ld b, $0c ; Number of tiles to update
    jr z, .endIf_B
        ld hl, queen_rearFootPointers
        ld de, queen_rearFootOffsets
        ld b, $10 ; Number of tiles to update
    .endIf_B:
    
    ; Get the foot tilemap/tile-offset pointers
    push de
        and $7f ; Mask out the bit determining which foot to render
        dec a   ; Adjusting because the value zero earlier meant "skip rendering"
        sla a
        ld e, a
        ld d, $00
        add hl, de
        ld e, [hl]
        inc hl
        ld d, [hl]
    pop hl
    ; HL now points to the offset table
    ; DE now points to the tilemap

    .vramUpdateLoop:
        push bc ; push the loop counter (b) on to the stack
            ; VRAM Offset: BC = $9A00 + [HL]
            ld b, $9a
            ld c, [hl]
            ; DE points to the current tile number to render
            ld a, [de]
            ld [bc], a ; Write to VRAM
            inc hl
            inc de
        pop bc ; pop the loop counter from the stack
        dec b
    jr nz, .vramUpdateLoop

    ; Don't increment the frame counter if we rendered the front foot
    ld a, [queen_footFrame]
    bit 7, a
    jr z, .endIf_C
        inc a
    .endIf_C:
    
    xor $80 ; Swap which foot to render next frame
    and $83 ; Mask frame numbers greater than 3
    ; inc if zero so we don't stop animating the feet
    jr nz, .endIf_D
        inc a
    .endIf_D:
    ld [queen_footFrame], a
ret

; Pointers, tile numbers, and tilemap offsets for the rear and front feet.
colour_queen_rearFootPointers:
    dw colour_queen_rearFoot1, colour_queen_rearFoot2, colour_queen_rearFoot3
colour_queen_frontFootPointers:
    dw colour_queen_frontFoot1, colour_queen_frontFoot2, colour_queen_frontFoot3
    
; 03:70D0
colour_queen_rearFoot1:
    db     $21,$22,$23,$24
    db $30,$31,$32,$33
    db $40,$41,$42,    $44
    db $50,$51,$52,$53
colour_queen_rearFoot2:
    db     $2c,$2d,$2e,$2f
    db $3b,$3c,$3d,$3e
    db $4b,$4c,$4d,    $4f
    db $7f,$f2,$ef,$df
colour_queen_rearFoot3:
    db     $2c,$2d,$2e,$2f 
    db $3b,$3c,$3d,$3e
    db $4b,$4c,$4d,    $4f
    db $10,$11,$12,$df

; 03:7100
colour_queen_frontFoot1:
    db $28,$29,$2a
    db $38,$39,$3a
    db $48,$49,$4a
    db $fe,$f9,$f4
colour_queen_frontFoot2:
    db $1b,$1c,$1d
    db $03,$04,$05
    db $0e,$0f,$1f
    db $ff,$ff,$ff
colour_queen_frontFoot3:
    db $1b,$1c,$1d
    db $03,$04,$05
    db $0e,$0f,$1f
    db $00,$01,$02
    
; 03:7124
colour_queen_rearFootOffsets:
    db     $01,$02,$03,$04
    db $20,$21,$22,$23
    db $40,$41,$42,    $44
    db $60,$61,$62,$63
colour_queen_frontFootOffsets:
    db $08,$09,$0a 
    db $28,$29,$2a 
    db $48,$49,$4a
    db $68,$69,$6a
;} No more code about the Queen's feet, please.

; Copy sprites to OAM buffer
colour_queen_writeOam: ;{ 03:7140
    ; Copy the 6 segments of the neck (or the spit projectiles)
    ; Set source pointer
    ld hl, queen_objectOAM ; $c308
    ; Set destination pointer
    ld a, [hOamBufferIndex]
    ld e, a
    ld d, HIGH(wram_oamBuffer)
    ; Load 6 pairs of sprites
    ld c, $06
    .loop_A:
        ; Break if at the last sprite
        ld a, [queen_pOamScratchpadLow]
        add $08
        cp l
            jr z, .break
        
        ; Load a pair of sprites to the OAM buffer
        ld b, $08
        .loop_B:
            ld a, [hl+]
            ld [de], a
            inc de
            dec b
        jr nz, .loop_B
        
        ; Decrement loop counter
        dec c
    jr nz, .loop_A
    .break:

    ; Copy the wall segments
    ld hl, queen_wallOAM ; $C338
    ld b, $0C*4 ;$30
    .loop_C:
        ld a, [hl+]
        ld [de], a
        inc de
        dec b
    jr nz, .loop_C
    
    ; Update the OAM index
    ld a, e
    ld [hOamBufferIndex], a
ret ;}

; Compute the change in camera position
colour_queen_getCameraDelta: ;{ 03:716E
    ; Load previous Y camera value
    ld a, [queen_cameraY]
    ld b, a
    ; Clamp minimum value of camera to zero
    ld a, [scrollY]
    cp $f8
    jr c, .endIf
        xor a
    .endIf:
    ; Update to current X camera value
    ld [queen_cameraY], a
    ; delta = cur - prev
    sub b
    ld [queen_cameraDeltaY], a
    
    ; Load previous X camera value
    ld a, [queen_cameraX]
    ld b, a
    ; Update to current X camera value
    ld a, [scrollX]
    ld [queen_cameraX], a
    ; delta = cur - prev
    sub b
    ld [queen_cameraDeltaX], a
ret ;}

colour_queen_adjustBodyForCamera: ;{ 03:7190
; Adjust X positions
    ; Get delta X
    ld a, [queen_cameraDeltaX]
    ld b, a
    
    ; Adjust body position
    ld a, [queen_bodyXScroll]
    add b ; Add due to how the raster split works
    ld [queen_bodyXScroll], a
    ; Adjust head position
    ld a, [queen_headX]
    sub b
    ld [queen_headX], a

; Adjust Y positions
    ; Get delta Y
    ld a, [queen_cameraDeltaY]
    ld b, a
    
    ; Adjust body position
    ld a, [queen_headY]
    sub b
    ld [queen_headY], a
    
; Get the scanline numbers for the queen's raster splits (using queen body/height)
    ; Clamp minimum value of camera to zero
    ld a, [scrollY]
    cp $f8
    jr c, .endIf
        xor a
    .endIf:
    ld c, a
    
    ld a, $67 ; Pixels between the top of the BG map to the top of the queen (minus 1)
    sub c
    jr c, .else
        ; If the top of the camera is above the top of the queen's body
        ; bodyY = $67 - ScrollY
        ld [queen_bodyY], a
        ; height = standard
        ld a, $37
        ld [queen_bodyHeight], a
        ret
    .else:
        ; If the top of the camera is below the top of the queen's body (normally impossible)
        ; height = $67 - ScrollY + $37 (this math doesn't seem right)
        ld d, $37
        add d
        ld [queen_bodyHeight], a
        ; Set top of queen's body to top of the screen
        xor a
        ld [queen_bodyY], a
        ret
;}

; Camera adjustment
colour_queen_adjustSpritesForCamera: ;{ 03:71CF
    ; Set offset for OAM scratchpad pointer
    ld a, [queen_stomachBombedFlag]
    ld d, $05
    and a
    jr z, .endIf_A
        ld d, $01
    .endIf_A:

    ; Load camera deltas to B and C
    ld a, [queen_cameraDeltaX]
    ld b, a
    ld a, [queen_cameraDeltaY]
    ld c, a
    
    ; Skip ahead if OAM scratchpad is being unused (low byte of pointer is $00)
    ld a, [queen_pOamScratchpadLow]
    cp $00
    jr z, $7215
        ; Set OAM scratchpad pointer (should be pointing at an X value)
        add d
        ld l, a
        ld a, [queen_pOamScratchpadHigh]
        ld h, a
        ; Iterate backwards through the OAM scratchpad
        .loop_A:
            ; Adjust X position
            ld a, [hl]
            sub b
            ld [hl-], a
            ; Adjust Y position
            ld a, [hl]
            sub c
            ld [hl-], a
            ; Skip attributes and tile of previous sprite
            dec l
            dec l
            ; Exit loop if below the end of the OAM scratchpad
            ld a, $05
            cp l
        jr nz, .loop_A
        
        ; Adjust positions of projectiles
        ld hl, queenActor_spitA + 1 ; $C741
        ld d, $03
        .loop_B:
            call queen_singleCameraAdjustment
            ; Iterate to next actor
            ld a, l
;}
;}
