module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    reg low;
    
    parameter S1 = 2'b00;
    parameter S2 = 2'b01;
    parameter S3 = 2'b10;
    parameter S4 = 2'b11;
    
    always@(*)
    begin
        case(curr_state)
            S1: next_state =  s[1] ? S2 : S1;
            S2: next_state =  s[2] ? S3 : (~s[1] ? S1 : S2);
            S3: next_state =  s[3] ? S4 : (~s[2] ? S2 : S3);
            S4: next_state = ~s[3] ? S3 : S4;
        endcase
    end
    
    always@(posedge clk)
    begin
        if(reset)
            curr_state <= S1;
        else
            curr_state <= next_state;
    end
    
    always @(posedge clk)begin
        if (reset || curr_state < next_state)
            low <= 1'b0;
        else if (curr_state > next_state)
            low <= 1'b1;
        else
            low <= low;
    end
    
    assign fr3 = (curr_state <= S1) ? 1'b1 : 1'b0;
    assign fr2 = (curr_state <= S2) ? 1'b1 : 1'b0;
    assign fr1 = (curr_state <= S3) ? 1'b1 : 1'b0;
    assign dfr = (curr_state == S1) || low;

endmodule
