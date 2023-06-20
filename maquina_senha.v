module maquina_senha(
	input [3:0] botoes,
	input on_off, 
	input clk, 
	
	output erro, 
	output senha_certa, 
	output display,
	input clk_1hz, 
	output tempo_20s
);
 
	 wire iniciar_contador;
	 wire rest_temporizador;
	 
	// REUNIR OS PULSOS DOS BOTÕES EM UM SÓ LUGAR;
	assign rest_temporizador = botoes[0] | botoes[1] | botoes[2] | botoes[3];

/*MÁQUINA DE ESTADOS PARA ADMINISTRADA A ENTRADA DA SENHA*/
	 maquina_de_estados_da_senha dsssd(botoes, on_off, clk, erro, senha_certa, iniciar_contador, display); 

/*CONTAR OS 20 SEGUNDOS PARA INSERÇÃO DA SENHA*/
	 temporizador temp(clk_1hz, iniciar_contador, rest_temporizador, tempo_20s);
	 
endmodule
