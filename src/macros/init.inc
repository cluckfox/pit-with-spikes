; MIT License
;
; Copyright © 2021 CluckFox
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
.ifndef MACROS_INIT_INC
.define MACROS_INIT_INC

; Clobbers A
.macro	NMIOFF
	lda	#0
	sta	PPUCTRL
	bit	PPUSTATUS
.endmacro

; Clobbers A
.macro	NMION
	lda	#VBLANK_NMI
	sta	PPUCTRL
	bit	PPUSTATUS
.endmacro

; Clobbers A
.macro IRQOFF
	sei
	lda	#%01000000
	sta	APUSEQ
	lda	#0
	sta	SNDCHN
	sta	DMC10
	bit	SNDCHN
.endmacro

; Clobbers A
.macro	IRQON
	lda	#0
	sta	APUSEQ
	cli
.endmacro

; clobbers flags NVZ
.macro	PPUSTALL
.scope 
stall:	bit	PPUSTATUS
	bpl	stall
.endscope
.endmacro

; clobbers everything including SP and WRAM ($0000 - $07FF)
.macro	ZWRAM
	ZPAGE	$0000
	ZPAGE	$0100
	ldx	#$ff
	txs
	ZPAGE	$0200
	ZPAGE	$0300
	ZPAGE	$0400
	ZPAGE	$0500
	ZPAGE	$0600
	ZPAGE	$0700
.endmacro

; Clobbers A, X, and 256 bytes of addr
.macro ZPAGE	addr
.scope 
	lda	#0
	ldx	#0
loop:	sta	addr,x
	inx
	bne	loop
.endscope
.endmacro



.endif
; vim: set syntax=asm_ca65:
