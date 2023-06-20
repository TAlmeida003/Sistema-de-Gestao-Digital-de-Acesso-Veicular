module pisca_led (
    input on_off,
    input clk, 
    output led_azul
);
// FAZER O LED PISCAR AO SER HABILITADO;
    assign led_azul = on_off & clk;
endmodule