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

.ifndef GLOBAL_INC
.define GLOBAL_INC

; init.s
.global reset_handler

; main.s
.global OAM
.global main, nmi_handler, irq_handler
.globalzp cur_keys, new_keys, oam_used, nmis

; bg.s
.global draw_bg

; player.s
.global init_player, move_player

; pads.s
.global read_pads

; ppuclear.s
.global ppu_clear_nt, ppu_clear_oam, ppu_screen_on

; bankcall ids
.globalzp draw_player_sprite, load_chr_ram

.endif
; vim: set syntax=asm_ca65:
