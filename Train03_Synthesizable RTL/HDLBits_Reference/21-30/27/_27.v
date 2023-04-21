module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire carry;
    wire [15 : 0] temp_a;
    wire [15 : 0] temp_b;
    
    assign sum[31 : 16] = carry ? temp_b : temp_a;
    
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
        .cin(1'b0),
        .sum(temp_a),
        .cout()
    );
    
    add16 ADD2(
        .a(a[31 : 16]),
        .b(b[31 : 16]),
        .cin(1'b1),
        .sum(temp_b),
        .cout()
    );

endmodule
