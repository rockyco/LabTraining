module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    parameter A = 0;
    parameter B = 1;
    
    always@(posedge clk or posedge areset)
    begin
        if(areset)
            curr_state[A] = 1'b1;
        else
            curr_state   <= next_state;
    end
    
    always@(*)
    begin
        next_state[A] = curr_state[A] & ~x;
        next_state[B] = curr_state[A] &  x || curr_state[B];
    end
    
    assign z = curr_state[A] ? x : ~x;

endmodule
