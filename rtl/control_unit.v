module control_unit (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg [3:0] alu_control
);

always @(*) begin

    // Default values
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    alu_control = 4'b0000;

    case (opcode)

        7'b0110011: begin  // R-type
            reg_write = 1;

            case ({funct7, funct3})
                {7'b0000000, 3'b000}: alu_control = 4'b0000; // ADD
                {7'b0100000, 3'b000}: alu_control = 4'b0001; // SUB
                {7'b0000000, 3'b111}: alu_control = 4'b0010; // AND
                {7'b0000000, 3'b110}: alu_control = 4'b0011; // OR
                default: alu_control = 4'b0000;
            endcase
        end

        7'b0000011: begin // LW
            reg_write = 1;
            mem_read = 1;
            alu_control = 4'b0000; // ADD for address calculation
        end

        7'b0100011: begin // SW
            mem_write = 1;
            alu_control = 4'b0000; // ADD for address calculation
        end

    endcase

end

endmodule
