INC
- Control.v: adicionado novo caso, que é uma cópia total dos sinais do comando ADDI;
- Decode.v: adicionado desvio condicional baseado no opcode da instrução, que atribui 1 ao valor imediato a ser somado.

MUL
- Control.v: adicionado novo caso, que é uma cópia modificada dos sinais do comando ADD, trocando a AluOP de 010 para 111;
- Alu.v: adicionado tratamento para o novo comando, através de um registrador intermediário de 64 bits. Esse registrador recebe o valor da multiplicação dos registradores. Se algum dos seus 32 bits mais significativos for diferente de 0 se os multiplicandos tiverem o mesmo sinal ou diferente de 1 se os multiplicandos tiverem sinais diferentes, houve overflow na multiplicação. Caso contrário, os 32 bits menos significativos desse registrador são copiados para aluout_reg.

