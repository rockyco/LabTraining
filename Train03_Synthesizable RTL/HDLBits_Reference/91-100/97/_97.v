module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg  [31 : 0] in_q1;
    wire [31 : 0] pos_edge;
    
    assign pos_edge = in_q1 & ~in;
    
    always@(posedge clk) begin
        in_q1 <= in;
    end
    
    integer i;
    
    always@(posedge clk) begin
        if(reset)
            out <= 32'd0;
        else begin
            for(i = 0; i < 32; i = i + 1) begin
                if(pos_edge[i] == 1'b1)
                    out[i] = 1'b1;
                else
                    out[i] = out[i];
            end
        end
    end

endmodule
