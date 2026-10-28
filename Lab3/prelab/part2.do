
vlib work
vlog part2.sv

vsim part2

log {/*}
add wave {/*}


# expected ALUout = 00000011
force {Function} 2'b00
force {A} 4'b0001
force {B} 4'b0010
run 10ns

force {Function} 2'b01
force {A} 4'b0001
force {B} 4'b0001
run 10ns

force {Function} 2'b10
force {A} 4'b0010
force {B} 4'b0001
run 10ns

force {Function} 2'b11
force {A} 4'b0010
force {B} 4'b0100
run 10ns