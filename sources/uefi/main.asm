BITS 64
default rel
global main

section .data
BlockIoProtocolGuid:
dd 0x964e5b21
dw 0x6459, 0x11d2
dq 0x3b7269c9a000398e
LoadedImageProtocolGuid:
dd 0x5B1B31A1, 0x11D29562
dq 0x3B7269C9A0003F8E

HandleBuffer: dq 0
HandleCount: dq 0
BufferOfSector: times 512 db 0
BlockIO: dq 0
Maple: times 4096 db 0
LoadedImage: dq 0
;BlockIo: dq 0
Media: dq 0
BlockSize: dd 0
LastBlock: dq 0
MediaId: dd 0
Removable: db 0

section .text
find_root: ;void find_root(EFI_HANDLE *ImageHandle(rcx), EFI_SYSTEM_TABLE *SystemTable(rdx), void *Buffer(r8));
    sub rsp, 0x28
    mov rax, [rdx+0x98]
    push rcx
    push rdx
    push r8
    ;push r9
    lea rdx, [LoadedImageProtocolGuid]
    lea r8, [LoadedImage]
    call rax
    mov rbx, [LoadedImage]
    add rbx, 0x18
    mov rcx, rbx
    mov rsi, [rsp+8]
    mov r8, [BlockIO]
    mov rax, [rsi+0x98]
    call rax
    mov r12, [BlockIO]
    add r12, 0x8
    mov r13, [r12]
    add r13, 9
    mov [BlockSize], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    add r13, 18
    mov [LastBlock], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    mov [MediaId], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    add r13, 5
    mov [Removable], r13



read_sector:
    ;-

main:
    ;-
ㅌㅌㅌ
