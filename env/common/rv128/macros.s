# See LICENSE for license details.

.equ REGBYTES, 16

.macro lx a, b
lq \a, \b
.endm

.macro sx a, b
sq \a, \b
.endm

.macro lxsp a, b
lq \a, ((\b)*REGBYTES)(sp)
.endm

.macro sxsp a, b
sq \a, ((\b)*REGBYTES)(sp)
.endm

.macro .ptr a
.octa \a
.endm
