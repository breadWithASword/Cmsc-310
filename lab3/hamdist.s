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


    movb $0, %r15   # acts as loop counter for get_char
    movb $0, %r14   # stores distance value

    leaq str1(%rip), %rsi   # makes %rsi point to string 1
    leaq str2(%rip), %rdi   # makes %rdi point to string 2

    cmpl %r8, %r9   # compare size of 1 to size of 2
    jge get_char    # bypasses 2_less if 2 is >=


2_less: # sets r8 to the value of r9 if r9 is less
    mov %r9, %r8


# gets the next character of each string
get_char:
    cmp %r15, %r8       # checks if the end of the shortest string has been reached
    jge output_dist

    mov (%rsi), %r11    # puts char from 1 into %r11
    mov (%rsi), %r12    # puts char from 2 into %r12

    xor %r12, %r11      # gets difference & places it in %r11

    mov $8, %rcx        # loop vaule for count_loop
    inc %r15


count_loop:
    rol     $1, %r11                 # Rotate left to test highest bit into Carry Flag
    jc      set_one                 # If carry flag is set, bit is '1'
    dec %rcx
    jnz count_loop
    jmp get_char
    

set_one:
    inc %r14




mov $60, %rax   # tells the program to end the function
mov $0, %rdi    # rdi(0) = ended successfully
syscall