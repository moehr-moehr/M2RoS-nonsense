;pause map tiles for lair3
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtH, mt2, mt2, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtH, mt1, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt1, mtX, mtX, mt2, mt2, mt2, mt3, mtX, mtX, mtX, mtX, mt1, mtX, mtX
	db mtX, mtX, mtX, mtV, mtX, mtX, mt1, mtX, mtX, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt1, mtX, mtX
	db mtX, mtX, mtX, mt2, mt2, mt2, mt1, mtX, mtX, mt1, mt2, mt2, mt3, mtX, mtX, mtX, mtX, mt1, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt1, mt2, mt2, mt1, mtX, mtX, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt1, mtX, mtX, mt1, mt3, mtX, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt3, mt2, mt2, mt3, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus mt sprite list
	;save and refill
	db autoVal, $00, $28, $38, mtS, $00
	db autoVal, $00, $80, $60, mtR, $00
	db endList
