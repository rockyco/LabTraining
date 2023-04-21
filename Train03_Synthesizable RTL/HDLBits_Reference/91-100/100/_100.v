module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
    always@(posedge clk)
    begin
        if(reset)
            q <= 4'd0;
        else begin
            if(q == 4'd9)
                q <= 4'd0;
            else
                q <= q + 1'b1;
        end
    end

endmodule
