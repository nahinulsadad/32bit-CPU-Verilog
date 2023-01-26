
module comp (clk,clrn,reset,inst,pc,aluout,reg1,reg2);   // single cycle computer
    input         clk, clrn;                      // clock and reset
	 input reset;
    output [31:0] pc;                             // program counter
    output [31:0] inst;                           // instruction
    output [31:0] aluout;                         // alu output
	 output [31:0] reg1,reg2;                                     // read ports
    
    
	 wire clk2;
	 //cpu (clk,clrn,inst,pc,alu_out);
	 cpu cpu1 (clk2,clrn,inst,pc,aluout,reg1,reg2);   // cpu
    
	 instmem imem (pc,inst);                               // inst memory
    //scdatamem dmem (clk,memout,data,aluout,wmem);           // data memory
	 
	 clkdiv U1
				( 
				.clk3(clk2),
				.clr(reset),
				.clk(clk)
				);
	 
	 
endmodule
