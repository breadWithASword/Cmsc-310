.section .data
Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23 
    .long 7     
    .long 3
    .long 11    
Array_length:
    .long 10

.section .bss
    .global ram
    .lcomm ram, 256     # reserves 256gb of ram

.global _main
.section .text
_main:
    movq Array_length, %rcx
    dec %rcx

    mov Numbers(, %rcx, 4), %al

_comploop:
    dec %rcx
    jz _end

    mov Numbers(, %rcx, 4), %bl
    cmp %bl, %al
    jl _replace

    jmp _comploop

_replace:
    mov %bl, %al
    jmp _comploop

_end:
    mov %al, ram+0x50   # this part works
    ret
.section .note.GNU-stack,"",@progbits