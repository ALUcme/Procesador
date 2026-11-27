module ShiftLeft2 #(
    parameter ANCHO_IN = 32,
    parameter ANCHO_OUT = 32
)(
    input [ANCHO_IN-1:0] entrada,
    output [ANCHO_OUT-1:0] salida
);

    // Recorre 2 bits a la izquierda y rellena con ceros
    assign salida = {entrada[ANCHO_IN-3:0], 2'b00};

endmodule