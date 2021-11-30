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

.export famistudio_shim_reset

.include "macros/regs.inc"

.define FAMISTUDIO_CA65_ZP_SEGMENT ZEROPAGE
.define FAMISTUDIO_CA65_RAM_SEGMENT BSS
.define FAMISTUDIO_CA65_CODE_SEGMENT CODE
FAMISTUDIO_CFG_EXTERNAL = 1
; FAMISTUDIO_CFG_PAL_SUPPORT   = 1
FAMISTUDIO_CFG_NTSC_SUPPORT  = 1
FAMISTUDIO_CFG_DPCM_SUPPORT  = 1
FAMISTUDIO_CFG_SFX_SUPPORT   = 1 
FAMISTUDIO_CFG_SFX_STREAMS   = 2
; FAMISTUDIO_CFG_SMOOTH_VIBRATO = 1 
FAMISTUDIO_CFG_THREAD         = 1 
; FAMISTUDIO_USE_FAMITRACKER_TEMPO = 1
; FAMISTUDIO_USE_FAMITRACKER_DELAYED_NOTES_OR_CUTS = 1
FAMISTUDIO_USE_VOLUME_TRACK      = 1
FAMISTUDIO_USE_VOLUME_SLIDES     = 1
FAMISTUDIO_USE_PITCH_TRACK       = 1
FAMISTUDIO_USE_SLIDE_NOTES       = 1
FAMISTUDIO_USE_NOISE_SLIDE_NOTES = 1
FAMISTUDIO_USE_VIBRATO           = 1
FAMISTUDIO_USE_ARPEGGIO          = 1
FAMISTUDIO_CFG_C_BINDINGS        = 0

.include "../vendor/FamiStudio/SoundEngine/famistudio_ca65.s"

.CODE
.proc	famistudio_shim_reset
	PHREGS
	ldx	#<music_data_tutorial
	ldy	#>music_data_tutorial
	lda	#1
	jsr	famistudio_init
	ldx	#<sounds
	ldy	#>sounds
	jsr	famistudio_sfx_init
	PLREGS
	rts	
.endproc

.segment "RODATA"
.include "audio/tutorial.s"
.include "../vendor/FamiStudio/SoundEngine/DemoSource/sfx_ca65.s"

.segment "DMC"
.incbin "audio/tutorial.dmc"
; vim: set syntax=asm_ca65:
