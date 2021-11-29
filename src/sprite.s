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

.include "nes.inc"
.include "global.inc"
.include "ppusprite.inc"
.exportzp spr_args
.export draw_ppu_sprite

.ZEROPAGE
spr_args:	.tag PPUSprite

.CODE
; clobbers A
.proc draw_ppu_sprite
.importzp oam_used
	txa
	pha
	ldx	oam_used
	lda	spr_args+PPUSprite::ypos
	sta	OAM,x
	inx

	lda	spr_args+PPUSprite::tile
	sta	OAM,x
	inx

	lda	spr_args+PPUSprite::attr
	sta	OAM,x
	inx

	lda	spr_args+PPUSprite::xpos
	sta	OAM,x
	inx
	stx	oam_used
exit:	pla
	tax
	rts
.endproc
; vim: set syntax=asm_ca65:
