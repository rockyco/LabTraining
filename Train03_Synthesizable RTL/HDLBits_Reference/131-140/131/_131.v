module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter WL = 3'd0;
    parameter WR = 3'd1;
    parameter FL = 3'd2;
    parameter FR = 3'd3;
    parameter DL = 3'd4;
    parameter DR = 3'd5;
    parameter splat = 3'd6;
    
    reg [2 : 0] curr_state;
    reg [2 : 0] next_state;
    
    reg [31 : 0] cnt;
    
    //state transtition logic
    always@(*)
    begin
        case(curr_state)
            WL: next_state = ground ? (dig ? DL : (bump_left  ? WR : WL)) : FL;
            WR: next_state = ground ? (dig ? DR : (bump_right ? WL : WR)) : FR;
            FL: next_state = ground ? (cnt > 19 ?  splat : WL) : FL;
            FR: next_state = ground ? (cnt > 19 ?  splat : WR) : FR;
            DL: next_state = ground ?  DL : FL;
            DR: next_state = ground ?  DR : FR;
            splat: next_state = splat;
        endcase
    end
    
    always@(posedge clk or posedge areset)
    begin
        if(areset) 
            curr_state <= WL;
    	else 
            curr_state <= next_state;
    end
    
    always@(posedge clk or posedge areset)
    begin
        if(areset)
            cnt <= 'd0;
        else begin
            if(curr_state == FL || curr_state == FR)
                cnt <= cnt + 1'b1;
            else
                cnt <= 'd0;
        end
    end
    
    always@(*)
    begin
        case(curr_state) 
            WL: {walk_left, walk_right, aaah, digging} = 4'b1000;
            WR: {walk_left, walk_right, aaah, digging} = 4'b0100;
            FL: {walk_left, walk_right, aaah, digging} = 4'b0010;
            FR: {walk_left, walk_right, aaah, digging} = 4'b0010;
            DL: {walk_left, walk_right, aaah, digging} = 4'b0001;
            DR: {walk_left, walk_right, aaah, digging} = 4'b0001;    
            splat: {walk_left, walk_right, aaah, digging} = 4'b0000;
        endcase
    end

endmodule
