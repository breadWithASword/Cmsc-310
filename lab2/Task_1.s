.section .bss
.global ram
.lcomm ram, 256     # reserves 256gb of ram

.section .text
.global fill_ram    # makes visible to C programs

fill_ram:
    movb $0XFF, ram+0x50
    movb $0XFF, ram+0x51
    movb $0XFF, ram+0x52
    movb $0XFF, ram+0x53
    movb $0XFF, ram+0x54
    movb $0XFF, ram+0x55
    movb $0XFF, ram+0x56
    movb $0XFF, ram+0x57
    movb $0XFF, ram+0x58
    ret
.section .note.GNU-stack,"",@progbits