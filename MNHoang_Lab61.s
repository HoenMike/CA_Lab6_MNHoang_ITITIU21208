# Mai Nguyen Hoang
# ITITIU21208

.data
arr: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  # Array declaration
arr_end: # Label for end of array

.text
.globl main

main:
  la $a0, arr # Load arr address
  jal print_arr # Call function
  li $v0, 10 # Exit program
  syscall

print_arr:
  la $t2, arr_end # Load arr_end address
  beq $a0, $t2, exit # Check for end of array
  addi $sp, $sp, -8 # Stack space
  sw $ra, 4($sp) # Save return address
  sw $a0, 0($sp) # Save arr value

  lw $t0, 0($a0) # Load first element
  li $v0, 1 # Print integer syscall
  move $a0, $t0 # Move value to $a0
  syscall # Print integer

  li $v0, 11 # Print character syscall
  li $a0, ' ' # Load space character
  syscall # Print space

  lw $a0, 0($sp) # Restore arr value
  addi $a0, $a0, 4 # Next array element
  jal print_arr # Recursive call

exit:
  lw $ra, 4($sp) # Restore return address
  lw $a0, 0($sp) # Restore arr value
  addi $sp, $sp, 8 # Deallocate stack space
  jr $ra # Return