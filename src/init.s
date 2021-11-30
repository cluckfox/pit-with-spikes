;
; Simple sprite demo for NES
; Copyright 2011 Damian Yerrick
;
; Copying and distribution of this file, with or without
; modification, are permitted in any medium without royalty provided
; the copyright notice and this notice are preserved in all source
; code copies.  This file is offered as-is, without any warranty.
;

; Modified by Cluckfox in 2021

.include "nes.inc"
.include "mmc1.inc"
.include "global.inc"
.include "macros/init.inc"

.import nmi_stall, famistudio_shim_reset

.segment "CODE"
.proc	reset_handler
  ; The very first thing to do when powering on is to put all sources
  ; of interrupts into a known state.
	IRQOFF
	NMIOFF
	PPUSTALL
  ; We have about 29700 cycles to burn until the second frame's
  ; vblank.  Use this time to get most of the rest of the chipset
  ; into a known state.
  ; Most versions of the 6502 support a mode where ADC and SBC work
  ; with binary-coded decimal.  Some 6502-based platforms, such as
  ; Atari 2600, use this for scorekeeping.  The second-source 6502 in
  ; the NES ignores the mode setting because its decimal circuit is
  ; dummied out to save on patent royalties, and games either use
  ; software BCD routines or convert numbers to decimal every time
  ; they are displayed.  But some post-patent famiclones have a
  ; working decimal mode, so turn it off for best compatibility.
  	cld
	ZWRAM
	jsr	famistudio_shim_reset
	PPUSTALL
	lda	#>OAM
	sta	OAM_DMA
  ; There are two ways to wait for vertical blanking: spinning on
  ; bit 7 of PPUSTATUS (as seen above) and waiting for the NMI
  ; handler to run.  Before the PPU has stabilized, you want to use
  ; the PPUSTATUS method because NMI might not be reliable.  But
  ; afterward, you want to use the NMI method because if you read
  ; PPUSTATUS at the exact moment that the bit turns on, it'll flip
  ; from off to on to off faster than the CPU can see.

	lda 	#4
	jsr 	setPRGBank
	IRQON
	NMION
	jsr	nmi_stall
	jmp 	main	; main starts in vblank
.endproc

; vim: set syntax=asm_ca65:
