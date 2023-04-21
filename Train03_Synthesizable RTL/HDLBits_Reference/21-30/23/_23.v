module top_module ( input clk, input d, output q );
    
    wire d_q1;
    wire d_q2;
    
    my_dff DFF0(
        .clk(clk),
        .d(d),
        .q(d_q1)
    );
    
    my_dff DFF1(
        .clk(clk),
        .d(d_q1),
        .q(d_q2)
    );
    
    my_dff DFF2(
        .clk(clk),
        .d(d_q2),
        .q(q)
    );

endmodule
