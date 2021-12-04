"""
Simple build script for pit-with-spikes

Usage: py buildrom.py

Requires cl65 executable to be on the current path

"""
import pprint
import subprocess

default_args = [
        "-o",
        "pitwiths.nes",
        "-t",
        "nes",
        "-C",
        "./unrom512.cfg",
        "-m",
        "pitwiths.map",
        "./src/vectors.s",
        "./src/unrom512.s",
        "./src/init.s",
        "./src/bankcalltable.s",
        "./src/bg.s",
        "./src/chrram.s",
        "./src/main.s",
        "./src/pads.s",
        "./src/player.s",
        "./src/ppuclear.s",
        "./src/ldvram.s",
        "./src/fault.s",
        "./src/sprite.s",
        "./src/irq.s",
        "./src/famistudio_shim.s",
        "./src/nmi.s",
        "./src/scene.s"
        ]

def cl65(*args):
    allargs = ['cl65'] + list(args)
    result = subprocess.run(allargs, check=True)
    pprint.pprint(result)

def build():
    cl65(*default_args)

if __name__ == "__main__":
    build()
