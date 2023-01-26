`timescale 1ns / 1ns

module cpu_tb;

	// Inputs
	reg clk;
	reg clrn;
	reg [31:0] inst;
	reg [31:0] datafmem;
	reg [15:0] imm_data;
	reg [5:0] op;
	reg [4:0] ra;
	reg [4:0] rb;
	reg [4:0] rc;

	// Outputs
	wire [31:0] pc;
	wire wmem;
	wire [31:0] alu;
	wire [31:0] data2mem;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk), 
		.clrn(clrn), 
		.inst(inst), 
		.datafmem(datafmem), 
		.pc(pc), 
		.wmem(wmem), 
		.alu_out(alu), 
		.data2mem(data2mem)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		clrn = 0;
		inst = 0;
		datafmem = 0;

		// Wait 100 ns for global reset to finish
		#2 clrn = 1;
		imm_data = 16'b0000_0000_0000_0111;
		op = 6'b010000;
		rc = 5'b00001;
		ra = 5'b00001;
		inst = {op,rc,ra,imm_data};

		#2 
		op = 6'b000000;
		rc = 5'b00010;
		ra = 5'b00001;
		rb = 5'b00001;
		inst = {op,rc,ra,rb, 11'b000000_00000};	
		
		#2 
		op = 6'b000000;
		rc = 5'b00000;
		ra = 5'b00000;
		rb = 5'b00000;
		inst = {op,rc,ra,rb, 11'b000000_00000};	
		
		/*#2 op = 6'b000010;
		#2 op = 6'b000011;
		#2 op = 6'b000100;
		#2 op = 6'b000101;
		#2 op = 6'b000110;
		#2 op = 6'b000111;
		#2 op = 6'b001000;
		#2 op = 6'b001001;
		
		#2 op = 6'b010000;
		#2 op = 6'b010001;
		#2 op = 6'b010010;
		#2 op = 6'b010011;
		#2 op = 6'b010100;
		#2 op = 6'b010101;
		#2 op = 6'b010110;
		#2 op = 6'b010111;
		#2 op = 6'b011000;
		#2 op = 6'b011001;*/
        
		#2 $finish;

	end
	
	always #1 clk = !clk;
      
endmodule

