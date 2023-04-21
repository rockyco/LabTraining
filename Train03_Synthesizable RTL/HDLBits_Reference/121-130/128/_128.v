module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT  = 1'b0; 
    parameter RIGHT = 1'b1;
    
    reg curr_state; 
    reg next_state;
    
    always @(*)
    begin
        case(curr_state)
            LEFT:  next_state = bump_left  ? RIGHT : LEFT;
            RIGHT: next_state = bump_right ? LEFT  : RIGHT;
        endcase// State transition logic
    end
    
    always @(posedge clk or posedge areset) 
    begin
        if(areset) 
            curr_state <= LEFT;
        else 
            curr_state <= next_state;// State flip-flops with asynchronous reset
    end
    
    assign walk_left  = (curr_state == LEFT);
    assign walk_right = (curr_state == RIGHT);

endmodule
