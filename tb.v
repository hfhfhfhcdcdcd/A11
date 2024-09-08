`timescale 1ns / 1ps
module tb;
reg sys_clk     ;
reg rst_n       ;
reg [39:0]Data  ;
wire  uart_tx   ;

state st1(    
   sys_clk   ,
   rst_n     ,
   Data      ,
   uart_tx    );

/*-------------- sys_clk ---------------------------------*/
initial begin 
   sys_clk=0;
end
always begin
   #10 sys_clk=~sys_clk;
end
/*-------------- initial others --------------------------*/
initial begin
   rst_n=0;
   Data=40'd0;
   #201;
   rst_n=1;
   Data=40'h10_08_04_02_01;
   #434_000;
   $stop;
end
endmodule
