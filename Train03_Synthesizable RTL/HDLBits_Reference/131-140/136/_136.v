module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    reg [2 : 0] curr_state;
    reg [2 : 0] next_state;
    
    reg [4 : 0] cnt;
    
    parameter IDLE  = 3'd0;
    parameter START = 3'd1;
    parameter DATA  = 3'd2;
    parameter STOP  = 3'd3;
    parameter ERROR = 3'd4;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= IDLE;
    	else
            curr_state <= next_state;
    end
    
    always@(posedge clk)
    begin
        if(curr_state == START)
            cnt <= 4'd0;
        else if(curr_state == DATA)
            cnt <= cnt + 1'b1;
        else
            cnt <= 4'd0;
    end
    
    always@(*)
    begin
        case(curr_state)
            IDLE:  next_state = in ? IDLE : START;
            START: next_state = DATA;
            DATA:  next_state = (cnt == 7) ? (in ? STOP : ERROR) : DATA;
            STOP:  next_state = in ? IDLE : START;
            ERROR: next_state = in ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    always@(posedge clk)
    begin
        if(reset)
            out_byte <= 8'd0;
        else
            case(next_state)
                START: out_byte <= 8'd0;
                DATA : out_byte <= {in,out_byte[7:1]}; //移位寄存器
            endcase
    end
    
    assign done = (curr_state == STOP);
    

endmodule
