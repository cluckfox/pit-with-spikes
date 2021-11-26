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
        "./uorom2mbit.cfg",
        "-m pitwiths.map",
        "./src/unrom.s",
        "./src/init.s",
        "./src/bankcalltable.s",
        "./src/bg.s",
        "./src/chrram.s",
        "./src/main.s",
        "./src/pads.s",
        "./src/player.s",
        "./src/ppuclear.s"
        ]

def cl65(*args):
    allargs = ['cl65'] + default_args
    result = subprocess.run(allargs, check=True)
    pprint.pprint(result)

def build():
    cl65(*default_args)

if __name__ == "__main__":
    build()
