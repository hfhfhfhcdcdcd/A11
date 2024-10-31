`timescale 1ns / 1ps
module tb;
reg               sys_clk     ;
reg               rst_n       ;
wire    [39:0]    Data        ;
wire    [39:0]    length      ;          
wire              uart_tx     ;

top top1(    
   .sys_clk (sys_clk)   ,
   .rst_n   (rst_n  )   ,
   .Data    (Data   )   ,
   .length  (length )   ,
   .uart_tx (uart_tx)    
);

/*-------------- sys_clk ---------------------------------*/
initial begin 
   sys_clk=0;
   rst_n=0;
   #201;
   rst_n=1;
   #434000;//length*10850+200;10850是1bit的传输时间
   #200;
   $stop;
end
always #10 sys_clk=~sys_clk;

endmodule
