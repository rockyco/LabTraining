module top_module ();
    
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        t = 1'b0;
        #40
        reset = 1'b0;
        t = 1'b1;
    end
    
    always begin
        #5 clk = ~clk;
    end
    
    tff TFF(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

endmodule
