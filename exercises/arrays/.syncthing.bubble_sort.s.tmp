.text
.globl main 

main:
  la $a0, msg2
  jal print_string
  jal read_int
  move $a0, $v0
  move $a0, $v0
  jal print_int

  la $a0, $msg3
  jal print_string
  la $a0, empty_array
  move $a1, $s0
  jal read_arr


  la $a0, empty_array
  move $a1, $s0

  jal sort

  la $a0, msg4
  jal print_string
  la $a0, empty_array
  move $a1, $s0
  jal print_arr

j exit

exit:
  li $v0, 10
  syscall

swap:
  sll $t1, $a1, 2 
  add $t1, $a0, $t1
  lw $t0, 0($t1)
  lw $t2, 4($t1)
  sw $t2, 0($t1)
  sw $t0, 4($t1)
  jr $ra 

sort:
  addi $sp, $sp, -20
  sw $ra, 16($sp)
  sw $s3, 12($sp)
  sw $s2, 8($sp)
  sw $s1, 4($sp)
  sw $s0, 0($sp)

  move $s2, $a0
  move $s3, $a1
  move $s0, $zero

for1tst:
  slti $t0, $s0, $s3
  bne $t0, $zero, exit1
  addi $s1, $s0, -1

for2tst:
  slti $t0, $s1, 0
  bne $t0, $zero, exit2
  sll $t1, $s1, 2 
  add $t2, $s2, $t1
  lw $t3, 0($t2)
  lw $t4, 4($t2)
  slt $t0, $t4, $t3
  beq $t0, $zero, exit2

  move $a0, $s2
  move $a1, $s1
  jal swap

  addi $s1, $s1, -1
  j for2tst

exit2:
  addi $s0, $s0, 1 
  j for1tst

exit1:
  lw $s0, 0($sp)
  lw $s1, 4($sp)
  lw $s2, 8($sp)
  lw $s3, 12($sp)
  lw $ra, 16($sp)
  addi $sp, $sp, 20
  jr $ra


sum_array:
  li $v0, 0
  addi $sp, $sp, -4
  sw $s0, 0($sp)

  li $s0, 0
  for_sum_arr:
    sll $t0, $s0, 2
    add $t0, $t0, $a0

    lw $t1, 0($t0)
    add $v0, $v0, $t1
  
  addi $s0, $s0, 1
  blt $s0, $a1, for_sum_arr

  lw $s0, 0($sp)
  addi $sp, $sp, 4
  jr $ra


print_arr:
  addi $sp, $sp, -4
  sw $s0, 0($sp)

  li $s0, 0
  for_print_arr:
    move $t2, $a0
    sll $t0, $t0, 2
    add $t0, $t0, $a0

    lw $t1, 0($t0)
    move $a0, $t1

    li $v0, 1
    syscall

    li $v0, 11
    li $a0, 32
    syscall

    move $a0, $t2

  addi $s0, $s0, 1
  blt $s0, $a1, for_print_arr

  move $t7, $ra
  jal print_endl
  move $ra, $t7

  lw $s0, 0($sp)
  addi $sp, $sp, 4 
  jr $ra

read_arr:
  addi $sp, $sp, -8
  sw $s0, 0($sp)
  sw $s1, 4($sp)

  li $s0, 0
  for_read_arr:
    li $v0, 5
    syscall

    move $s1, $v0
    move $t2, $a0

    li $v0, 1 
    move $a0, $s1
    syscall

    move $a0, $t2
    sll $t0, $s0, 2 
    add $t0, $t0, $a0

    sw $s1, 0($t0)

    li $v0, 11
    li $a0, 32
    syscall

    move $a0, $t2

  addi $s0, $s0, 1
  blt $s0, $a1, for_read_arr

  move $t7, $ra
  jal print_endl
  move $ra, $t7

  lw $s0, 0($sp)
  lw $s1, 4($sp)
  addi $sp, $sp, 4
  jr $ra


print_string:
  li $v0, 4
  syscall
  jr $ra

read_int:
  li $v0, 5
  syscall
  jr $ra

print_int:
  li $v0, 1
  syscall 
  jr $ra

print_endl:
  addi $sp, $sp, -4
  sw $a0, 0($sp)
  li $a0, 10 
  li $v0, 11
  syscall
  lw $a0, 0($sp)
  addi $sp, $sp, 4
  jr $ra


.data
empty_array: .space 400

msg1: .asciiz ": "
msg2: .asciiz "Give the N: (up to 100)\n"
msg3: .asciiz "\nGive the elements of the array\n"
msg4: .asciiz "The array you gave is:\n"
summ: .asciiz "The sum is: "
