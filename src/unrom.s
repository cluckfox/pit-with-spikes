;
; UNROM driver for NES
; Copyright 2011-2015 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty provided
; the copyright notice and this notice are preserved in all source
; code copies.  This file is offered as-is, without any warranty.
;

.include "mmc1.inc"  ; implements a subset of the same interface
.import nmi_handler, reset_handler, irq_handler, bankcall_table

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

; UNROM512 configuration has a static bank at $c000 so this stub
; simply guarantees that bank $00 is loaded at $8000 on startup
.macro resetstub_in segname
.segment segname
.scope
resetstub_entry:
  lda filler
  sta filler
  jmp reset_handler
  filler: .byt $00
  .addr nmi_handler, resetstub_entry, irq_handler
.endscope
.endmacro

.segment "CODE"
resetstub_in "STUB31"

.segment "CODE"
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
