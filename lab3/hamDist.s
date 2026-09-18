.section .data
    ask1:
        .ascii "Enter string 1: \n"
    ask1_len = . - ask1

    ask2:
        .ascii "Enter string 2: \n"
    ask2_len = . - ask2


.section .bss
.lcomm strx, 225    # reserving 2 225 char variables to store user inputs
.lcomm stry, 225
dist: .int, 0
.lcomm binx, 8      # stores the binary version of each character
.lcomm biny, 8


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
    movq $strx, %rsi        # points to stry
    movq $255, %rdx         # max bytes to read
    syscall
    movq %rax, %r8         # saves length of strx


    # asks for string 2
    movq $1, %rax           # set syscall to write
    movq $1, %rdi           # set syscall to output
    movq $ask2, %rsi      # move ask2 to a usable point
    movq $ask2_len, %rdx  # set length of ask2
    syscall 

    # takes user input for string 2
    movq $0, %rax           # set syscall to read
    movq $0, %rdi           # set syscall to input
    movq $stry, %rsi        # points to stry
    movq $255, %rdx         # max bytes to read
    syscall
    movq %rax, %r9         # saves length of stry


_xgreater:


_ygreater:






mov $60, %rax   # tells the program to end the function
mov $0, %rdi    # rdi(0) = ended successfully
syscall