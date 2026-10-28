
vlib work
vlog prelab3.sv

vsim part3

log {/*}
add wave {/*}

force {Clock} 0 0ns, 1 5ns -repeat 10ns

force {Reset_b} 1
force {Data} 4'b0000
force {Function} 3'b000
run 10ns

force {Reset_b} 0
force {Data} 4'b0001
force {Function} 3'b000
run 10ns

