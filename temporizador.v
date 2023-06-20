module temporizador(
    input clk,
    input on_off,
    input rest,
    output reg tempo_20s);

/*CONTADOR DE MODULO 20*/
reg [4:0]tempo;

/*ESTADOS*/
parameter a0 = 5'b00000, 
          a1 = 5'b00001,
          a2 = 5'b00010,
          a3 = 5'b00011,
          a4 = 5'b00100,
          a5 = 5'b00101,
          a6 = 5'b00110,
          a7 = 5'b00111,
          a8 = 5'b01000,
          a9 = 5'b01001,
          a10 = 5'b01010,
          a11 = 5'b01011,
          a12 = 5'b01100,
          a13 = 5'b01101,
          a14 = 5'b01110,
          a15 = 5'b01111,
          a16 = 5'b10000,
          a17 = 5'b10001,
          a18 = 5'b10010,
          a19 = 5'b10011,
          a20 = 5'b10100;
          
          
    initial tempo <= a0;
          
/*TRANSIÇÃO DE ESTADOS*/
    always @(posedge rest, posedge clk, negedge on_off) begin
        
        if (rest) tempo <= a0; // REINICIAR CONTAGEM;
        else if (!on_off) tempo <= a0; 
        else begin
            case (tempo)
                a0 : tempo <= a1;
                a1 : tempo <= a2;
                a2 : tempo <= a3;
                a3 : tempo <= a4;
                a4 : tempo <= a5;
                a5 : tempo <= a6;
                a6 : tempo <= a7;
                a7 : tempo <= a8;
                a8 : tempo <= a9;
                a9 : tempo <= a10;
                a10: tempo <= a11;
                a11: tempo <= a12;
                a12: tempo <= a13;
                a13: tempo <= a14;
                a14: tempo <= a15;
                a15: tempo <= a16;
                a16: tempo <= a17;
                a17: tempo <= a18;
                a18: tempo <= a19;
                a19: tempo <= a20;
                a20: tempo <= a0;
            endcase
        end
    end

// ALERTA FIM DOS 20 SEGUNDOS;
    always @(tempo)begin
		case (tempo)
			a20: tempo_20s <= 1;
			default tempo_20s <= 0;
		endcase
	end


endmodule