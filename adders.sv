module full_adder (input x, y, cin,
			  output logic s, c
	);
	
	assign s = x^y^cin;
	assign c = (x&y)|(y&cin)|(cin&x);

			  
endmodule

module half_adder (input x, y,
			  output logic s, c
			  );
	assign s = x ^ y;
	assign c = x & y;
endmodule

module carry_lookahead_adder32
(	input logic[31:0] A,
	input logic[31:0] B,
	output logic[31:0] Sum,
	output logic C0);

	logic P7, P6, P5, P4, P3, P2, P1, P0, G7, G6, G5, G4, G3, G2, G1, G0, C7, C6, C5, C4, C3, C2, C1;

	four_bit_cla CLA0(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(Sum[3:0]), .pOut(P0), .gOut(G0));
	assign C1 = G0;
	
	four_bit_cla CLA1(.x(A[7:4]), .y(B[7:4]), .cin(C1), .s(Sum[7:4]), .pOut(P1), .gOut(G1));
	assign C2 = (G0 & P1) | G1;
	
	four_bit_cla CLA2(.x(A[11:8]), .y(B[11:8]), .cin(C2), .s(Sum[11:8]), .pOut(P2), .gOut(G2));
	assign C3 = (G0 & P1 & P2) | (G1 & P2) | G2;
	
	four_bit_cla CLA3(.x(A[15:12]), .y(B[15:12]), .cin(C3), .s(Sum[15:12]), .pOut(P3), .gOut(G3));
	assign C4 = (G0 & P1 & P2 & P3) | (G1 & P2 & P3) | (G2 & P3) | G3;

	four_bit_cla CLA4(.x(A[19:16]), .y(B[19:16]), .cin(C4), .s(Sum[19:16]), .pOut(P4), .gOut(G4));
	assign C5 = (G0 & P1 & P2 & P3 & P4) | (G1 & P2 & P3 & P4) | (G2 & P3 & P4) | (G3 & P4) | G4;

	four_bit_cla CLA5(.x(A[23:20]), .y(B[23:20]), .cin(C5), .s(Sum[23:20]), .pOut(P5), .gOut(G5));
	assign C6 = (G0 & P1 & P2 & P3 & P4 & P5) | (G1 & P2 & P3 & P4 & P5) | (G2 & P3 & P4 & P5) | (G3 & P4 & P5) | (G4 & P5) | G5;

	four_bit_cla CLA6(.x(A[27:24]), .y(B[27:24]), .cin(C6), .s(Sum[27:24]), .pOut(P6), .gOut(G6));
	assign C7 = (G0 & P1 & P2 & P3 & P4 & P5 & P6) | (G1 & P2 & P3 & P4 & P5 & P6) | (G2 & P3 & P4 & P5 & P6) | (G3 & P4 & P5 & P6) | (G4 & P5 & P6) | (G5 & P6) | G6;

	four_bit_cla CLA7(.x(A[31:28]), .y(B[31:28]), .cin(C7), .s(Sum[31:28]), .pOut(P7), .gOut(G7));
	assign C0 = (G0 & P1 & P2 & P3 & P4 & P5 & P6 & P7) | (G1 & P2 & P3 & P4 & P5 & P6 & P7) | (G2 & P3 & P4 & P5 & P6 & P7) | (G3 & P4 & P5 & P6 & P7) 
			| (G4 & P5 & P6 & P7) | (G5 & P6 & P7) | (G6 & P7) | G7;

endmodule

module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

	  logic P3, P2, P1, P0, G3, G2, G1, G0, C3, C2, C1;
	  
	  four_bit_cla CLA0(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(Sum[3:0]), .pOut(P0), .gOut(G0));
	  assign C1 = G0;
	  
	  four_bit_cla CLA1(.x(A[7:4]), .y(B[7:4]), .cin(C1), .s(Sum[7:4]), .pOut(P1), .gOut(G1));
	  assign C2 = (G0 & P1) | G1;
	  
	  four_bit_cla CLA2(.x(A[11:8]), .y(B[11:8]), .cin(C2), .s(Sum[11:8]), .pOut(P2), .gOut(G2));
	  assign C3 = (G0 & P1 & P2) | (G1 & P2) | G2;
	  
	  four_bit_cla CLA3(.x(A[15:12]), .y(B[15:12]), .cin(C3), .s(Sum[15:12]), .pOut(P3), .gOut(G3));
	  assign CO = (G0 & P1 & P2 & P3) | (G1 & P2 & P3) | (G2 & P3) | G3;
	   
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