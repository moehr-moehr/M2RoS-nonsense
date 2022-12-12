SECTION "ROM Bank $007", ROMX[$4000], BANK[$7]

if !def(COLOURHACK)
    gfx_plantBubbles:: incbin "tilesets/plantBubbles.chr",0,$800
    gfx_ruinsInside::  incbin "tilesets/ruinsInside.chr", 0,$800
    gfx_queenBG::      incbin "tilesets/queenBG.chr",     0,$800
    gfx_caveFirst::    incbin "tilesets/caveFirst.chr",   0,$800
    gfx_surfaceBG::    incbin "tilesets/surfaceBG.chr",   0,$800
    gfx_lavaCavesA::   incbin "tilesets/lavaCavesA.chr",  0,$530
    gfx_lavaCavesB::   incbin "tilesets/lavaCavesB.chr",  0,$530
    gfx_lavaCavesC::   incbin "tilesets/lavaCavesC.chr",  0,$530

    ; 7:7790 - Item graphics (0x40 each)
    ; Plasma Beam, Ice Beam, Wave Beam, Spazer Beam
    ; Bombs, Screw Attack, Varia Suit, High Jump Boots
    ; Space Jump, Spider Ball, Spring Ball
    gfx_items:: incbin "gfx/items.chr"

    ; 7:7A50 - Item Orb
    gfx_itemOrb:: incbin "gfx/itemOrb.chr"

    ; 7:7A90 - Missile Tank, Door, Missile Block, Refills
    gfx_commonItems:: incbin "gfx/commonItems.chr"
else
    gfx_plantBubbles:: incbin "tilesets/colour/plantBubbles.chr",0,$800
    gfx_ruinsInside::  incbin "tilesets/ruinsInside.chr",        0,$800
    gfx_queenBG::      incbin "tilesets/colour/queenBG.chr",     0,$800
    gfx_caveFirst::    incbin "tilesets/colour/caveFirst.chr",   0,$800
    gfx_surfaceBG::    incbin "tilesets/surfaceBG.chr",          0,$800
    gfx_lavaCavesA::   incbin "tilesets/colour/lavaCavesA.chr",  0,$530
    gfx_lavaCavesB::   incbin "tilesets/lavaCavesB.chr",         0,$530
    gfx_lavaCavesC::   incbin "tilesets/colour/lavaCavesC.chr",  0,$530

    ; 7:7790 - Item graphics (0x40 each)
    ; Plasma Beam, Ice Beam, Wave Beam, Spazer Beam
    ; Bombs, Screw Attack, Varia Suit, High Jump Boots
    ; Space Jump, Spider Ball, Spring Ball
    gfx_items:: incbin "gfx/colour/items.chr"

    ; 7:7A50 - Item Orb
    gfx_itemOrb:: incbin "gfx/itemOrb.chr"

    ; 7:7A90 - Missile Tank, Door, Missile Block, Refills
    gfx_commonItems:: incbin "gfx/colour/commonItems.chr"
endc

bank7_freespace: ; 7:7B90 -- Freespace
