module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    wire [2 : 0] curr_state = y;
    reg  [2 : 0] next_state;
    
    parameter S1 = 3'd0;
    parameter S2 = 3'd1;
    parameter S3 = 3'd2;
    parameter S4 = 3'd3;
    parameter S5 = 3'd4;
    
    always@(*)
    begin
        case(curr_state)
            S1: next_state = x ? S2 : S1;
            S2: next_state = x ? S5 : S2;
            S3: next_state = x ? S2 : S3;
            S4: next_state = x ? S3 : S2;
            S5: next_state = x ? S5 : S4;
            default: next_state = S1;
        endcase
    end
    
    assign z  = (curr_state == S4) || (curr_state == S5);
    assign Y0 = next_state[0];

endmodule
