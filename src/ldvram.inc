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
.ifndef LDVRAM_INC
.define LDVRAM_INC

.include "ldvram_args.inc"

; clobbers everything
.macro LDVRAM	src, src_size, dest
.scope 
.importzp load_vram_args
.import load_vram
STARTADDR=src
ENDADDR=src+src_size
	ldx	#<STARTADDR
	ldy	#>STARTADDR
	stx	load_vram_args+LDVA::startaddr
	sty	load_vram_args+LDVA::startaddr+1
	ldx	#<ENDADDR
	ldy	#>ENDADDR
	stx	load_vram_args+LDVA::endaddr
	sty	load_vram_args+LDVA::endaddr+1
	ldx	#>dest
	ldy	#<dest
	bit	PPUSTATUS
	stx	PPUADDR
	sty	PPUADDR
	jsr	load_vram
.endscope
.endmacro

.endif
; vim: set syntax=asm_ca65:
