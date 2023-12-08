;=======================================================================;
;									;
;             	*****    CONFIGURAÇÃO DO ASSEMBLER	*****		;
;									;
;=======================================================================;


; MAPEAMENTO DE MEMÓRIA
;----------------------

.LOROM
.FASTROM
.DEFINE BANKSIZE $8000
.DEFINE BANK_COUNT 48
.DEFINE ADDR $8000
.DEFINE SIZE $0b
.DEFINE NMI $0000

.MEMORYMAP
 SLOTSIZE BANKSIZE
 DEFAULTSLOT 0
 SLOT 0 ADDR
.ENDME

.ROMBANKSIZE BANKSIZE
.ROMBANKS BANK_COUNT

.BANK 0 SLOT 0
.ORG $0000
reset:


; MAPEAMENTO DA ROM
;------------------

.BACKGROUND	"rom/dls.sfc"
.UNBACKGROUND	$007B23	$007FBF
.UNBACKGROUND	$00FD10	$00FFFF
.UNBACKGROUND	$012381	$012498	; antigo local nomes jogadores
.UNBACKGROUND	$017DD0	$017FFF
.UNBACKGROUND	$01FB00	$01FFFF
.UNBACKGROUND	$027C90	$027FFF
.UNBACKGROUND	$02F780	$02FFFF
.UNBACKGROUND	$03FB60	$03FFFF
.UNBACKGROUND	$0465A0	$046FFF
.UNBACKGROUND	$047B60	$047FFF
.UNBACKGROUND	$047B60	$047FFF
.UNBACKGROUND	$04FFD0	$04FFFF
.UNBACKGROUND	$06FDE0	$06FEFF
.UNBACKGROUND	$06FFE0	$06FFFF
.UNBACKGROUND	$07E190	$07FFFF
.UNBACKGROUND	$088000	$089BFF	; fonte
.UNBACKGROUND	$09FFE4	$09FFFF
.UNBACKGROUND	$0AFBC4	$0AFFFF
.UNBACKGROUND	$0BFFDC	$0BFFFF
.UNBACKGROUND	$0D7890	$0D7FFF
.UNBACKGROUND	$0DFE50	$0DFFFF
.UNBACKGROUND	$157FC0	$157FFF
.UNBACKGROUND	$15FFF0	$15FFFF
.UNBACKGROUND	$167FE0	$167FFF
.EMPTYFILL	$00

;=======================================================================;
;									;
;      			*****     BIO TIMES   	*****			;
;									;
;=======================================================================;

.BANK 27

.DEFINE retrato_pos	= $0041		; pos retrato dos times
.DEFINE jnl1_pos_y	= $0010		; pos inicio janela 01
.DEFINE jnl1_pos_x	= $F868		; fim/começo janela 01 horz
.DEFINE jnl1_tam	= $0048		; tamanho janela 01
.DEFINE	jnl_spc		= $0018		; espaço entre janelas
.DEFINE jnl2_pos_x	= $F808		; fim/começo janela 02 horz
.DEFINE jnl2_tam	= $004F		; tamanho janela 02
.DEFINE jnl1_txt_pos	= $088E		; pos texto 01
.DEFINE jnl2_txt_pos	= $09A2		; pos texto 01

.ORG $7857

bios_prop:
.DW 	retrato_pos

.ORG $7902
.DW	jnl1_txt_pos

.ORG $794A
.DW	jnl2_txt_pos

.ORG $78A2
jsr	hdma_over

.SECTION "HDMA_OVER"	SEMIFREE
hdma_over:
	phx
	sep	#$20
	lda.b	#$7f
	pha
	plb
	ldx.w	#jnl1_pos_y*2
	ldy.w	#$0000
	rep	#$20
	lda.w	#$0001
	jsr	hdma_vazio

	lda.w	#jnl1_pos_x+$0001-$0100
	jsr	hdma_borda

	ldx.w	#jnl1_tam
-:	lda.w	#jnl1_pos_x
	sta	$0cc0,y
	iny
	iny
	lda.w	#$8180
	sta	$0CC0,y
	iny
	iny
	dex
	bne	-

	lda.w	#jnl1_pos_x+$0001-$0100
	jsr	hdma_borda

	ldx.w	#jnl_spc
	lda.w	#$0001
	jsr	hdma_vazio

	lda.w	#jnl2_pos_x+$0001-$0100
	jsr	hdma_borda

	ldx.w	#jnl2_tam
-:	lda.w	#jnl2_pos_x
	sta	$0cc0,y
	iny
	iny
	lda.w	#$8180
	sta	$0CC0,y
	iny
	iny
	dex
	bne	-

	lda.w	#jnl2_pos_x+$0001-$0100
	jsr	hdma_borda

-:	lda.w	#$0001
	sta.w	$0CC0,y
	iny
	iny
	tya
	cmp	#$02DF
	bcc	-

	sep	#$20
	lda.b	#$7e
	pha
	plb
	rep	#$20
	lda	#$0003
	clc
	plx
	rts

hdma_vazio:
-:	sta	$0cc0,y
	iny
	iny
	dex
	bne	-
	rts

hdma_borda:
	sta	$0CC0,y
	iny
	iny
	lda.w	#$8180
	sta	$0CC0,y
	iny
	iny
	rts
.ENDS

;=======================================================================;
;									;
;      			*****     ARQUIVOS   	*****			;
;									;
;=======================================================================;

.BANK 17

.ORG	$0000
.SECTION "F_FONTE"	FORCE
	gfx_fonte:
		.INCBIN	"gfx/fonte_00_br.2bpp"	FSIZE s_fonte
.ENDS
