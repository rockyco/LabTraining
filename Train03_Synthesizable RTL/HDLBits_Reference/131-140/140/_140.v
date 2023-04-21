module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter S0 = 0; 
    parameter S1 = 1; 
    parameter S2 = 2;
    
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    
	always @(*) 
    begin
        case(curr_state)
			S0 : begin
			next_state = x ? S1 : S0;
			z = 1'b0;
			end
			S1 : begin
			next_state = x ? S2 : S1;
			z = 1'b1;
			end
			S2 : begin
			next_state = x ? S2 : S1;
			z = 1'b0;
			end
			default : begin
			next_state = S0;
			z = 1'b0;
			end
		endcase
	end
	always @(posedge clk or posedge areset)
		if(areset)
			curr_state <= S0;
		else
			curr_state <= next_state;


endmodule
