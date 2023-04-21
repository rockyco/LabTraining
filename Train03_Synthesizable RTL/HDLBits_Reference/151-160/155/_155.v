module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    reg [2 : 0] curr_state;
    reg [2 : 0] next_state;
    
    parameter S0   = 3'd0;
    parameter S1   = 3'd1;
    parameter S2   = 3'd2;
    parameter S3   = 3'd3;
    parameter S4   = 3'd4;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= S0;
        else
            curr_state <= next_state;
    end
    
    always@(*)
    begin
        case(curr_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S4;
        endcase
    end
    
    always@(*)
    begin
        case(curr_state)
            S0: shift_ena = 1'b1;
            S1: shift_ena = 1'b1;
            S2: shift_ena = 1'b1;
            S3: shift_ena = 1'b1;
            S4: shift_ena = 1'b0;
        endcase
    end
        

endmodule
