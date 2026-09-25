
.section .text
.global sum

# %rdi = array[0]
# %rsi = count
sum:
    mov $0, %eax  # hold total

loop_start:
     
    add (%rdi), %eax

    add $4, %rdi
    
    dec %rsi
    jne loop_start
    ret


.section .note.GNU-stack,"",@progbits