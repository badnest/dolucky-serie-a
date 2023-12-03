;=======================================================================;
;									;
;             	*****    CONFIGURAÇÃO DO ASSEMBLER	*****		;
;									;
;=======================================================================;


; CABEÇALHO
;----------


; MAPEAMENTO DE MEMÓRIA
;----------------------

.LOROM
.DEFINE BANKSIZE $8000
.DEFINE BANK_COUNT 48
.DEFINE ADDR $8000
.DEFINE SIZE $0b
.DEFINE NMI $0000

; wla internals ----------------------------------------------------------------

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
.UNBACKGROUND	$7B23	$7FBF
.UNBACKGROUND	$FD10	$FFFF
.UNBACKGROUND	$17C50	$17FFF
.UNBACKGROUND	$1FB00	$1FFFF
.EMPTYFILL	$00

;=======================================================================;
;									;
;      			*****     ARQUIVOS   	*****			;
;									;
;=======================================================================;

.BANK 17

.ORG	$0000
.SECTION "F_FONTE"	OVERWRITE
	gfx_fonte:
		.INCBIN	"gfx/fonte_00_br.2bpp"	FSIZE s_fonte
.ENDS
