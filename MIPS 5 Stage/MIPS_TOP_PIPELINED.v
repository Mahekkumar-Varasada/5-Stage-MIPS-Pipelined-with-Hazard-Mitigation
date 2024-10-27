/*`include"IF_ID_Stage.v"
`include"ID_EX_Stage.v"
`include"EX_MEM_Stage.v"
`include"MEM_WB_Stage.v"
`include"WB_Stage.v"
`include"hazard_unit.v"*/

module MIPS_TOP_PIPELINED(input clk,
input RegReset,
output ResultRegisterValue);          //sample output flag 

//IF Stage wires
wire PCSrcD_topwire_in;               //input from decode stage
wire StallF_topwire_in;               //input from hazard unit
wire StallD_topwire_in;               //input from hazard unit
wire [31:0]PCBranchD_topwire_in;      //input from decode stage 
wire [31:0]InstrD_topwire_out;        //output as input to decode 
wire [31:0]PCPlus4D_topwire_out;      //output as input to decode

//Decode Stage wires
wire FlushE_topwire_in;               //input from hazard unit
wire RegWriteW_topwire_in;            //input from writeback
wire[4:0] WriteRegW_topwire_in;       //input from writeback
                                      //InstrD used from Fetch stage   
                                      //PCPlus4D used from Fetch stage
wire [31:0]ResultW_topwire_in;        //ResultW used from WB
wire ForwardA_D_topwire_in;           //Input from control unit
wire ForwardB_D_topwire_in;           //Input from control unit
wire [31:0]ALUOutM_topwire_in;        //input from mem stage  
wire RegWriteE_topwire_out;           //output to exe stage 
wire MemtoRegE_topwire_out;           //output to exe stage 
wire MemWriteE_topwire_out;           //output to exe stage 
wire [2:0]ALUControlE_topwire_out;    //output to exe stage 
wire ALUSrcE_topwire_out;             //output to exe stage 
wire RegDstE_topwire_out;             //output to exe stage 
wire [31:0]RD1_E_topwire_out;         //output to exe stage  
wire [31:0]RD2_E_topwire_out;         //output to exe stage 
wire [31:0]SignImmE_topwire_out;      //output to exe stage          
wire [4:0] RS_E_topwire_in;           //output to exe stage 
wire [4:0] RT_E_topwire_out;          //output to exe stage 
wire [4:0] RD_E_topwire_out;          //output to exe stage 
                                      //PCBranchD o/p as i/p to fetch
wire BranchD_topwire_out;
												  
//execute stage wires

wire [1:0]ForwardAE_topwire_in;       //Input from hazard unit
wire [1:0]ForwardBE_topwire_in;       //Input from hazard unit 
wire RegWriteM_topwire_out;
wire MemtoRegM_topwire_out;
wire MemWriteM_topwire_out;
                                      //ALUOutM_topwire_in as output ALUOutM already defined in fetch stage
wire [31:0]WriteDataM_topwire_out;
wire [4:0]WriteRegM_topwire_out ; 
wire [4:0] RS_E_topwire_out; 


//memory stage wires


                                      //RegWriteW not used as it already defined as RegWriteW_topwire_in in fetch wires	
wire MemtoRegW_topwire_out;
wire [31:0]ReadDataW_topwire_out;
wire [31:0] ALUOutW_topwire_out;
                                      //WriteRegW not used as it already defined as WriteRegW_topwire_in in fetch wires	



//writeback nil wires



//hazard unit wires



//initialization for easy simulation





	
//InstructionFetch Stage
IF_ID_Stage IIS1(.clk(clk),
					  .StallD(StallD_topwire_in),
					  .PCSrcD(PCSrcD_topwire_in),
					  .StallF(StallF_topwire_in),
					  .PCBranchD(PCBranchD_topwire_in),
					  .InstrD(InstrD_topwire_out),
					  .PCPlus4D(PCPlus4D_topwire_out)
						);
						
//InstructionDecode Stage	
ID_EX_Stage IES1(.clk(clk),
                 .clr(FlushE_topwire_in),
					  .RegReset(RegReset),
					  .RegWriteW(RegWriteW_topwire_in),
					  .WriteRegW(WriteRegW_topwire_in),
                 .InstrD(InstrD_topwire_out),
					  .PCPlus4D(PCPlus4D_topwire_out),
					  .ResultW(ResultW_topwire_in),
					  .ForwardA_D(ForwardA_D_topwire_in),
					  .ForwardB_D(ForwardB_D_topwire_in),
					  .ALUOutM(ALUOutM_topwire_in),
					  .RegWriteE(RegWriteE_topwire_out),
					  .MemtoRegE(MemtoRegE_topwire_out),
					  .MemWriteE(MemWriteE_topwire_out),
					  .ALUControlE(ALUControlE_topwire_out),
					  .ALUSrcE(ALUSrcE_topwire_out),
					  .RegDstE(RegDstE_topwire_out),
					  .RD1_E(RD1_E_topwire_out),
					  .RD2_E(RD2_E_topwire_out), 
					  .SignImmE(SignImmE_topwire_out),
					  .RS_E(RS_E_topwire_in),
					  .RT_E(RT_E_topwire_out), 
					  .RD_E(RD_E_topwire_out),
					  .PCBranchD(PCBranchD_topwire_in),
					  .BranchD(BranchD_topwire_out),
					  .PCSrcD(PCSrcD_topwire_in)
					  );

EX_MEM_Stage EMS1(.clk(clk),
				     .RegWriteE(RegWriteE_topwire_out),
					  .MemtoRegE(MemtoRegE_topwire_out),
					  .MemWriteE(MemWriteE_topwire_out),
					  .ALUControlE(ALUControlE_topwire_out),
					  .ALUSrcE(ALUSrcE_topwire_out),
					  .RegDstE(RegDstE_topwire_out),
					  .RD1_E(RD1_E_topwire_out),
					  .RD2_E(RD2_E_topwire_out), 
					  .RsE(RS_E_topwire_in),
					  .RtE(RT_E_topwire_out), 
					  .RdE(RD_E_topwire_out),
                 .SignImmE(SignImmE_topwire_out),
					  .ForwardAE(ForwardAE_topwire_in),
					  .ForwardBE(ForwardBE_topwire_in),
					  .ResultW(ResultW_topwire_in),
					  .RegWriteM(RegWriteM_topwire_out),
					  .MemtoRegM(MemtoRegM_topwire_out),
					  .MemWriteM(MemWriteM_topwire_out),
					  .ALUOutM(ALUOutM_topwire_in),
					  .WriteDataM(WriteDataM_topwire_out),
					  .WriteRegM(WriteRegM_topwire_out),
					  .RsE_out(RS_E_topwire_out)
				     );					  
					 
MEM_WB_Stage MWS1(.clk(clk),
             .RegWriteM(RegWriteM_topwire_out),
				 .MemtoRegM(MemtoRegM_topwire_out),
				 .MemWriteM(MemWriteM_topwire_out),
				 .ALUOutM(ALUOutM_topwire_in),
				 .WriteDataM(WriteDataM_topwire_out),
				 .WriteRegM(WriteRegM_topwire_out),
             .RegWriteW(RegWriteW_topwire_in),
				 .MemtoRegW(MemtoRegW_topwire_out),
				 .ReadDataW(ReadDataW_topwire_out),
				 .ALUOutW(ALUOutW_topwire_out),
				 .WriteRegW(WriteRegW_topwire_in)
				 );					 
				
WB_Stage WS1(
          .RegWriteW(RegWriteW_topwire_in),
			 .MemtoRegW(MemtoRegW_topwire_out),
			 .ReadDataW(ReadDataW_topwire_out),
			 .ALUOutW(ALUOutW_topwire_out),
			 .WriteRegW(WriteRegW_topwire_in),
          .ResultW(ResultW_topwire_in)
         );		
	
hazard_unit hu1(
            .BranchD(BranchD_topwire_out),
				.RsD(InstrD_topwire_out[25:21]),
				.RtD(InstrD_topwire_out[20:16]),
				.RsE(RS_E_topwire_out),
				.RtE(RT_E_topwire_out),
				.WriteRegE(WriteRegM_topwire_out),
				.MemtoRegE(MemtoRegE_topwire_out),
				.RegWriteE(RegWriteE_topwire_out),
				.WriteRegM(WriteRegM_topwire_out),
				.RegWriteM(RegWriteM_topwire_out),
				.WriteRegW(WriteRegW_topwire_in),
				.RegWriteW(RegWriteW_topwire_in),
				.StallF(StallF_topwire_in),
				.StallD(StallD_topwire_in),
				.FlushE(FlushE_topwire_in),
				.ForwardAE(ForwardAE_topwire_in),
				.ForwardBE(ForwardBE_topwire_in),
				.ForwardAD(ForwardA_D_topwire_in),
				.ForwardBD(ForwardB_D_topwire_in)
				
);	

assign ResultRegisterValue = ResultW_topwire_in[0];		
		
endmodule

