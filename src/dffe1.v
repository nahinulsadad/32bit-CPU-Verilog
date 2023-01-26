
module dffe1 (d,clk,clrn,e,q);                         // a 32-bit register
    input             d;                                // input d
    input             e;                                // e: enable
    input             clk, clrn;                        // clock and reset
    output reg        q;                                // output q
    always @(negedge clrn or posedge clk)
        if (!clrn)  q <= 0;                             // q = 0 if reset
        else if (e) q <= d;                             // save d if enabled
endmodule
