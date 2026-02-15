module riscv_top(
    input clk,
    input [31:0] instruction
);

/////////////////////////////////////////////////
// IF STAGE
/////////////////////////////////////////////////

reg [31:0] IF_ID_instr;

always @(posedge clk)
    IF_ID_instr <= instruction;

/////////////////////////////////////////////////
// ID STAGE
/////////////////////////////////////////////////

wire [4:0] rs1 = IF_ID_instr[19:15];
wire [4:0] rs2 = IF_ID_instr[24:20];
wire [4:0] rd  = IF_ID_instr[11:7];

wire [31:0] read_data1, read_data2;

wire reg_write;
wire [3:0] alu_op;

control_unit cu(
    .instruction(IF_ID_instr),
    .reg_write(reg_write),
    .alu_op(alu_op)
);

register_file rf(
    .clk(clk),
    .reg_write(MEM_WB_reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(MEM_WB_rd),
    .write_data(MEM_WB_result),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

/////////////////////////////////////////////////
// ID/EX PIPELINE REGISTER
/////////////////////////////////////////////////

reg [31:0] ID_EX_data1, ID_EX_data2;
reg [4:0]  ID_EX_rd;
reg [3:0]  ID_EX_alu_op;
reg        ID_EX_reg_write;

always @(posedge clk) begin
    ID_EX_data1     <= read_data1;
    ID_EX_data2     <= read_data2;
    ID_EX_rd        <= rd;
    ID_EX_alu_op    <= alu_op;
    ID_EX_reg_write <= reg_write;
end

/////////////////////////////////////////////////
// EX STAGE
/////////////////////////////////////////////////

wire [31:0] alu_result;

alu alu_inst(
    .a(ID_EX_data1),
    .b(ID_EX_data2),
    .alu_op(ID_EX_alu_op),
    .result(alu_result)
);

/////////////////////////////////////////////////
// EX/MEM PIPELINE REGISTER
/////////////////////////////////////////////////

reg [31:0] EX_MEM_result;
reg [4:0]  EX_MEM_rd;
reg        EX_MEM_reg_write;

always @(posedge clk) begin
    EX_MEM_result    <= alu_result;
    EX_MEM_rd        <= ID_EX_rd;
    EX_MEM_reg_write <= ID_EX_reg_write;
end

/////////////////////////////////////////////////
// MEM STAGE (currently passthrough)
/////////////////////////////////////////////////

/////////////////////////////////////////////////
// MEM/WB PIPELINE REGISTER
/////////////////////////////////////////////////

reg [31:0] MEM_WB_result;
reg [4:0]  MEM_WB_rd;
reg        MEM_WB_reg_write;

always @(posedge clk) begin
    MEM_WB_result    <= EX_MEM_result;
    MEM_WB_rd        <= EX_MEM_rd;
    MEM_WB_reg_write <= EX_MEM_reg_write;
end

endmodule
