module maquina_de_estados_da_senha (
	input [3:0] SENHA_INSERIDA,
	input ON_OFF,
	input CLK,

	output reg ERRO, 
	output reg STATUS_DE_SENHA_CERTA, 
	output reg INICIALIZAR_CONTADOR, 
	output reg LIGAR_DISPLAY
);
    
    
/* ESTADOS DA MÁQUINA;*/
    parameter ESTADO_DO_PRIMEIRO_CODIGO = 3'b000,
              ESTADO_DO_SEGUNDO_CODIGO = 3'b001, 
              ESTADO_DO_TERCEIRO_CODIGO = 3'b010, 
              ESTADO_DO_QUART_CODIGO = 3'b011, 
              ESTADO_DE_SENHA_COMPLETAMENTE_CORRETA = 3'b100, 
              ESTADO_DE_ERRO_DE_CODIGO = 3'b101; 
    
/*SEQUÊNCIA DA SENHA*/
    parameter PRIMEIRO_CODIGO_DA_SENHA = 4'b0001,
              SEGUNDO_CODIGO_DA_SENHA = 4'b0010,
              TERCEIRO_CODIGO_DA_SENHA = 4'b0100,
              QUARTO_CODIGO_DA_SENHA = 4'b1000;
    
    reg [2:0] ESTADOS_DA_SENHA;
    reg [3:0] SENHA_ATUAL;
	 
    initial begin 
	    ESTADOS_DA_SENHA <= 0; 
	    SENHA_ATUAL <= PRIMEIRO_CODIGO_DA_SENHA;
	end

/*SAÍDAS DA MAQUINA PARA CADA ESTADO*/
	always @(ESTADOS_DA_SENHA) begin

		case (ESTADOS_DA_SENHA)

				ESTADO_DO_PRIMEIRO_CODIGO: begin
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= PRIMEIRO_CODIGO_DA_SENHA; 
			end

			ESTADO_DO_SEGUNDO_CODIGO: begin
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= SEGUNDO_CODIGO_DA_SENHA;
			end

			ESTADO_DO_TERCEIRO_CODIGO: begin
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= TERCEIRO_CODIGO_DA_SENHA;
			end

			ESTADO_DO_QUART_CODIGO: begin 
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= QUARTO_CODIGO_DA_SENHA;
			end

			ESTADO_DE_SENHA_COMPLETAMENTE_CORRETA: begin
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 1;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= QUARTO_CODIGO_DA_SENHA;
			end

			ESTADO_DE_ERRO_DE_CODIGO: begin
				ERRO <= 1;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 1;
				SENHA_ATUAL <= PRIMEIRO_CODIGO_DA_SENHA;
			end
			
			default begin
				ERRO <= 0;
				STATUS_DE_SENHA_CERTA <= 0;
				INICIALIZAR_CONTADOR <= 1;
				LIGAR_DISPLAY <= 0;
				SENHA_ATUAL <= PRIMEIRO_CODIGO_DA_SENHA;
			end
			
		endcase

	end

/* TRANSIÇÃO DE ESTADOS*/	
    always @ (negedge ON_OFF, posedge CLK) begin

		if(!ON_OFF) begin// ENTRADA ASSINCRONA DA MAQUINA;
			ESTADOS_DA_SENHA <= ESTADO_DO_PRIMEIRO_CODIGO;
		end

		else begin

            case (ESTADOS_DA_SENHA)

                ESTADO_DO_PRIMEIRO_CODIGO: begin
                    if (SENHA_INSERIDA == SENHA_ATUAL)
						ESTADOS_DA_SENHA <= ESTADO_DO_SEGUNDO_CODIGO; 
                    else if ( SENHA_INSERIDA == 0) 
						ESTADOS_DA_SENHA <= ESTADO_DO_PRIMEIRO_CODIGO; 
                    else 
						ESTADOS_DA_SENHA <= ESTADO_DE_ERRO_DE_CODIGO; 
                end

                ESTADO_DO_SEGUNDO_CODIGO:begin
                    if (SENHA_INSERIDA == SENHA_ATUAL) 
						ESTADOS_DA_SENHA <= ESTADO_DO_TERCEIRO_CODIGO;
                    else if (SENHA_INSERIDA == 0) 
						ESTADOS_DA_SENHA <= ESTADO_DO_SEGUNDO_CODIGO;
                    else 
						ESTADOS_DA_SENHA <= ESTADO_DE_ERRO_DE_CODIGO;
                end

                ESTADO_DO_TERCEIRO_CODIGO: begin
                    if (SENHA_INSERIDA == SENHA_ATUAL)
						ESTADOS_DA_SENHA <= ESTADO_DO_QUART_CODIGO;
                    else if (SENHA_INSERIDA == 0) 
						ESTADOS_DA_SENHA <= ESTADO_DO_TERCEIRO_CODIGO;
                    else 
						ESTADOS_DA_SENHA <= ESTADO_DE_ERRO_DE_CODIGO;
                end

                ESTADO_DO_QUART_CODIGO: begin
                    if (SENHA_INSERIDA == SENHA_ATUAL) 
                        ESTADOS_DA_SENHA <= ESTADO_DE_SENHA_COMPLETAMENTE_CORRETA;
                    else if (SENHA_INSERIDA == 0) 
                        ESTADOS_DA_SENHA <= ESTADO_DO_QUART_CODIGO;
                    else 
                        ESTADOS_DA_SENHA <= ESTADO_DE_ERRO_DE_CODIGO;
                end

                ESTADO_DE_ERRO_DE_CODIGO: begin
                    if (SENHA_INSERIDA == SENHA_ATUAL) 
                        ESTADOS_DA_SENHA <= ESTADO_DO_SEGUNDO_CODIGO;
                    else 
                        ESTADOS_DA_SENHA <= ESTADO_DE_ERRO_DE_CODIGO; 
                end

                ESTADO_DE_SENHA_COMPLETAMENTE_CORRETA: ESTADOS_DA_SENHA <= ESTADO_DE_SENHA_COMPLETAMENTE_CORRETA; 
            
            endcase
        end

    end

endmodule 