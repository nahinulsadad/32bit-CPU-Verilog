
module shift_mux (d,sa,right,arith,sh, c);         // a barrel shift using muxs
    input  [31:0] d;                            // input: 32-bit data
    input   [4:0] sa;                           // input: shift amount
    input         right;                        // 1: shift right; 0: left
    input         arith;                        // 1: arithmetic; 0: logical
    output [31:0] sh;                           // output: shifted result
	 output c;                                   // carry
	 
    wire   [31:0] t0, t1, t2, t3, t4;           // wires: outputs of muxs
    wire   [31:0] s1, s2, s3, s4;               // wires: outputs of muxs
    wire          a = d[31] & arith;            // a: filling bit
    wire   [15:0] e = {16{a}};                  // replicate a to 16 bits
    parameter     z = 16'b0;                    // a 16 bits zero
    
	 wire   [31:0] sdl4,sdl3,sdl2,sdl1,sdl0;     // left  shifted data
    wire   [31:0] sdr4,sdr3,sdr2,sdr1,sdr0;     // right shifted data
	 
	 wire   c_sdl4,c_sdl3,c_sdl2,c_sdl1,c_sdl0;     // carry of left shifted data
    wire   c_sdr4,c_sdr3,c_sdr2,c_sdr1,c_sdr0;     // carry of right shifted data
	 
	 wire clr0, clr1, clr2, clr3, clr4;                // output of carry mux
	 wire c1, c2, c3, c4;                        // output of carry output mux
    
	 assign  sdl4  =  {d[15:0],  z};             // shift to left  by 16 bits
    assign  sdl3  =  {s4[23:0], z[7:0]};        // shift to left  by  8 bits
    assign  sdl2  =  {s3[27:0], z[3:0]};        // shift to left  by  4 bits
    assign  sdl1  =  {s2[29:0], z[1:0]};        // shift to left  by  2 bits
    assign  sdl0  =  {s1[30:0], z[0]};          // shift to left  by  1 bit
	 
	 assign  c_sdl4  =  d[16];         // carry of shift to left  by 16 bits
    assign  c_sdl3  =  s4[24];        // carry of shift to left  by  8 bits
    assign  c_sdl2  =  s3[28];        // carry of shift to left  by  4 bits
    assign  c_sdl1  =  s2[30];        // carry of shift to left  by  2 bits
    assign  c_sdl0  =  s1[31];        // carry of shift to left  by  1 bit
	 
    
	 assign  sdr4  =  {e,        d[31:16]};      // shift to right by 16 bits
    assign  sdr3  =  {e[7:0],   s4[31:8]};      // shift to right by  8 bits
    assign  sdr2  =  {e[3:0],   s3[31:4]};      // shift to right by  4 bits
    assign  sdr1  =  {e[1:0],   s2[31:2]};      // shift to right by  2 bits
    assign  sdr0  =  {e[0],     s1[31:1]};      // shift to right by  1 bit
	 
	 assign  c_sdr4  =  d[15];      // carry of shift to right by 16 bits
    assign  c_sdr3  =  s4[7];      // carry of shift to right by  8 bits
    assign  c_sdr2  =  s3[3];      // carry of shift to right by  4 bits
    assign  c_sdr1  =  s2[1];      // carry of shift to right by  2 bits
    assign  c_sdr0  =  s1[0];      // carry of shift to right by  1 bit
    
	 mux2x32 m_right4 (sdl4, sdr4, right, t4);   // select left or right
    mux2x32 m_right3 (sdl3, sdr3, right, t3);   // select left or right
    mux2x32 m_right2 (sdl2, sdr2, right, t2);   // select left or right
    mux2x32 m_right1 (sdl1, sdr1, right, t1);   // select left or right
    mux2x32 m_right0 (sdl0, sdr0, right, t0);   // select left or right
	 
	 mux2x32 c_right4 (c_sdl4, c_sdr4, right, clr4);   // select carry left or carry right
    mux2x32 c_right3 (c_sdl3, c_sdr3, right, clr3);   // select carry left or carry right
    mux2x32 c_right2 (c_sdl2, c_sdr2, right, clr2);   // select carry left or carry right
    mux2x32 c_right1 (c_sdl1, c_sdr1, right, clr1);   // select carry left or carry right
    mux2x32 c_right0 (c_sdl0, c_sdr0, right, clr0);   // select carry left or carry right
    
	 mux2x32 m_shift4 (d,      t4, sa[4], s4);   // select not_shift or shift
    mux2x32 m_shift3 (s4,     t3, sa[3], s3);   // select not_shift or shift
    mux2x32 m_shift2 (s3,     t2, sa[2], s2);   // select not_shift or shift
    mux2x32 m_shift1 (s2,     t1, sa[1], s1);   // select not_shift or shift
    mux2x32 m_shift0 (s1,     t0, sa[0], sh);   // select not_shift or shift

	 mux2x32 c_shift4 (1'b0,      clr4, sa[4], c4);   // select carry not_shift or shift
    mux2x32 c_shift3 (c4,     clr3, sa[3], c3);   // select carry not_shift or shift
    mux2x32 c_shift2 (c3,     clr2, sa[2], c2);   // select carry not_shift or shift
    mux2x32 c_shift1 (c2,     clr1, sa[1], c1);   // select carry not_shift or shift
    mux2x32 c_shift0 (c1,     clr0, sa[0], c);   // select carry not_shift or shift

endmodule
