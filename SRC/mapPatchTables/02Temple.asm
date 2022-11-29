;pause map tiles for area 1 and lair 1
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt1, mt1, mt1, mt2, mt0, mt0, mt2, mtX, mtX, mtX
	db mtX, mtX, mt2, mt1, mt1, mt1, mt0, mt0, mt2, mt2, mtX, mtX, mtX, mt2, mt0, mt0, mt1, mt1, mtX, mtX
	db mtX, mtH, mt2, mtX, mtX, mtX, mtX, mtX, mtX, mt2, mt1, mt1, mt1, mt2, mtX, mtX, mtX, mt2, mtX, mtX
	db mtX, mtX, mt2, mtH, mtX, mtX, mt2, mt1, mt1, mt2, mtX, mtX, mtX, mt2, mt1, mt1, mt1, mt2, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt3, mt1, mt1, mt2, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus map sprite list
	;save and refill
	db autoVal, $00, $30, $48, mtR, $00
	db autoVal, $00, $30, $68, mtR, $00
	db autoVal, $00, $48, $48, mtS, $00
	;items
	db validateBankD, $22, $50, $68, mtI, $00  ;etank
	db validateBankD, $23, $58, $38, mtI, $00  ;bomb
	db validateBankC, $E0, $58, $90, mtI, $00  ;spider
	db autoVal, $00, $60, $58, mtW, $00		;ice
	;missiles
	db validateBankD, $20, $40, $58, mtM, $00
	db validateBankD, $21, $40, $68, mtM, $00
	db validateBankD, $3A, $58, $38, mtM, $00
	db validateBankD, $25, $58, $78, mtM, $00
	db validateBankD, $26, $58, $80, mtM, $00
	db validateBankD, $27, $58, $80, mtM, $00
	db endList
