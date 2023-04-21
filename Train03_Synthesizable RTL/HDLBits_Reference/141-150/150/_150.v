module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    reg [3 : 0] curr_state;
    reg [3 : 0] next_state;
    
    parameter A = 0;
    parameter B = 1;
    parameter C = 2;
    parameter D = 3;
    
    always@(posedge clk)
    begin
        if(~resetn)
            curr_state <= 4'd1;
        else
            curr_state <= next_state;
    end
    
    always@(*)
    begin
        next_state[A] = (curr_state[A] & ~r[1] & ~r[2] & ~r[3]) ||(curr_state[B] & ~r[1]) || (curr_state[C] & ~r[2]) || (curr_state[D] & ~r[3]);
        next_state[B] = (curr_state[A] &  r[1]) || (curr_state[B] &  r[1]);
        next_state[C] = (curr_state[A] &  ~r[1] &  r[2]) || (curr_state[C] &  r[2]);
        next_state[D] = (curr_state[A] &  ~r[1] & ~r[2] & r[3]) || (curr_state[D] &  r[3]);
    end
    
    assign g = curr_state[3 : 1];

endmodule
