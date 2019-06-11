
module CLK_1KHZ(
		input clk_in, //50Mhz
		output reg clk_out
	);
	
	
	reg [14:0] clk_count; 
	
	
	// initial
	initial
	begin
		clk_count = 0;
		clk_out = 0;
	end	

	
	// clock counts
	always @ (posedge clk_in)
	begin 
		clk_count = clk_count + 1'b1;
		if(clk_count==25000) 
		begin
			clk_count = 0;	
			clk_out = ~clk_out;
		end
	end
endmodule