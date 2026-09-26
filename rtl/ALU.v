module ALU(A, B, Result, ALUControl, OverFlow, Carry, Zero, Negative);

    input [31:0] A, B;
    input [2:0] ALUControl;
    output [31:0] Result;
    output OverFlow, Carry, Zero, Negative;

    wire Cout;
    wire [31:0] Sum;

    // ALUControl[0] = 0 -> Addition
    // ALUControl[0] = 1 -> Subtraction (A - B)
    assign Sum = (ALUControl[0] == 1'b0) ? A + B : A + ((~B) + 1);

    // ALU operation selection
    // 000 -> ADD
    // 001 -> SUB
    // 010 -> AND
    // 011 -> OR
    // 101 -> SLT
    assign {Cout, Result} = (ALUControl == 3'b000) ? Sum :
                            (ALUControl == 3'b001) ? Sum :
                            (ALUControl == 3'b010) ? A & B :
                            (ALUControl == 3'b011) ? A | B :
                            (ALUControl == 3'b101) ? {31'b0, Sum[31]} :
                                                      33'b0;

    // Signed overflow detection
    assign OverFlow = (Sum[31] ^ A[31]) &
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]);

    // Carry is valid for ADD/SUB
    assign Carry = (~ALUControl[1]) & Cout;

    // Result is zero
    assign Zero = &(~Result);

    // Sign bit of result
    assign Negative = Result[31];

endmodule