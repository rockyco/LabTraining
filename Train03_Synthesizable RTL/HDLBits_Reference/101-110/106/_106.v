module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    always@(posedge clk)
    begin
        if(reset) begin
            pm <= 1'b0;
        end
        else begin
            if(ena && (hh == 8'h11) && (mm == 8'h59) && (ss == 8'h59)) begin
                pm <= ~pm;
            end
            else begin
                pm <= pm;
            end
        end
    end
    
    always@(posedge clk)
    begin
        if(reset) begin
            hh <= 8'h12;
        end
        else begin
            if(ena && (hh == 8'h12) && (mm == 8'h59) && (ss == 8'h59)) begin
                hh <= 8'h1;
            end
            else if(ena && (hh == 8'h9) && (mm == 8'h59) && (ss == 8'h59)) begin
                hh <= 8'h10;
            end
            else if(ena && (mm == 8'h59) && (ss == 8'h59)) begin
                hh[3 : 0] <= hh[3 : 0] + 1'b1;
            end
            else begin
                hh <= hh;
            end
        end
    end
    
    always@(posedge clk)
    begin
        if(reset) begin
            mm <= 8'h00;
        end
        else if(ena && (ss == 8'h59)) begin
            if(mm ==8'h59) begin
                mm <= 8'h00;
            end
            else if(mm[3 : 0] < 4'h9) begin
                mm[3 : 0] <= mm[3 : 0] + 1'b1;
            end
            else if(mm[3 : 0] == 4'h9) begin
                mm[3 : 0] <= 4'h0;
                mm[7 : 4] <= mm[7 : 4] + 1'b1;
            end
            else begin
                mm <= mm;
            end
        end
        else begin
            mm <= mm;
        end
    end
    
    always@(posedge clk)
    begin
        if(reset) begin
            ss <= 8'h00;
        end
        else if(ena) begin
            if(ss ==8'h59) begin
                ss <= 8'h00;
            end
            else if(ss[3 : 0] < 4'h9) begin
                ss[3 : 0] <= ss[3 : 0] + 1'b1;
            end
            else if(ss[3 : 0] == 4'h9) begin
                ss[3 : 0] <= 4'h0;
                ss[7 : 4] <= ss[7 : 4] + 1'b1;
            end
            else begin
                ss <= ss;
            end
        end
        else begin
            ss <= ss;
        end
    end

endmodule
