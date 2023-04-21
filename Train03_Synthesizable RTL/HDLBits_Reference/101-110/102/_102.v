module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always@(posedge clk)
    begin
        if(reset)
            q <= 4'd0;
        else begin
            if(q == 4'd9)
                q <= slowena ? 4'd0 : q;
            else
                q <= slowena ? (q + 1'b1) : q;
        end
    end

endmodule
