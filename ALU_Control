module ALU_Control (
    input [1:0] ALU_Op,
    input [5:0] funct,
    output reg [2:0] ALU_Ctl
);

    always @(*) begin
        case (ALU_Op)
            2'b00: ALU_Ctl = 3'b010; // Suma (lw, sw, addi)
            2'b01: ALU_Ctl = 3'b110; // Resta para comparar en beq
            2'b11: ALU_Ctl = 3'b000; // AND logico (andi)
            2'b10: begin             // Instrucciones tipo R: revisa funct
                case (funct)
                    6'b100000: ALU_Ctl = 3'b010; // add -> suma
                    6'b100010: ALU_Ctl = 3'b110; // sub -> resta
                    6'b100100: ALU_Ctl = 3'b000; // and -> and
                    6'b100101: ALU_Ctl = 3'b001; // or  -> or
                    6'b101010: ALU_Ctl = 3'b111; // slt -> menor que
                    default:   ALU_Ctl = 3'b010;
                endcase
            end
            default: ALU_Ctl = 3'b010;
        endcase
    end

endmodule