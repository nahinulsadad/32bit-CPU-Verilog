
module instmem (a,inst);               // instruction memory, rom
    input  [31:0] a;                     // address
    output [31:0] inst;                  // instruction
    wire   [31:0] rom [0:20];            // rom cells: 32 words * 32 bits
     
	 // rom[word_addr] = instruction      // (pc) label   instruction
	assign rom[5'h0] = 32'b010101_00001_00001_0000000000000001; //XORI R1 R1 1
	assign rom[5'h1] = 32'b010101_00010_00010_0000000000000000; //XORI R2 R2 0
	assign rom[5'h2] = 32'b010101_00011_00011_0000000000000000; //XORI R3 R3 0
	assign rom[5'h3] = 32'b010000_00010_00010_0000000000000001; //JP: ADDI R2 R2 1
	assign rom[5'h4] = 32'b000010_00001_00001_00010_00000000000; //MUL R1 R1 R2
	assign rom[5'h5] = 32'b010011_00100_00100_0000000000000000; //ANDI R4 R4 0
	assign rom[5'h6] = 32'b000000_00100_00000_00010_00000000000; //ADD R4 R0 R2
	assign rom[5'h7] = 32'b010111_00100_00100_0000000000000001; //SHRI R4 R4 1
	assign rom[5'h8] = 32'b111000_00001110_00000_00000_00000000; //JNC JP1
	assign rom[5'h9] = 32'b010011_00101_00101_0000000000000000; //ANDI R5 R5 0
	assign rom[5'hA] = 32'b000000_00101_00000_00001_00000000000; //ADD R5 R0 R1
	assign rom[5'hB] = 32'b010110_00101_00101_0000000000000001; //SHLI R5 R5 1
	assign rom[5'hC] = 32'b000000_00011_00011_00101_00000000000; //ADD R3 R3 R5
	assign rom[5'hD] = 32'b110000_00010010_00000_00000_00000000; //JMP JP2
	assign rom[5'hE] = 32'b010011_00101_00101_0000000000000000; //JP1: ANDI R5 R5 0
	assign rom[5'hF] = 32'b000000_00101_00000_00001_00000000000; //ADD R5 R0 R1
	assign rom[5'h10] = 32'b011000_00101_00101_0000000000000001; //SARI R5 R5 1
	assign rom[5'h11] = 32'b000001_00011_00011_00101_00000000000; //SUB R3 R3 R5
	assign rom[5'h12] = 32'b011001_00010_00010_0000000000000100; //JP2: CMPI R2 R2 4
	assign rom[5'h13] = 32'b110010_00000011_00000_00000_00000000; //JNE JP
	assign rom[5'h14] = 32'b000011_00010_00010_00010_00000000000; //NOP

    //assign inst = rom[a];           // use word address to read rom
	 assign inst = (a >= 5'h15)? 32'b000011_00010_00010_00010_00000000000 : rom[a]; // read port A
endmodule







