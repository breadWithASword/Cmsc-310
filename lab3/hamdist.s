.section .data
    ask1:
        .ascii "Enter string 1: \n"
    ask1_len = . - ask1

    ask2:
        .ascii "Enter string 2: \n"
    ask2_len = . - ask2

    endl:
        .ascii " \n"
    endl_len = . - endl

    testx:
        .ascii "x \n"
    testx_len = . - testx

    testy:
        .ascii "y \n"
    testy_len = . - testy

    output:
        .ascii " "


.section .bss
.lcomm str1, 225    # reserving 2 225 char variables to store user inputs
.lcomm str2, 225


.section .text
.global _start
_start:
    mov $0, %r8
    mov $0, %r9

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


    mov $0, %r15   # acts as loop counter for get_char

    lea str1(%rip), %rsp   # makes %rsi point to string 1
    lea str2(%rip), %rbp   # makes %rdi point to string 2

    cmp %r8, %r9   # compare size of 1 to size of 2
    jge get_char    # bypasses r9_less if 2 is >= 1


r9_less: # sets r8 to the value of r9 if r9 is less
    mov %r9, %r8


# gets the next character of each string
get_char: 
    cmp %r15, %r8
    jl endfunc

    movzbq (%rsp), %r11    # puts char from 1 into %r11
    movzbq (%rbp), %r12    # puts char from 2 into %r12
    xor %r12, %r11         # gets distance & places it in %r11

    mov $8, %rcx        # loop vaule for count_loop
    


count_loop:
    rol $1, %r11    # Rotate left to test highest bit into Carry Flag
    jc set_one     # If carry flag is set, bit is 1
    mov $'0', %bl
    jmp out_bit
    

set_one:
    mov $'1', %bl


out_bit:
    mov     %bl, output(%rip)      # Move character into output buffer

    mov $1, %rax                # RAX = 1 (write)
    mov $1, %rdi                # RDI = 1 (stdout)
    lea output(%rip), %rsi      # RSI = pointer to character
    mov $1, %rdx                # RDX = length (1 byte)
    syscall

    dec %rcx
    jnz count_loop


endfunc:
    movq $1, %rax           # adds a newline at the end of the output
    movq $1, %rdi   
    movq $endl, %rsi      
    movq $endl_len, %rdx  
    syscall
mov $60, %rax   # tells the program to end the function
mov $0, %rdi    # rdi(0) = ended successfully
syscall