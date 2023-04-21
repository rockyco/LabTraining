module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always@(*)
    begin
        if(clock)
            p = a;
    end
    
    always@(negedge clock)
        q <= a;

endmodule
