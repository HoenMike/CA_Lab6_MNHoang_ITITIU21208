# Name: Mai Nguyen Hoang
# ID: ITITIU21208

.data
arr: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  # Declare an array with elements 0-10
arr_end: # This label will point to the memory location just after the array

.text
.globl main

main:
    la $a0, arr # Load the address of arr into $a0
    jal print_arr # Call the print_arr function
    li $v0, 10 # Exit the program
    syscall

print_arr:
    la $t2, arr_end # Load the address of arr_end into $t2
    beq $a0, $t2, exit # If the current address is equal to arr_end, exit
    addi $sp, $sp, -8 # Allocate space on the stack
    sw $ra, 4($sp) # Save the return address on the stack
    sw $a0, 0($sp) # Save the value of $a0 (arr) on the stack

    lw $t0, 0($a0) # Load the first element of arr into $t0
    li $v0, 1 # Print integer syscall code
    move $a0, $t0 # Move the value to be printed into $a0
    syscall # Print the integer

    li $v0, 11 # Print character syscall code
    li $a0, ' ' # Load the space character into $a0
    syscall # Print a space character

    lw $a0, 0($sp) # Restore the value of $a0 (arr)
    addi $a0, $a0, 4 # Move to the next element in arr
    jal print_arr # Recursive call to print_arr

exit:
    lw $ra, 4($sp) # Restore the return address from the stack
    lw $a0, 0($sp) # Restore the value of $a0 (arr) from the stack
    addi $sp, $sp, 8 # Deallocate space from the stack
    jr $ra # Return to the caller