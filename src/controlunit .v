
module controlunit (op,zf, sf, cf, alu_op, wreg, imm_select, jmp_select);            // control unit
	  input  [5:0] op;                          // op, func 
	  input        zf;                              // alu, zero flag
	  input        sf;                              // alu, sign flag
	  input        cf;                              // alu, carry flag
	  
	  output [3:0] alu_op;                              // alu operation control
	  output       wreg;                              	// write regfile
	  output       imm_select;                     		// immediate select
	  output       jmp_select;                     		// jump select
	  	  
	  // decode instructions
	  wire i_add  = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; //00 0000
	  wire i_sub  = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0]; //00 0001
	  wire i_mul  = ~op[5] & ~op[4] & ~op[3] & ~op[2] &  op[1] & ~op[0]; //00 0010
	  wire i_and  = ~op[5] & ~op[4] & ~op[3] & ~op[2] &  op[1] &  op[0]; //00 0011
	  wire i_or   = ~op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0]; //00 0100 
	  wire i_xor  = ~op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] &  op[0]; //00 0101
	  wire i_sll  = ~op[5] & ~op[4] & ~op[3] &  op[2] &  op[1] & ~op[0]; //00 0110
	  wire i_srl  = ~op[5] & ~op[4] & ~op[3] &  op[2] &  op[1] &  op[0]; //00 0111
	  wire i_sra  = ~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //00 1000
	  wire i_cmp  = ~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] &  op[0]; //00 1001
	  
	  wire i_addi  = ~op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; //01 0001
	  wire i_subi  = ~op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0]; //01 0000
	  wire i_muli  = ~op[5] &  op[4] & ~op[3] & ~op[2] &  op[1] & ~op[0]; //01 0010
	  wire i_andi  = ~op[5] &  op[4] & ~op[3] & ~op[2] &  op[1] &  op[0]; //01 0011
	  wire i_ori   = ~op[5] &  op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0]; //01 0100
	  wire i_xori  = ~op[5] &  op[4] & ~op[3] &  op[2] & ~op[1] &  op[0]; //01 0101
	  wire i_slli  = ~op[5] &  op[4] & ~op[3] &  op[2] &  op[1] & ~op[0]; //01 0110
	  wire i_srli  = ~op[5] &  op[4] & ~op[3] &  op[2] &  op[1] &  op[0]; //01 0111
	  wire i_srai  = ~op[5] &  op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //01 1000
	  wire i_cmpi  = ~op[5] &  op[4] &  op[3] & ~op[2] & ~op[1] &  op[0]; //01 1001
	  
	  wire i_jmp   =  op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; //11 0000
	  wire i_je    =  op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0]; //11 0001
	  wire i_jne   =  op[5] &  op[4] & ~op[3] & ~op[2] &  op[1] & ~op[0]; //11 0010
	  wire i_jl    =  op[5] &  op[4] & ~op[3] & ~op[2] &  op[1] &  op[0]; //11 0011
	  wire i_jle   =  op[5] &  op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0]; //11 0100
	  wire i_jg    =  op[5] &  op[4] & ~op[3] &  op[2] & ~op[1] &  op[0]; //11 0101
	  wire i_jge   =  op[5] &  op[4] & ~op[3] &  op[2] &  op[1] & ~op[0]; //11 0110
	  wire i_jc    =  op[5] &  op[4] & ~op[3] &  op[2] &  op[1] &  op[0]; //11 0111
	  wire i_jnc   =  op[5] &  op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //11 1000
	  wire i_jz    =  op[5] &  op[4] &  op[3] & ~op[2] & ~op[1] &  op[0]; //11 1001
	  wire i_jnz   =  op[5] &  op[4] &  op[3] & ~op[2] &  op[1] & ~op[0]; //11 1010
	  
	  assign wreg    = i_add  | i_sub  |  i_mul | i_and  | i_or  | i_xor  | i_sll  | i_srl  | i_sra  |
							 i_addi | i_subi |  i_muli| i_andi | i_ori | i_xori | i_slli | i_srli | i_srai;
							 
	  assign imm_select = ~op[5] &  op[4];
	  
	  assign alu_op[3] = i_sra | i_srai | i_xor | i_xori;                         

	  assign alu_op[2] = i_sub  | i_subi | i_srl  | i_srli  | i_or  | i_ori | i_sra | i_srai | i_cmp |i_cmpi;

	  assign alu_op[1] = i_and  | i_andi  | i_or  | i_ori  | i_xor | i_xori | 
							  i_sll | i_slli  | i_srl | i_srli | i_sra | i_srai;

	  assign alu_op[0] = i_mul  | i_muli | i_sll | i_slli  | i_srl | i_srli | i_sra | i_srai;
	  
	  assign jmp_select = i_jmp | (i_je & zf & ~sf) | (i_jne & ~zf) | (i_jl & (sf & ~zf)) | (i_jle & (sf | zf)) |
								 (i_jg & ~sf & ~zf) | (i_jge & (~sf | zf)) | (i_jc & cf) | (i_jnc & ~cf) |
								  (i_jz & zf) | (i_jnz & ~zf);

	  //assign shift   = i_sll  | i_srl  | i_sra;
	  //assign aluimm  = i_addi | i_andi | i_ori  | i_xori | i_lw  | i_lui | i_sw;
	  //assign sext    = i_addi | i_lw   | i_sw   | i_beq  | i_bne;
	  //assign pcsrc[1]= i_jr   | i_j    | i_jal;
	  //assign pcsrc[0]= i_beq & z | i_bne & ~z | i_j | i_jal;

	  
endmodule
