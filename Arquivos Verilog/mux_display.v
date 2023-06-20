module mux_display(
    output reg [3:0] digitos,
    output reg [7:0] segmentos_display, 
	 
    input clk,
    input [15:0] dados,
    input on_off_DEMUX
);
    
    reg [1:0] estados;
    reg [3:0] input_decodificador;
    
	 
	 
    initial begin 
        estados <= 2'b00;
    end
    
// CÓDIGOS DE SELEÇÃO
    parameter a0 = 2'b00,
              a1 = 2'b01,
              a2 = 2'b10,
              a3 = 2'b11;
				  
	wire [3:0] PRIMEIRA_DIGITO, SEGUNDO_DIGITO, TERCEIRO_DIGITO, QUARTO_DIGITO;

/* CONTADOR: TROCAR OS ESTADOS DO MUX DE DISPLAY*/
	always @ ( posedge clk ) begin 

        case (estados)
		  
            a0 : estados <= a1;
            a1 : estados <= a2;
            a2 : estados <= a3;
            a3 : estados <= a0;
				
        endcase
    end
	 
	 
	 assign PRIMEIRA_DIGITO = {dados[3], dados[2], dados[1], dados[0]};
	 assign SEGUNDO_DIGITO = {dados[7], dados[6], dados[5], dados[4]};
	 assign TERCEIRO_DIGITO =  {dados[11], dados[10], dados[9], dados[8]};
	 assign QUARTO_DIGITO = {dados[15], dados[14], dados[13], dados[12]};

/*TROCAR OS DÍGITOS ATRAVES DO DEMUX*/
    always @ (estados, on_off_DEMUX, PRIMEIRA_DIGITO, SEGUNDO_DIGITO, TERCEIRO_DIGITO, QUARTO_DIGITO) begin
	 
        if (!on_off_DEMUX) begin
             digitos <= 4'b1111;
				 input_decodificador <= PRIMEIRA_DIGITO;
        end
        else begin 
            case (estados) // PORTA SELETORA
                a0 : begin
						digitos <= 4'b1110;
						input_decodificador <= PRIMEIRA_DIGITO;
					end
                a1 : begin
						digitos <= 4'b1101;
						input_decodificador <= SEGUNDO_DIGITO;
					end
                a2 : begin
						digitos <= 4'b1011;
						input_decodificador <= TERCEIRO_DIGITO;
					end
                a3 : begin
						digitos <= 4'b0111;
						input_decodificador <= QUARTO_DIGITO;
					 end
					 default : begin
						digitos <= 4'b1111;
						input_decodificador <= PRIMEIRA_DIGITO;
					 end
            endcase
        end
    end
	 
	
/*DECODIFICADOR*/
//SAÍDAS DO DISPLAY;
// ORDEM DE BITS: A, B, C, D, E, F, G e DP;
    always @ (input_decodificador) begin
        case (input_decodificador)
            4'b0000 : segmentos_display = 8'b00010001;
            4'b0001 : segmentos_display = 8'b01110001;
            4'b0010 : segmentos_display = 8'b00001001;
            4'b0011 : segmentos_display = 8'b11110011;
            4'b0100 : segmentos_display = 8'b11100011;
            4'b0101 : segmentos_display = 8'b00000011;
            4'b0110 : segmentos_display = 8'b00110001;
            4'b0111 : segmentos_display = 8'b01001001;
            4'b1000 : segmentos_display = 8'b11100001;
            4'b1001 : segmentos_display = 8'b10000011;
				4'b1010 : segmentos_display = 8'b11111111;
				default : segmentos_display = 8'b00000000;
        endcase
    end

endmodule