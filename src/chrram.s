;
; Trivial CHR RAM loader for NES
; Copyright 2011 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty provided
; the copyright notice and this notice are preserved in all source
; code copies.  This file is offered as-is, without any warranty.
;
.include "ldvram.inc"
.include "nes.inc"
.include "mmc1.inc"
.export load_chr_ram_far

.segment "BANK13"
template_chr:
  .incbin "obj/nes/bggfx.chr"
  .incbin "obj/nes/spritegfx.chr"

;;
; Loads 8192 bytes of uncompressed data into CHR RAM.
.proc load_chr_ram_far
	LDVRAM	template_chr, 8192, $0000
	jmp	bankrts
.endproc


