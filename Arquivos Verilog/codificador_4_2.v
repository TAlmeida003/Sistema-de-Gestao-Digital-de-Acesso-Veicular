/*CODIFICADOR 4 X 2*/
module codificador_4_2 (
    output reg [1:0] output_codificado,
    input [3:0] input_cod
);
    
// CÓDIGO DE SAÍDA;
    parameter a0 = 2'b00,
              a1 = 2'b01,
              a2 = 2'b10,
              a3 = 2'b11;

// ENTRADAS DO CODIFICADOR;
    parameter w0 = 4'b0001,
          w1 = 4'b0010,
          w2 = 4'b0100,
          w3 = 4'b1000;

// A PARTIR DAS ENTRANDAS TRANSFORMAR UMA DELAS EM UM CÓDIGO BINÁRIO; 
    always @ (input_cod) begin
        case (input_cod)
            w0 : output_codificado <= a0;
            w1 : output_codificado <= a1;
            w2 : output_codificado <= a2;
            w3 : output_codificado <= a3;
				default output_codificado <= a0;
				
        endcase
    end
    
endmodule
