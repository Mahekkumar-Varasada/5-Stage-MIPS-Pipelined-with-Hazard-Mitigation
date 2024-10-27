module IF_ID_Stage(
input clk, 
input StallD,
input PCSrcD,   // clr as same
input StallF,
input [31:0] PCBranchD,
output [31:0] InstrD,
output [31:0] PCPlus4D);

wire [31:0] PC_P, PCF, PCPlus4F, inst_fetched; //PC_P is  PC'

reg [31:0] Inst_Fetch_reg;
reg [31:0] PCPlus4F_reg;



mux2x1_1 MUX_IF(
    .d0(PCPlus4F),
    .d1(PCBranchD),
    .s(PCSrcD),
    .y(PC_P)
);

program_counter  PC_IF(
    .clk(clk),
	 .pc(PC_P),
	 .enable(~StallF),
	 .pcf(PCF)
);

Pcplus4_adder PCADD4_IF(
    .a(PCF),
	 .c(PCPlus4F)
);

instruction_memory InstrMem_IF(
    .address(PCF),
	 .data(inst_fetched)
);


always @(posedge clk or posedge PCSrcD)
begin
 if(PCSrcD== 1'b1) begin
        Inst_Fetch_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
    end
else begin
        if(StallD==0)                         //StallD=0 as Enable =1
		   begin 
          Inst_Fetch_reg <= inst_fetched;
          PCPlus4F_reg <= PCPlus4F;
			end
    end
end


assign InstrD = Inst_Fetch_reg;
assign PCPlus4D = PCPlus4F_reg;

endmodule
	 