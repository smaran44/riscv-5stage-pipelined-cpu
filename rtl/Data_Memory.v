module Data_Memory(clk, rst, WE, WD, A, RD);

    input clk, rst, WE;
    input [31:0] A, WD;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

    // Write data to memory
    always @(posedge clk) begin
        if (WE)
            mem[A] <= WD;
    end

    // Read data from memory
    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        mem[0] = 32'h00000000;
    end

endmodule