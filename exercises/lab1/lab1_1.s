######################
# lab1_1.s           #
# Pseudoinstructions #
# Examples sys calls #
# t0 - holds a byte  #
# t1 - string length #
# t2 - pointer to str#
######################

.text
    .globl __start

__start:
  la $a0, str
  li $v0, 4
  syscall
  la $a0, endl 
  li $v0, 4 
  syscall 
  la $t2, str #t2 now holds the address of the string
  li $t1, 0   #t1 holds the count set to 0 now
  nextCh: lb $t0, ($t2) #get a byte from the string
  beqz $t0, strEnd #if t0 equals zero it means end of string
  add $t1, $t1, 1 #increment the count
  add $t2, 1 #increment pointer by one byte
  j nextCh 
  strEnd:
  la $a0, ans
  li $v0, 4
  syscall
  move $a0, $t1
  li $v0, 1 
  syscall
  la $a0, endl
  li $v0, 4
  syscall
  li $v0, 10 
  syscall 

.data
str: .asciiz "hello world"
ans: .asciiz "Length is "
endl: .asciiz "\n"
