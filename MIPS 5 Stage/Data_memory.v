module Data_memory(
input [31:0]a,
input [31:0]wd,
input we,
output [31:0]rd,
input clk);

reg[31:0]data_mem[31:0];
assign rd = data_mem[a[31:2]];

always@(posedge clk)
 if(we)
   data_mem[a[31:2]]<=wd;
endmodule