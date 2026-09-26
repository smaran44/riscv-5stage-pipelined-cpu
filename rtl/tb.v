module tb();

    reg clk = 0;
    reg rst;

    // Clock generation: 10 MHz
    always begin
        clk = ~clk;
        #50;
    end

    // Reset and simulation control
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;

        #1000;
        $finish;
    end

    // Waveform dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

    // DUT
    Pipeline_top dut (
        .clk(clk),
        .rst(rst)
    );

endmodule