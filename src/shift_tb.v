
`timescale 1ns/1ns
module shift_tb;
    reg  [31:0] d;
    reg   [4:0] sa;
    reg         right,arith;
    wire [31:0] sh;
	 wire carry;
    shift_mux sft (d,sa,right,arith,sh,carry);
    initial begin
           right=0; arith=0; d=32'hff0000ff; sa=5'h8;
        #1 right=1; arith=0; d=32'h00000009; sa=5'h8;
        #1 right=1; arith=1; d=32'h00000008; sa=5'h8;
        #1 right=0; arith=0; d=32'hff0000ff; sa=5'h0;
        #1 $finish;
    end
    initial begin
        $monitor("%2d:",$time," right=%b",right," arith=%b",
                 arith," d=%h",d," sa=%h",sa," sh=%h",sh);
    end
endmodule
