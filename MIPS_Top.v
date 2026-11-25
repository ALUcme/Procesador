`timescale 1ns / 1ps

module MIPS_Top (
    input clk,
    input reset,
    output [31:0] PC_Actual,
    output [31:0] Instruccion_Actual,
    output [31:0] ALU_Resultado,
    output [31:0] Dato_Escrito_Reg,
    output Zero_Flag
);
    wire [31:0] pc_out, pc_next, pc_plus4, branch_target, jump_target, mux4_out;
    wire [31:0] dr1, dr2, imm_ext, alu_b, mem_read_data;
    wire [4:0]  write_reg;
    wire [3:0]  alu_ctl;
    wire [2:0]  alu_op;
    wire reg_dst, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, en_br, ext_op, pc_src;

    assign PC_Actual = pc_out;

    PC u_pc (
        .clk(clk),
        .reset(reset),
        .PC_Next(pc_next),
        .PC_Out(pc_out)
    );

    Memoria_Instrucciones u_imem (
        .PC(pc_out),
        .Instruccion(Instruccion_Actual)
    );

    Unidad_Control u_ctrl (
        .op(Instruccion_Actual[31:26]),
        .RegDst(reg_dst),
        .Jump(jump),
        .Branch(branch),
        .MemRead(mem_read),
        .MemToReg(mem_to_reg),
        .ALUOp(alu_op),
        .MemWrite(mem_write),
        .ALUSrc(alu_src),
        .en_BR(en_br),
        .ExtOp(ext_op)
    );

    assign write_reg = (reg_dst) ? Instruccion_Actual[15:11] : Instruccion_Actual[20:16];

    Banco_Registros u_rf (
        .clk(clk),
        .reset(reset),
        .en_BR(en_br),
        .AR1(Instruccion_Actual[25:21]),
        .AR2(Instruccion_Actual[20:16]),
        .AW(write_reg),
        .DW(Dato_Escrito_Reg),
        .DR1(dr1),
        .DR2(dr2)
    );

    Extensor_Inmediato u_ext (
        .Inmediato(Instruccion_Actual[15:0]),
        .ExtOp(ext_op),
        .ImmExt(imm_ext)
    );

    assign alu_b = (alu_src) ? imm_ext : dr2;

    ALU_Control u_aluctrl (
        .ALUOp(alu_op),
        .funct(Instruccion_Actual[5:0]),
        .ALUctl(alu_ctl)
    );

    ALUMIPS u_alu (
        .ALUctl(alu_ctl),
        .A(dr1),
        .B(alu_b),
        .ALUOut(ALU_Resultado),
        .Zero(Zero_Flag)
    );

    Memoria_Datos u_dmem (
        .clk(clk),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .Address(ALU_Resultado),
        .WriteData(dr2),
        .ReadData(mem_read_data)
    );

    assign Dato_Escrito_Reg = (mem_to_reg) ? mem_read_data : ALU_Resultado;

    assign pc_plus4      = pc_out + 32'd4;
    assign branch_target = pc_plus4 + {imm_ext[29:0], 2'b00};
    assign pc_src        = branch & Zero_Flag;
    assign mux4_out      = (pc_src) ? branch_target : pc_plus4;
    assign jump_target   = {pc_plus4[31:28], Instruccion_Actual[25:0], 2'b00};
    assign pc_next       = (jump) ? jump_target : mux4_out;

endmodule