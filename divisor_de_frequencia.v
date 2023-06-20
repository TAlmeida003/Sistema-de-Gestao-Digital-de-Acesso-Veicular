 module divisor_de_frequencia(
    output clk_dividido_11hz, 
    input clk_da_placa
);
    
    reg [15:0] fli_flop_divided;
	 
    initial begin
        fli_flop_divided = 0;
    end
    
    assign clk_dividido_11hz = fli_flop_divided[15];
    
    always @ (posedge clk_da_placa) begin
	 
         if (fli_flop_divided == 16'b1111111111111111) begin
            fli_flop_divided <= 0;
        end
		  else begin
				fli_flop_divided <= fli_flop_divided + 1'b1;
			end
        
    end
    
 endmodule 