module full_adder (input x, y, cin,
			  output logic s, c
	);
	
	assign s = x^y^cin;
	assign c = (x&y)|(y&cin)|(cin&x);

			  
endmodule

module half_adder (input x, y,
			  output logic s, c
			  );
	assign s = x | y;
	assign c = x & y;
endmodule


module four_bit_cla(
						input [3:0] x,
						input [3:0] y,
						input cin,
						output logic [3:0] s,
						output logic pOut,
						output logic gOut
						);
	logic p3, p2, p1, p0, g3, g2, g1, g0, c3, c2, c1;
	
	bit_cla cla0(.a(x[0]), .b(y[0]), .c(cin), .s(s[0]), .p(p0), .g(g0));
	assign c1 = (cin & p0) | g0;
	
	bit_cla cla1(.a(x[1]), .b(y[1]), .c(c1), .s(s[1]), .p(p1), .g(g1));
	assign c2 = (cin & p0 & p1) | (g0 & p1) | g1;
	
	bit_cla cla2(.a(x[2]), .b(y[2]), .c(c2), .s(s[2]), .p(p2), .g(g2));
	assign c3 = (cin & p0 & p1 & p2) | (g0 & p1 & p2) | (g1 & p2) | g2;
	
	bit_cla cla3(.a(x[3]), .b(y[3]), .c(c3), .s(s[3]), .p(p3), .g(g3));
	assign pOut = p3 & p2 & p1 & p0;
	assign gOut = (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;
	
endmodule

module bit_cla(
					input a,
					input b,
					input c,
					output logic s,
					output logic p,
					output logic g
					);
	assign s = a ^ b ^ c;
	assign p = a ^ b;
	assign g = a & b;
	
endmodule