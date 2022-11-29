;;;;special thanks to RT-55J without whom and his SRC this project wouldn't have happened
;;;;P.jboy for ASM help, and Conner and Liam for making m2 hacking fun through editor dev

def gameMode_paused = $08
def sram_total = $27
def clear_new_map_flag = $00
def set_new_map_flag = $01
def enable_PPU_flag = $e3

def mapDotsOAM_hi = $c0
def mapDotsOAM_lo = $0c
def mapIconsWram_hi = $dd
def mapIconsWram_lo = $70

def windowHeight_hud = $88
def windowHeight_text = $80
def windowHeight_map = $00

def start_items = $00
def total_items = $36

def isBeam = $05
def isRefill = $0e
def isFirstBeam = $00

;enemyOffset is where in enemy hRam to get the item wRam index value
;that value -$40 gives you the SRAM floor for the low byte of the SRAM address of the item
;bankOffset is used to account for currentLevelBank min val of $09
;loopLimit is anded with bankOffset+1 to enter a loop with a dec/jr z conditional at the start
;it also accounts for there being only 4 valid low byte offsets - $00, $40, $80, $C0
def mapTable_bankOffset = $09
def clearItem_enemyOffset = $1d
def clearItem_sramOffsetHi = $c9
def clearItem_sramOffsetLo = $40
def clearItem_bankOffset = mapTable_bankOffset
def clearItem_loopLimit = $03
def set_item_collected = $02

def tile_blank = $ff
def tile_white = $af
def tile_missile = $9f
def tile_colon = $9e
def tile_slash = $ae
def tile_0 = $a0
def tile_S = $d2
def tile_A = $c0
def tile_V = $d5
def tile_E = $c4
def tile_COL = $de

def mapIcon_samus = $01
def mapIcon_crossHair = $0f

;load this map
def nun = $ff	;unused map, easier to see, reconfigurable, plus lulz
def m00 = $00
def m01 = $01
def m02 = $02
def m03 = $03
def m04 = $04
def m05 = $05
def m06 = $06
def m07 = $07
def m08 = $08
def m09 = $09
def m0A = $0A
def m0B = $0B
def m0C = $0C
def m0D = $0D

;draw map with these map tiles
def mt0 = $AF ;room pattern 0
def mt1 = $9D ;room pattern 1
def mt2 = $9C ;room pattern 2
def mt3 = $AD ;room pattern 3
def mtH = $8F ;horizontal to next map
def mtV = $8F ;vertical to next map
def mtI = $91 ;accessory/item/etank
def mtM = $91 ;missile tank
def mtW = $90 ;beam upgrades, respawn so leave on map
def mtR = $93 ;refill point
def mtS = $92 ;save zone
def mtX = $FF ;cannot enter
def mtG = $36	;gunship
def flipL = $00	;left flip
def flipR = $20	;right flip

;how map sprite arrays are done:
;auto-validate address:
def icon_array_terminator = $ff
def autoVal = $c0
def endList = $ff
def validateBank9 = $c9
def validateBankA = $c9
def validateBankB = $c9
def validateBankC = $c9
def validateBankD = $ca
def validateBankE = $ca
def validateBankF = $ca
;6 entries per sprite
;- SRAM-to-check high (c5-c6),
;- SRAM-to-check low (00-ff),
;- sprite's map Y coord on window
;- sprite's map X coord on window
;- sprite tile to draw
;- sprite palette to use
;example:
;AUTOVAL, $00, $28, $48, $3f, $00, ENDLIST