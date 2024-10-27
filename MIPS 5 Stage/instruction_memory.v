module instruction_memory #(parameter width=32)(
input [width-1:0]address,
output [width-1:0]data);

reg [width-1:0]instrmem[0:31];

//pc can address 2^32 locations but we use as per program size, also pc+4 is there so last two bits is zero.
//as we read file zeroth location is next data after @00000000 and inc 4 to access next instruction. 
initial begin
$readmemh("instrmemfile_Copy.hex",instrmem);
end

assign data = instrmem[address[width-1:2]];

endmodule
