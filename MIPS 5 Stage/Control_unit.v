module Control_unit (
input [5:0] op,
input [5:0] funct,
input EqualD,
output regwrite,
output memtoreg,
output memwrite,
output [2:0] alucontrol,
output alusrc,
output regdst,
output pcsrc,
output BranchD
);
wire [1:0] aluop;
wire branch;

maindec md (op, memtoreg, memwrite, branch, alusrc, regdst, regwrite,aluop);
aludec ad (funct, aluop, alucontrol);

assign BranchD= branch;
assign pcsrc= BranchD & EqualD;
endmodule

module maindec(
input [5:0] op,
output memtoreg,
output memwrite,
output branch,
output alusrc,
output regdst,
output regwrite,
                      //jump is not included in architecture but still gets generated for future integrations.
output [1:0] aluop);

reg [7:0] controls;
assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop} = controls; //
always @ (*)
case(op)
6'b000000: controls <= 8'b11000010; //Rtyp
6'b100011: controls <= 8'b10100100; //LW
6'b101011: controls <= 8'b00101000; //SW
6'b000100: controls <= 8'b00010001; //BEQ
6'b001000: controls <= 8'b10100000; //ADDI
                                     //J not include 
default: controls <= 8'bxxxxxxxx;   //unknown
endcase
endmodule

module aludec (input [5:0] funct,
input [1:0] aluop,
output reg [2:0] alucontrol);
always @ (*)
case (aluop)
2'b00: alucontrol <= 3'b010;     // add
2'b01: alucontrol <= 3'b110;     // sub

default: case(funct)             // RTYPE
6'b100000: alucontrol <= 3'b010; // ADD
6'b100010: alucontrol <= 3'b110; // SUB
6'b100100: alucontrol <= 3'b000; // AND
6'b100101: alucontrol <= 3'b001; // OR
6'b101010: alucontrol <= 3'b111; // SLT
default: alucontrol <= 3'bxxx;   // unknown
endcase
endcase
endmodule
