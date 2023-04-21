module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    parameter IDLE  = 3'd0; 
    parameter DATA  = 3'd1; 
    parameter CHECK = 3'd2; 
    parameter STOP  = 3'd3; 
    parameter ERROR = 3'd4;
    
    reg [2 : 0] curr_state; 
    reg [2 : 0] next_state;
    reg [3 : 0] cnt;
    reg [7 : 0] out;
    reg check;
    
    wire odd; 
    wire start;  
    
    //transition
    always@(*)
    begin
        start = 0;
        case(curr_state)
            IDLE : begin 
                next_state = in ? IDLE : DATA; 
                start=1; 
            end
            DATA : begin
                next_state = (cnt == 8) ? CHECK : DATA;
            end
            CHECK: begin 
                next_state = in ? STOP : ERROR;
            end
            STOP : begin 
                next_state = in ? IDLE : DATA; 
                start = 1; 
            end
            ERROR: begin
                next_state = in ? IDLE : ERROR;
            end
        endcase
    end
    
    //state
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end
    
    //cnt
    always@(posedge clk)
    begin
        if(reset)
            cnt <= 0;
        else begin
            case(curr_state)
                DATA: cnt <= cnt + 1'b1;
                default: cnt <= 0;
            endcase
        end
    end
    
    //out
    always@(posedge clk)
    begin
        if(reset)
            out <= 8'd0;
        else begin
            case(next_state)
                DATA: out <= {in, out[7 : 1]};
            endcase
        end
    end
    
    //check
    always@(posedge clk)
    begin
        if(reset)
            check <= 1'b0;
        else
            check <= odd;
    end
    
    assign out_byte = out;
    assign done = check & (curr_state == STOP);
    
    parity parity_inst(
        .clk(clk),
        .reset(reset | start),
        .in(in),
        .odd(odd));  
    
endmodule
