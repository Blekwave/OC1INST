/**
 * Testbench 1 - INC
 * Este testbench realiza testes com a instrução INC, que incrementa em 1 o va-
 * lor de um registrador. É esperado como resultado que o registrador $s3 tenha
 * 23 como seu valor, visto que $s0 começa como 13 e $s1 começa como 7, e é in-
 * crementado três vezes.
 */
module Mips_TB;
    reg clock, reset;

    top top_i (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        $readmemb("tb1_incr.bin", top_i.RAM.memory);

        $dumpfile("mips_tb1.vcd");
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