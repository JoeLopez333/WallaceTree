module testbench();
timeunit 10ns;
timeprecision 1ns;
logic Clk;
logic [31:0] result;
logic [15:0] MUR;
logic [15:0] MUD;
integer error;

WallaceTree wtree(.*);

always begin : CLOCK_GEN
#1 Clk = ~Clk;
end

initial begin : CLOCK_INIT
	Clk = 0;
end

initial begin : TEST
	//Reset = 1;
	//Run = 0;
	//ClearA_LoadB = 1;
	error = 0;
	for (int i = 0; i < 128; i++)
		for (int j = 0; j < 128; j++)
		begin
			MUR <= i;
			MUD <= j;
			if (result != MUR*MUD)
				error = error+1;
				
		end
			
			
//MUR = 16'b1011001100110011;
//MUD = 16'b0000000000110000;

	
#20 ;
#21 $display("error = %d", error);
	
end
endmodule