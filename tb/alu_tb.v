`timescale 1ns/1ps

module alu_tb;

reg  [31:0] a;
reg  [31:0] b;
reg  [3:0]  alu_control;
wire [31:0] result;
wire zero;

alu uut (
    .a(a),
    .b(b),
    .alu_control(alu_control),
    .result(result),
    .zero(zero)
);

initial begin
    a = 20; b = 5;

    alu_control = 4'b0000; #10; // ADD
    $display("ADD Result = %d", result);

    alu_control = 4'b0001; #10; // SUB
    $display("SUB Result = %d", result);

    alu_control = 4'b0010; #10; // AND
    $display("AND Result = %d", result);

    alu_control = 4'b0011; #10; // OR
    $display("OR Result = %d", result);

    $finish;
end

endmodule
