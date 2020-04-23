module TCGenerator(input logic [3:0] in,
						 output logic [3:0] out);
		logic [3:0] temp;
		 always_comb begin
			temp = !in;
			out = temp + 1;
		 end
		 
endmodule
