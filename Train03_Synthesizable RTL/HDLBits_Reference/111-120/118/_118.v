module top_module(
	input  clk,
	input  load,
	input  [255 : 0] data,
	output [255 : 0] q
);

	reg  [15 : 0] q_d [15  : 0];
	wire [2  : 0] num [255 : 0];
	integer idx_i_up, idx_i_down, idx_j_left, idx_j_right;
	integer i, j;
	
	always@(*)
	begin
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 16; j = j + 1) begin
				idx_i_up    = (i ==  0) ? 15 : i - 1;
				idx_i_down  = (i == 15) ?  0 : i + 1;
				idx_j_left  = (j ==  0) ? 15 : j - 1;
				idx_j_right = (j == 15) ?  0 : j + 1;
				num[i * 16 + j] = q_d[idx_i_up  ][idx_j_left] + q_d[idx_i_up  ][j] + q_d[idx_i_up  ][idx_j_right]
								+ q_d[i         ][idx_j_left] +                    + q_d[i         ][idx_j_right]
								+ q_d[idx_i_down][idx_j_left] + q_d[idx_i_down][j] + q_d[idx_i_down][idx_j_right];
			end
		end
	end
	
	always@(posedge clk)
	begin
		if(load) begin: LOAD
			for(i = 0; i < 16; i = i + 1) begin
				for(j = 0; j < 16; j = j + 1) begin
					q_d[i][j] <= data[i * 16 + j];
				end
			end
		end
		else begin:COMPARE
			for(i = 0; i < 16; i = i + 1) begin
				for(j = 0; j < 16; j = j + 1) begin
					q_d[i][j] <= (num[i * 16 + j]  > 3) ? 1'b0
							  : ((num[i * 16 + j] == 3) ? 1'b1
							  : ((num[i * 16 + j] == 2) ? q_d[i][j]
							  : 1'b0));
				end
			end
		end
	end
	
	always@(*)
	begin
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 16; j = j + 1) begin
				q[i * 16 + j] = q_d[i][j];
			end
		end
	end

endmodule