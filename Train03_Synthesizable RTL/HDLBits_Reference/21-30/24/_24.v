module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire [7 : 0] d_q1;
    wire [7 : 0] d_q2;
    wire [7 : 0] d_q3;
    
    my_dff8 DFF0(
        .clk(clk),
        .d(d),
        .q(d_q1)
    );
    
    my_dff8 DFF1(
        .clk(clk),
        .d(d_q1),
        .q(d_q2)
    );
    
    my_dff8 DFF2(
        .clk(clk),
        .d(d_q2),
        .q(d_q3)
    );
    
    always@(*) begin
        case(sel)
            2'b00: q = d;
            2'b01: q = d_q1;
            2'b10: q = d_q2;
            2'b11: q = d_q3;
            default: q = 8'd0;
        endcase
    end

endmodule
