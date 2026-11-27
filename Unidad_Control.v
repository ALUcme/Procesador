module Unidad_Control (
    input [5:0] opcode,
    output reg RegDst,
    output reg ALU_Src,
    output reg MemToReg,
    output reg en_BR,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALU_Op
);

    always @(*) begin
        // Valores por defecto (todo apagado)
        RegDst   = 1'b0;
        ALU_Src  = 1'b0;
        MemToReg = 1'b0;
        en_BR    = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        Branch   = 1'b0;
        Jump     = 1'b0;
        ALU_Op   = 2'b00;

        case (opcode)
            // Formato R: add, sub, slt, or, and (opcode = 000000)
            6'b000000: begin
                RegDst   = 1'b1;
                ALU_Src  = 1'b0;
                MemToReg = 1'b0;
                en_BR    = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b10;
            end

            // lw: cargar palabra de memoria (opcode = 100011)
            6'b100011: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b1;
                en_BR    = 1'b1;
                MemRead  = 1'b1;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b00;
            end

            // sw: guardar palabra en memoria (opcode = 101011)
            6'b101011: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b0;
                en_BR    = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b1;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b00;
            end

            // beq: saltar si son iguales (opcode = 000100)
            6'b000100: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b0;
                MemToReg = 1'b0;
                en_BR    = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b1;
                Jump     = 1'b0;
                ALU_Op   = 2'b01;
            end

            // addi: sumar inmediato (opcode = 001000)
            6'b001000: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b0;
                en_BR    = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b00;
            end

            // andi: AND con inmediato (opcode = 001100)
            6'b001100: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b0;
                en_BR    = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b11;
            end

            // ori: OR con inmediato (opcode = 001101)
            6'b001101: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b0;
                en_BR    = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b01;
            end

            // slti: menor que con inmediato (opcode = 001010)
            6'b001010: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b1;
                MemToReg = 1'b0;
                en_BR    = 1'b1;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b0;
                ALU_Op   = 2'b10;
            end

            // j: salto incondicional (opcode = 000010)
            6'b000010: begin
                RegDst   = 1'b0;
                ALU_Src  = 1'b0;
                MemToReg = 1'b0;
                en_BR    = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                Branch   = 1'b0;
                Jump     = 1'b1;
                ALU_Op   = 2'b00;
            end
        endcase
    end

endmodule