module ex_stage (
    input [31:0] operand1,
    input [31:0] operand2,
    input [3:0] alu_control,
    output [31:0] alu_result,
    output zero
);

alu alu_inst (
    .a(operand1),
    .b(operand2),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
);

endmodule
