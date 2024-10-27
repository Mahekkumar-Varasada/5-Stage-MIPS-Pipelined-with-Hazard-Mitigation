module sign_extend(input [15:0] a, output [31:0] b);

// Zero extension: pad the upper 16 bits with zeros.
assign b = {{16{a[15]}}, a};

endmodule