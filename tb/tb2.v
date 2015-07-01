/**
 * Testbench 2 - MUL
 * Este testbench realiza testes com a instrução MUL, que multiplica dois in-
 * teiros e salva o resultado em outro registrador caso não haja overflow. É
 * esperado que haja overflow para o último teste, que extrapola o limite de
 * um inteiro de 32 bits.
 */
module Mips_TB;
    reg clock, reset;

    top top_i (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        $readmemb("tb2_mul.bin", top_i.RAM.memory);

        $dumpfile("mips_tb2.vcd");
        $dumpvars;

        $display("\t\tA\tB\tOut\tAluOP\tOverflow");
        $monitor("\t%d%d%d\t%d\t%d", top_i.MIPS.EXECUTE.id_ex_rega, top_i.MIPS.EXECUTE.mux_imregb, top_i.MIPS.EXECUTE.aluout, top_i.MIPS.EXECUTE.id_ex_aluop, top_i.MIPS.EXECUTE.aluov);

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