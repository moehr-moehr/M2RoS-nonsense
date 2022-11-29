;pause map tiles for 2nd lava section, areas 4 and 5, and the start of 3rd lava section to the Tower
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt2, mt2, mt2, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt1, mt1, mt1, mtX, mtX, mt3, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt3, mt2, mtX, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt1, mt1, mt1, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt3, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt1, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt2, mt2, mt2, mt3, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt1, mt1, mt1, mt1, mt1, mt3, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt2, mt2, mt2, mt2, mt2, mt2, mtH, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus mt sprite list
	;save and refill
	db autoVal, $00, $50, $60, mtR, $00
	db autoVal, $00, $50, $60, mtR, $00
	db autoVal, $00, $78, $58, mtS, $00
	;items
	db autoVal, $00, $38, $58, mtW, $00	;ice beam
	db endList
