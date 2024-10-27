module WB_Stage(
input RegWriteW,
input MemtoRegW,
input [31:0]ReadDataW,
input [31:0]ALUOutW,
input [4:0]WriteRegW,
output [31:0]ResultW
);

 
mux2x1_5 m1(.d0(ALUOutW),
          .d1(ReadDataW),
			 .s(MemtoRegW),
			 .y(ResultW)
          );

endmodule
