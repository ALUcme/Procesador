module Mux2a1 #(
    parameter ANCHO = 32
)(
    input [ANCHO-1:0] A,      // Entrada 0
    input [ANCHO-1:0] B,      // Entrada 1
    input sel,                // Selector (0 = A, 1 = B)
    output [ANCHO-1:0] Salida // Dato que pasa
);

    assign Salida = (sel == 1'b0) ? A : B;

endmodule