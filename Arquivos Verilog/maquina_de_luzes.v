module maquina_de_luzes(
    output STATUS_DE_ENTRADA_LIBERADA,
    output STATUS_DE_ESTRADA_BLOQUEADA,

    input ON_OFF, 
    input SENSOR_EXTERNO, 
    input CLK
);
    
    reg ESTADOS_DA_LUZES_DE_ALERTA;
    
    initial begin
        ESTADOS_DA_LUZES_DE_ALERTA <= 1'b0;
    end

// SAÍDAS DA MÁQUINA 
    // SE NÃO APARECE ALGO NO SENSOR, ENQUANTO O CARRO ESTA ENTRANDO, PERMANER LIVRE;
    assign STATUS_DE_ENTRADA_LIBERADA = ( ~SENSOR_EXTERNO | ~ESTADOS_DA_LUZES_DE_ALERTA) & ON_OFF;
    // CASO O CARRO JÁ TENHA SAÍDO E APAREÇA ALGO NO SENSOR SINAL DE PARE;
    assign STATUS_DE_ESTRADA_BLOQUEADA = SENSOR_EXTERNO & ESTADOS_DA_LUZES_DE_ALERTA;

// TRANSIÇÃO DE ESTADOS
    always @ (posedge CLK, negedge ON_OFF) begin

        // MÁQUINA DESLIGADA;
        if (!ON_OFF) begin
            ESTADOS_DA_LUZES_DE_ALERTA <= 1'b0;
        end

        else begin
            // QUANDO O SENSOR EXTERNO PERCEBER QUE O CARRO JÁ SAIO, MUDAR DE ESTADO;
            ESTADOS_DA_LUZES_DE_ALERTA <= ESTADOS_DA_LUZES_DE_ALERTA | ~SENSOR_EXTERNO;
        end
        
    end
    
endmodule