module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    wire [6 : 1] curr_state = y;
    reg  [6 : 1] next_state;
    
    parameter A = 1;
    parameter B = 2;
    parameter C = 3;
    parameter D = 4;
    parameter E = 5;
    parameter F = 6;
    
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
    
    assign Y2 = next_state[B];
    assign Y4 = next_state[D];

endmodule
