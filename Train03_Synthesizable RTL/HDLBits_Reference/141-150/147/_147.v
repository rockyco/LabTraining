module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    reg  [6 : 1] curr_state;
    reg  [6 : 1] next_state;
    
    parameter A = 1;
    parameter B = 2;
    parameter C = 3;
    parameter D = 4;
    parameter E = 5;
    parameter F = 6;
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state    <= A;
        else
            curr_state    <= next_state;
    end
    
    always@(*)
    begin
        next_state[A] = (curr_state[A] &  w) || (curr_state[D] &  w);
        next_state[B] = (curr_state[A] & ~w);
        next_state[C] = (curr_state[B] & ~w) || (curr_state[F] & ~w);
        next_state[D] = (curr_state[B] &  w) || (curr_state[C] &  w)
       				 || (curr_state[E] &  w) || (curr_state[F] &  w);
        next_state[E] = (curr_state[C] & ~w) || (curr_state[E] & ~w);
        next_state[F] = (curr_state[D] & ~w);
    end
    
    assign z = curr_state[E] | curr_state[F];

endmodule
