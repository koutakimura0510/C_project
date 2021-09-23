/*
 * Create 2021/09/21
 * Author kimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  vivado20.2
 * Borad  ArtyZ7-20
 * -
 * pwm動作確認テストベンチ
 */

`timescale 1ns / 1ps
module pwm_tb;

/* comment */
parameter CYCLE = 10;
reg reset, clk;
wire pwm, pwm_debug, led;

// defparam pwm_top.MAX_CLK = 4;
pwm_top #(.MAX_CLK(CYCLE))
    i0(
    .CLK(clk),
    .RESET(reset),
    .AUD_PWM(pwm),
    .CK_IO0(pwm_debug),
    .LED1(led)
);

always #(CYCLE/2)
	clk = ~clk;


initial begin
    clk   = 0;
    reset = 0;
    #(CYCLE);
    reset = 1;
    #(CYCLE * 16);
    $finish;
end



endmodule
