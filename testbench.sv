module testbench();
timeunit 10ns;
timeprecision 1ns;

logic Clk, Reset, Run, ClearA_LoadB;
logic [31:0] result;
logic [31:0] result1;
logic [31:0] result2;
logic [15:0] MUR;
logic [15:0] MUD;
logic [31:0] z1, z2;

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
	MUR = 16'b0011001100110011;
	MUD = 16'b0000000000110000;
	
#20 ;
	
end
endmodule