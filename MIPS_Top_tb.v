`timescale 1ns / 1ps

module MIPS_Top_tb;

    reg clk;
    reg reset;

    wire [31:0] PC_Actual;
    wire [31:0] Instruccion_Actual;
    wire [31:0] ALU_Resultado;
    wire [31:0] Dato_Escrito_Reg;
    wire Zero_Flag;

    MIPS_Top uut (
        .clk(clk),
        .reset(reset),
        .PC_Actual(PC_Actual),
        .Instruccion_Actual(Instruccion_Actual),
        .ALU_Resultado(ALU_Resultado),
        .Dato_Escrito_Reg(Dato_Escrito_Reg),
        .Zero_Flag(Zero_Flag)
    );

    always #5 clk = ~clk;

    integer ciclo;

    initial begin
        clk = 0;
        reset = 1;
        #12;
        reset = 0;

        for (ciclo = 1; ciclo <= 20; ciclo = ciclo + 1) begin
            @(negedge clk);
            $display("Ciclo %02d | PC: 0x%02h | Inst: 0x%08h | ALUOut: 0x%08h (%0d) | Zero: %b",
                     ciclo, PC_Actual, Instruccion_Actual, ALU_Resultado, $signed(ALU_Resultado), Zero_Flag);
        end

        @(posedge clk);
        #2;

        $display("\n================ VERIFICACION AUTOMATICA DE RESULTADOS ================");
        check_reg(5'd0,  32'd0,         "$zero (Proteccion escritura)");
        check_reg(5'd8,  32'd20,        "$t0   (addi positivo)");
        check_reg(5'd9,  32'd15,        "$t1   (addi negativo -5)");
        check_reg(5'd10, 32'd35,        "$t2   (add)");
        check_reg(5'd11, 32'd5,         "$t3   (sub)");
        check_reg(5'd12, 32'd4,         "$t4   (and)");
        check_reg(5'd13, 32'd31,        "$t5   (or)");
        check_reg(5'd14, 32'd1,         "$t6   (slt verdadero)");
        check_reg(5'd15, 32'd0,         "$t7   (slt falso)");
        check_reg(5'd16, 32'h0000000F,  "$s0   (andi bit15=1 ext ceros)");
        check_reg(5'd17, 32'h0000F00F,  "$s1   (ori  bit15=1 ext ceros)");
        check_reg(5'd18, 32'd0,         "$s2   (slti negativo falso)");
        check_reg(5'd20, 32'd1,         "$s4   (slti negativo verdadero)");
        check_reg(5'd21, 32'd35,        "$s5   (lw desde Mem[8])");
        check_reg(5'd22, 32'd0,         "$s6   (Omitido por beq tomado)");
        check_reg(5'd23, 32'd77,        "$s7   (Salto j ejecutado)");

        if (uut.u_dmem.ram[2] === 32'd35)
            $display("[PASS] Memoria[0x08] (sw) -> Valor: %0d", uut.u_dmem.ram[2]);
        else
            $display("[FAIL] Memoria[0x08] (sw) -> Esperado: 35, Obtenido: %0d", uut.u_dmem.ram[2]);

        $display("==========================================================================");
        $stop;
    end

    task check_reg;
        input [4:0] reg_num;
        input [31:0] esperado;
        input [255:0] nombre;
        begin
            if (uut.u_rf.registros[reg_num] === esperado)
                $display("[PASS] %0s -> Obtenido: 0x%08h (%0d)", nombre, uut.u_rf.registros[reg_num], $signed(uut.u_rf.registros[reg_num]));
            else
                $display("[FAIL] %0s -> Esperado: 0x%08h, Obtenido: 0x%08h", nombre, esperado, uut.u_rf.registros[reg_num]);
        end
    endtask

endmodule