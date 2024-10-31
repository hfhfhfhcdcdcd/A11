`timescale 1ns / 1ps
module tb;
reg              sys_clk     ;
reg              rst_n       ;
reg    [39:0]    Data        ;
reg    [39:0]    length      ;          
wire             uart_tx     ;

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
   Data = 40'hb1_A2_1e_3f_49;
   length = 40'd4;
   #201;
   rst_n=1;
   #43400;//(length/8) * 86_800;
   $stop;
end
always #10 sys_clk=~sys_clk;

endmodule
