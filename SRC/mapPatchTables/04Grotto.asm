;pause map tiles for area 2 ruins
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt1, mt1, mt0, mt0, mt0, mt0, mt0, mt0, mt0, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mt0, mt0, mt0, mt0, mt0, mt3, mt1, mt1, mt0, mt0, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mt1, mt0, mt0, mt0, mt0, mt0, mt2, mt2, mt3, mt0, mt0, mt0, mt0, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mt1, mt0, mt0, mt0, mt2, mt2, mt3, mt1, mt3, mt0, mt0, mt0, mt0, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mt1, mt0, mt0, mt0, mt1, mt1, mt2, mt2, mt2, mt1, mt1, mt0, mt0, mtH, mtX
	db mtX, mtX, mtX, mtX, mtX, mt1, mt0, mt0, mt0, mt2, mt0, mt3, mt3, mt3, mt3, mt2, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mt1, mtH, mtX, mtX, mt2, mt2, mt2, mt2, mtX, mtX, mt2, mt1, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt1, mt3, mt3, mt3, mt2, mt1, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mt1, mt2, mt2, mt2, mt3, mt1, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
	db mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX, mtX
;samus map sprite list
	;save and refill
	db autoVal, $00, $38, $40, mtR, $00
	db autoVal, $00, $58, $50, mtS, $00
	db autoVal, $00, $58, $80, mtS, $00
	;items
	db validateBankD, $30, $40, $60, mtI, $00	;spring
	db validateBankD, $29, $50, $50, mtI, $00	;varia
	db validateBankD, $37, $78, $70, mtI, $00	;etank
	db validateBankD, $35, $78, $80, mtI, $00	;hijump
	db autoVal, $00, $60, $58, mtW, $00			;wave
	;missiles
	db validateBank9, $26, $40, $48, mtM, $00
	db validateBankD, $2C, $48, $70, mtM, $00
	db validateBankD, $38, $60, $50, mtM, $00
	db validateBankD, $2D, $68, $58, mtM, $00
	db validateBankD, $32, $70, $70, mtM, $00
	db validateBankD, $33, $70, $70, mtM, $00
	db validateBankD, $3B, $78, $68, mtM, $00
	db validateBankD, $34, $78, $70, mtM, $00
	db endList
