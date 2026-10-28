module subrot (input logic loadn, D, LoadLeft, right, left, clock, reset, output logic Q);
    logic Din;
    logic load1;
    always_comb begin
        if (LoadLeft)
            load1 = left;
        else
            load1 = right;
        if (!loadn)
            Din = D;
        else
            Din = load1;
    end

    always_ff@(posedge clock)
        if (reset)
            Q<=1'b0;
        else
            Q<=Din;
endmodule

module part1 (input logic [3:0] Data_IN, input logic ASRight, RotateRight, ParallelLoadn, clock, reset, output logic [3:0] Q);
    logic Q_3_L;
    always_comb begin
        if (ASRight)
            Q_3_L = Q[3];
        else
            Q_3_L = Q[0];
    end
    subrot s0 (ParallelLoadn, Data_IN[0], RotateRight, Q[3], Q[1], clock, reset, Q[0]);
    subrot s1 (ParallelLoadn, Data_IN[1], RotateRight, Q[0], Q[2], clock, reset, Q[1]);
    subrot s2 (ParallelLoadn, Data_IN[2], RotateRight, Q[1], Q[3], clock, reset, Q[2]);
    subrot s3 (ParallelLoadn, Data_IN[3], RotateRight, Q[2], Q_3_L, clock, reset, Q[3]);
endmodule