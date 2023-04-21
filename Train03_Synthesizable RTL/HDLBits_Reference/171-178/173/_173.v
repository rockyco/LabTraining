module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always@(posedge clk)begin
        if(a == b)begin
        	state <= a;
        end
        else begin
            state <= state;
        end
    end
    
    always@(*)begin
        q = a & ~b & ~state | ~a & ~b & state | a & b & state | ~a & b & ~state;
    end

endmodule
