.section .bss
.global ram
.lcomm ram, 256     # reserves 256gb of ram

.section .text
.global fill_ram    # makes visible to C programs

fill_ram:
    lea ram+0x50, %eax
    movb $0XFF, (%eax)
    lea ram+0x51, %eax
    movb $0XFF, (%eax)
    lea ram+0x52, %eax
    movb $0XFF, (%eax)
    lea ram+0x53, %eax
    movb $0XFF, (%eax)
    lea ram+0x54, %eax
    movb $0XFF, (%eax)
    lea ram+0x55, %eax
    movb $0XFF, (%eax)
    lea ram+0x56, %eax
    movb $0XFF, (%eax)
    lea ram+0x57, %eax
    movb $0XFF, (%eax)
    lea ram+0x58, %eax
    movb $0XFF, (%eax)

    ret
.section .note.GNU-stack,"",@progbits