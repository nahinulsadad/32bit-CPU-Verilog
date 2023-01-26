
module cla32 (a,b,ci,s, cout);    // 32-bit carry lookahead adder, no g, p outputs
    input  [31:0] a, b;                                 // inputs: a, b
    input         ci;                                   // input:  carry_in
    output [31:0] s;                                    // output: sum
    output cout;
	 wire          g_out, p_out;                         // internal wires
    
	 cla_32 cla (a, b, ci, g_out, p_out, s);             // use cla_32 module
	 assign cout = g_out | (p_out & ci);
endmodule
