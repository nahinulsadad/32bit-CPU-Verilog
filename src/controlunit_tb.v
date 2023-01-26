`timescale 1ns / 1ps

module controlunit_tb;

	// Inputs
	reg [5:0] op;
	reg zf;
	reg sf;
	reg cf;

	// Outputs
	wire [3:0] alu_op;
	wire wreg;
	wire imm_select;

	// Instantiate the Unit Under Test (UUT)
	controlunit uut (
		.op(op), 
		.zf(zf), 
		.sf(sf), 
		.cf(cf), 
		.alu_op(alu_op), 
		.wreg(wreg), 
		.imm_select(imm_select)
	);

	initial begin
		// Initialize Inputs
		op = 0;
		zf = 0;
		sf = 0;
		cf = 0;

		// Wait 100 ns for global reset to finish
		#2;
        
		// Add stimulus here
		
		# 2 op = 6'b000000;
		# 2 op = 6'b000001;
		# 2 op = 6'b000010;
		# 2 op = 6'b000011;
		# 2 op = 6'b000100;
		# 2 op = 6'b000101;
		# 2 op = 6'b000110;
		# 2 op = 6'b000111;
		# 2 op = 6'b001000;
		# 2 op = 6'b001001;
		
		# 2 op = 6'b010000;
		# 2 op = 6'b010001;
		# 2 op = 6'b010010;
		# 2 op = 6'b010011;
		# 2 op = 6'b010100;
		# 2 op = 6'b010101;
		# 2 op = 6'b010110;
		# 2 op = 6'b010111;
		# 2 op = 6'b011000;
		# 2 op = 6'b011001;
		
		#2 $finish;
		
	end
      
endmodule

