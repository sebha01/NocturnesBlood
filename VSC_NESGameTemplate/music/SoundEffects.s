; This file is for the FamiTone2 library and was generated by FamiStudio

sounds:
	.word @ntsc
	.word @ntsc
@ntsc:
	.word @sfx_ntsc_dash
	.word @sfx_ntsc_dying
	.word @sfx_ntsc_jump
	.word @sfx_ntsc_levelclear

@sfx_ntsc_dash:
	.byte $8a,$0f,$89,$3f,$08,$8a,$0e,$08,$00
@sfx_ntsc_dying:
	.byte $81,$89,$82,$03,$80,$3f,$89,$f0,$04,$81,$34,$82,$04,$04,$81,$b8
	.byte $04,$81,$4c,$82,$05,$04,$81,$4d,$82,$06,$04,$81,$7f,$82,$07,$04
	.byte $81,$ff,$14,$00
@sfx_ntsc_jump:
	.byte $8a,$00,$89,$3f,$08,$00
@sfx_ntsc_levelclear:
	.byte $81,$c4,$82,$01,$80,$3f,$89,$f0,$04,$81,$52,$04,$81,$0c,$04,$81
	.byte $e1,$82,$00,$04,$81,$bd,$04,$81,$9f,$04,$81,$7e,$04,$81,$70,$04
	.byte $81,$4f,$04,$81,$31,$04,$00

.export sounds
