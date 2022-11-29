;pause map tiles for ruin2
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt1, mt1, mt0, mtX, mtX, mtX
	db mtX, mtX, mtX, mt1, mt2, mt2, mt1, mt1, mt1, mt0, mt0, mt1, mt0, mt0, mt2, mt3, mt0, mtX, mtX, mtX
	db mtX, mtX, mtX, mt1, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt1, mt0, mt0, mt2, mt1, mt0, mtX, mtX, mtX
	db mtX, mtX, mtX, mt1, mtH, mtX, mtX, mtX, mtX, mt0, mtX, mt3, mt1, mt1, mt2, mt1, mt0, mtH, mtX, mtX
	db mtX, mtX, mtX, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt2, mt3, mt3, mt3, mt1, mt2, mt2, mt1, mtX
	db mtH, mt0, mt0, mt1, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt1, mt1, mt2, mt2, mt3, mt3, mt3, mt1, mtX
	db mtX, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtH, mt0, mt0, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus mt sprite list
	;save and refill
	db autoVal, $00, $28, $80, mtR, $00
	db autoVal, $00, $38, $78, mtS, $00
	db autoVal, $00, $50, $50, mtR, $00
	;items
	db validateBankE, $63, $40, $60, mtI, $00	;space jump
	db validateBankE, $64, $40, $80, mtI, $00	;etank
	db autoVal, $00, $50, $60, mtW, $00			;spazer
	db validateBankE, $6A, $58, $58, mtI, $00	;etank
	db autoVal, $00, $60, $58, mtW, $00			;plasma
	;missiles
	db validateBankE, $6D, $38, $80, mtM, $00
	db validateBank9, $22, $40, $88, mtM, $00
	db validateBankE, $6E, $48, $80, mtM, $00
	db validateBankE, $70, $60, $88, mtM, $00
	db endList
