module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3 : 0] in_q;
    
    assign out = in_q[3];
    
    always@(posedge clk)
    begin
        if(!resetn)
            in_q <= 4'd0;
        else
            in_q <= {in_q[3 : 1], in};
    end

endmodule
