module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    assign cout[0] = (a[0] & b[0]) | (a[0] & cin) | (b[0] & cin);
    assign sum[0]  = a[0] ^ b[0] ^ cin;
    
    integer i;
    always@(*) begin
        for(i = 1; i < 100; i = i + 1) begin
            sum[i]  = a[i] ^ b[i] ^ cout[i-1];
            cout[i] = (a[i] & b[i]) | (a[i] & cout[i-1]) | (b[i] & cout[i-1]);
        end
    end

endmodule
