module RateDivider
#(parameter CLOCK_FREQUENCY=500)(
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable
);

logic [$clog2(4*CLOCK_FREQUENCY)-1:0] count_max;
logic [$clog2(4*CLOCK_FREQUENCY)-1:0] count_in;
logic [$clog2(4*CLOCK_FREQUENCY)-1:0] count_out;

always_comb begin
    case (Speed)
        2'b00: count_max = '0;
        2'b01: count_max = CLOCK_FREQUENCY -1;
        2'b10: count_max = CLOCK_FREQUENCY*2 -1;
        2'b11: count_max = CLOCK_FREQUENCY*4 -1;
    endcase
end
always_comb begin
    if (Enable)
        count_in = count_max;
    else
        count_in = count_out -1;
end

always_ff@(posedge ClockIn) begin
    if (Reset)
        count_out <= count_max;
    else
        count_out <= count_in;

end

assign Enable = &(~count_out);


endmodule

module DisplayCounter (
    input logic Clock,
    input logic Reset,
    input logic EnableDC,
    output logic [3:0] CounterValue
);
logic add_in;
logic [3:0] counter_in;
always_comb begin
    if (EnableDC)
        add_in = 1;
    else
        add_in = 0;
end
assign counter_in = CounterValue + add_in;
always_ff@(posedge Clock) begin
    if (Reset)
        CounterValue <= 4'b0;
    else
        CounterValue <= counter_in;
    
end

endmodule

module part2
#(parameter CLOCK_FREQUENCY=500)(
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic [3:0] CounterValue
);
logic Enable;
RateDivider #(CLOCK_FREQUENCY) r1 (ClockIn, Reset, Speed, Enable);
DisplayCounter d1 (ClockIn, Reset, Enable, CounterValue);

endmodule
