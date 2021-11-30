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
.ifndef FAULT_IMPL_INC
.define FAULT_IMPL_INC
.scope FAULT_IMPL
.proc	load_graphics
	LDVRAM	fault_pal, 32, $3f00	
	LDVRAM	fault_chr, 8192, $0000
	LDVRAM	fault_nt, 1024, $2000
	rts
.endproc

.proc 	enable_nmi
	lda	#VBLANK_NMI
	sta	PPUCTRL
	bit	PPUSTATUS
	rts
.endproc

.proc	quick_reset
.import	famistudio_music_stop
	sei
	jsr	famistudio_music_stop
	lda	#0
	bit	PPUSTATUS
	sta	PPUCTRL
	bit	PPUSTATUS
	sta	PPUMASK
	sta	SNDCHN
	sta	$4010
	lda	#$40
	sta	$4017
	lda 	#0
	tax
@loop:	sta	OAM,x
	inx
	bne	@loop
	rts
.endproc

.proc draw_sprites
	rts
.endproc

.endscope ; FAULT_IMPL

.endif
; vim: set syntax=asm_ca65:
