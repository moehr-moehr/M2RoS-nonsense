;pause map tiles for 2nd lava section, areas 4 and 5, and the start of 3rd lava section to the Tower
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt2, mt2, mt3, mt3, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt1, mt1, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt2, mt2, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt3, mt3, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt2, mt2, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt3, mt1, mt0, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt2, mt1, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mt3, mt3, mt2, mt2, mt2, mt2, mt0, mt3, mt1, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt2, mt1, mt0, mt0, mt2, mt2, mt2, mt2, mt3, mt3, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt3, mt3, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt2, mt1, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mtX, mt1, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mt3, mt3, mt2, mt2, mt0, mtX, mt1, mt0, mt0, mtH, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mtX, mtX, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus mt sprite list
	;save and refill
	db autoVal, $00, $58, $58, mtR, $00
	db autoVal, $00, $58, $60, mtR, $00
	db autoVal, $00, $80, $48, mtS, $00
	;items
	db validateBank9, $27, $20, $50, mtI, $00	;etank
	db validateBank9, $20, $30, $50, mtI, $00	;etank
	db validateBankE, $61, $40, $50, mtI, $00	;screw attack
	db autoVal, $00, $58, $48, mtW, $00			;plasma
	db autoVal, $00, $60, $48, mtW, $00			;spazer
	db autoVal, $00, $68, $48, mtW, $00			;wave
	db autoVal, $00, $70, $48, mtW, $00			;ice
	;missiles
	db validateBank9, $25, $20, $48, mtM, $00
	db validateBankE, $60, $38, $50, mtM, $00
	db validateBank9, $21, $60, $60, mtM, $00
	db validateBank9, $23, $98, $58, mtM, $00
	db endList
