#        Xgfedcba 
# S = $0b01101101, ADEFG
# H = $0b01110110, BCEFG
# E = $0b01111001, ADEFG
.section .data


.global _main
.section .text
_main:
    mov $1, %bp             # starting direction [right->left]
    mov $5, %si             # starting point of 1st letter
    mov $0b0010000, %bl     # binary location of 1st letter
    mov $7, %di             # loop counter
    mov $703H, %dx          # address port A 


_loop
    cmp %si, %di        # checks if counter has reached 1st letter of "SHE"
    je _write           # writes SHE to the next 3 digits  

    dec %di
    jmp _loop


_left:
    mov $1, %bp         # increments location of "SHE" one to the left
    add %bp, %si
    ror %bp, %bl
    mov $7, %di         # reset loop counter


_right:
    mov $-1 %bp         # increments location of "SHE" one to the right
    add %bp, %si
    ror %bp, %bl
    mov $7, %di         # reset loop counter



_write:
    mov $701H, %dx          # address port A
    mov $0b01101101, %al    # place "S" into %al 
    out %bl, %dx            # send binary position of "S" to port A
    dec %dx                 # address port B
    out %al, %dx            # place "S" into its proper spot
    inc %dx                 # address port A
    ror $1, %bl             # increment location 1 right to place "H"

    mov $0b01110110, %al    # repeat previous steps for "H"
    out %bl, %dx
    dec %dx
    out %al, %dx
    inc %dx
    ror $1, bl%

    mov $0b01111001, %al    # repeat previous steps for "E"
    out %bl, %dx
    dec %dx
    out %al, %dx
    inc %dx

    ror $-2, %bl            # reset %bl

    cmp $7, %si             # switches direction if %si has reached end
    jz _right
    cmp $2, %si
    jz _left

    cmp $0 %bp              # returns to previous loop if %si is in bounds
    jg _left
    jl _right

