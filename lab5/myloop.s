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
    .lcomm ram, 256     # reserves 256gb of ram to pass back to printloop.c

.global _main
.section .text
_main:
    movq Array_length, %rcx         # save length of array to %rcx 
    dec %rcx                        # %rec-- as indexes are 0 to n-1

    mov Numbers(, %rcx, 4), %al     # save Numbers[n-1] to %al

_comploop:                          
    dec %rcx                        # %rec--, ends loop if %rec == 0
    jz _end

    mov Numbers(, %rcx, 4), %bl     # move the next index of Numbers to %bl
    cmp %bl, %al                    # %bl replaces %al if %bl is larger
    jl _replace

    jmp _comploop

_replace:
    mov %bl, %al
    jmp _comploop

_end:                               
    mov %al, ram+0x50               # saves the value of %al to ram so that it can be passed to printloop.c and printed
    ret
.section .note.GNU-stack,"",@progbits