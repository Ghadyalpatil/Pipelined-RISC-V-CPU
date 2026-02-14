module mem_stage (
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory [255:0];

always @(posedge clk) begin
    if (mem_write)
        memory[address] <= write_data;
end

always @(*) begin
    if (mem_read)
        read_data = memory[address];
    else
        read_data = 32'b0;
end

endmodule
