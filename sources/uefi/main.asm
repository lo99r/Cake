BITS 64
default rel
global main

section .data
guid:
dd 0x964e5b21
dw 0x6459, 0x11d2
dq 0x3b7269c9a000398e

HandleBuffer: dq 0
HandleCount: dq 0
BufferOfSector: times 512 db 0
BlockIO: dq 0
Maple: times 4096 db 0

section .text
read_sector:
    ;-

main:
    ;-
