`timescale 1ns / 1ps

module Extensor_Inmediato (
    input [15:0] Inmediato,
    input ExtOp,
    output [31:0] ImmExt
);
    assign ImmExt = (ExtOp == 1'b1) ? {{16{Inmediato[15]}}, Inmediato} : {16'd0, Inmediato};
endmodule
