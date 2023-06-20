module maquina_principal (
    output reg STATUS_DA_CANCELA_DO_ESTACIONAMENTO,
    output reg STATUS_DO_DISPLAY, 
    output reg STATUS_DA_SINALIZACAO_DE_LUZES, 
    output reg STATUS_DO_PAINEL_DE_SENHA, 
    output reg STATUS_DO_ESTACIONAMENTO_CHEIO, 
                          
    input SENSOR_EXTERNO,
    input SENSOR_INTERNO,
    input STATUS_DO_TEMPORIZADOR_DE_VINTE_SEGUNDOS, 
    input cheio, 
    input clk,
    input STATUS_DA_SENHA_INSERIDA 
);
    reg [1:0] ESTADOS;
    
    initial begin
        ESTADOS <= 1'b0;
        STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b0; 
        STATUS_DO_DISPLAY <= 1'b0; 
        STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b0; // LIGAR A MQUINA DE LUZES;
        STATUS_DO_PAINEL_DE_SENHA <= 1'b0; // LIGAR A MAQUINA DE ADMINISTRAÇÃO DE SENHA;
        STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b0;
    end
    
//ESTADOS DA MAQUINA
    parameter DESLIGADA = 2'b00, 
              INSERIR_SENHA = 2'b01, 
              ENTRADA_DO_VEICULO = 2'b10, 
              ESTACIONAMENTO_CHEIO = 2'b11;
              
    
/*TRANSIÇÃO DE ESTADOS*/
    always @ ( posedge clk) begin

        case (ESTADOS)

            DESLIGADA : begin
                if (SENSOR_EXTERNO) ESTADOS <= INSERIR_SENHA; 
                else if (cheio) ESTADOS <= ESTACIONAMENTO_CHEIO;
                else ESTADOS <= DESLIGADA;
            end

            INSERIR_SENHA : begin
                if (STATUS_DA_SENHA_INSERIDA) ESTADOS <= ENTRADA_DO_VEICULO;
                else if (cheio) ESTADOS <= ESTACIONAMENTO_CHEIO;
                else if (STATUS_DO_TEMPORIZADOR_DE_VINTE_SEGUNDOS) ESTADOS <= DESLIGADA;
                else ESTADOS <= INSERIR_SENHA;
            end

            ENTRADA_DO_VEICULO : begin
                if (SENSOR_INTERNO) ESTADOS <= DESLIGADA;
                else if (SENSOR_INTERNO & SENSOR_EXTERNO) ESTADOS <= INSERIR_SENHA;
                else ESTADOS <= ENTRADA_DO_VEICULO;
            end

            ESTACIONAMENTO_CHEIO : begin
                if ( !cheio) ESTADOS <= DESLIGADA;
                else ESTADOS <= ESTACIONAMENTO_CHEIO;
            end

        endcase

    end

/*SAIDAS DA MAQUINA*/
    always @ (ESTADOS) begin

        case (ESTADOS)

            DESLIGADA : begin
                STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b0;
                STATUS_DO_DISPLAY <= 1'b0;
                STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b0;
                STATUS_DO_PAINEL_DE_SENHA <= 1'b0;
                STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b0;
            end

            INSERIR_SENHA : begin 
                STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b0;
                STATUS_DO_DISPLAY <= 1'b1;
                STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b0;
                STATUS_DO_PAINEL_DE_SENHA <= 1'b1;
                STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b0;
            end

            ENTRADA_DO_VEICULO : begin
                STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b1;
                STATUS_DO_DISPLAY <= 1'b1;
                STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b1;
                STATUS_DO_PAINEL_DE_SENHA <= 1'b0;
                STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b0;
            end

            ESTACIONAMENTO_CHEIO : begin
                STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b0;
                STATUS_DO_DISPLAY <= 1'b1;
                STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b0;
                STATUS_DO_PAINEL_DE_SENHA <= 1'b0;
                STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b1;
            end
				
				default begin 
					 STATUS_DA_CANCELA_DO_ESTACIONAMENTO <= 1'b0;
                STATUS_DO_DISPLAY <= 1'b0;
                STATUS_DA_SINALIZACAO_DE_LUZES <= 1'b0;
                STATUS_DO_PAINEL_DE_SENHA <= 1'b0;
                STATUS_DO_ESTACIONAMENTO_CHEIO <= 1'b0;
				end

        endcase

    end
    
endmodule