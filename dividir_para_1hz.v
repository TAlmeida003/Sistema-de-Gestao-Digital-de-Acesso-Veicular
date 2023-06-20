
module dividir_para_1hz(
    output clk_out, 
    input clk
);

// CONTA = 50000000 / (5 ^ 8) × (2 ^ 7);
/* PARA DIVIDIR PARA UM HZ É NECESSARIO TER 8 DIVISORES DE 5 E 7 DIVISORES POR 2;*/
    wire a0, a1, a2, a3, a4, a5, a6, a7;
 
 //AGRUPAMENTO DE DIVISORES;   
    divide_5 e1(clk, a0);
    divide_5 e2(a0, a1);
    divide_5 e3(a1, a2);
    divide_5 e4(a2, a3);
    divide_5 e5(a3, a4);
    divide_5 e8(a4, a5);
    divide_5 e7(a5, a6);
    divide_5 e6(a6, a7);
    
	divisor_por_128 w2(clk_out, a7);

endmodule 