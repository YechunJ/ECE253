vlib work
vlog part1.sv part2.sv

vsim part2

log {/*}
add wave {/*}

# Function 0: addition
# 1 + 2 = 3; expected ALUout = 00000011
force {Function} 2'b00
force {A} 4'b0001
force {B} 4'b0010
run 10ns

# Carry propagation: 15 + 1 = 16
# Expected ALUout = 00010000
force {A} 4'b1111
force {B} 4'b0001
run 10ns

# Maximum sum: 15 + 15 = 30
# Expected ALUout = 00011110
force {B} 4'b1111
run 10ns

# Function 1: reduction OR
# All zeros; expected ALUout = 00000000
force {Function} 2'b01
force {A} 4'b0000
force {B} 4'b0000
run 10ns

# One bit in A is 1; expected ALUout = 00000001
force {A} 4'b1000
run 10ns

# One bit in B is 1; expected ALUout = 00000001
force {A} 4'b0000
force {B} 4'b0001
run 10ns

# Function 2: reduction AND
# All ones; expected ALUout = 00000001
force {Function} 2'b10
force {A} 4'b1111
force {B} 4'b1111
run 10ns

# One bit in A is 0; expected ALUout = 00000000
force {A} 4'b0111
run 10ns

# One bit in B is 0; expected ALUout = 00000000
force {A} 4'b1111
force {B} 4'b1110
run 10ns

# Function 3: concatenation
# Expected ALUout = 10100101
force {Function} 2'b11
force {A} 4'b1010
force {B} 4'b0101
run 10ns

# Expected ALUout = 00111100
force {A} 4'b0011
force {B} 4'b1100
run 10ns