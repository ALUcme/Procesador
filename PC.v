module 
    pc (
        // direccion calculada de la siguiente instruccion
        input  wire [31:0] n_calc_dr, 
        // direccion de intruccion actual
        output reg  [31:0] instrc_dr, 
        input  wire        clk,
        input  wire        reset
    );
    // asignacion de siguientes instrucciones
    always @(posedge clk or posedge reset) begin
        // reset
        if (reset) instrc_dr <= 32'h00000000;
        else instrc_dr <= n_calc_dr;
    end
endmodule