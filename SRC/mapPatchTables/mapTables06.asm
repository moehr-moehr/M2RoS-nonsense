;map tables for vanilla bank 0F
;map to load for each screen of bank
	db m00, m00, m00, m00, m00, m00, nun, nun, m0D, m0D, m0D, m0D, m0D, m0D, m0D, m0D
	db m00, m00, m00, m00, m00, m00, nun, nun, m0D, m0D, m0D, m0D, m0D, m0D, m0D, m0D
	db m00, m00, m00, m00, m00, m00, m00, m00, m0D, m0D, m0D, nun, nun, m0D, m0D, m0D
	db m00, m00, m00, m00, m00, m00, m00, m00, m0D, m0D, m0D, nun, nun, m0D, m0D, m0D
	db m00, m00, m00, nun, nun, m00, m00, m00, m0D, m0D, m0D, nun, nun, m0D, m0D, m0D
	db m00, m00, m00, nun, nun, m00, m00, m00, nun, m0D, nun, nun, nun, m0D, m0D, m0D
	db m00, m00, m00, nun, nun, m00, m00, m00, nun, m0D, m00, m00, m00, nun, nun, nun
	db nun, nun, nun, nun, nun, m00, m00, m00, nun, m0D, m0D, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, m0D, m0D, m0D, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, m0D, m0D, m0D, nun, nun, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, m0D, m0D, m0D, m0D, nun, nun, nun, nun, nun, nun
	db m0B, m0B, m0B, m0B, m0B, m0B, nun, nun, nun, nun, m0C, m0C, m0C, m0C, m0C, nun
	db m0B, m0B, m0B, m0B, nun, nun, nun, nun, nun, nun, m0C, m0C, m0C, m0C, m0C, nun
	db m0B, m0B, m0B, m0B, m0B, m0B, nun, nun, nun, nun, m0C, m0C, m0C, m0C, m0C, nun
	db m0B, m0B, m0B, m0B, m0B, m0B, nun, nun, nun, nun, m0C, m0C, m0C, m0C, m0C, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, m0C, m0C, m0C, m0C, nun
;samus map location offset Y for screen
	db $0F, $0F, $0F, $0F, $0F, $0F, nun, nun, $05, $05, $05, $05, $05, $05, $05, $05
	db $11, $11, $11, $11, $11, $11, nun, nun, $05, $05, $05, $05, $05, $05, $05, $05
	db $03, $03, $03, $03, $03, $03, $03, $03, $05, $05, $05, nun, nun, $05, $05, $05
	db $03, $03, $03, $03, $03, $03, $03, $03, $05, $05, $05, nun, nun, $05, $05, $05
	db $03, $03, $03, nun, nun, $03, $03, $03, $05, $05, $05, nun, nun, $05, $05, $05
	db $03, $03, $03, nun, nun, $03, $03, $03, nun, $05, nun, nun, nun, $05, $05, $05
	db $03, $03, $03, nun, nun, $03, $03, $03, nun, $05, $05, $05, $05, nun, nun, nun
	db nun, nun, nun, nun, nun, $03, $03, $03, nun, $05, $05, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, $05, $05, $05, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, $05, $05, $05, nun, nun, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, $05, $05, $05, $05, nun, nun, nun, nun, nun, nun
	db $01, $01, $01, $01, $01, $01, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $1D, $1D, $1D, $1D, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $1E, $1E, $1E, $1E, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $1A, $1A, $1A, $1A, $1A, $1A, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, nun, $17
;samus map location offset X for screen
	db $0E, $0E, $0E, $0E, $0E, $0E, nun, nun, $04, $04, $04, $04, $04, $04, $04, $04
	db $07, $07, $07, $07, $07, $07, nun, nun, $04, $04, $04, $04, $04, $04, $04, $04
	db $03, $03, $03, $03, $03, $03, $03, $03, $04, $04, $04, nun, nun, $04, $04, $04
	db $03, $03, $03, $03, $03, $03, $03, $03, $04, $04, $04, nun, nun, $04, $04, $04
	db $03, $03, $03, nun, nun, $03, $03, $03, $04, $04, $04, nun, nun, $04, $04, $04
	db $03, $03, $03, nun, nun, $03, $03, $03, nun, $04, nun, nun, nun, $04, $04, $04
	db $03, $03, $03, nun, nun, $03, $03, $03, nun, $04, $05, $05, $05, nun, nun, nun
	db nun, nun, nun, nun, nun, $03, $03, $03, nun, $04, $04, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, $04, $04, $04, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, $04, $04, $04, nun, nun, nun, nun, nun, nun, nun
	db nun, nun, nun, nun, nun, nun, $04, $04, $04, $04, nun, nun, nun, nun, nun, nun
	db $07, $07, $07, $07, $07, $07, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $08, $08, $08, $08, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $0E, $0E, $0E, $0E, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db $01, $01, $01, $01, $01, $01, nun, nun, nun, nun, $1F, $1F, $1F, $1F, $1F, nun
	db nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, nun, $1F, $1F, $1F, nun, $1C