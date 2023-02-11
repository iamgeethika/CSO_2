.global Next_Largest_Element
                                            # initially %rdi holds n

Next_Largest_Element:
    movq    $0,%r8                          # initialise stack size to 0
    movq    $0, %rax                        # moving 0 to %rax
    pushq   %rax                            # push %rax onto the stack
    incq    %r8                             # incrementing the value of %r8
    movq    $1,%rcx                         # %rcx = i ... initially 1

.Loop:
    cmpq     %rdi,%rcx                      # comparing %rdi (n) and %rcx (i)
    jl      .L1                             # if i<n then, jump to loop .L1 
    jmp     .L6                             # else jump to loop .L6

.L1:
    cmpq    $0,%r8                          # comparing 0 and %r8
    jg      .L2                             # if the stack size is greater than 0...i.e, not empty...jump to loop .L2
    jmp     .L4                             # else..,jump to loop .L4

.L2:
    movq    (%rsp),%r9                      # temp = %r9
    movq    (%rsi, %rcx, 8),%r10            # A[i] = %r10
    cmpq     %r10, (%rsi, %r9, 8)			# compare A[i] and A[Stack.top()]
    jl      .L3                             # if A[Stack.top()] < A[i] then, jump to loop .L3
    jmp     .L4                             # else jump to loop .L4


.L3:
    movq    %rcx,(%rdx,%r9,8)               # %rcx to the register with address (%rdx+8*%r9) 
    popq    %r11                            # pop this to destination
    decq    %r8                             # decrement the value of %r8
    jmp     .L1                             # jump to loop .L1

.L4:
    pushq   %rcx                            # push %rcx to the top of the stack
    incq    %r8                             # incrementing the value of %r8
    incq    %rcx                            # incrementing the value of %rcx
    jmp     .Loop                           # jump to loop .Loop 

.L6:
    cmpq    $0,%r8                          # comparing 0 and %r8
    jg      .L7                             # if the stack size is greater than 0...i.e, not empty...jump to loop .L7
    jmp     .L10                            # else, jump to loop .L10

.L7:
    movq    (%rsp),%r9                      # temp = %r9
    movq    $-1,(%rdx,%r9,8)                # moving 0 to the A[Stack.top()].... if he Element is the Top of the Stack or the End(Last Element) of the input array.. it doesn't have any element after it ... so the Laregest ELement after it should return -1
    popq    %r11                            # pop this to destination                 
    decq    %r8                             # decrement the value of %r8
    jmp     .L6                             # jump to loop .L6

.L10:
    ret                                     # return the value
