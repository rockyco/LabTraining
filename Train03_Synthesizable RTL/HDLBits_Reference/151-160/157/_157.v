module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    reg  [3 : 0] curr_state;
    reg  [3 : 0] next_state;
    
    reg  [1 : 0] S_cnt;
    
    wire [9 : 0] dly_cnt;
    wire dly_ctrl;
    
    wire [3 : 0] dly_val;
    wire dly_val_ctrl;
    wire dly_val_dec;
    
    parameter IDLE    = 4'd0;
    parameter S1      = 4'd1;
    parameter S11     = 4'd2;
    parameter S110    = 4'd3;
    parameter S_shift = 4'd4;
    parameter S_count = 4'd5;
    parameter S_done  = 4'd6;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    always@(posedge clk)
    begin
        if(reset)
            S_cnt <= 2'b00;
        else if(curr_state == S_shift)
            S_cnt <= S_cnt + 1'b1;
        else
            S_cnt <= 2'b00;
    end
    
    always@(*)
    begin
        case(curr_state)
            IDLE   : next_state  = data ? S1      : IDLE;
            S1     : next_state  = data ? S11     : IDLE;
            S11    : next_state  = data ? S11     : S110;
            S110   : next_state  = data ? S_shift : IDLE;
            S_shift: next_state  = ( S_cnt   ==  2'd3  )  ?  S_count : S_shift;
            S_count: next_state  = ((dly_cnt == 10'd999) && (dly_val == 4'd0)) ? S_done : S_count;
            S_done : next_state  = ack ? IDLE : S_done;
            default: next_state  = IDLE;
        endcase
    end
    
    assign dly_val_ctrl = (curr_state == S_shift);
    assign dly_val_dec  = (dly_cnt    == 10'd999) && (dly_cnt != 4'd0);
    assign counting     = (curr_state == S_count);
    assign dly_ctrl     = (curr_state == S_count);
    assign done         = (curr_state == S_done );
    assign count        = dly_val;
    
    cnt_1000 cnt_1000_inst(
        .clk(clk),
        .reset(~dly_ctrl),
        .q(dly_cnt)
    );
    
    shift_4 shift_4_inst(
        .clk(clk),
        .shift_ena(dly_val_ctrl),
        .count_ena(dly_val_dec),
        .data(data),
        .q(dly_val)
    );

endmodule

module cnt_1000 (
    input clk,
    input reset,
    output [9:0] q);
    
    always@(posedge clk)
    begin
        if(reset)
            q <= 10'd0;
        else begin
            if(q == 10'd999)
                q <= 10'd0;
            else
                q <= q + 1'b1;
        end
    end

endmodule

module shift_4 (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    always@(posedge clk) begin
        if(shift_ena)
            q <= {q[2:0], data};
        else if(count_ena) begin
            q <= q - 1'b1;
        end
        else begin
           	q <= q;
        end
    end

endmodule
