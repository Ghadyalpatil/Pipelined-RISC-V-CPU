`timescale 1ns/1ps

module top_tb;

initial begin
    $display("HELLO WORLD");
    #10;
    $finish;
end

endmodule
