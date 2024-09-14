`timescale 1ns / 1ps
module tb;
reg sys_clk     ;
reg rst_n       ;
wire  uart_tx   ;

top top1(    
   sys_clk   ,
   rst_n     ,
   uart_tx    
);

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
   #201;
   rst_n=1;
   #868_000;
   $stop;
end
endmodule
