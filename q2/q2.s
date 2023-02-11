.global	CountBinarySequence
CountBinarySequence:

                                      # initially %rdi holds n
									  # initially %rsi holds difference.....which is 0

	pushq	%rbp                      # pushes the value of the register rbp onto the stack
	movq	%rsp, %rbp                # saves the current stack pointer in %rbp --> callee's frame pointer
	pushq	%rbx                      # saves old copy of this register
	subq	$40, %rsp                 # to allocate (uninitialized) local variables on the stack
	movq	%rdi, 8(%rsp)             # moves n to the Register with address (%rsp + 8)
	movq	%rsi, 16(%rsp)            # moves difference to the Register with address (%rsp + 16)
	movq	$13, 24(%rsp)             # moves 13 to the Register with address (%rsp + 24)....K=13
	movq	16(%rsp), %rax            # fetches the argument..difference from the stack and place it in %rax
	cmpq	8(%rsp), %rax             # comparing value in (%rsp + 8)...which is n and the value in (%rsp +16)...which is difference
	jg	.L1                           # if difference > n ... jump to loop .L1
	movq	8(%rsp), %rax             # fetches the argument..n from the stack and place it in %rax
	negq	%rax                      # negative of n
	cmpq	%rax, 16(%rsp)            # comparing value in (%rsp + 8)...which is n and the value in (%rsp +16)...which is difference
	jge	.L2                           # if n >= difference, then jump to loop .L2

.L1:                                 

	movq	$0, %rax                  # moves 0 to %rax
	jmp	.L3                           # jump to loop .L3

.L4:
                                      # n = 1 and difference = 0
    movq	$2, %rax                  # moves 2 to %rax
	jmp	.L3                           # jump to loop .L3

.L6:                                  # n = 1 and difference = 1

	movq	$1, %rax                  # moves 1 to %rax
	jmp	.L3                           # jump to loop .L3

.L2:

	cmpq	$1, 8(%rsp)               # comparing 1 and value in (%rsp + 8)
	jne	.L5                           # if they are not equal.....n != 1, then jump to .L5

	cmpq	$0, 16(%rsp)              # comparing 0 and value in (%rsp + 16)
	je	.L4                           # if equal.....difference = 0, then jump to loop .L4

	cmpq	$1, 16(%rsp)              # comparing 1 and (%rsp + 16)
	je	.L6                           # if equal.....difference = 1, then jump to loop .L6

	cmpq	$-1, 16(%rsp)             # comparing -1 and value in (%rsp +16)
	je	.L6                           # if equal.....difference = -1 then jump to loop .L6

.L5:

	movq 8(%rsp), %rax                # moves the value in (%rsp + 8) to %rax
	subq $1, %rax                     # Subtracting 1 from %rax and again storing in it.....%rax = %rax - 1.....(n = n-1)
	movq 16(%rsp), %rdx               # moves the value in (%rsp + 16) to %rdx
	addq $1, %rdx                     # Adding 1 to %rax and again storing in it.....%rdx = %rdx + 1......(difference = difference + 1)
	movq %rax, %rdi                   # moving %rax to %rdi
	movq %rdx, %rsi                   # moving %rdx to %rsi

	call CountBinarySequence          # calling the function CountBinarySequence

	movq %rax, %rbx                   # moves %rax to %rbx
	movq 8(%rsp), %rax                # moves the value in the Register (%rsp + 8) to %rax
	subq $1, %rax                     # Subtracting 1 from %rax and again storing in it.....%rax = %rax - 1......(n = n - 1)
	movq 16(%rsp), %rdx               # moves the value in (%rsp + 16) to %rdx
	movq %rax, %rdi                   # moving %rax to %rdi
	movq %rdx, %rsi                   # moving %rdx to %rsi

	call CountBinarySequence          # calling the function CountBinarySequence

	addq %rax, %rax                   # Adding %rax and %rax and again storing it in %rax.....%rax = %rax + %rax
	addq %rax, %rbx                   # Adding %rbx and %rax and again storing it in %rbx.....%rbx = %rbx + %rax
	movq 8(%rsp), %rax                # moves the value in the Register (%rsp + 8) to %rax
	subq $1, %rax                     # Subtracting 1 from %rax and again storing in it.....%rax = %rax - 1......(n = n-1)
	movq 16(%rsp), %rdx               # moves the value in (%rsp + 16) to %rdx
	subq $1, %rdx                     # Subtracting 1 from %rdx and again storing in it.....%rdx = %rdx - 1......(difference = difference -1)
	movq %rax, %rdi                   # moving %rax to %rdi
	movq %rdx, %rsi                   # moving %rdx to %rsi

	call CountBinarySequence          # calling the function CountBinarySequence

	addq %rbx, %rax                   # Adding %rax and %rbx and again storing it in %rax.....%rax = %rax + %rbx
	cqto                              # converting quad to octa
	idivq 24(%rsp)                    # Dividing %rax by K, which is 13.....It stores the quotient in %rax and remainder in %rdx
	movq %rdx, %rax                   # moving %rdx..i.e, the remainder to %rax
	
.L3:
	addq	$40, %rsp                 # Deallocate Stack Space 
	popq	%rbx                      # cancels the effect of pushq %rbx...Restoring its original value
	popq	%rbp                      # cancels the effect of pushq %rbp...Restoring its original value
	ret                               # return the value
	