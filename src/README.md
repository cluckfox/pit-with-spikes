Program Modules
===============

* `vectors.s` - reset, nmi, irq vectors
* `unrom512.s` - reset handler and bank-switching
* `init.s` - crash and startup entry points
* `nmi.s` - NMI handler
* `irq.s` - IRQ handler; service routines for brk, APU IRQ
* `famistudio_shim.s` - includes FamiStudio driver source
* `fault.s` - main loop to display brk bank and location
* `main.s` - main loop for snrom-template demo
* `ldvram.s` - pseudo-DMA routine for loading CHR-RAM
