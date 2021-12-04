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

.include "macros/scene.inc"
.import setPRGBank
.export load_scene
.exportzp scene

.zeropage
scene:	.res 1

.RODATA
scenery:
.include "scenery.inc"

.CODE

; A - index of scene to load
; Clobbers X, Y, A
.proc	load_scene
ptr=$00
tmp=ptr+2
	sta	tmp
	cmp	scene
	beq	exit
	pha
	asl
	clc
	adc	z:tmp
	bcs	fault
	tax
	lda	scenery,x
	sta	z:ptr
	inx
	lda	scenery,x
	sta	z:ptr+1
	inx
	lda	scenery,x
	jsr	setPRGBank
	pla
	sta	scene
	jmp	(ptr)
exit:	rts
fault:	brk
.endproc

; vim: set syntax=asm_ca65:
