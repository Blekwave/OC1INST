/**
 * Testbench 3 - 7 Fatorial (MUL e INC)
 * Este testbench final combina as duas instruções implementadas nesse trabalho
 * para realizar o cálculo de um fatorial.
 */
module Mips_TB;
    reg clock, reset;

    top top_i (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        $readmemb("tb3_fat.bin", top_i.RAM.memory);

        $dumpfile("mips_tb3.vcd");
        $dumpvars;

        $display("\t\tA\tB\tOut\tAluOP\tOverflow");
        $monitor("\t%d%d%d\t%d\t%d", top_i.MIPS.EXECUTE.id_ex_rega, top_i.MIPS.EXECUTE.mux_imregb, top_i.MIPS.EXECUTE.aluout, top_i.MIPS.EXECUTE.id_ex_aluop, top_i.MIPS.EXECUTE.aluov);

        #1000 $finish;
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