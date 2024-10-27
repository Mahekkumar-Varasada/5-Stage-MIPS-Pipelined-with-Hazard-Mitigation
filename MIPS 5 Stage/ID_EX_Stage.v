 /*`include "Control_unit.v"
 `include "register_file.v"
 `include "sign_extend.v"
 //`include "mux2x1.v"
 `include "br_adder.v"
 `include "shift_left_two.v"
 `include "mux2x1_2.v"
 `include "mux2x1_3.v"*/
 

module ID_EX_Stage(
    input clk, 
	 input clr,
	 input RegReset,
	 input RegWriteW,
    input [4:0] WriteRegW,
    input [31:0] InstrD,
	 input [31:0] PCPlus4D, 
	 input [31:0] ResultW,
    input ForwardA_D, 
	 input ForwardB_D,
    input [31:0]ALUOutM,
    output RegWriteE,
	 output MemtoRegE,
	 output MemWriteE,
	 output [2:0] ALUControlE,
	 output ALUSrcE,
	 output RegDstE,
    output [31:0] RD1_E,
	 output [31:0] RD2_E, 
	 output [31:0] SignImmE,
    output [4:0] RS_E, 
	 output [4:0] RT_E, 
	 output [4:0] RD_E,
	 output [31:0] PCBranchD,
	 output BranchD,
	 output PCSrcD
    ) ;
    
    // Declare Interim Wires
    wire RegWriteD;
	 wire MemtoRegD;
	 wire MemWriteD;
	 wire [2:0] ALUControlD;
	 wire ALUSrcD;
	 wire RegDstD;
    wire BranchD_wire;
	 wire EqualD;
    wire [31:0] RD1_D;
	 wire [31:0] RD2_D;
	 wire [31:0] RD1_D_MUX;
	 wire [31:0] RD2_D_MUX;
    wire [4:0] RS_D_WIRE;
	 wire [4:0] RT_D_WIRE;
	 wire [4:0] RD_D_WIRE;
	 wire [31:0] SignImmD;
	 wire [31:0] shift_by_2;

    // Declaration of Interimediate Register
	 
	 reg RegWriteD_r;
	 reg MemtoRegD_r;
	 reg MemWriteD_r;
	 reg [2:0] ALUControlD_r;
	 reg ALUSrcD_r;
	 reg RegDstD_r;
    reg [31:0] RD1_r;
	 reg [31:0] RD2_r;
    reg [4:0] RS_D_r;
	 reg [4:0] RT_D_r;
	 reg [4:0] RD_D_r;
	 reg [31:0] SignImmD_r;
	 
    assign RS_D_WIRE = InstrD[25:21];
    assign RT_D_WIRE = InstrD[20:16];
	 assign RD_D_WIRE = InstrD[15:11];
	 

	 
    // Initiate the modules


    // Register File
    register_file rf (
                        .clock(clk),
                        .Regreset(RegReset),
                        .WE3(RegWriteW),
                        .WD3(ResultW),
                        .A1(InstrD[25:21]),
                        .A2(InstrD[20:16]),
                        .A3(WriteRegW),
                        .RD1(RD1_D),
                        .RD2(RD2_D)
                        );


    mux2x1_2 execute_src_1 (
            .d0(RD1_D),
            .d1(ALUOutM),
            .s(ForwardA_D),
            .y(RD1_D_MUX)
            );

    mux2x1_3 execute_src_2 (
            .d0(RD2_D),
            .d1(ALUOutM),
            .s(ForwardB_D),
            .y(RD2_D_MUX)
            );

assign EqualD = (RD1_D_MUX == RD2_D_MUX)? 1'b1:1'b0;

    // Control Unit
    Control_unit controlu (
                            .op(InstrD[31:26]),
									 .funct(InstrD[5:0]),
									 .EqualD(EqualD),
                            .regwrite(RegWriteD),
                            .memtoreg(MemtoRegD),
									 .memwrite(MemWriteD),
									 .alucontrol(ALUControlD),
                            .alusrc(ALUSrcD),
									 .regdst(RegDstD),
									 .pcsrc(PCSrcD),
									  .BranchD(BranchD_wire)
                          );

    // Sign Extension
    sign_extend extension (
                        .a(InstrD[15:0]),
                        .b(SignImmD)
                        );
   //shift left by two
	shift_left_two slbt (
	                    .In32(SignImmD),
                       .Out32(shift_by_2)	
	                    );
   // Branch adder
	br_adder br1(
	         .a(shift_by_2),
				.b(PCPlus4D),
				.sum(PCBranchD)
	         );
				
							  
   // Declaring Register Logic
    always @(posedge clk or posedge clr) begin
        if(clr == 1'b1) begin
		  
				 RegWriteD_r<= 1'b0;
				 MemtoRegD_r<=1'b0;
				 MemWriteD_r<=1'b0;
				 ALUControlD_r<=3'b0;
				 ALUSrcD_r<=1'b0;
				 RegDstD_r<=1'b0;
				 RD1_r<=32'h00000000;
				 RD2_r<=32'h00000000;
				 RS_D_r<=5'h00;
				 RT_D_r<=5'h00;
				 RD_D_r<=5'h00;
				 SignImmD_r<=32'h00000000; 
		  
        end
        else begin
		  
		   
		       RegWriteD_r<= RegWriteD;
				 MemtoRegD_r<=MemtoRegD;
				 MemWriteD_r<=MemWriteD;
				 ALUControlD_r<=ALUControlD;
				 ALUSrcD_r<=ALUSrcD;
				 RegDstD_r<=RegDstD;
				 RD1_r<=RD1_D;
				 RD2_r<=RD2_D;
				 RS_D_r<=RS_D_WIRE;
				 RT_D_r<=RT_D_WIRE;
				 RD_D_r<=RD_D_WIRE;
				 SignImmD_r<=SignImmD; 
		  
        end
    end

    // Output asssign statements
	 	 
    assign RegWriteE = RegWriteD_r;
    assign MemtoRegE = MemtoRegD_r;
    assign MemWriteE = MemWriteD_r;
	 assign ALUControlE = ALUControlD_r;
	 assign ALUSrcE =  ALUSrcD_r;
	 assign RegDstE = RegDstD_r;
	
    assign RD1_E = RD1_r;
    assign RD2_E = RD2_r;
	 
	 assign RS_E = RS_D_r;
	 assign RT_E = RT_D_r;
	 assign RD_E = RD_D_r;
	 
    assign SignImmE =  SignImmD_r;
    assign BranchD = BranchD_wire;
    
endmodule