.section .bss
.global ram
.lcomm ram, 256     # reserves 256gb of ram

.section .text
.global fill_ram    # makes visible to C programs

fill_ram:
    movb $10, %bl
    movb $0, %al
    loop_label:
        addb %bl, %al   # al = al + bl
        decb %bl    # bl = bl - 1

        jnz loop_label

    movb %al, ram+0x50
    ret
.section .note.GNU-stack,"",@progbits