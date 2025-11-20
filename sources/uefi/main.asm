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
    mov rcx, [rbx]
    mov rsi, [rsp+8]
    mov r8, [BlockIO]
    mov rax, [rsi+0x98]
    call rax
    mov r12, [BlockIO]
    add r12, 0x8
    mov r13, [r12]
    add r13, 12
    mov [BlockSize], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    add r13, 0x18
    mov [LastBlock], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    mov [MediaId], r13
    mov r12, [BlockIO]
    add r12, 8
    mov r13, [r12]
    add r13, 4
    mov [Removable], r13
    pop r8
    pop rdx
    pop rcx
    xor rax, rax
    add rsp, 0x28 ;
    ;todo: main함수 작성이 끝나면 검토 후 본 함수 코드 일부 수정
    ;fix: 오프셋 계산 전체 다시해야함.
    ret


read_sector:
    sub rsp, 0x38
    mov rax, [BlockIO]
    add rax, 0x18
    push rcx
    push rdx
    push r8
    push r9
    lea rcx, [BlockIO]
    mov rdx, [MediaId]
    mov r9, [BlockSize]
    lea r10, [BufferOfSector]
    mov [rsp+0x20], r10
    call rax
    pop r9
    pop r8
    pop rdx
    pop rcx
    cmp rax, 0x8000000000000000
    jne if1
    mov rax, 1
    add rsp, 0x38
    ret
    if1:
    add rsp, 0x38
    xor rax, rax
    ret

main:
    call find_root
    xor r8, r8
    sloop1:
    call read_sector
    inc r8
    cmp rax, 0
    je eloop1
    lea r15, [BufferOfSector]
    ;todo: 뒤에 구현

