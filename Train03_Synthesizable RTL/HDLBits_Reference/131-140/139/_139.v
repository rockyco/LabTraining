module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
    parameter START = 2'd0;
    parameter MID   = 2'd1;
    parameter END   = 2'd2;
    
    always@(posedge clk or negedge aresetn)
    begin
        if(~aresetn)
            curr_state <= START;
        else
            curr_state <= next_state;
    end
    
    always@(*)
    begin
        case(curr_state)
            START: next_state = x ? MID : START;
            MID  : next_state = x ? MID : END  ;
            END  : next_state = x ? MID : START;
            default: next_state = START;
        endcase
    end
    
    assign z = (curr_state == END) ? x : 1'b0;

endmodule
