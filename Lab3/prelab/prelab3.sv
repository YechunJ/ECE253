module FA (input logic a, b, cin, output logic s, cout);
    assign s = a^b^cin;
    assign cout = (a&b) | (b&cin) | (a&cin);
endmodule

module part1(input logic [3:0] a, b, input logic c_in,
output logic [3:0] s, c_out);
    FA f1(a[0], b[0], c_in, s[0], c_out[0]);
    FA f2(a[1], b[1], c_out[0], s[1], c_out[1]);
    FA f3(a[2], b[2], c_out[1], s[2], c_out[2]);
    FA f4(a[3], b[3], c_out[2], s[3], c_out[3]);

endmodule


module part2(input logic [3:0] A, B, input logic [1:0] Function,
output logic [7:0] ALUout);
    logic [7:0] D0;
    logic [7:0] D1;
    logic [7:0] D2;
    logic [7:0] D3;
    logic res_or;
    logic res_and;
    assign D3 = {A,B};
    logic [3:0] RCA_s;
    logic [3:0] RCA_cout;
    part1 RCA(A,B,1'b0,RCA_s, RCA_cout);
    assign res_or = |D3;
    assign res_and = &D3;
    assign D0 = {3'b0, RCA_cout[3], RCA_s};
    assign D1 = {7'b0, res_or};
    assign D2 = {7'b0, res_and};
    always_comb begin
        case (Function)
            2'b00: ALUout = D0;
            2'b01: ALUout = D1;
            2'b10: ALUout = D2;
            2'b11: ALUout = D3;
            default: ALUout = 8'b0;
        endcase
    end
endmodule

module part3(input logic Clock, Reset_b, input logic [3:0] Data, input logic
[2:0] Function, output logic [7:0] ALU_reg_out);
    logic [7:0] ALUout;
    logic [3:0] B;
    assign B = ALU_reg_out[3:0];
    always_comb begin
        case (Function)
            2'b00: ALUout = {4'b0,Data} + {4'b0,B};
            2'b01: ALUout = {4'b0,Data} * {4'b0,B};
            2'b10: ALUout = {4'b0,B} << Data;
            2'b11: ALUout = ALU_reg_out;
            default: ALUout = 8'b0;
        endcase
    end
    always_ff@(posedge Clock)
        if (Reset_b)
            ALU_reg_out<=8'b0;
        else
            ALU_reg_out <= ALUout;
endmodule



