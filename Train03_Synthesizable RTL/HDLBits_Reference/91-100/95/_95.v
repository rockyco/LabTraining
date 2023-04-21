module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    reg [7 : 0] in_q1;
    
    always@(posedge clk) begin
        in_q1 <= in;
    end
    
    always@(posedge clk) begin
        pedge <= in & (~in_q1);
    end

endmodule
