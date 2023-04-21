module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    
    wire carry;
    
    add16 ADD0(
        .a(a[15 : 0]),
        .b(b[15 : 0]),
        .cin(1'b0),
        .sum(sum[15 : 0]),
        .cout(carry)
    );
    
    add16 ADD1(
        .a(a[31 : 16]),
        .b(b[31 : 16]),
        .cin(carry),
        .sum(sum[31 : 16]),
        .cout()
    );

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
