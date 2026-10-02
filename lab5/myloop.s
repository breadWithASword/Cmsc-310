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

.global ram
.lcomm ram, 256

.global main
.section .text
main:
    leaq Numbers(%rip), %rbx
    mov $2, %rcx

    mov Array_length, %r15

    mov (%rbx,4), %r9

_comploop:
    mov (%rbx, %rcx, 4), %r10
    cmp %r10, %r9
    jg _replace

    inc %rcx
    cmp $10, %rcx
    jg _end
    jmp _comploop

_replace:
    mov %r10, %r9

    inc %rcx
    cmp $10, %rcx
    jg _end
    jmp _comploop


_end:
    mov %r9, ram+0x50

    mov $1, %rax                # RAX = 1 (write)
    mov $1, %rdi                # RDI = 1 (stdout)
    lea ram+0x50, %rsi               # RSI = pointer to character
    mov $256, %rdx                # RDX = length (1 byte)
    syscall


    mov $60, %rax   # tells the program to end the function
    mov $0, %rdi    # rdi(0) = ended successfully
    syscall