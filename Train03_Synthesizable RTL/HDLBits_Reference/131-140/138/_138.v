module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    reg [3 : 0] curr_state;
    reg [3 : 0] next_state;
    
    parameter IDLE    = 4'd0;
    parameter S1      = 4'd1;
    parameter S2      = 4'd2;
    parameter S3      = 4'd3;
    parameter S4      = 4'd4;
    parameter S5      = 4'd5;
    parameter S6      = 4'd6;
    parameter ERROR   = 4'd7;
    parameter FLAG    = 4'd8;
    parameter DISCARD = 4'd9;
    
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
            IDLE   : next_state = in ? S1 : IDLE;
            S1     : next_state = in ? S2 : IDLE;
            S2     : next_state = in ? S3 : IDLE;
            S3     : next_state = in ? S4 : IDLE;
            S4     : next_state = in ? S5 : IDLE;
            S5     : next_state = in ? S6 : DISCARD;
            S6     : next_state = in ? ERROR : FLAG;
            ERROR  : next_state = in ? ERROR : IDLE;
            FLAG   : next_state = in ? S1 : IDLE;
            DISCARD: next_state = in ? S1 : IDLE;
        endcase
    end
    
    assign disc = (curr_state == DISCARD);
    assign flag = (curr_state == FLAG   );
    assign err  = (curr_state == ERROR  );

endmodule
