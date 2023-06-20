module main(
    input SENSOR_EXTERNO, 
    input SENSOR_INTERNO,
    input INPUT_CHEIO,
    input CLK_DA_PLACA,
    input [3:0] BOTOES,

    output [7:0] DISPLAY_7_SEGMENTOS,
    output [3:0] DIGITOS_DO_DISPLAY,
    output LED_VERDE,
    output LED_VERMELHO,
    output LED_AZUL,
    output CANCELA_DO_ESTACIONAMENTO
 );

/*BLOCO DE FIOS*/
    wire CLK_760HZ, CLK_1HZ; //CLOCK REDUZIDO;
    wire [3:0] BOTOES_SEM_RUIDO; 
    wire ON_OFF_PAINEL_DE_SENHA, STATUS_DE_SENHA_CERTA, iniciar_contador; // SAÍDAS DA MFE DA SENHA;
    wire tempo_20s;
    wire CANCELA_DO_ESTACIONAMENTO_aberta, on_off_display, on_off_luzes, on_off_display_painel, on_offdisplay_mfe_principal;
    wire [15:0] entrada_mux;
    wire [3:0] estado_frase; // 3 É ERRO, 2 É LIBERADO, 1 É PARE E 0 É cheio; 
    wire rest_temporizador;


    assign on_off_display = on_off_display_painel | on_offdisplay_mfe_principal; //LIGAR E DESLIGAR O DISPLAY DEPENDENDO DAS SAÍDAS DAS MEF; 
  
/*DIVIDIR O CLOCK DE 50Mhz PARA 760hz*/
//O CLOCK DE 760hz É USADO PARA MULTIPLEXAR O DISPLAY E FAZER A TROCA DE ESTADOS DAS MAQUINAS MEF;
    divisor_de_frequencia a(CLK_760HZ, CLK_DA_PLACA);

/*DIVIDIR O CLOCK DE 50Mhz EM EXATOS 1hz*/
    dividir_para_1hz tnj(CLK_1HZ, CLK_DA_PLACA);

/*RETIRAR OS RUIDOS DOS BOTÕES*/
// TORNAR AS ENTRADAS DOS BOTÕES SINCRONAS;
    level_to_pulse PR(!BOTOES[0], CLK_760HZ, BOTOES_SEM_RUIDO[0]);
    level_to_pulse SR(!BOTOES[1], CLK_760HZ, BOTOES_SEM_RUIDO[1]);
    level_to_pulse TR(!BOTOES[2], CLK_760HZ, BOTOES_SEM_RUIDO[2]);
    level_to_pulse QR(!BOTOES[3], CLK_760HZ, BOTOES_SEM_RUIDO[3]);
	
/*MEF PARA ADMINISTRAR A INSERÇÃO DO CÓDIGO DO ESTACIONAMENTO*/
	maquina_senha mefMs(BOTOES_SEM_RUIDO, ON_OFF_PAINEL_DE_SENHA, CLK_760HZ, estado_frase[3], STATUS_DE_SENHA_CERTA, on_off_display_painel, CLK_1HZ, tempo_20s);

/*MEF PARA CONTOLAR OS PROCESSOS DE ENTRADA DO ESTACIONAMENTO */
    maquina_principal mefMp(CANCELA_DO_ESTACIONAMENTO_aberta, on_offdisplay_mfe_principal, on_off_luzes,  ON_OFF_PAINEL_DE_SENHA, estado_frase[0], SENSOR_EXTERNO, SENSOR_INTERNO , tempo_20s, INPUT_CHEIO, CLK_760HZ, STATUS_DE_SENHA_CERTA);

/*MEF PARA CONTROLAR OS ESTADOS DE LIBERAR E PARAR*/
    maquina_de_luzes mefMl(estado_frase[2] , estado_frase[1], on_off_luzes, SENSOR_EXTERNO, CLK_760HZ);

/*PISCAR O LED AZUL QUANDO A MAQUINA DE LUZES LIGAR O SINAL DE PARA*/
    pisca_led pl(estado_frase[1], CLK_1HZ, LED_AZUL);

/*CODIFICAR UM DOS 4 QUATRO SINAIS (LIBERADO, PARE, ERRO E cheio) PARA UMA SAÍDA DE 16BITS COM OS CÓDIGOS DA PALAVRA*/
    conversor cs(estado_frase, entrada_mux);

/*MULTIPLEXAR A FRASE NO DISPLAY DE 7SEGMENTOS*/
    mux_display md(DIGITOS_DO_DISPLAY, DISPLAY_7_SEGMENTOS, CLK_760HZ, entrada_mux, on_off_display);

/*CONECTAR AS SAÍDAS DAS MEF NOS LEDS*/
    assign LED_VERMELHO = estado_frase[3];
    assign CANCELA_DO_ESTACIONAMENTO = CANCELA_DO_ESTACIONAMENTO_aberta;
    assign LED_VERDE = estado_frase[2];

endmodule 