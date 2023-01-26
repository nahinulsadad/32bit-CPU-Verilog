
module flag_registers (zf,sf,cf,clk,clrn,dzf,dsf,dcf);
    input zf,sf,cf;                                // flag registers
    input clk, clrn;                                 // clock, reset
    
	 output dzf,dsf,dcf;                                // flag registers
    
	 wire [31:0] e = 32'b1;
    wire  register[2:0];  

	//dffe1 (d,clk,clrn,e,q); 
	 dffe1 reg01  (zf,clk,clrn,e,register[0]);    // zf
    dffe1 reg02  (sf,clk,clrn,e,register[1]);    // sf
    dffe1 reg03  (cf,clk,clrn,e,register[2]);    // cf
        
	 assign dzf = register[0];
	 assign dsf = register[1];
	 assign dcf = register[2];
endmodule
