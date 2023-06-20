module conversor(
    input [3:0] palavra_index, 
    output [15:0] entrada_mux
);

    wire [1:0] selecao;

// RECEBER UM DOS SINAIS QUE DEVERAM SER EXIBIDOS NO DISPLAY;
// SINAL DE CHEIO, ENTRADA LIBERADO, ALERTA DE PARE E ERRO DE SENHA;
    codificador_4_2 a(selecao, palavra_index);
    
// SELECIONAR UMA DAS PALAVRAS A PARTIR DO CÓDIGO BÍNARIO GERADO NO CODIFICADOR;
    mux_64_16 b(entrada_mux, selecao);
	 
endmodule 