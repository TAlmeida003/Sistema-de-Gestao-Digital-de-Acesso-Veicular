module divisor_por_128 (output clk_dividido, input clk);

	reg [6:0] flip_flop_divided;
    
    initial begin
        flip_flop_divided = 0;
    end

// CLOCK APÓS 128 PERÍODOS 
    assign clk_dividido = flip_flop_divided[6];
    
    always @ (posedge clk) begin
	 
        flip_flop_divided <= flip_flop_divided + 1'b1;
        
        if (flip_flop_divided == 7'b1111111) begin
            flip_flop_divided <= 1'b0;
        end
		  else begin
		     flip_flop_divided <= flip_flop_divided + 1'b1;
		  end
    end
    
endmodule
