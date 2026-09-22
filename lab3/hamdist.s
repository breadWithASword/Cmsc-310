.section .data
    ask1:
        .ascii "Enter string 1: \n"
    ask1_len = . - ask1

    ask2:
        .ascii "Enter string 2: \n"
    ask2_len = . - ask2


.section .bss
.lcomm str1, 225    # reserving 2 225 char variables to store user inputs
.lcomm str2, 225
dist: .int, 0
binx: .ascii "00000000\n"      # stores the binary version of each character
biny: .ascii "00000000\n"


.section .text
.global _start
_start:
    # asks for string 1
    movq $1, %rax           # set syscall to write
    movq $1, %rdi           # set syscall to output
    movq $ask1, %rsi        # point to ask1
    movq $ask1_len, %rdx    # set length of ask1
    syscall 

    # takes user input for string 1
    movq $0, %rax           # set syscall to read
    movq $0, %rdi           # set syscall to input
    movq $str1, %rsi        # points to str1
    movq $255, %rdx         # max bytes to read
    syscall
    movq %rax, %r8         # saves length of str1


    # asks for string 2
    movq $1, %rax           # set syscall to write
    movq $1, %rdi           # set syscall to output
    movq $ask2, %rsi      # move ask2 to a usable point
    movq $ask2_len, %rdx  # set length of ask2
    syscall 

    # takes user input for string 2
    movq $0, %rax           # set syscall to read
    movq $0, %rdi           # set syscall to input
    movq $str2, %rsi        # points to str2
    movq $255, %rdx         # max bytes to read
    syscall
    movq %rax, %r9         # saves length of str2


    movb $1, %r15
    cmpl %r8, %r9
    jge _2greater
    jl _1greater



1greater:
    

2greater:
    a


# gets the next character of each string
get_char:
    leaq str1(%rip), %rsi
    movb %r15(%rsi), %al
    leaq str2(%rip), %rsi
    movb %r15(%rsi), %bl
    inc %r15
    cmp %r15, %r9
    
    jmp convert_loop

convert_loop:
    mov r8b, 8
    shl cl, 1
    jc set_one
    jmp next_bit
    

set_one:
    # If carry is 1, store ASCII '1' (0x31)
    mov byte ptr [rdi], '1'

next_bit:
    inc rdi         # Move to the next character in the buffer
    dec r8b         # Decrease bit counter
    jnz convert_loop  # Repeat for all 8 bits

    cmpl %r8, %r9
    jge _ygreater
    jl _xgreater



mov $60, %rax   # tells the program to end the function
mov $0, %rdi    # rdi(0) = ended successfully
syscall