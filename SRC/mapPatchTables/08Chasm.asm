;pause map tiles for 2nd lava section, areas 4 and 5, and the start of 3rd lava section to the Tower
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt1, mt1, mt1, mt1, mt2, mt2
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mtX, mtX, mtX, mtX, mt2, mt2
	db mtX, mtX, mtX, mtX, mtX, mt2, mt2, mt1, mt1, mt1, mt1, mt2, mt1, mt2, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mt2, mt2, mtX, mtX, mtX, mtX, mt2, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mt2, mt1, mt1, mt1, mt1, mt3, mt3, mtX, mt0, mt0, mtH, mt2, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mt2, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mtX, mtX, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mt2, mt1, mt1, mt1, mt1, mt1, mt1, mt1, mt0, mt0, mtX, mtX, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mtX, mtX, mt1, mtH, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtH, mt1, mt1, mt1, mt1, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus mt sprite list
	;save and refill
	db autoVal, $00, $30, $A0, mtR, $00
	db autoVal, $00, $40, $30, mtR, $00
	db endList
