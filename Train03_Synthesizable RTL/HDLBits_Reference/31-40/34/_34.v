// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    always@(*) begin
        casez(in)
            4'bZZZ1: pos = 2'd0;
            4'bZZ1Z: pos = 2'd1;
            4'bZ1ZZ: pos = 2'd2;
            4'b1ZZZ: pos = 2'd3;
            default: pos = 2'd0;
        endcase
    end

endmodule
