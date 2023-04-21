module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire carry;
    wire [31 : 0] b_temp;
    
    assign b_temp = b ^ {32{sub}};
    
    add16 ADD0(
        .a(a[15 : 0]),
        .b(b_temp[15 : 0]),
        .cin(sub),
        .sum(sum[15 : 0]),
        .cout(carry)
    );
    
    add16 ADD1(
        .a(a[31 : 16]),
        .b(b_temp[31 : 16]),
        .cin(carry),
        .sum(sum[31 : 16]),
        .cout()
    );

endmodule
