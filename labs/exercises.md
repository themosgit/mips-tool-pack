National and Kapodistrian University of AthensDepartment of Informatics and TelecommunicationsCourse: Computer Architecture ILaboratory ExercisesD. Gizopoulos, ProfessorLaboratory Exercise 1: Introduction – Registers – Memory – System CallsIntroductionThe purpose of the first laboratory lesson is to familiarize with the environment of the QtSpim simulator and assembler, which simulates the operation of the MIPS microprocessor. Basic MIPS assembly language instructions will be used for moving data between memory and registers and performing logical operations. Basic directives to the simulator will be used, as well as the system calls it supports. Additionally, the single-step simulation and breakpoint features will be used.The simulator is already installed in the laboratory on a Windows operating system, but for private use, you can copy it from the course website (versions for Windows, Linux, and Mac are available). The simulator is provided by its designer, James Larus, at http://sourceforge.net/projects/spimsimulator/files/ and is distributed for free under the BSD license.Part 1: Execution, Code and Data Segments, Data TransferExercise 1.1Start QtSpim and load (File → Load) the program lab1_1.s from the course website (the code is also provided below). Open the example file with a text editor like Notepad.# lab1_1.s
# Pseudoinstruction examples System calls
# $t0 - holds each byte from string in turn
# $t1 - contains count of characters
# $t2 - points to the string

###################################################
# text segment
###################################################
.text
.globl start

start:
    la      $t2, str        # t2 points to the string
    li      $t1, 0          # t1 holds the count

nextCh:
    lb      $t0, ($t2)      # get a byte from string
    beqz    $t0, strEnd     # zero means end of string
    add     $t1, $t1, 1     # increment count
    add     $t2, 1          # move pointer one character
    j       nextCh          # go round the loop again

strEnd:
    la      $a0, ans        # system call to print out a message
    li      $v0, 4
    syscall

    move    $a0, $t1        # system call to print out the length worked out
    li      $v0, 1
    syscall

    la      $a0, endl       # system call to print out a newline
    li      $v0, 4
    syscall

    li      $v0, 10         # au revoir...
    syscall

###################################################
# data segment
###################################################
.data
str:    .asciiz "hello world"
ans:    .asciiz "Length is "
endl:   .asciiz "\n"
# End of File
In QtSpim, observe the memory addresses in the text and data windows where the program's code and data have been loaded. By comparing the contents of the code window and Notepad, identify which instructions in lab1_1.s are pseudo-instructions.[Image: QtSpim User Text Segment view showing assembly code and corresponding machine code.]Observe that the la (load address) pseudo-instruction is expanded into two real instructions (lui and ori). Observe the move pseudo-instruction which is converted to addu. Also, observe the pseudo-instruction add $t2, 1 which is converted by the assembler to the real MIPS instruction addi $t2, $t2, 1.[Image: QtSpim Data Segment view showing the memory layout of the strings.]Execute the program step-by-step (Simulator → Single Step or F10) and observe the changes in the relevant registers.[Image: QtSpim register view before and after program execution, highlighting the final value in register $t1.]Exercise 1.2This exercise will demonstrate the different categories of load and store instructions available in QtSpim.(a) Create the following layout in the data segment using the .data, .byte, and .word directives.[Image: Diagram of the Data Segment layout with specified byte and word addresses and values.](b) In the main program, use the unsigned load instructions lbu and lhu, and the lw instruction to load data starting from address 0x10010000 into registers $t0, $t1, and $t2.(c) Do the same for data starting from address 0x10010004 into registers $t3, $t4, and $t5.(d) Repeat the transfers using signed load instructions lb, lh, and lw. Use a breakpoint to observe the sign extension.(e) Load the byte from address 0x10010004 into register $t6 (unsigned) and then store it back to memory using sb. Check for sign extension.(f) How would $t6 be stored in memory if the processor were big-endian?Exercise 1.3This exercise clarifies memory alignment.(a) Modify the previous program to load bytes from aligned and unaligned addresses into registers $t0, $t1, and $t2 and observe the behavior.(b) Add an extra byte and a half-word to misalign subsequent data. Observe how the simulator performs automatic alignment.(c) Modify the program to disable automatic alignment using .align 0. An error will occur when trying to access unaligned words. Use the pseudo-instructions ulw (unaligned load word) and ulh (unaligned load half-word) to access the unaligned data and see how they are expanded.Part 2: System CallsExercise 1.4Write a program that reads a string from the user. Then, display only the first five characters of the string. Use the read_string and print_string system calls.[Image: Console output showing "abcdefghij" as input and "abcde" as output.]Exercise 1.5Write a program that reads an integer from the console and then displays it. Use read_int and print_int. Experiment with out-of-range integers like 2,147,483,648.Exercise 1.6Write a program that reads two integers from the user and displays their sum and difference.[Image: Console output showing inputs 22, 8 and outputs 30, 14.]Laboratory Exercise 2: Arithmetic and Logical OperationsIntroductionThis lab covers logical operations, integer arithmetic, overflow handling, multiplication, and division in MIPS.Part 1: Logical OperationsExercise 2.1Write a program to convert a 32-bit binary number to its Gray code equivalent using only logical and shift operations.gn​=bn​gi​=bi+1​⊕bi​, for i=0...n−1Exercise 2.2Write a program to convert a 32-bit word from big-endian to little-endian format using only logical and shift operations.[Image: Diagram showing the byte-swapping from Big-Endian to Little-Endian format.]Part 2: Addition - Subtraction - Overflow - CarryExercise 2.3Perform additions on pairs of 32-bit signed numbers in QtSpim using add and addu. Observe the results, overflow behavior, and the difference between the two instructions.Exercise 2.4(a) Write a program to detect overflow when adding two signed numbers without using conditional branches, storing the overflow bit in a register.(b) Based on the previous exercise, determine the logical function of the final carries (C32​ and C31​) that produces the overflow bit V.Exercise 2.5Devise a method to calculate the final carry-out (C32​) of a 32-bit addition, since MIPS does not provide a carry flag. Write a program to implement this.Exercise 2.6Create a program to add two 64-bit signed numbers. Use your carry-detection logic from the previous exercise to handle the carry from the low 32 bits to the high 32 bits.Part 3: Multiplication and DivisionExercise 2.7Compare the mult (signed) and multu (unsigned) instructions. Test them with various pairs of numbers (positive/negative) and observe the 64-bit results in the hi and lo registers.Exercise 2.8Write a program that takes two signed integers from the user and performs division using the div instruction. Display the quotient and remainder. Test with various inputs, including division by zero and the most negative integer.Laboratory Exercise 3: Program Flow ControlIntroductionThis lab focuses on using MIPS decision-making and branching instructions to implement high-level control structures like if-then-else, case, and loops.Part 1: Conditional BranchesExercise 3.1Create a switch-case structure. The program should read an integer and print messages indicating if it is divisible by 2, 3, or 5.(a) Implement it so that all applicable messages are printed (e.g., for 10, it prints messages for 2 and 5). This is like a switch without break statements.(b) Implement it so that only the message for the smallest divisor (2, 3, or 5) is printed. This is like a switch with break statements.Part 2: LoopsExercise 3.2Write a program to calculate the Hamming distance between two 32-bit words stored in memory. The Hamming distance is the number of bit positions in which the two words differ. (Hint: use xor and srl).Exercise 3.3Given the following program lab3_3.s which copies a string until a specific character ('t') is found:##################################################
# lab3_3.s
##################################################
.text
.globl start
start:
    li      $t1, 0          # counter for string
    li      $s0, 't'        # character to end copy
while:
    lbu     $t0, string($t1) # load a character
    beq     $t0, $s0, end   # if character to end copy then exit loop
    sb      $t0, copy($t1)  # copy character
    addi    $t1, $t1, 1     # increment counter
    j       while           # repeat while loop
end:
    li      $t2, 0
    sb      $t2, copy($t1)  # append end character to copied string
    la      $a0, copy       # display copy
    li      $v0, 4
    syscall
    li      $v0, 10         # exit
    syscall

.data
string: .asciiz "Mary had a little lamb"
copy:   .space 80
#################################################
Modify the program:(a) Change the loop condition to: while (current_char != 't' AND chars_read < n).(b) Change the loop condition to: while (current_char != 't' OR chars_read < n).Exercise 3.4Write a program that accepts a sequence of characters from the user and prints the same sequence in uppercase. (ASCII 'a'-'z' are 97-122, 'A'-'Z' are 65-90).Laboratory Exercise 4: Procedures and the StackIntroductionThese exercises demonstrate the use of the stack for creating procedures, culminating in a program to calculate the Fibonacci sequence using recursion.Part 1: Simple Call and Register ConventionsExercise 4.1Create a procedure that takes four integers in registers $a0-$a3 and returns the smallest in $v0 and the largest in $v1. Follow the MIPS calling convention, saving any $s registers you use onto the stack. In the main program, load the arguments and also initialize the $s registers with arbitrary values to verify that they are preserved across the procedure call. Use the provided skeleton code lab4_1a.s.Part 2: Recursive CallsExercise 4.2Write a program with a main part and a recursive procedure. The main program asks for an integer, n, and calls the procedure with it. The procedure checks if its argument is zero. If not, it decrements it by one and calls itself. In either case, it prints the value it received.Is it necessary to save the parameter $a0 on the stack? Explain.[Image: Diagram showing a linear chain of recursive procedure calls and returns.]Exercise 4.3Enhance the previous program so that the procedure returns the lowest stack pointer address reached during its execution. The main program will then calculate and display the total stack memory used.[Image: Diagram of a procedure proc that takes $a0, calls itself with $a0-1, and returns min($v0, $sp) in $v0.]Exercise 4.4The next step is to compute the n-th term of the Fibonacci sequence. To maintain the linear recursion pattern and improve efficiency, use the following equivalent formulas:f(n)=f(n−1)+a(n−1), for n>1a(n)=f(n−1), for n>1with base cases:f(1)=1,a(1)=1 and f(0)=0,a(0)=1.Your procedure will take n in $a0 and return f(n) in $v1 and a(n) in $v0.[Image: Diagram showing the recursive step of the Fibonacci procedure.]Before writing the program, complete the diagram below for the base case of the procedure (i.e., for n=1).[Image: Diagram for the base case (n=1) of the Fibonacci procedure, with empty boxes for the return values in $v0 and $v1.]Laboratory Exercise 5: Floating-Point ArithmeticIntroductionThis lab will examine the input/output of single-precision floating-point numbers, their representation, precision limitations, and special-case operations. The second part involves developing a more complex program to calculate the exponential function ex.Part 1: Representation - Precision - Operations - ConversionsExercise 5.1Write a program that reads a single-precision float using read_float and prints it using print_float.(a) Experiment with powers of 2 (e.g., -0.75, 1.5, 1/216).(b) Experiment with other numbers (e.g., 0.775, 0.1).(c) Modify the program to load the hexadecimal representation of the following special numbers directly into a floating-point register. Fill in their binary and hex representations.Representation of Special NumbersNumber3130-2322-0HEX+∞NaN+min_denormExercise 5.2Write a program to perform the operations in the table below and fill in the results. Define constants for 0.0,+∞,−∞,+NaN, a positive number x, and a negative number y.OperationResultx⋅yx⋅(−∞)y/00/00⋅(+∞)(+∞)/(−∞)(+∞)+(−∞)x+NaNExercise 5.3Calculating factorials with integer arithmetic quickly leads to overflow (13! exceeds a 32-bit integer).(a) Run the provided integer factorial program lab5_3a.s and observe the results for n≥13.(b) Modify the program to use single-precision floating-point arithmetic. You will likely need mtc1, cvt.s.w, and mul.s. Run the program for n>20 and compare the results with a calculator.Part 2: Complex CalculationsExercise 5.4The exponential function can be approximated using the Taylor series:ex=∑n=0∞​n!xn​Write a program to calculate ex using the first k terms of the series (e.g., k=8). The value of x will be given by the user. Use single-precision floating-point arithmetic.
