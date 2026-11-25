
`timescale 1ns / 1ps

module Memoria_Datos (
    input clk,
    input MemWrite,
    input MemRead,
    input [31:0] Address,
    input [31:0] WriteData,
    output [31:0] ReadData
);
    reg [31:0] ram [0:63];
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            ram[i] = 32'd0;
        end
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            ram[Address[7:2]] <= WriteData;
        end
    end

    assign ReadData = (MemRead) ? ram[Address[7:2]] : 32'd0;
endmodule