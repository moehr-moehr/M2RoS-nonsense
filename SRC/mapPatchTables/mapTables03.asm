;map tables for vanilla bank 0C
;map to load for each screen of bank
	db nun, nun, m02, m02, m01, m06, m07, nun, m07, nun, m0A, nun, m0B, m0A, m0A, nun
	db nun, nun, m02, m02, m01, m06, m07, nun, m07, m07, m0A, nun, m0B, m0A, m0A, nun
	db nun, m00, m02, nun, nun, m06, m07, nun, m07, m07, m0A, nun, m0B, nun, nun, nun
	db nun, m00, nun, nun, nun, m06, m07, m07, m07, m07, m0A, nun, m0B, nun, nun, nun
	db nun, m00, nun, nun, nun, m06, m08, m07, m07, m07, m08, nun, m0B, m0B, nun, nun
	db nun, m00, nun, nun, m08, m01, m08, m07, m07, m07, m08, nun, nun, m0B, nun, nun
	db nun, m00, nun, nun, m08, m01, m08, m07, m07, m07, m08, nun, m0B, m0B, nun, nun
	db nun, m00, nun, nun, m08, m01, m0A, nun, m07, m07, m0A, nun, m0B, nun, nun, nun
	db m0A, m00, nun, nun, m0A, m01, m0A, m0A, m07, nun, m0A, m0A, m0B, nun, nun, m0A
	db m0A, nun, nun, nun, m0A, nun, nun, m0A, m07, m08, m0A, m0A, m0B, m0B, nun, m0A
	db m0A, m01, m04, m07, m0A, nun, m0A, nun, nun, m08, m0A, m0A, m0B, m0B, nun, m0A
	db m0A, m01, m04, m07, m0A, nun, m0A, m0C, nun, m08, m0A, m0A, m0B, m0B, nun, m0A
	db m0A, m01, m04, m07, nun, nun, m0A, m0C, m0C, m08, m0A, m0A, m0B, nun, nun, m0A
	db m0A, m01, m04, m07, nun, nun, m0A, nun, m0C, m08, nun, m0A, nun, m0A, nun, m0A
	db nun, m01, m04, m07, nun, nun, m0A, nun, m0C, m08, nun, m0A, nun, m0A, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, m0C, nun, nun, nun, nun, m0A, nun, nun
;samus map location offset Y for screen
	db nun, nun, $09, $0A, $11, $08, $07, nun, $05, nun, $06, nun, $06, $0D, $0D, nun
	db nun, nun, $09, $0A, $11, $08, $07, nun, $05, $07, $06, nun, $06, $0D, $0D, nun
	db nun, $0A, $09, nun, nun, $08, $07, nun, $05, $07, $06, nun, $06, nun, nun, nun
	db nun, $0A, nun, nun, nun, $08, $07, $07, $05, $07, $06, nun, $06, nun, nun, nun
	db nun, $0A, nun, nun, nun, $08, $01, $07, $07, $07, $05, nun, $06, $06, nun, nun
	db nun, $0A, nun, nun, $02, $06, $01, $07, $07, $07, $05, nun, nun, $06, nun, nun
	db nun, $0A, nun, nun, $02, $06, $01, $07, $07, $07, $05, nun, $04, $06, nun, nun
	db nun, $0A, nun, nun, $02, $06, $06, nun, $07, $07, $06, nun, $04, nun, nun, nun
	db $1C, $0A, nun, nun, $1E, $06, $06, $06, $07, nun, $06, $06, $04, nun, nun, $1C
	db $1C, nun, nun, nun, $1E, nun, nun, $06, $07, $1E, $07, $06, $04, $1F, nun, $1C
	db $1C, $1D, $1F, $1C, $1E, nun, $03, nun, nun, $1E, $07, $02, $04, $1F, nun, $1C
	db $1C, $1D, $1F, $1C, $1E, nun, $03, $04, nun, $1E, $07, $02, $04, $1F, nun, $1C
	db $1C, $1A, $1F, $1C, nun, nun, $03, $04, $05, $1E, $07, $02, $04, nun, nun, $1C
	db $1C, $1A, $1F, $1C, nun, nun, $03, nun, $05, $1E, nun, $02, nun, $04, nun, $1C
	db nun, $1A, $1F, $1C, nun, nun, $03, nun, $02, $1E, nun, $02, nun, $04, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, $02, nun, nun, nun, nun, $04, nun, nun
;samus map location offset X for screen
	db nun, nun, $01, $0F, $0A, $1F, $04, nun, $0A, nun, $07, nun, $00, $19, $18, nun
	db nun, nun, $01, $0F, $0A, $1F, $04, nun, $0A, $04, $07, nun, $00, $19, $18, nun
	db nun, $10, $01, nun, nun, $1F, $04, nun, $0A, $04, $07, nun, $00, nun, nun, nun
	db nun, $10, nun, nun, nun, $1F, $04, $04, $0A, $04, $07, nun, $00, nun, nun, nun
	db nun, $10, nun, nun, nun, $1F, $08, $04, $04, $04, $17, nun, $00, $00, nun, nun
	db nun, $0C, nun, nun, $08, $04, $08, $04, $04, $04, $17, nun, nun, $00, nun, nun
	db nun, $0C, nun, nun, $08, $04, $08, $04, $04, $04, $17, nun, $1A, $00, nun, nun
	db nun, $0C, nun, nun, $08, $04, $06, nun, $04, $04, $02, nun, $1A, nun, nun, nun
	db $05, $0C, nun, nun, $00, $04, $06, $06, $04, nun, $02, $02, $1A, nun, nun, $16
	db $05, nun, nun, nun, $00, nun, nun, $06, $04, $04, $19, $02, $1A, $1A, nun, $16
	db $05, $06, $04, $04, $00, nun, $09, nun, nun, $04, $19, $17, $1A, $1A, nun, $16
	db $05, $06, $04, $04, $00, nun, $09, $02, nun, $04, $19, $17, $1A, $1A, nun, $16
	db $05, $0E, $04, $04, nun, nun, $09, $02, $00, $04, $19, $17, $1A, nun, nun, $16
	db $05, $0E, $04, $04, nun, nun, $09, nun, $00, $04, nun, $17, nun, $1B, nun, $16
	db nun, $0E, $04, $04, nun, nun, $09, nun, $06, $04, nun, $17, nun, $1B, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, $06, nun, nun, nun, nun, $1B, nun, nun
