module program_counter #(parameter width = 32)(input clk,
input [(width-1):0]pc,
input enable,
output reg [(width-1):0]pcf);
initial
begin
pcf= 32'b0;
end

always@(posedge clk)
begin
if (enable==1)
   pcf<= pc;
end	
endmodule