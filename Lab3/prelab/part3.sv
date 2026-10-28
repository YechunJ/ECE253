module part3(input logic Clock, Reset_b, input logic [3:0] Data, input logic
[2:0] Function, output logic [7:0] ALU_reg_out);
    logic [7:0] ALUout;
    logic [3:0] B;
    assign B = ALU_reg_out[3:0];
    always_comb begin
        case (Function)
            3'b000: ALUout = {4'b0, Data} + {4'b0, B};
            3'b001: ALUout = {4'b0, Data} * {4'b0, B};
            3'b010: ALUout = {4'b0, B} << Data;
            3'b011: ALUout = ALU_reg_out;
            default: ALUout = 8'b0;
        endcase
    end
    always_ff@(posedge Clock)
        if (Reset_b)
            ALU_reg_out<=8'b0;
        else
            ALU_reg_out <= ALUout;
endmodule
