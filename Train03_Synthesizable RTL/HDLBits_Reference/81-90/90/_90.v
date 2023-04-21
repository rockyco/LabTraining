module top_module (
    input clk,
    input in, 
    output out);
    
    always@(posedge clk)
        out <= in ^ out;

endmodule
