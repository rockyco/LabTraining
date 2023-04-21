module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    parameter WL = 2'b00;
    parameter WR = 2'b01;
    parameter FL = 2'b10;
    parameter FR = 2'b11;
    
    always @(*)
    begin
        case(curr_state)
            WL: next_state = ground ? (bump_left  ? WR : WL): FL;
            WR: next_state = ground ? (bump_right ? WL : WR): FR;
            FL: next_state = ground ?  WL : FL;
            FR: next_state = ground ?  WR : FR;
        endcase
    end
    
    always @(posedge clk or posedge areset)
    begin
        if(areset) 
            curr_state <= WL;
        else 
            curr_state <= next_state;
    end
    
    always @(*)
    begin
        case(curr_state)
            WL: {walk_left, walk_right, aaah} = 3'b100;
            WR: {walk_left, walk_right, aaah} = 3'b010;
            FL: {walk_left, walk_right, aaah} = 3'b001;
            FR: {walk_left, walk_right, aaah} = 3'b001;
        endcase
    end

endmodule
