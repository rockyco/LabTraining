module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [399:0] cout_temp;
    genvar i;

    bcd_fadd inst1_bcd_fadd (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(cout_temp[0]),
        .sum(sum[3:0])
    );

    generate
        for(i=4; i<400; i=i+4)
            begin: bcd
                bcd_fadd inst_bcd_fadd(
                    .a(a[i+3:i]), 
                    .b(b[i+3:i]), 
                    .cin(cout_temp[i-4]), //上次计算输出的cout
                    .cout(cout_temp[i]), //本次计算输出的cout，在下次计算中变为cin
                    .sum(sum[i+3:i])
                );
            end
    endgenerate 

    assign cout = cout_temp[396]; 

endmodule
