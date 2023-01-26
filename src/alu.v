
module alu (a,b,op,r,zf,sf,cf);           // 32-bit alu with a zero flag, carry flag and sign flag
    input  [31:0] a, b;              // inputs: a, b
    input   [3:0] op;              // input:  alu control: // aluc[3:0]:
    output [31:0] r;                 // output: alu result   
    output        zf;                 // output: zero flag 
	 output        sf;					  // output: zero flag
	 output        cf; 					  // output: zero flag

    wire   [31:0] d_and = a & b;                             // 0 0 (1 0)  AND
    wire   [31:0] d_or  = a | b;                             // 0 1 (1 0)  OR
    wire   [31:0] d_xor = a ^ b;                             // 1 x (1 0)  XOR

    //wire   [31:0] d_andor  = op[2]? d_or  : d_and;        
    //wire   [31:0] d_andor_xor = op[3]? d_xor : d_andor;        

	 //mux2x32 (a0,a1,s,y);
	 wire [31:0] d_andor, d_andor_xor;
    mux2x32 select_andor     (d_and   ,d_or  ,op[2] ,d_andor);	 
    mux2x32 select_andor_xor (d_andor ,d_xor ,op[3] ,d_andor_xor);	 
		
    wire   [31:0] d_as, d_sh, d_mul;  

	 wire cf1, cf2;

    // x 0 (0 0)  ADD
	 // x 1 (0 0)  SUB
	 // addsub32   (a,b,sub,    s);
    addsub32 as32 (a,b,op[2],d_as, cf1);                        // add/sub

	 // x x (0 1) MUL
	 mul_signed mul32 ( a[15:0], b[15:0], d_mul);         //multipication

	 // 0 0 (1 1)  SLL
    // 0 1 (1 1)  SRL
 	 // 1 1 (1 1)  SRA
    // shift      (d,sa,    right,  arith,  sh);
    shift_mux shifter (a,b[4:0],op[2],op[3],d_sh, cf2);           // shift
	
	 // mux4x32  ( a00,  a01,      a10,  a11,  s,    y);
    mux4x32 res (d_as,d_mul,d_andor_xor,d_sh,op[1:0],r);  // alu result

    assign zf = ~|r;                // z = (r == 0)
	 assign cf = (cf1 & ~op[1] & ~op[0]) | (cf2 & op[1] & op[0]);				// carry from add or shift operation
	 assign sf = r[31];
endmodule
