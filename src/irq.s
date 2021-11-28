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

.include "mmc1.inc"
.include "fault_frame.inc"


.export irq_handler
.import fault_main, setPRGBank
.importzp fault_frame, lastPRGBank

.CODE
.proc	irq_handler
	bit	fault_frame
	bpl	exit
	jmp	service_brk
exit:	rti
.endproc ; irq_handler

.proc	service_brk
	pla
	lda	lastPRGBank
	sta	fault_frame+FAULTFR::fbank
	pla
	sta	fault_frame+FAULTFR::faddr
	pla
	sta	fault_frame+FAULTFR::faddr+1
	lda	#>crash_init
	pha
	lda	#<crash_init
	pha
	lda	#0
	pha
	rti
.endproc ; service_brk


.proc	crash_init
	lda	#0
	jsr	setPRGBank
	jmp	fault_main
.endproc
; vim: set syntax=asm_ca65:
