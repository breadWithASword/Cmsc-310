.section .text
.global .sum

# %rdi = array[0]
# %rsi = count
sum:
    xor %eax, $0  # hold total
    xor %r8, $0  # loop counter

loop_start:
    cmp $rsi, $r8   # checks if the loop counter has reached the max value 
    jge loop_end

    add %eax, %rdi+%r8

    inc %r8
    jmp loop_start

loop_end:
    ret %eax