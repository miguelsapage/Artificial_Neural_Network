################################################################
# Author: Miguel Sapage
################################################################

.text
################################################################
# This is the "main" part of the code
# Test cases for 00, 01, 10, and 11
################################################################
# Develop your code here
    li a0 0    #input A
    li a1 0    #input B
    jal ra neural_network_xor
    li a0 0    #input A
    li a1 1    #input B
    jal ra neural_network_xor
    li a0 1    #input A
    li a1 0    #input B
    jal ra neural_network_xor
    li a0 1    #input A
    li a1 1    #input B
    jal ra neural_network_xor
    
end:             # exit your program with this sequence
    li a7 10     # sets register a7 (x17) to 10
    ecall        # system call: exit the program with code 0


###############################################################
# multiply: multiplies two numbers and returns the result
###############################################################
multiply:
    lw a0 8(sp)            #load variable from stack
    lw a2 12(sp)           #load weight from stack
    li a6 0                #loop control variable
    li a4 0                #multiplication output
    
    bgtz a0 mult
    neg a0 a0              #in case variable is negative
    bnez a0 mult           #in case variable is zero
    sw a4 16(sp)           #pass output of multiplication to stack
    jr ra
    
mult:
    add a4 a4 a2            #successive additions
    addi a6 a6 1
    bne a6 a0 mult          #compare control variable
    lw a0 8(sp)             #restores variable value
    bgtz a0 8               #if variable is positive keep output
    neg a4 a4               #if variable is negative negate output
    sw a4 16(sp)            #pass output of multiplication to stack
    jr ra                   #go back to neuron
    
###############################################################
# neuron: computes the output of a neuron
###############################################################
neuron:
    sw ra 4(sp)
    li a5 0               #s
    sw a0 8(sp)           #pass x1 to stack
    sw a2 12(sp)          #pass w1 to stack
    jal ra multiply       #do multiplication
    lw a4 16(sp)          #load output of multiplication
    add a5 a5 a4          #s=x1*w1
    sw a1 8(sp)           #pass x2 to stack
    sw a3 12(sp)          #pass w2 to stack
    jal ra multiply
    lw a4 16(sp)          #load output of multiplication
    add a5 a5 a4          #s=s+x2*w2
    add a5 a5 a7          #s=s+b
    
    lw ra 4(sp)
    bltz a5 else          #sees value to return
    li a4 1               #if s>=0 return 1
    jr ra
else:
    li a4 0               #if s<0 return 0
    jr ra

###############################################################
# neural_network_xor: computes the output of XOR gate 
# using a small neural network
###############################################################
neural_network_xor:
    addi sp sp -28      #make room on stack
    sw ra 0(sp)
    sw a0 20(sp)        #save input A value
    sw s1 24(sp)        #save s0 value
    
    li a7 -1    #constant b
    li a2 2     #w1
    li a3 -2    #w2
    jal ra neuron        #neuron NA
    mv s1 a4    #c
    li a2 -2    #w1
    li a3 2     #w2
    lw a0 20(sp)         #restore input A value to a0
    jal ra neuron        #neuron NB
    mv a1 a4   #d = x2
    mv a0 s1   #c = x1
    li a2 2    #w1
    li a3 2    #w2
    jal ra neuron        #neuron NC
    lw ra 0(sp)
    lw s1 24(sp)    #restore s0 original value
    addi sp sp 28   #"close" stack
    jr ra