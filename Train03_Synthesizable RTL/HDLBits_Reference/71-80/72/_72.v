module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3 : 0] temp;
    
    assign cout = temp[3];
    
    bcd_fadd ADD0(
        .a(a[3 : 0]),
        .b(b[3 : 0]),
        .cin(cin),
        .cout(temp[0]),
        .sum(sum[3 : 0])
    );
    
    bcd_fadd ADD1(
        .a(a[7 : 4]),
        .b(b[7 : 4]),
        .cin( temp[0]),
        .cout(temp[1]),
        .sum(sum[7 : 4])
    );
    
    bcd_fadd ADD2(
        .a(a[11 : 8]),
        .b(b[11 : 8]),
        .cin( temp[1]),
        .cout(temp[2]),
        .sum(sum[11 : 8])
    );
    
    bcd_fadd ADD3(
        .a(a[15 : 12]),
        .b(b[15 : 12]),
        .cin( temp[2]),
        .cout(temp[3]),
        .sum(sum[15 : 12])
    );

endmodule
