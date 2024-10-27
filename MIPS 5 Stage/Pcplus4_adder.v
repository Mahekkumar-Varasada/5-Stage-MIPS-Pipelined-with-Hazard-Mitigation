module Pcplus4_adder #(parameter width = 32)
(
    input wire [width-1:0] a,      // Input A
    output wire [width-1:0] c      // Output C
);

    // Declare constant value for 4 (PC + 4 increment)
    wire [width-1:0] b = 32'b00000000000000000000000000000100;

    // Add a + b
    assign c = a + b;

endmodule
