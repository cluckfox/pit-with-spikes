;
; UNROM driver for NES
; Copyright 2011-2015 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty provided
; the copyright notice and this notice are preserved in all source
; code copies.  This file is offered as-is, without any warranty.
;

; Modified by CluckFox in 2021
.export reset_unrom512
.import reset_handler, bankcall_table

.include "mmc1.inc"  ; implements a subset of the same interface

.segment "INESHDR"
  .byt "NES",$1A  ; magic signature
  .byt 32         ; size of PRG ROM in 16384 byte units
  .byt 0          ; size of CHR ROM in 8192 byte units
  .byt $e3        ; lower mapper nibble, vertical mirroring, flashable
  .byt $10        ; upper mapper nibble
  
.segment "ZEROPAGE"
lastPRGBank: .res 1
lastBankMode: .res 1
bankcallsaveA: .res 1

.segment "CODE"
.proc	reset_unrom512
	jmp	reset_handler
.endproc
;;
; Changes $8000-$BFFF to point to a 16384 byte chunk of PRG ROM
; starting at $4000 * A.
.proc setPRGBank
  sta lastPRGBank
  tay
  sta identity128,y
  rts
.endproc

; No-op
.proc setMMC1BankMode
  rts
.endproc

; Inter-bank method calling system.  There is a table of up to 85
; different methods that can be called from a different PRG bank.
; Typical usage:
;   ldx #move_character
;   jsr bankcall
.proc bankcall
  sta bankcallsaveA
  lda lastPRGBank
  pha
  lda bankcall_table+2,x
  jsr setPRGBank
  lda bankcall_table+1,x
  pha
  lda bankcall_table,x
  pha
  lda bankcallsaveA
  rts
.endproc

; Functions in the bankcall_table MUST NOT exit with 'rts'.
; Instead, they MUST exit with 'jmp bankrts'.
.proc bankrts
  sta bankcallsaveA
  pla
  jsr setPRGBank
  lda bankcallsaveA
  rts
.endproc

.segment "RODATA"
; To avoid bus conflicts, bankswitch needs to write a value
; to a ROM address that already contains that value.
; see https://wiki.nesdev.org/w/index.php?title=UNROM_512#RetroUSB_board
identity128:
  .repeat 128, I
    .byte I
  .endrepeat
