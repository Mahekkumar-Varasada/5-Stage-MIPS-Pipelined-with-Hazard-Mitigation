module mux2x1_3 # (parameter WIDTH =32)
(input [WIDTH-1:0] d0, d1,
input s,
output [WIDTH-1:0] y);
assign y=(s==1'b0) ? d0 : d1;
endmodule