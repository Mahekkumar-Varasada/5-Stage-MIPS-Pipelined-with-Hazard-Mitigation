module hazard_unit (
    input BranchD,            // Branch signal from Decode stage
    input [4:0] RsD,          // Source register from Decode stage
    input [4:0] RtD,          // Target register from Decode stage
    input [4:0] RsE,          // Source register from Execute stage
    input [4:0] RtE,          // Target register from Execute stage
    input [4:0] WriteRegE,    // Write register from Execute stage
    input MemtoRegE,          // Memory to register signal from Execute stage
    input RegWriteE,          // Register write signal from Execute stage
    input [4:0] WriteRegM,    // Write register from Memory stage
    input RegWriteM,          // Register write signal from Memory stage
    input [4:0] WriteRegW,    // Write register from Write-back stage
    input RegWriteW,          // Register write signal from Write-back stage
    output reg StallF,        // Stall signal for Fetch stage
    output reg StallD,        // Stall signal for Decode stage
    output reg FlushE,        // Flush signal for Execute stage
    output reg [1:0] ForwardAE, // Forwarding signal for RsE
    output reg [1:0] ForwardBE, // Forwarding signal for RtE
    output reg ForwardAD,     // Forwarding signal for RsD
    output reg ForwardBD      // Forwarding signal for RtD
);

    // Forwarding logic for Execute stage (AE, BE)
    always @(*) begin
        // Forward for RsE
        if ((RsE != 0) && (RsE == WriteRegM) && RegWriteM)
            ForwardAE = 2'b10;  // Forward from Memory stage
        else if ((RsE != 0) && (RsE == WriteRegW) && RegWriteW)
            ForwardAE = 2'b01;  // Forward from Write-back stage
        else
            ForwardAE = 2'b00;  // No forwarding

        // Forward for RtE
        if ((RtE != 0) && (RtE == WriteRegM) && RegWriteM)
            ForwardBE = 2'b10;  // Forward from Memory stage
        else if ((RtE != 0) && (RtE == WriteRegW) && RegWriteW)
            ForwardBE = 2'b01;  // Forward from Write-back stage
        else
            ForwardBE = 2'b00;  // No forwarding
    end

    // Forwarding logic for Decode stage (AD, BD)
    always @(*) begin
        ForwardAD = (RsD != 0) && (RsD == WriteRegM) && RegWriteM;
        ForwardBD = (RtD != 0) && (RtD == WriteRegM) && RegWriteM;
    end

    // Branch stall detection logic
    wire branchstall;
    assign branchstall = BranchD && RegWriteE && 
                         ((WriteRegE == RsD) || (WriteRegE == RtD)) || 
                         BranchD && MemtoRegE && 
                         ((WriteRegM == RsD) || (WriteRegM == RtD));

    // Stall and Flush signals
    always @(*) begin
        StallF = branchstall;
        StallD = branchstall;
        FlushE = branchstall;
    end

endmodule
