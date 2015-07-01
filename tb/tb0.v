/**
 * Testbench 0 - Esqueleto e ALU
 * Este testbench básico realiza testes aritméticos, realizando várias adições.
 * Sua função principal é garantir que o esqueleto dos testbenches esteja fun-
 * cionando corretamente, assim como testar instruções básicas da ALU, necessá-
 * rias para o bom funcionamento de qualquer outro programa. São monitorados os
 * sinais de entrada da ALU, do opcode e da saída desse módulo
 */
module Mips_TB;
    reg clock, reset;

    top top_i (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        $readmemh("tb0_arith_basic_split.hex", top_i.RAM.memory);

        $dumpfile("mips_tb0.vcd");
        $dumpvars;

        $display("\t\tA\tB\tOut\tAluOP");
        $monitor("\t%d%d%d\t%d", top_i.MIPS.EXECUTE.id_ex_rega, top_i.MIPS.EXECUTE.mux_imregb, top_i.MIPS.EXECUTE.aluout, top_i.MIPS.EXECUTE.id_ex_aluop);

        #500 $finish;
    end

    initial begin
        clock <= 0;
        reset <= 1;
        #2 reset <= 0;
        #2 reset <= 1;
    end

    always begin
        #3 clock <= ~clock;
    end

endmodule