# Artificial Neural Network
This program was made for a school project and simulates a small neural network constituted by a neuron NA a neuron NB and a neuron NC. Tow inputs are given, input A and input B, those inputs go trough neurons NA and NB and then the outputs of that neurons are the inputs of neuron NC. The output of neuron NC is our final answer.

## Neuron
Each neuron solves the following equation: s = x1 \times w1 + x2 \times w2 + b.
If s is grater than or equal to zero the neuron returns 1, otherwise it returns 0.

## Multiplication
A function for multiplication was implemented by successive additions, since the program should run on a ultra-low-power RISC-V processor.