module inst_mem (
    // direccion de intruccion actual
    input  wire [31:0] instrc_dr,
    // instruccion recuperada
    output wire [31:0] rec_instc
);
    // Memoria de memoria (256 palabras de 32 bits)
    reg [31:0] mem [0:255];
    // Cargar instrucciones.mem (archivo externo)
    initial begin
        $readmemh("instrucciones.mem", mem);
    end

    // Recuperacion de instruccion 8 bits - 2 LSB [9:2]
    assign rec_instc = mem[instrc_dr[9:2]]; 
endmodule