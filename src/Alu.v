module Alu (
    input     [31:0]    a,
    input     [31:0]    b,
    output    [31:0]    aluout,
    input     [2:0]     op,
    input               unsig,
    output              overflow
);


    /////////////////////////////////////////////////////////////////////////////
    // Novos wires utilizados para garantir que a multiplicação seja feita le- //
    // vando o sinal em consideração                                           //
    /////////////////////////////////////////////////////////////////////////////
    wire signed [31:0] signed_a;
    wire signed [31:0] signed_b;
    assign signed_a = a;
    assign signed_b = b;

    reg [31:0] aluout_reg;
    reg        overflow_reg;

    ////////////////////////////////////////////////////////////////////////////
    // Novo registrador utilizado para armazenar o resultado da multiplicação //
    // incluindo possível overflow                                            //
    ////////////////////////////////////////////////////////////////////////////
    reg signed  [63:0]    mul_reg;

    assign aluout = aluout_reg;
    assign overflow = overflow_reg;

    always @(*) begin
        case (op)
            3'b000:  aluout_reg = a & b;
            3'b001:  aluout_reg = a | b;
            3'b010:  aluout_reg = a + b;
            3'b100:  aluout_reg = ~(a | b);
            3'b101:  aluout_reg = a ^ b;
            3'b110:  aluout_reg = a - b;

            ///////////////////////////////////////////////////////////////////
            // Novo caso para o AluOP da multiplicação (111)                 //
            // A operação realiza a multiplicação dos dois valores levando o //
            // sinal em consideração e guarda o resultado em um registrador  //
            // intermediário.                                                //
            ///////////////////////////////////////////////////////////////////
            3'b111:     mul_reg = $signed(signed_a * signed_b);
            default: aluout_reg = 32'hXXXX_XXXX;
        endcase
        if ((op==3'b010 & a[31]==0 & b[31]==0 & aluout_reg[31]==1) ||
            (op==3'b010 & a[31]==1 & b[31]==1 & aluout_reg[31]==0) ||
            (op==3'b110 & a[31]==0 & b[31]==1 & aluout_reg[31]==1) ||
            (op==3'b110 & a[31]==1 & b[31]==0 & aluout_reg[31]==0) ||
            /////////////////////////////////////////////////////////////////////
            // Novos casos de overflow para a multiplicação, que checam os     //
            // bits mais significativos de mul_reg. Se os operandos tem sinal  //
            // diferente, a operação deve resultar em um número negativo, o    //
            // que significa que, caso não haja overflow, os 32 bits mais sig- //
            // nificativos do resultado devem ser 1. Similarmente, para resul- //
            // tados positivos, esses bits devem ser 0.                        //
            /////////////////////////////////////////////////////////////////////
            (op==3'b111 & (a[31] !== b[31] & mul_reg[63:32] !== 32'hFFFF_FFFF)) ||
            (op==3'b111 & (a[31] === b[31] & mul_reg[63:32] !== 32'h0000_0000))) begin
            overflow_reg <= 1'b1;
        end else begin
            overflow_reg <= 1'b0;
            ////////////////////////////////////////////////////////////////////
            // Caso não haja overflow, os 32 bits menos significativos do re- //
            // sultado são copiados para o registrador destino.               //
            ////////////////////////////////////////////////////////////////////
            if (op===3'b111) begin
                aluout_reg <= mul_reg[31:0];
            end
        end
    end

endmodule
