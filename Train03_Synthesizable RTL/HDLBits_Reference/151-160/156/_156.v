module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg [3 : 0] curr_state;
    reg [3 : 0] next_state;
    
    reg [1 : 0] cnt;
    
    parameter IDLE    = 4'd0;
    parameter S1      = 4'd1;
    parameter S11     = 4'd2;
    parameter S110    = 4'd3;
    parameter S1101   = 4'd4;
    parameter S_shift = 4'd5;
    parameter S_count = 4'd6;
    parameter S_done  = 4'd7;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    always@(posedge clk)
    begin
        if(reset) begin
            cnt <= 2'd0;
        end
        else begin
            if(curr_state == S_shift)
                cnt <= cnt + 1'b1;
            else
                cnt <= cnt;
        end 
    end
    
    always@(*)
    begin
        case(curr_state)
            IDLE    : next_state = data ? S1      : IDLE;
            S1      : next_state = data ? S11     : IDLE;
            S11     : next_state = data ? S11     : S110;
            S110    : next_state = data ? S_shift : IDLE;
            //S1101   : next_state = S_shift;
            S_shift : next_state = (cnt == 2'b11) ? S_count : S_shift;
            S_count : next_state = done_counting  ? S_done  : S_count;
            S_done  : next_state = ack ? IDLE : S_done;
            default : next_state = IDLE;
        endcase
    end
    
    assign shift_ena = (curr_state == S_shift);
    assign counting  = (curr_state == S_count);
    assign done      = (curr_state == S_done );

endmodule
