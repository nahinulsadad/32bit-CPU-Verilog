`timescale 1ns / 1ps

module test_dff;

	// Inputs
	reg [31:0] d;
	reg clk;
	reg clrn;
	reg e;

	// Outputs
	wire [31:0] q;

	// Instantiate the Unit Under Test (UUT)
	dffe32 uut (
		.d(d), 
		.clk(clk), 
		.clrn(clrn), 
		.e(e), 
		.q(q)
	);

	initial begin
		// Initialize Inputs
		d = 0;
		clk = 0;
		clrn = 1;
		e = 0;

		// Wait 100 ns for global reset to finish
		#2;
		clrn = 0;
		
		
        
		// Add stimulus here

	end
      
endmodule

