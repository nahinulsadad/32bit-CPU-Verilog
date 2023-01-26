
module regfile (ra1,ra2,rwd,rw,we,clk,clrn,rd1,rd2,reg1,reg2);
    input   [4:0] ra1,ra2,rw;                                // reg numbers
    input  [31:0] rwd;                                         // write data
    input         we;                                        // write enable
    input         clk, clrn;                                 // clock, reset
    output [31:0] rd1,rd2;                                     // read ports
    output [31:0] reg1,reg2;                                     // read ports
    
	 wire   [31:0] e;                                         // enables
    
    
	 reg [31:0] register [1:5]; // 31 32-bit registers
	 
	 assign rd1 = (ra1 == 0)? 0 : register[ra1]; // read port A
	 assign rd2 = (ra2 == 0)? 0 : register[ra2]; // read port B
	 
	 assign reg1 = register[5]; // read port 1
	 assign reg2 = register[4]; // read port 1
	 
	
	integer i;
	always @(posedge clk or negedge clrn) // write port
	if (!clrn)
		for (i = 1; i < 6; i = i + 1)
		register[i] <= 0; // reset
	else
		if ((rw != 0) && we) // not reg[0] & enabled
			register[rw] <= rwd; // write d to reg[wn]
endmodule
