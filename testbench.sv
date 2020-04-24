module testbench();
timeunit 10ns;
timeprecision 1ns;

logic Clk, Reset, Run, ClearA_LoadB;
logic [31:0] result;
logic [31:0] result1;
logic [31:0] result2;
logic [15:0] MUR;
logic [15:0] MUD;
logic [15:0] test, test2;

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
	MUR = 7'b0001111;
	MUD = 7'b0000111;
	
#20 ;
	
end
endmodule