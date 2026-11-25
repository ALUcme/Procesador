`timescale 1ns / 1ps

module ALUMIPS (
    input [3:0] ALUctl,
    input [31:0] A, B,
    output reg [31:0] ALUOut,
    output Zero
);
    assign Zero = (ALUOut == 32'd0);

    always @(*) begin
        case (ALUctl)
            4'b0000: ALUOut = A & B;                                     
            4'b0001: ALUOut = A | B;                                     
            4'b0010: ALUOut = A + B;                                     
            4'b0110: ALUOut = A - B;                                     
            4'b0111: ALUOut = ($signed(A) <$signed(B)) ? 32'd1 : 32'd0; 
            4'b1100: ALUOut = ~(A | B);                                  
            default: ALUOut = 32'd0;
        endcase
    end
endmodule
