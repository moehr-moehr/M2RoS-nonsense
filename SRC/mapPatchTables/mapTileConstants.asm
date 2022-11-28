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

MAP0 = $AF ;room pattern 0
MAP1 = $9D ;room pattern 1
MAP2 = $9C ;room pattern 2
MAP3 = $AD ;room pattern 3
MAPH = $8F ;horizontal to next map
MAPV = $8F ;vertical to next map
MAPI = $91 ;accessory/item/etank
MAPM = $91 ;missile tank
MAPW = $90 ;beam upgrades, respawn so leave on map
MAPR = $93 ;refill point
MAPZ = $92 ;save zone
MAPX = $FF ;cannot enter
SHIP = $36
LEFT = $00
RIGHT = $20
TST0 = $A0
TST1 = $A1
TST2 = $A2
TST3 = $A3
TST4 = $A4
TST5 = $A5
TST6 = $A6
TST7 = $A7

;how map sprite arrays are done:
;auto-validate address:
def icon_array_terminator = $ff
AUTOVAL = $c0
ENDLIST = $ff
COLLECTED = $02 ;works for doors, metroids, items :D
VALIDATEBANK9 = $c9
VALIDATEBANKA = $c9
VALIDATEBANKB = $c9
VALIDATEBANKC = $c9
VALIDATEBANKD = $ca
VALIDATEBANKE = $ca
VALIDATEBANKF = $ca
;6 entries per sprite
;- SRAM-to-check high (c5-c6),
;- SRAM-to-check low (00-ff),
;- sprite's map Y coord on window
;- sprite's map X coord on window
;- sprite tile to draw
;- sprite palette to use
;example:
;AUTOVAL, $00, $28, $48, $3f, $00, ENDLIST