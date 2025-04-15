;
; File generated by cc65 v 2.19 - Git 5cb1bc6
;
	.fopt		compiler,"cc65 v 2.19 - Git 5cb1bc6"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_bg
	.import		_pal_spr
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_oam_clear
	.import		_oam_spr
	.import		_pad_poll
	.import		_vram_adr
	.import		_vram_fill
	.import		_vram_write
	.import		_get_pad_new
	.export		_TestLevel
	.import		_abs
	.export		_palette
	.export		_currentGameState
	.export		_text
	.export		_titlePrompt
	.export		_endScreenTitle
	.export		_endScreenPrompt
	.export		_inputPad
	.export		_movementPad
	.export		_playerX
	.export		_playerY
	.export		_goalX
	.export		_goalY
	.export		_DrawTitleScreen
	.export		_GameLoop
	.export		_MovePlayer
	.export		_DrawPlayer
	.export		_GetTileIndex
	.export		_CheckIfEnd
	.export		_DrawEndScreen
	.export		_main

.segment	"DATA"

_currentGameState:
	.byte	$00
_playerX:
	.byte	$0f
_playerY:
	.byte	$df
_goalX:
	.byte	$c8
_goalY:
	.byte	$c8

.segment	"RODATA"

_TestLevel:
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$02
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_palette:
	.byte	$0f
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
_text:
	.byte	$4E,$6F,$63,$74,$75,$72,$6E,$65,$73,$20,$42,$6C,$6F,$6F,$64,$00
_titlePrompt:
	.byte	$50,$72,$65,$73,$73,$20,$53,$54,$41,$52,$54,$00
_endScreenTitle:
	.byte	$45,$6E,$64,$20,$53,$63,$72,$65,$65,$6E,$00
_endScreenPrompt:
	.byte	$54,$6F,$20,$70,$6C,$61,$79,$20,$61,$67,$61,$69,$6E,$00

.segment	"BSS"

.segment	"ZEROPAGE"
_inputPad:
	.res	1,$00
_movementPad:
	.res	1,$00

; ---------------------------------------------------------------
; void __near__ DrawTitleScreen (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_DrawTitleScreen: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(palette); // load the BG palette
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; vram_adr(NTADR_A(8, 8)); // places text at screen position
;
	ldx     #$21
	lda     #$08
	jsr     _vram_adr
;
; vram_write(text, sizeof(text) - 1); //write Title to screen
;
	lda     #<(_text)
	ldx     #>(_text)
	jsr     pushax
	ldx     #$00
	lda     #$0F
	jsr     _vram_write
;
; vram_adr(NTADR_A(10, 14));
;
	ldx     #$21
	lda     #$CA
	jsr     _vram_adr
;
; vram_write(titlePrompt, sizeof(titlePrompt) - 1);
;
	lda     #<(_titlePrompt)
	ldx     #>(_titlePrompt)
	jsr     pushax
	ldx     #$00
	lda     #$0B
	jsr     _vram_write
;
; ppu_on_all(); // turn on screen
;
	jmp     _ppu_on_all

.endproc

; ---------------------------------------------------------------
; void __near__ GameLoop (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_GameLoop: near

.segment	"CODE"

;
; ppu_off(); 
;
	jsr     _ppu_off
;
; vram_adr(NAMETABLE_A);   // Set VRAM address to the top-left of the screen
;
	ldx     #$20
	lda     #$00
	jsr     _vram_adr
;
; vram_write(TestLevel, 1024);
;
	lda     #<(_TestLevel)
	ldx     #>(_TestLevel)
	jsr     pushax
	ldx     #$04
	lda     #$00
	jsr     _vram_write
;
; pal_bg(palette);
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; pal_spr((const char*)palette);
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_spr
;
; ppu_on_all();
;
	jmp     _ppu_on_all

.endproc

; ---------------------------------------------------------------
; void __near__ MovePlayer (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_MovePlayer: near

.segment	"CODE"

;
; if(movementPad & PAD_LEFT)
;
	lda     _movementPad
	and     #$02
	beq     L000F
;
; if (TestLevel[GetTileIndex(playerX - 1, playerY + 1)] != 0x01)
;
	lda     _playerX
	sec
	sbc     #$01
	jsr     pusha
	lda     _playerY
	clc
	adc     #$01
	jsr     _GetTileIndex
	sta     ptr1
	txa
	clc
	adc     #>(_TestLevel)
	sta     ptr1+1
	ldy     #<(_TestLevel)
	lda     (ptr1),y
	cmp     #$01
	beq     L000F
;
; playerX--;
;
	dec     _playerX
;
; if (movementPad & PAD_RIGHT)
;
L000F:	lda     _movementPad
	and     #$01
	beq     L0010
;
; if (TestLevel[GetTileIndex(playerX + 8, playerY + 1)] != 0x01)
;
	lda     _playerX
	clc
	adc     #$08
	jsr     pusha
	lda     _playerY
	clc
	adc     #$01
	jsr     _GetTileIndex
	sta     ptr1
	txa
	clc
	adc     #>(_TestLevel)
	sta     ptr1+1
	ldy     #<(_TestLevel)
	lda     (ptr1),y
	cmp     #$01
	beq     L0010
;
; playerX++;
;
	inc     _playerX
;
; if(movementPad & PAD_UP)
;
L0010:	lda     _movementPad
	and     #$08
	beq     L0011
;
; if (TestLevel[GetTileIndex(playerX, playerY)] != 0x01)
;
	lda     _playerX
	jsr     pusha
	lda     _playerY
	jsr     _GetTileIndex
	sta     ptr1
	txa
	clc
	adc     #>(_TestLevel)
	sta     ptr1+1
	ldy     #<(_TestLevel)
	lda     (ptr1),y
	cmp     #$01
	beq     L0011
;
; playerY--;
;
	dec     _playerY
;
; if (movementPad & PAD_DOWN)
;
L0011:	lda     _movementPad
	and     #$04
	beq     L000D
;
; if (TestLevel[GetTileIndex(playerX, playerY + 9)] != 0x01)
;
	lda     _playerX
	jsr     pusha
	lda     _playerY
	clc
	adc     #$09
	jsr     _GetTileIndex
	sta     ptr1
	txa
	clc
	adc     #>(_TestLevel)
	sta     ptr1+1
	ldy     #<(_TestLevel)
	lda     (ptr1),y
	cmp     #$01
	beq     L000D
;
; playerY++;
;
	inc     _playerY
;
; }
;
L000D:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ DrawPlayer (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_DrawPlayer: near

.segment	"CODE"

;
; oam_clear();
;
	jsr     _oam_clear
;
; oam_spr(playerX, playerY, 0x04, 0x00);
;
	jsr     decsp3
	lda     _playerX
	ldy     #$02
	sta     (sp),y
	lda     _playerY
	dey
	sta     (sp),y
	lda     #$04
	dey
	sta     (sp),y
	tya
	jsr     _oam_spr
;
; oam_spr(goalX, goalY, 0x05, 0x00);
;
	jsr     decsp3
	lda     _goalX
	ldy     #$02
	sta     (sp),y
	lda     _goalY
	dey
	sta     (sp),y
	lda     #$05
	dey
	sta     (sp),y
	tya
	jmp     _oam_spr

.endproc

; ---------------------------------------------------------------
; unsigned int __near__ GetTileIndex (unsigned char playerX, unsigned char playerY)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_GetTileIndex: near

.segment	"CODE"

;
; {
;
	jsr     pusha
;
; unsigned char tileX = playerX / 8; 
;
	ldy     #$01
	lda     (sp),y
	lsr     a
	lsr     a
	lsr     a
	jsr     pusha
;
; unsigned char tileY = playerY / 8;
;
	ldy     #$01
	lda     (sp),y
	lsr     a
	lsr     a
	lsr     a
	jsr     pusha
;
; unsigned int tileIndex = tileY * 32 + tileX;
;
	ldx     #$00
	lda     (sp,x)
	jsr     shlax4
	stx     tmp1
	asl     a
	rol     tmp1
	sta     ptr1
	ldy     #$01
	lda     (sp),y
	clc
	adc     ptr1
	ldx     tmp1
	bcc     L0002
	inx
L0002:	jsr     pushax
;
; return tileIndex;
;
	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
;
; }
;
	jmp     incsp6

.endproc

; ---------------------------------------------------------------
; void __near__ CheckIfEnd (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_CheckIfEnd: near

.segment	"CODE"

;
; if (abs((playerX + 4) - (goalX + 4)) < 6 && 
;
	ldx     #$00
	lda     _playerX
	clc
	adc     #$04
	bcc     L0003
	inx
L0003:	jsr     pushax
	ldx     #$00
	lda     _goalX
	clc
	adc     #$04
	bcc     L0004
	inx
L0004:	jsr     tossubax
	jsr     _abs
	cmp     #$06
	txa
	sbc     #$00
	bvc     L0005
	eor     #$80
L0005:	bpl     L000D
;
; abs((playerY + 4) - (goalY + 4)) < 6)
;
	ldx     #$00
	lda     _playerY
	clc
	adc     #$04
	bcc     L0007
	inx
L0007:	jsr     pushax
	ldx     #$00
	lda     _goalY
	clc
	adc     #$04
	bcc     L0008
	inx
L0008:	jsr     tossubax
	jsr     _abs
	cmp     #$06
	txa
	sbc     #$00
	bvc     L0009
	eor     #$80
L0009:	bmi     L000E
L000D:	rts
;
; currentGameState = END_SCREEN;
;
L000E:	lda     #$02
	sta     _currentGameState
;
; DrawEndScreen();
;
	jmp     _DrawEndScreen

.endproc

; ---------------------------------------------------------------
; void __near__ DrawEndScreen (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_DrawEndScreen: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(palette); // load the BG palette
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; oam_clear();
;
	jsr     _oam_clear
;
; playerX = 15;
;
	lda     #$0F
	sta     _playerX
;
; playerY = 223;
;
	lda     #$DF
	sta     _playerY
;
; vram_adr(NAMETABLE_A);            // Set VRAM address to start of screen
;
	ldx     #$20
	lda     #$00
	jsr     _vram_adr
;
; vram_fill(0x00, 1024);
;
	lda     #$00
	jsr     pusha
	ldx     #$04
	jsr     _vram_fill
;
; vram_adr(NTADR_A(8, 8)); // places text at screen position
;
	ldx     #$21
	lda     #$08
	jsr     _vram_adr
;
; vram_write(endScreenTitle, sizeof(endScreenTitle) - 1); //write Title to screen
;
	lda     #<(_endScreenTitle)
	ldx     #>(_endScreenTitle)
	jsr     pushax
	ldx     #$00
	lda     #$0A
	jsr     _vram_write
;
; vram_adr(NTADR_A(10, 14));
;
	ldx     #$21
	lda     #$CA
	jsr     _vram_adr
;
; vram_write(titlePrompt, sizeof(titlePrompt) - 1);
;
	lda     #<(_titlePrompt)
	ldx     #>(_titlePrompt)
	jsr     pushax
	ldx     #$00
	lda     #$0B
	jsr     _vram_write
;
; vram_adr(NTADR_A(10, 18));
;
	ldx     #$22
	lda     #$4A
	jsr     _vram_adr
;
; vram_write(endScreenPrompt, sizeof(endScreenPrompt) - 1);
;
	lda     #<(_endScreenPrompt)
	ldx     #>(_endScreenPrompt)
	jsr     pushax
	ldx     #$00
	lda     #$0D
	jsr     _vram_write
;
; ppu_on_all(); // turn on screen
;
	jmp     _ppu_on_all

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; DrawTitleScreen();
;
L000C:	jsr     _DrawTitleScreen
;
; ppu_wait_nmi();
;
L0002:	jsr     _ppu_wait_nmi
;
; movementPad = pad_poll(0);
;
	lda     #$00
	jsr     _pad_poll
	sta     _movementPad
;
; inputPad = get_pad_new(0);
;
	lda     #$00
	jsr     _get_pad_new
	sta     _inputPad
;
; switch(currentGameState)
;
	lda     _currentGameState
;
; }
;
	beq     L000D
	cmp     #$01
	beq     L0009
	cmp     #$02
	beq     L000E
	jmp     L0002
;
; if (inputPad & PAD_START)
;
L000D:	lda     _inputPad
	and     #$10
	beq     L0002
;
; currentGameState = GAME_LOOP;
;
	lda     #$01
	sta     _currentGameState
;
; GameLoop();
;
	jsr     _GameLoop
;
; break;
;
	jmp     L0002
;
; MovePlayer();
;
L0009:	jsr     _MovePlayer
;
; DrawPlayer();
;
	jsr     _DrawPlayer
;
; CheckIfEnd();
;
	jsr     _CheckIfEnd
;
; break;
;
	jmp     L0002
;
; if (inputPad & PAD_START)
;
L000E:	lda     _inputPad
	and     #$10
	beq     L0002
;
; currentGameState = START_SCREEN;
;
	lda     #$00
	sta     _currentGameState
;
; break;
;
	jmp     L000C

.endproc

