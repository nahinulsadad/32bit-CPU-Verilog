
`timescale 1ns/1ns
module addsub32_tb;
    reg  [31:0] a,b;
    reg        sub;
    wire [31:0] s;
    wire       co;
    addsub32 as4 (a,b,sub,s,co);
    initial begin
            a   = 32'h2; // +2
            b   = 32'h3; // +3
            sub = 0;
				
        #20 a   = 32'he; // -2
            b   = 32'hd; // -3
				sub = 1;
    end
    //always #5  ci  = !ci;
    //always #10 sub = !sub;
endmodule
