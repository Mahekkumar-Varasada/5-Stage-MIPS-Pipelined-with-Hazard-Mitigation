module register_file(
    input clock,
    input Regreset,
    input WE3,         // WE: Write Enable
    input [4:0] A1,    // 5-bit address1 for read source1
    input [4:0] A2,    // 5-bit address2 for read source2
    input [4:0] A3,    // 5-bit address3 for write destination
    input [31:0] WD3,  // WD: Write Data
    output [31:0] RD1, // RD: Read Data of source1
    output [31:0] RD2  // RD: Read Data of source2
);
    
    reg [31:0] register_memory[31:0]; // Register memory
    integer i;     
    // Assign read data outputs, force RD1 and RD2 to 0 if reading from $r0 (A1 or A2 == 0)
    assign RD1 = (A1 == 5'b00000) ? 32'h00000000 : register_memory[A1];
    assign RD2 = (A2 == 5'b00000) ? 32'h00000000 : register_memory[A2];

    // Reset and Write process
    always @ (posedge clock or posedge Regreset) begin
        if (Regreset == 1'b1) begin
                              
            for (i = 0; i < 32; i = i + 1) begin
                register_memory[i] <= 32'h00000000; // Clear register values
            end
        end
        else begin
            // Write data only if WE3 is enabled and A3 is not $r0 (register 0)
            if (WE3 == 1'b1 && (A3 != 5'b00000)) begin
                register_memory[A3] <= WD3; // Write data when enabled and address is not zero
            end
        end
    end

endmodule
