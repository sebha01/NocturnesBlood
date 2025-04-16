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
	.export		_spritePalette
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
	.export		_velocityY
	.export		_isJumping
	.export		_isDashing
	.export		_dashTimer
	.export		_dashCooldown
	.export		_hasDashedInAir
	.export		_dashDirection
	.export		_i
	.export		_DrawTitleScreen
	.export		_GameLoop
	.export		_MovePlayer
	.export		_DrawPlayer
	.export		_GetTileIndex
	.export		_CheckIfEnd
	.export		_DrawEndScreen
	.export		_OnGround
	.export		_checkIfCollidableTile
	.export		_main

.segment	"DATA"

_currentGameState:
	.byte	$00
_playerX:
	.byte	$1e
_playerY:
	.byte	$d7
_goalX:
	.byte	$dc
_goalY:
	.byte	$27
_velocityY:
	.word	$0000
_isJumping:
	.byte	$00
_isDashing:
	.byte	$00
_dashTimer:
	.byte	$00
_dashCooldown:
	.byte	$00
_hasDashedInAir:
	.byte	$00
_dashDirection:
	.byte	$00
_i:
	.word	$0000

.segment	"RODATA"

_TestLevel:
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
	.byte	$01
	.byte	$01
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
	.byte	$01
	.byte	$01
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
	.byte	$01
	.byte	$01
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
	.byte	$01
	.byte	$01
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$01
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$83
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
	.byte	$82
	.byte	$83
	.byte	$92
	.byte	$93
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
	.byte	$92
	.byte	$93
	.byte	$82
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$81
	.byte	$80
	.byte	$83
	.byte	$92
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$91
	.byte	$90
	.byte	$93
	.byte	$80
	.byte	$a0
	.byte	$a0
	.byte	$a0
	.byte	$a0
	.byte	$a0
	.byte	$a0
	.byte	$20
	.byte	$88
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$5a
	.byte	$12
	.byte	$88
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$5a
	.byte	$5a
	.byte	$aa
	.byte	$22
	.byte	$88
	.byte	$5a
	.byte	$5a
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$22
	.byte	$88
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$5a
	.byte	$5a
	.byte	$22
	.byte	$88
	.byte	$aa
	.byte	$6a
	.byte	$5a
	.byte	$9a
	.byte	$aa
	.byte	$aa
	.byte	$22
	.byte	$88
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$aa
	.byte	$22
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
	.byte	$0f
	.byte	$01
	.byte	$11
	.byte	$31
	.byte	$0f
	.byte	$05
	.byte	$16
	.byte	$27
	.byte	$0f
	.byte	$09
	.byte	$19
	.byte	$29
_spritePalette:
	.byte	$0f
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$0f
	.byte	$01
	.byte	$11
	.byte	$21
	.byte	$0f
	.byte	$05
	.byte	$16
	.byte	$36
	.byte	$0f
	.byte	$09
	.byte	$19
	.byte	$39
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
; pal_spr((const char*)spritePalette);
;
	lda     #<(_spritePalette)
	ldx     #>(_spritePalette)
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
; if (movementPad & PAD_LEFT)
;
	lda     _movementPad
	and     #$02
	beq     L0045
;
; if (!checkIfCollidableTile(TestLevel[GetTileIndex(playerX - 1, playerY + 1)]))
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
	jsr     _checkIfCollidableTile
	tax
	bne     L0045
;
; playerX--;
;
	dec     _playerX
;
; if (movementPad & PAD_RIGHT)
;
L0045:	lda     _movementPad
	and     #$01
	beq     L0046
;
; if (!checkIfCollidableTile(TestLevel[GetTileIndex(playerX + 8, playerY + 1)]))
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
	jsr     _checkIfCollidableTile
	tax
	bne     L0046
;
; playerX++;
;
	inc     _playerX
;
; if ((inputPad & PAD_B) && !isDashing && dashCooldown == 0) 
;
L0046:	lda     _inputPad
	and     #$40
	beq     L001B
	lda     _isDashing
	bne     L001B
	lda     _dashCooldown
	bne     L001B
;
; if (OnGround() || !hasDashedInAir)
;
	jsr     _OnGround
	tax
	bne     L004A
	lda     _hasDashedInAir
	bne     L001B
;
; if (movementPad & PAD_LEFT) 
;
L004A:	lda     _movementPad
	and     #$02
	beq     L004B
;
; isDashing = 1;
;
	lda     #$01
	sta     _isDashing
;
; dashDirection = -1;
;
	lda     #$FF
;
; else if (movementPad & PAD_RIGHT) 
;
	jmp     L0059
L004B:	lda     _movementPad
	and     #$01
	beq     L001B
;
; isDashing = 1;
;
	lda     #$01
	sta     _isDashing
;
; dashDirection = 1;
;
L0059:	sta     _dashDirection
;
; dashTimer = DASH_DURATION;
;
	lda     #$0A
	sta     _dashTimer
;
; if (!OnGround())
;
	jsr     _OnGround
	tax
	bne     L001B
;
; hasDashedInAir = 1;
;
	lda     #$01
	sta     _hasDashedInAir
;
; if (isDashing) 
;
L001B:	lda     _isDashing
	jeq     L001C
;
; for (i = 0; i < DASH_SPEED; i++) 
;
	lda     #$00
	sta     _i
	sta     _i+1
L001D:	lda     _i
	cmp     #$04
	lda     _i+1
	sbc     #$00
	bvc     L0021
	eor     #$80
L0021:	bpl     L004D
;
; int nextX = playerX + dashDirection;
;
	ldx     #$00
	lda     _playerX
	bpl     L0023
	dex
L0023:	clc
	adc     _dashDirection
	bcc     L0043
	inx
L0043:	jsr     pushax
;
; int checkX = nextX + (dashDirection == 1 ? 7 : 0);
;
	ldx     #$00
	lda     _dashDirection
	cmp     #$01
	bne     L004C
	lda     #$07
	jmp     L0025
L004C:	txa
L0025:	clc
	ldy     #$00
	adc     (sp),y
	pha
	txa
	iny
	adc     (sp),y
	tax
	pla
	jsr     pushax
;
; if (!checkIfCollidableTile(TestLevel[GetTileIndex(checkX, playerY + 1)])) 
;
	ldy     #$00
	lda     (sp),y
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
	jsr     _checkIfCollidableTile
	tax
	bne     L0026
;
; playerX = nextX;
;
	ldy     #$02
	lda     (sp),y
	sta     _playerX
;
; else 
;
	jmp     L002A
;
; isDashing = 0;
;
L0026:	lda     #$00
	sta     _isDashing
;
; dashCooldown = DASH_COOLDOWN;
;
	lda     #$14
	sta     _dashCooldown
;
; }
;
L002A:	jsr     incsp4
;
; for (i = 0; i < DASH_SPEED; i++) 
;
	inc     _i
	bne     L001D
	inc     _i+1
	jmp     L001D
;
; dashTimer--;
;
L004D:	dec     _dashTimer
;
; if (dashTimer <= 0) 
;
	lda     _dashTimer
	jne     L0052
;
; isDashing = 0;
;
	sta     _isDashing
;
; dashCooldown = dashCooldown;
;
	lda     _dashCooldown
	sta     _dashCooldown
;
; else 
;
	jmp     L0052
;
; if ((inputPad & PAD_A) && !isJumping && OnGround()) 
;
L001C:	lda     _inputPad
	and     #$80
	beq     L002D
	lda     _isJumping
	bne     L002D
	jsr     _OnGround
	tax
	beq     L002D
;
; isJumping = 1;
;
	lda     #$01
	sta     _isJumping
;
; velocityY = JUMP_VELOCITY;
;
	ldx     #$FF
	lda     #$F6
	sta     _velocityY
	stx     _velocityY+1
;
; if (isJumping) 
;
L002D:	lda     _isJumping
	beq     L0031
;
; velocityY += GRAVITY;
;
	inc     _velocityY
	bne     L0032
	inc     _velocityY+1
;
; if (velocityY > MAX_FALL_SPEED)
;
L0032:	lda     _velocityY
	cmp     #$05
	lda     _velocityY+1
	sbc     #$00
	bvs     L0034
	eor     #$80
L0034:	bpl     L0033
;
; velocityY = MAX_FALL_SPEED;
;
	ldx     #$00
	lda     #$04
	sta     _velocityY
	stx     _velocityY+1
;
; playerY += velocityY;
;
L0033:	lda     _velocityY
	cmp     #$80
	clc
	adc     _playerY
	sta     _playerY
;
; if (velocityY >= 0 && OnGround()) 
;
	ldx     _velocityY+1
	bmi     L0052
	jsr     _OnGround
	tax
	bne     L003E
	jmp     L0052
;
; playerY -= 1;
;
L003B:	dec     _playerY
;
; while (OnGround()) 
;
L003E:	jsr     _OnGround
	tax
	bne     L003B
;
; playerY += 1;
;
	inc     _playerY
;
; velocityY = 0;
;
	sta     _velocityY
	sta     _velocityY+1
;
; isJumping = 0;
;
	sta     _isJumping
;
; hasDashedInAir = 0;
;
	sta     _hasDashedInAir
;
; else 
;
	jmp     L0052
;
; if (!OnGround()) 
;
L0031:	jsr     _OnGround
	tax
	bne     L0052
;
; isJumping = 1;
;
	lda     #$01
	sta     _isJumping
;
; if (dashCooldown > 0) 
;
L0052:	lda     _dashCooldown
	beq     L0042
;
; dashCooldown--;
;
	dec     _dashCooldown
;
; }
;
L0042:	rts

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
; oam_spr(playerX, playerY - 8, 0x08, 0x01);
;
	jsr     decsp3
	lda     _playerX
	ldy     #$02
	sta     (sp),y
	lda     _playerY
	sec
	sbc     #$08
	dey
	sta     (sp),y
	lda     #$08
	dey
	sta     (sp),y
	lda     #$01
	jsr     _oam_spr
;
; oam_spr(playerX, playerY, 0x18, 0x01);
;
	jsr     decsp3
	lda     _playerX
	ldy     #$02
	sta     (sp),y
	lda     _playerY
	dey
	sta     (sp),y
	lda     #$18
	dey
	sta     (sp),y
	lda     #$01
	jsr     _oam_spr
;
; oam_spr(goalX, goalY, 0x16, 0x02);
;
	jsr     decsp3
	lda     _goalX
	ldy     #$02
	sta     (sp),y
	lda     _goalY
	dey
	sta     (sp),y
	lda     #$16
	dey
	sta     (sp),y
	lda     #$02
	jsr     _oam_spr
;
; oam_spr(goalX + 8, goalY, 0x17, 0x02);
;
	jsr     decsp3
	lda     _goalX
	clc
	adc     #$08
	ldy     #$02
	sta     (sp),y
	lda     _goalY
	dey
	sta     (sp),y
	lda     #$17
	dey
	sta     (sp),y
	lda     #$02
	jsr     _oam_spr
;
; oam_spr(goalX, goalY - 8, 0x06, 0x02);
;
	jsr     decsp3
	lda     _goalX
	ldy     #$02
	sta     (sp),y
	lda     _goalY
	sec
	sbc     #$08
	dey
	sta     (sp),y
	lda     #$06
	dey
	sta     (sp),y
	lda     #$02
	jsr     _oam_spr
;
; oam_spr(goalX + 8, goalY - 8, 0x07, 0x02);
;
	jsr     decsp3
	lda     _goalX
	clc
	adc     #$08
	ldy     #$02
	sta     (sp),y
	lda     _goalY
	sec
	sbc     #$08
	dey
	sta     (sp),y
	lda     #$07
	dey
	sta     (sp),y
	lda     #$02
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
	bpl     L0003
	dex
L0003:	clc
	adc     #$04
	bcc     L0004
	inx
L0004:	jsr     pushax
	ldx     #$00
	lda     _goalX
	bpl     L0005
	dex
L0005:	clc
	adc     #$04
	bcc     L0006
	inx
L0006:	jsr     tossubax
	jsr     _abs
	cmp     #$06
	txa
	sbc     #$00
	bvc     L0007
	eor     #$80
L0007:	bpl     L0011
;
; abs((playerY + 4) - (goalY + 4)) < 6)
;
	ldx     #$00
	lda     _playerY
	bpl     L0009
	dex
L0009:	clc
	adc     #$04
	bcc     L000A
	inx
L000A:	jsr     pushax
	ldx     #$00
	lda     _goalY
	bpl     L000B
	dex
L000B:	clc
	adc     #$04
	bcc     L000C
	inx
L000C:	jsr     tossubax
	jsr     _abs
	cmp     #$06
	txa
	sbc     #$00
	bvc     L000D
	eor     #$80
L000D:	bmi     L0012
L0011:	rts
;
; currentGameState = END_SCREEN;
;
L0012:	lda     #$02
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
; playerX = 30;
;
	lda     #$1E
	sta     _playerX
;
; playerY = 215;
;
	lda     #$D7
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
; char __near__ OnGround (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_OnGround: near

.segment	"CODE"

;
; return checkIfCollidableTile(TestLevel[GetTileIndex(playerX, playerY + 9)]);
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
	jmp     _checkIfCollidableTile

.endproc

; ---------------------------------------------------------------
; char __near__ checkIfCollidableTile (unsigned char tile)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_checkIfCollidableTile: near

.segment	"CODE"

;
; {
;
	jsr     pusha
;
; return tile == 0x80 || tile == 0x81 || tile == 0x82 || tile == 0x83 
;
	ldy     #$00
	lda     (sp),y
	cmp     #$80
	beq     L0004
	cmp     #$81
	beq     L0004
	cmp     #$82
	beq     L0004
;
; || tile == 0x90 || tile == 0x91 || tile == 0x92 || tile == 0x93;
;
	cmp     #$83
	beq     L0004
	cmp     #$90
	beq     L0004
	cmp     #$91
	beq     L0004
	cmp     #$92
	beq     L0004
	cmp     #$93
	beq     L0004
	ldx     #$00
	txa
	jmp     incsp1
L0004:	lda     #$01
	ldx     #$00
;
; }
;
	jmp     incsp1

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

