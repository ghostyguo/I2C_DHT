module I2C_DHT(
		input clock, //50Mhz
		input SCL,
		inout SDA,		
		inout dht22_sda,	
		input [3:0] sw, 	//switch		
		output [7:0] seg, 
		output [3:0] dig, 
		output reg [3:0] led
	);
               
	// variables of clocks
	wire ck1Mhz;
	wire ck1KHz;	
	CLK_1MHZ  clk_1MHz(clock, ck1Mhz);
	CLK_1KHZ  clk_1KHz(clock, ck1Khz);	
	
	// variables of 7-seg LED	
   wire [3:0] D3;
   wire [3:0] D2;
   wire [3:0] D1;
   wire [3:0] D0;
   wire [15:0] number;  // number to display
	
   BIN2BCD bin2bcd(number, D3, D2, D1, D0);
   Seg7    seg7(seg, dig, ck1Khz, D3, D2, D1, D0);	
	
	
	//DHT22 variables
	reg dht22_reset;
	reg dht22_get;
	reg dht22_select; //1=humidity, 0=temperature 
	wire  [39:0] dht22_data;
	DHT22 dht22(ck1Mhz, dht22_reset, dht22_get, dht22_sda, dht22_data);
	
	assign number[15:0] = dht22_select ? dht22_data[39:24]:dht22_data[23:8];
	
	
	// I2C	
	I2C i2c(clock, SCL, SDA, dht22_data);
	
	// tick
	reg [9:0] tick; 
	
	// initial
	initial
	begin
		dht22_reset = 0;
		dht22_get = 1;
		tick = 0;
		dht22_select = 1;		
		led[3:0]= 4'b1111; //LED off
	end			
	
	// select to show humidity or temperture
	always @ (posedge sw[0])
	begin	
		dht22_select = ~dht22_select;		
	end	
		
	always @ (posedge ck1Khz)
	begin				
		if (dht22_reset==0)
			begin
				//start to read DHT22
				dht22_reset = 1; 
				dht22_get = 0;
			end
			
		led[3] = dht22_get;			
		tick = tick + 1'b1;		
		
		if(tick == 10'd1000)	//1000ms
			begin
				tick = 0;  
				dht22_reset = 0; //reset dht22 status
			end
		if(tick == 10'd10)  //10ms
			begin			
				dht22_get = 1; //raise the read signal
			end			
	end			


endmodule