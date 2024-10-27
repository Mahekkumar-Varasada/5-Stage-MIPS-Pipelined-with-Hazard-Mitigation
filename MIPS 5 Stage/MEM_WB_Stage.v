module MEM_WB_Stage(
input clk,
input RegWriteM,
input MemtoRegM,
input MemWriteM,
input[31:0]ALUOutM,
input[31:0]WriteDataM,
input[4:0]WriteRegM,
output RegWriteW,
output MemtoRegW,
output[31:0] ReadDataW,
output[31:0]ALUOutW,
output[4:0]WriteRegW
);
// defining stage register
reg RegWriteM_r;
reg MemtoRegM_r;
reg [31:0]ReadDataM_r;
reg [31:0]ALUOutM_r;
reg [4:0]WriteRegM_r;

//defining interim wires.
wire[31:0]ReadDataM;

Data_memory dm1  (.a(ALUOutM),
                .wd(WriteDataM),
					 .we(MemWriteM),
					 .rd(ReadDataM),
					 .clk(clk)
					 );
					 
always@(posedge clk)
begin
    RegWriteM_r <= RegWriteM;
	 MemtoRegM_r <= MemtoRegM;
	 ReadDataM_r <= ReadDataM;
	 ALUOutM_r   <= ALUOutM;
	 WriteRegM_r <= WriteRegM;
end					 
					 
assign WriteRegW = WriteRegM_r;
assign ALUOutW   = ALUOutM_r;
assign ReadDataW = ReadDataM_r;
assign MemtoRegW = MemtoRegM_r;
assign RegWriteW = RegWriteM_r;  
					 
endmodule