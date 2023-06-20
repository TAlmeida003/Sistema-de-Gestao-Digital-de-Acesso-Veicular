/*MULTIPLEXADOR 64 X 16*/
module mux_64_16(
    output reg [15:0] output_display, 
    input [1:0] porta_seletora
);
    
// CÓDIGOS DAS ENTRADAS SELETORAS;
    parameter a0 = 2'b00,
              a1 = 2'b01,
              a2 = 2'b10,
              a3 = 2'b11;

// CÓDIGO DAS PALAVRAS PARA O DECODIFICADOR;
// A CADA 4 BITS TEM-SE UMA LETRA NO DISPLAY
    parameter FULL = 16'b0001100101000100,
              STOP = 16'b0111100001010110,
              PASS = 16'b0110000001110111,
              FAIL = 16'b0001000000110100; 
              
// A PARTIR DAS ENTRADAS SELETORAS ESCOLHER UMA PALAVRAS COMO SAÍDA DO MUX;
    always @(porta_seletora) begin

        case (porta_seletora)
            a0    : output_display <= FULL; 
            a1    : output_display <= STOP;
            a2    : output_display <= PASS;
            a3    : output_display <= FAIL;
				default output_display <= FULL;
        endcase
        
    end
    
endmodule