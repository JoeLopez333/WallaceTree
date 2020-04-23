module WallaceTree (input logic Clk, Reset, Run, ClearA_LoadB,
						  input logic [15:0] MUR, MUD, //multiplier and multiplicand
						  output logic [31:0] result,
						  output logic [31:0] result1,
						  output logic [31:0] result2);
						  
		logic [15:0] MURtc;
		logic [15:0] MUDtc;
	   logic m03, m02, m01, m00;
	   logic m13, m12, m11, m10;
		logic m23, m22, m21, m20;
		logic m33, m32, m31, m30;
		wire ha1s, ha1c, ha2s, ha2c, fa1s, fa1c, fa2s, fa2c, fa3s, fa3c, fa4s, fa4c;
		logic[31:0] z1;
		logic[31:0] z2;
		
		logic pp[15:0][15:0]; //partial products

		always_comb begin
			int i, j;
			for (i = 0; i <= 15; i = i+1)
			for (j = 0; j <= 15; j = j+1)
			pp[j][i] <= MUR[j] & MUD[i];
			
		end
						  
//half_adder ha1(.x(pp[2][2]), .y(pp[1][3]), .s(ha1s), .c(ha1c));
//half_adder ha2(.x(pp[1][2]), .y(pp[0][3]), .s(ha2s), .c(ha2c));
//
//full_adder fa1(.x(pp[3][2]), .y(pp[2][3]), .cin(ha1c),     .s(z2[5]), .c(z1[6]));
//full_adder fa2(.x(ha1s),     .y(pp[3][1]), .cin(ha2c),     .s(z2[4]), .c(z1[5]));
//full_adder fa3(.x(ha2s),     .y(pp[3][0]), .cin(pp[2][1]), .s(z2[3]), .c(z1[4]));
//full_adder fa4(.x(pp[1][1]), .y(pp[0][2]), .cin(0),      .s(z2[2]), .c(z1[3]));

wire fas[100:0];
wire has[100:0];
wire fac[100:0];
wire hac[100:0];
wire dot[50:0];

/*stage 1******************/ 
assign dot[0] = pp[0][0];
half_adder ha0( .x(pp[0][1]),  .y(pp[1][0]),  .s(has[0]), .c(hac[0]));
full_adder fa0( .x(pp[0][2]),  .y(pp[1][1]),  .cin(pp[2][0]),  .s(fas[0]),  .c(fac[0]));
full_adder fa1( .x(pp[0][3]),  .y(pp[1][2]),  .cin(pp[2][1]),  .s(fas[1]),  .c(fac[1]));
full_adder fa2( .x(pp[0][4]),  .y(pp[1][3]),  .cin(pp[2][2]),  .s(fas[2]),  .c(fac[2]));
full_adder fa3( .x(pp[0][5]),  .y(pp[1][4]),  .cin(pp[2][3]),  .s(fas[3]),  .c(fac[3]));
full_adder fa4( .x(pp[0][6]),  .y(pp[1][5]),  .cin(pp[2][4]),  .s(fas[4]),  .c(fac[4]));
full_adder fa5( .x(pp[0][7]),  .y(pp[1][6]),  .cin(pp[2][5]),  .s(fas[5]),  .c(fac[5]));
full_adder fa6( .x(pp[0][8]),  .y(pp[1][7]),  .cin(pp[2][6]),  .s(fas[6]),  .c(fac[6]));
full_adder fa7( .x(pp[0][9]),  .y(pp[1][8]),  .cin(pp[2][7]),  .s(fas[7]),  .c(fac[7]));
full_adder fa8( .x(pp[0][10]), .y(pp[1][9]),  .cin(pp[2][8]),  .s(fas[8]),  .c(fac[8]));
full_adder fa9( .x(pp[0][11]), .y(pp[1][10]), .cin(pp[2][9]),  .s(fas[9]),  .c(fac[9]));
full_adder fa10(.x(pp[0][12]), .y(pp[1][11]), .cin(pp[2][10]), .s(fas[10]), .c(fac[10]));
full_adder fa11(.x(pp[0][13]), .y(pp[1][12]), .cin(pp[2][11]), .s(fas[11]), .c(fac[11]));
full_adder fa12(.x(pp[0][14]), .y(pp[1][13]), .cin(pp[2][12]), .s(fas[12]), .c(fac[12]));
full_adder fa13(.x(pp[0][15]), .y(pp[1][14]), .cin(pp[2][13]), .s(fas[13]), .c(fac[13]));
half_adder ha1( .x(pp[1][15]), .y(pp[2][14]), .s(has[1]), .c(hac[1]));
assign dot[1] = pp[2][15];

assign dot[2] = pp[3][0];
half_adder ha2( .x(pp[3][1]),  .y(pp[4][0]),  .s(has[2]), .c(hac[2]));
full_adder fa14(.x(pp[3][2]),  .y(pp[4][1]),  .cin(pp[5][0]),  .s(fas[14]), .c(fac[14]));
full_adder fa15(.x(pp[3][3]),  .y(pp[4][2]),  .cin(pp[5][1]),  .s(fas[15]), .c(fac[15]));
full_adder fa16(.x(pp[3][4]),  .y(pp[4][3]),  .cin(pp[5][2]),  .s(fas[16]), .c(fac[16]));
full_adder fa17(.x(pp[3][5]),  .y(pp[4][4]),  .cin(pp[5][3]),  .s(fas[17]), .c(fac[17]));
full_adder fa18(.x(pp[3][6]),  .y(pp[4][5]),  .cin(pp[5][4]),  .s(fas[18]), .c(fac[18]));
full_adder fa19(.x(pp[3][7]),  .y(pp[4][6]),  .cin(pp[5][5]),  .s(fas[19]), .c(fac[19]));
full_adder fa20(.x(pp[3][8]),  .y(pp[4][7]),  .cin(pp[5][6]),  .s(fas[20]), .c(fac[20]));
full_adder fa21(.x(pp[3][9]),  .y(pp[4][8]),  .cin(pp[5][7]),  .s(fas[21]), .c(fac[21]));
full_adder fa22(.x(pp[3][10]), .y(pp[4][9]),  .cin(pp[5][8]),  .s(fas[22]), .c(fac[22]));
full_adder fa23(.x(pp[3][11]), .y(pp[4][10]), .cin(pp[5][9]),  .s(fas[23]), .c(fac[23]));
full_adder fa24(.x(pp[3][12]), .y(pp[4][11]), .cin(pp[5][10]), .s(fas[24]), .c(fac[24]));
full_adder fa25(.x(pp[3][13]), .y(pp[4][12]), .cin(pp[5][11]), .s(fas[25]), .c(fac[25]));
full_adder fa26(.x(pp[3][14]), .y(pp[4][13]), .cin(pp[5][12]), .s(fas[26]), .c(fac[26]));
full_adder fa27(.x(pp[3][15]), .y(pp[4][14]), .cin(pp[5][13]), .s(fas[27]), .c(fac[27]));
half_adder ha3( .x(pp[4][15]), .y(pp[5][14]), .s(has[3]), .c(hac[3]));
assign dot[3] = pp[5][15];

assign dot[4] = pp[6][0];
half_adder ha4( .x(pp[6][1]), .y(pp[7][0]), .s(has[4]), .c(hac[4]));
full_adder fa28(.x(pp[6][2]),  .y(pp[7][1]),  .cin(pp[8][0]), .s(fas[28]),  .c(fac[28]));
full_adder fa29(.x(pp[6][3]),  .y(pp[7][2]),  .cin(pp[8][1]), .s(fas[29]),  .c(fac[29]));
full_adder fa30(.x(pp[6][4]),  .y(pp[7][3]),  .cin(pp[8][2]), .s(fas[30]),  .c(fac[30]));
full_adder fa31(.x(pp[6][5]),  .y(pp[7][4]),  .cin(pp[8][3]), .s(fas[31]),  .c(fac[31]));
full_adder fa32(.x(pp[6][6]),  .y(pp[7][5]),  .cin(pp[8][4]), .s(fas[32]),  .c(fac[32]));
full_adder fa33(.x(pp[6][7]),  .y(pp[7][6]),  .cin(pp[8][5]), .s(fas[33]),  .c(fac[33]));
full_adder fa34(.x(pp[6][8]),  .y(pp[7][7]),  .cin(pp[8][6]), .s(fas[34]),  .c(fac[34]));
full_adder fa35(.x(pp[6][9]),  .y(pp[7][8]),  .cin(pp[8][7]), .s(fas[35]),  .c(fac[35]));
full_adder fa36(.x(pp[6][10]), .y(pp[7][9]),  .cin(pp[8][8]), .s(fas[36]),  .c(fac[36]));
full_adder fa37(.x(pp[6][11]), .y(pp[7][10]), .cin(pp[8][9]), .s(fas[37]),  .c(fac[37]));
full_adder fa38(.x(pp[6][12]), .y(pp[7][11]), .cin(pp[8][10]), .s(fas[38]), .c(fac[38]));
full_adder fa39(.x(pp[6][13]), .y(pp[7][12]), .cin(pp[8][11]), .s(fas[39]), .c(fac[39]));
full_adder fa40(.x(pp[6][14]), .y(pp[7][13]), .cin(pp[8][12]), .s(fas[40]), .c(fac[40]));
full_adder fa41(.x(pp[6][15]), .y(pp[7][14]), .cin(pp[8][13]), .s(fas[41]), .c(fac[41]));
half_adder ha5( .x(pp[7][15]), .y(pp[8][14]), .s(has[5]), .c(hac[5]));
assign dot[5] = pp[8][15];

assign dot[6] = pp[9][0];
half_adder ha6( .x(pp[9][1]), .y(pp[10][0]), .s(has[6]), .c(hac[6]));
full_adder fa42(.x(pp[9][2]),  .y(pp[10][1]),  .cin(pp[11][0]), .s(fas[42]), .c(fac[42]));
full_adder fa43(.x(pp[9][3]),  .y(pp[10][2]),  .cin(pp[11][1]), .s(fas[43]), .c(fac[43]));
full_adder fa44(.x(pp[9][4]),  .y(pp[10][3]),  .cin(pp[11][2]), .s(fas[44]), .c(fac[44]));
full_adder fa45(.x(pp[9][5]),  .y(pp[10][4]),  .cin(pp[11][3]), .s(fas[45]), .c(fac[45]));
full_adder fa46(.x(pp[9][6]),  .y(pp[10][5]),  .cin(pp[11][4]), .s(fas[46]), .c(fac[46]));
full_adder fa47(.x(pp[9][7]),  .y(pp[10][6]),  .cin(pp[11][5]), .s(fas[47]), .c(fac[47]));
full_adder fa48(.x(pp[9][8]),  .y(pp[10][7]),  .cin(pp[11][6]), .s(fas[48]), .c(fac[48]));
full_adder fa49(.x(pp[9][9]),  .y(pp[10][8]),  .cin(pp[11][7]), .s(fas[49]), .c(fac[49]));
full_adder fa50(.x(pp[9][10]), .y(pp[10][9]),  .cin(pp[11][8]), .s(fas[50]), .c(fac[50]));
full_adder fa51(.x(pp[9][11]), .y(pp[10][10]), .cin(pp[11][9]), .s(fas[51]), .c(fac[51]));
full_adder fa52(.x(pp[9][12]), .y(pp[10][11]), .cin(pp[11][10]), .s(fas[52]), .c(fac[52]));
full_adder fa53(.x(pp[9][13]), .y(pp[10][12]), .cin(pp[11][11]), .s(fas[53]), .c(fac[53]));
full_adder fa54(.x(pp[9][14]), .y(pp[10][13]), .cin(pp[11][12]), .s(fas[54]), .c(fac[54]));
full_adder fa55(.x(pp[9][15]), .y(pp[10][14]), .cin(pp[11][13]), .s(fas[55]), .c(fac[55]));
half_adder ha7( .x(pp[10][15]), .y(pp[11][14]), .s(has[7]), .c(hac[7]));
assign dot[7] = pp[11][15];

assign dot[8] = pp[12][0];
half_adder ha8( .x(pp[12][1]), .y(pp[13][0]), .s(has[8]), .c(hac[8]));
full_adder fa56(.x(pp[12][2]),  .y(pp[13][1]),  .cin(pp[14][0]),  .s(fas[56]), .c(fac[56]));
full_adder fa57(.x(pp[12][3]),  .y(pp[13][2]),  .cin(pp[14][1]),  .s(fas[57]), .c(fac[57]));
full_adder fa58(.x(pp[12][4]),  .y(pp[13][3]),  .cin(pp[14][2]),  .s(fas[58]), .c(fac[58]));
full_adder fa59(.x(pp[12][5]),  .y(pp[13][4]),  .cin(pp[14][3]),  .s(fas[59]), .c(fac[59]));
full_adder fa60(.x(pp[12][6]),  .y(pp[13][5]),  .cin(pp[14][4]),  .s(fas[60]), .c(fac[60]));
full_adder fa61(.x(pp[12][7]),  .y(pp[13][6]),  .cin(pp[14][5]),  .s(fas[61]), .c(fac[61]));
full_adder fa62(.x(pp[12][8]),  .y(pp[13][7]),  .cin(pp[14][6]),  .s(fas[62]), .c(fac[62]));
full_adder fa63(.x(pp[12][9]),  .y(pp[13][8]),  .cin(pp[14][7]),  .s(fas[63]), .c(fac[63]));
full_adder fa64(.x(pp[12][10]), .y(pp[13][9]),  .cin(pp[14][8]),  .s(fas[64]), .c(fac[64]));
full_adder fa65(.x(pp[12][11]), .y(pp[13][10]), .cin(pp[14][9]),  .s(fas[65]), .c(fac[65]));
full_adder fa66(.x(pp[12][12]), .y(pp[13][11]), .cin(pp[14][10]), .s(fas[66]), .c(fac[66]));
full_adder fa67(.x(pp[12][13]), .y(pp[13][12]), .cin(pp[14][11]), .s(fas[67]), .c(fac[67]));
full_adder fa68(.x(pp[12][14]), .y(pp[13][13]), .cin(pp[14][12]), .s(fas[68]), .c(fac[68]));
full_adder fa69(.x(pp[12][15]), .y(pp[13][14]), .cin(pp[14][13]), .s(fas[69]), .c(fac[69]));
half_adder ha9( .x(pp[13][15]), .y(pp[14][14]), .s(has[9]), .c(hac[9]));
assign dot[8] = pp[14][15];

assign dot[9]  = pp[15][0];
assign dot[10] = pp[15][1];
assign dot[11] = pp[15][2];
assign dot[12] = pp[15][3];
assign dot[13] = pp[15][4];
assign dot[14] = pp[15][5];
assign dot[15] = pp[15][6];
assign dot[16] = pp[15][7];
assign dot[17] = pp[15][8];
assign dot[18] = pp[15][9];
assign dot[19] = pp[15][10];
assign dot[20] = pp[15][11];
assign dot[21] = pp[15][12];
assign dot[22] = pp[15][13];
assign dot[23] = pp[15][14];
assign dot[24] = pp[15][15];
/***********************/
/*stage 2***************/
assign dot[25] = dot[0];
assign dot[26] = has[0];
half_adder ha10(.x(fas[0]), .y(hac[0]), .s(has[10]), .c(hac[10]));
full_adder fa70(.x(fas[1]),  .y(fac[0]),  .cin(dot[2]), .s(fas[70]), .c(fac[70]));
full_adder fa71(.x(fas[2]),  .y(fac[1]),  .cin(has[2]), .s(fas[71]), .c(fac[71]));
full_adder fa72(.x(fas[3]),  .y(fac[2]),  .cin(fas[14]), .s(fas[72]), .c(fac[72]));
full_adder fa73(.x(fas[4]),  .y(fac[3]),  .cin(fas[15]), .s(fas[73]), .c(fac[73]));
full_adder fa74(.x(fas[5]),  .y(fac[4]),  .cin(fas[16]), .s(fas[74]), .c(fac[74]));
full_adder fa75(.x(fas[6]),  .y(fac[5]),  .cin(fas[17]), .s(fas[75]), .c(fac[75]));
full_adder fa76(.x(fas[7]),  .y(fac[6]),  .cin(fas[18]), .s(fas[76]), .c(fac[76]));
full_adder fa77(.x(fas[8]),  .y(fac[7]),  .cin(fas[19]), .s(fas[77]), .c(fac[77]));
full_adder fa78(.x(fas[9]),  .y(fac[8]),  .cin(fas[20]), .s(fas[78]), .c(fac[78]));
full_adder fa79(.x(fas[10]), .y(fac[9]),  .cin(fas[21]), .s(fas[79]), .c(fac[79]));
full_adder fa80(.x(fas[11]), .y(fac[10]), .cin(fas[23]), .s(fas[80]), .c(fac[80]));
full_adder fa81(.x(fas[12]), .y(fac[11]), .cin(fas[24]), .s(fas[81]), .c(fac[81]));
full_adder fa82(.x(fas[13]), .y(fac[12]), .cin(fas[25]), .s(fas[82]), .c(fac[82]));
full_adder fa83(.x(has[1]),  .y(fac[13]), .cin(fas[26]), .s(fas[83]), .c(fac[83]));
full_adder fa84(.x(dot[1]),  .y(hac[1]),  .cin(fas[27]), .s(fas[84]), .c(fac[84]));
assign dot[27] = fas[28];
assign dot[28] = has[3];
assign dot[29] = dot[3];

assign dot[30] = hac[2];
half_adder ha11(.x(fac[14]), .y(dot[4]), .s(has[11]), .c(hac[11]));
half_adder ha12(.x(fac[15]), .y(has[4]), .s(has[12]), .c(hac[12]));
full_adder fa85(.x(fac[16]),  .y(fas[28]),  .cin(hac[4]), .s(fas[85]), .c(fac[85]));
full_adder fa86(.x(fac[17]),  .y(fas[29]),  .cin(fac[28]), .s(fas[86]), .c(fac[86]));
full_adder fa87(.x(fac[18]),  .y(fas[30]),  .cin(fac[29]), .s(fas[87]), .c(fac[87]));
full_adder fa88(.x(fac[19]),  .y(fas[31]),  .cin(fac[30]), .s(fas[88]), .c(fac[88]));
full_adder fa89(.x(fac[20]),  .y(fas[32]),  .cin(fac[31]), .s(fas[89]), .c(fac[89]));
full_adder fa90(.x(fac[21]),  .y(fas[33]),  .cin(fac[32]), .s(fas[90]), .c(fac[90]));
full_adder fa91(.x(fac[22]),  .y(fas[34]),  .cin(fac[33]), .s(fas[91]), .c(fac[91]));
full_adder fa92(.x(fac[23]),  .y(fas[35]),  .cin(fac[34]), .s(fas[92]), .c(fac[92]));
full_adder fa93(.x(fac[24]),  .y(fas[36]),  .cin(fac[35]), .s(fas[93]), .c(fac[93]));
full_adder fa94(.x(fac[25]),  .y(fas[37]),  .cin(fac[36]), .s(fas[94]), .c(fac[94]));
full_adder fa95(.x(fac[26]),  .y(fas[38]),  .cin(fac[37]), .s(fas[95]), .c(fac[95]));
full_adder fa96(.x(fac[27]),  .y(fas[39]),  .cin(fac[38]), .s(fas[96]), .c(fac[96]));
full_adder fa97(.x(hac[3]),   .y(fas[40]),  .cin(fac[39]), .s(fas[97]), .c(fac[97]));
half_adder ha13(.x(fas[41]), .y(fac[40]), .s(has[13]), .c(hac[13]));
half_adder ha14(.x(has[5]), .y(fac[41]), .s(has[14]), .c(hac[14]));
half_adder ha15(.x(dot[5]), .y(hac[5]), .s(has[15]), .c(hac[15]));

assign dot[31] = dot[6];
assign dot[32] = has[6];
half_adder ha16(.x(fas[42]), .y(hac[6]), .s(has[16]), .c(hac[16]));
full_adder fa98(.x(fas[43]), .y(fac[42]),  .cin(dot[8]), .s(fas[98]), .c(fac[98]));
full_adder fa99(.x(fas[44]), .y(fac[43]),  .cin(has[8]), .s(fas[99]), .c(fac[99]));
full_adder fa100(.x(fas[45]), .y(fac[44]),  .cin(fas[56]), .s(fas[100]), .c(fac[100]));
full_adder fa101(.x(fas[46]), .y(fac[45]),  .cin(fas[57]), .s(fas[101]), .c(fac[101]));
full_adder fa102(.x(fas[47]), .y(fac[46]),  .cin(fas[58]), .s(fas[102]), .c(fac[102]));
full_adder fa103(.x(fas[48]), .y(fac[47]),  .cin(fas[59]), .s(fas[103]), .c(fac[103]));
full_adder fa104(.x(fas[49]), .y(fac[48]),  .cin(fas[60]), .s(fas[104]), .c(fac[104]));
full_adder fa105(.x(fas[50]), .y(fac[49]),  .cin(fas[61]), .s(fas[105]), .c(fac[105]));
full_adder fa106(.x(fas[51]), .y(fac[50]),  .cin(fas[62]), .s(fas[106]), .c(fac[106]));
full_adder fa107(.x(fas[52]), .y(fac[51]),  .cin(fas[63]), .s(fas[107]), .c(fac[107]));
full_adder fa108(.x(fas[53]), .y(fac[52]),  .cin(fas[64]), .s(fas[108]), .c(fac[108]));
full_adder fa109(.x(fas[54]), .y(fac[53]),  .cin(fas[65]), .s(fas[109]), .c(fac[109]));
full_adder fa110(.x(fas[55]), .y(fac[54]),  .cin(fas[66]), .s(fas[110]), .c(fac[110]));
full_adder fa111(.x(has[7]),  .y(fac[55]),  .cin(fas[67]), .s(fas[111]), .c(fac[111]));
full_adder fa112(.x(dot[7]),  .y(hac[7]),   .cin(fas[68]), .s(fas[112]), .c(fac[112]));
assign dot[33] = fas[69];
assign dot[34] = has[9];
assign dot[35] = dot[9];

//last two rows of dots will carry over a few times, keep track of them

/*stage 3********/
//dot[25], dot[26]
assign dot[36] = has[10];
half_adder ha17(.x(fas[42]), .y(hac[6]), .s(has[16]), .c(hac[16]));




















assign z1[7] = 0;
assign z2[7] = 0;
assign z2[6] = pp[3][3];
assign z1[2] = pp[2][0];
assign z1[1] = pp[0][1];
assign z2[1] = pp[0][1];
assign z2[0] = pp[0][0];
assign z1[0] = 0;
assign result1 = z1;
assign result2 = z2;




						  
//TCGenerator tcgen0(.in(MUR), .out(MURtc));
//TCGenerator tcgen1(.in(MUD), .out(MUDtc));

endmodule
