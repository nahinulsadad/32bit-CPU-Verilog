`timescale 1ns / 1ns

module flag_reg_tb;

	// Inputs
	reg zf;
	reg sf;
	reg cf;
	reg clk;
	reg clrn;

	// Instantiate the Unit Under Test (UUT)
	flag_registers uut (
		.zf(zf), 
		.sf(sf), 
		.cf(cf), 
		.clk(clk), 
		.clrn(clrn)
	);

	initial begin
		// Initialize Inputs
		zf = 0;
		sf = 0;
		cf = 0;
		clk = 1;
		clrn = 0;

		// Wait 100 ns for global reset to finish
		#2 clrn = 1;
			zf = 0;
			sf = 0;
			cf = 1;
		
		#2 
			zf = 0;
			sf = 1;
			cf = 0;

		#2 
			zf = 1;
			sf = 0;
			cf = 0;
			
			
		#2 $finish;
		
        
		// Add stimulus here

	end
		always #1 clk = !clk;
      
endmodule

