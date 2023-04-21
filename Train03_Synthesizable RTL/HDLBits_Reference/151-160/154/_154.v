module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    reg [2 : 0] curr_state;
    reg [2 : 0] next_state;
    
    parameter IDLE  = 3'd0;
    parameter S1    = 3'd1;
    parameter S11   = 3'd2;
    parameter S110  = 3'd3;
    parameter S1101 = 3'd4;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    always@(*)
    begin
        case(curr_state)
            IDLE  : next_state = data ? S1: IDLE;
            S1    : next_state = data ? S11 : IDLE;
            S11   : next_state = data ? S11 : S110;
            S110  : next_state = data ? S1101 : S1;
            S1101 : next_state = S1101;
        endcase
    end
    
    always@(*)
    begin
        if(curr_state == S1101)
            start_shifting = 1'b1;
        else
            start_shifting = 1'b0;
    end

endmodule
