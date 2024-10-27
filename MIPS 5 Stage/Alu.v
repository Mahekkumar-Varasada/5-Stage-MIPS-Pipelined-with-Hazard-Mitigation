module Alu(
input [31:0]A,B,
input [2:0]ALUControl,
output [31:0]Result
);

//wire cout;
assign Result = (ALUControl==3'b010)?(A+B):                      //sum                          
                       (ALUControl==3'b110)?(A + (~B) + 32'h00000001):  //sub
					        (ALUControl==3'b000)?(A&B):                      //and
					        (ALUControl==3'b001)?(A|B):                      //or
					        (ALUControl==3'b111)?( A << B[4:0]):             //slt
					        {32{1'b0}};
					 

endmodule
