
module cpu (clk,clrn,inst,pc,alu_out,reg1,reg2);
    input  [31:0] inst;                           // inst from inst memory
    input         clk, clrn;                      // clock and reset
    
	 output [31:0] pc;                             // program counter
    output [31:0] alu_out;                            // alu output
  
	 output [31:0] reg1,reg2;                                     // read ports
	 
    // instruction fields
    wire    [5:0] op   = inst[31:26];             // op
    wire    [4:0] rc   = inst[25:21];             // rc = ra1
    wire    [4:0] ra   = inst[20:16];             // ra = ra2
    wire    [4:0] rb   = inst[15:11];             // rb = rw
    wire   [15:0] imm  = inst[15:00];             // immediate
    wire   [7:0] addr = inst[25:18];             // address
    
	 // control signals
    wire    [3:0] alu_op;                         // alu operation control
	 wire          imm_select;                     // immediate select
    wire          wreg;                           // write regfile
    wire          jmp_select;                     // jump select
    
	 // datapath wires
    wire   [31:0] p1;                             // pc+1
    //wire   [31:0] bpc;                            // branch target address
    wire   [31:0] npc;                            // next pc
    
	 wire   [31:0] alua;                           // alua = a
    wire   [31:0] alub;                           // alub = b
    wire   [31:0] r;                              // alu result
   
	 wire   [31:0] rwd;                             // regfile write port data
    wire   [31:0] rd1;                             // regfile output port a1
    wire   [31:0] rd2;                             // regfile output port a2
     
	 wire   [15:0] s16 = {16{imm_select & inst[15]}};    // 16-bit signs
	 wire   [31:0] i32 = {s16,imm};                // 32-bit immediate
	 
	 wire   [23:0] s24  = {24{1'b0}};
	 wire   [31:0] addr_ext = {s24,addr};
       
	 wire          zf;                              // alu, zero flag
	 wire          sf;                              // alu, sign flag
	 wire          cf;                              // alu, carry flag
	 wire          dzf;                             // data of zero flag
	 wire          dsf;                             // data of sign flag
	 wire          dcf;                             // data of carry flag
    
	 // control unit
    //controlunit (op,dzf, dsf, dcf, alu_op, wreg, imm_select, jmp_select);
	 controlunit cu(op,dzf, dsf, dcf, alu_op, wreg, imm_select, jmp_select);
	 
	 // datapath
	 // dffe32 (d,clk,clrn,e,q); 
	 cla32 pcplus1 (pc,32'h1,1'b0,p1);               // pc + 1
    
	 mux2x32 ok(p1,addr_ext, jmp_select, npc);
	 //assign npc = p1;
    dff32 inst_pointer (npc,clk,clrn,pc);           // pc register    
	 	 
	 //mux2x32 (a0,a1,s,y);
	 mux2x32 iselect (rd2,i32,imm_select,alub);
	
	 //regfile (ra1,ra2,rwd,rw,we,clk,clrn,rd1,rd2);
	 regfile rf (ra,rb,rwd,rc,wreg,clk,clrn,rd1,rd2,reg1,reg2); // register file
	 
	 //alu (a,b,op,r,zf,sf,cf);
	 assign alua = rd1;
    alu alunit (alua,alub,alu_op,r,zf,sf,cf);  // alu
	 
	 //flag_registers (zf,sf,cf,clk,clrn,dzf,dsf,dcf);
    flag_registers flag (zf,sf,cf,clk,clrn,dzf,dsf,dcf); //flag register to store cf, sf and zf
	 
	 
	 assign alu_out = r;
	 assign rwd = r;

endmodule
