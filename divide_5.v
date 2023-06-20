module divide_5 (
    input clk,
     output clk_out
);

/*CONTADOR DE MODULO 5;*/
    wire d2,d1,d0;
	 wire q2bar, q1bar, q0bar;
    reg q2,q1,q0,q2temp;

    initial begin
        q2 = 0;
        q1 = 0;
        q0 = 0;
    end
    
// COMBINACIONAL DO CONTADOR SINCRONO;
    assign q2bar = ~q2;
    assign q1bar = ~q1;
    assign q0bar = ~q0;

    assign d0 = q2bar & q0bar;
    assign d1 = (q1 & q0bar) | (q1bar & q0);
    assign d2 = q1 & q0;

// TRANSIÇÃO DE ESTADOS;
    always @(posedge clk) begin
        q0 <= d0;
        q1 <= d1;
        q2 <= d2;
    end

// RESETAR OS FLIP-FLOPS;
    always @(negedge clk) begin
        q2temp <= q1;

    end
    
 // CLOCK DIVIDIDO APÓS 5 PERÍODOS   
    assign clk_out = q1 | q2temp;
    
endmodule
