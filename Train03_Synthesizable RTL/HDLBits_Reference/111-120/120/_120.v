// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    reg curr_state;
    reg next_state;
    
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= B;
        else
            curr_state <= next_state;
    end
    
    always@(*)
    begin
        case(curr_state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
        endcase
    end
    
    always@(*)
    begin
        case(curr_state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
