//`include "Alu.v"
//`include "mux2x1.v"
//`include "mux2x1_5bit.v"
//`include "mux3x1.v"


module EX_MEM_Stage(
input clk, 
input RegWriteE,
input MemtoRegE,
input MemWriteE,
input [2:0]ALUControlE,
input ALUSrcE,
input RegDstE,
input[31:0]RD1_E,
input[31:0]RD2_E,
input [4:0]RsE,
input [4:0]RtE,
input [4:0]RdE,
input [31:0]SignImmE,
input [1:0]ForwardAE,
input [1:0]ForwardBE, 
input [31:0]ResultW,
output RegWriteM,
output MemtoRegM,
output MemWriteM,
output [31:0]ALUOutM,
output [31:0]WriteDataM,
output [4:0]WriteRegM,
output [4:0] RsE_out
);

//defining Stage registers
reg RegWriteE_r;
reg MemtoRegE_r;
reg MemWriteE_r;
reg [31:0]ALUOutE_r;
reg [31:0]WriteDataE_r;
reg [4:0]WriteRegE_r;

//wire declarations
wire [4:0]WriteRegE;
wire [31:0]SrcAE;
wire [31:0]SrcBE;
wire [31:0]WriteDataE;
wire [31:0]ALUOutE;

//modules instantiation
mux2x1_5bit m1(.d0(RtE),
          .d1(RdE),
		    .s(RegDstE),
	       .y(WriteRegE)		 
 	    	);


mux3x1 m2(.d0(RD1_E),
          .d1(ResultW),
			 .d2(ALUOutM),
			 .s(ForwardAE),
			 .y(SrcAE) 
			 );
			 
mux3x1 m3(.d0(RD2_E),
          .d1(ResultW),
			 .d2(ALUOutM),
			 .s(ForwardBE),
			 .y(WriteDataE) 
			 );

mux2x1_3 m4(.d0(WriteDataE),
          .d1(SignImmE),
		    .s(ALUSrcE),
	       .y(SrcBE)		 
 	    	);			 
			 
Alu a1(.A(SrcAE),
       .B(SrcBE),
		 .ALUControl(ALUControlE),
		 .Result(ALUOutE)
       );	
	

//Assignment to stage register

always@(posedge clk)
begin
   RegWriteE_r = RegWriteE;
	MemtoRegE_r = MemtoRegE;
	MemWriteE_r = MemWriteE;
	ALUOutE_r   = ALUOutE;
	WriteDataE_r= WriteDataE;
	WriteRegE_r = WriteRegE;
	
end

assign   RegWriteM = RegWriteE_r;
assign	MemtoRegM = MemtoRegE_r;
assign	MemWriteM = MemWriteE_r;
assign	ALUOutM   = ALUOutE_r;
assign	WriteDataM= WriteDataE_r;
assign	WriteRegM = WriteRegE_r;
assign  RsE_out= RsE;
 	
endmodule