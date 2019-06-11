/*

	Bin2BCD.v: Convert binary to 4 BCDs
	
	ref: http://alex9ufoexploer.blogspot.com/2013/12/binary-to-bcd-conversion-algorithm.html
*/

module BIN2BCD(
	input [15:0] binary,
	output reg [3:0] BCD3,
	output reg [3:0] BCD2,
	output reg [3:0] BCD1,
	output reg [3:0] BCD0
	);
	
	integer i;
	always@(binary)
	begin
		BCD3 = 4'd0;
		BCD2 = 4'd0;
		BCD1 = 4'd0;
		BCD0 = 4'd0;
		for (i=14; i>=0; i=i-1)
		begin
			if (BCD3>=4'd5)
				BCD3 = BCD3 + 4'd3;
			if (BCD2>=4'd5)
				BCD2 = BCD2 + 4'd3;
			if (BCD1>=4'd5)
				BCD1 = BCD1 + 4'd3;
			if (BCD0>=4'd5)
				BCD0 = BCD0 + 4'd3;
				
			BCD3 = BCD3 << 1;
			BCD3[0] = BCD2[3];
			BCD2 = BCD2 << 1;
			BCD2[0] = BCD1[3];
			BCD1 = BCD1 << 1;
			BCD1[0] = BCD0[3];
			BCD0 = BCD0 << 1;
			BCD0[0] = binary[i];
		end
	end

endmodule
			
			