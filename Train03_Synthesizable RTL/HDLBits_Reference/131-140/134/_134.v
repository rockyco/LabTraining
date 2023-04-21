module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    parameter D = 2'd3;

    // State transition logic (combinational)
    always@(*)
        case(curr_state)
            A: next_state = in[3] ? B : A;
            B: next_state = C;
            C: next_state = D;
            D: next_state = in[3] ? B : A;
        endcase

    // State flip-flops (sequential)
    always@(posedge clk)
        if(reset)
            curr_state <= A;
    	else
            curr_state <= next_state;
 
    // Output logic
    assign done = (curr_state == D);
    
    always@(posedge clk)
    begin
        case(curr_state)
            A: out_bytes[23:16] <= in;
            B: out_bytes[15: 8] <= in;
            C: out_bytes[ 7: 0] <= in;
            D: out_bytes[23:16] <= in;
        endcase
    end

endmodule
