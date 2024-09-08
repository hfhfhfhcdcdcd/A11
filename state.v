module state(
input sys_clk,
input rst_n,
input [39:0]Data,
output uart_tx
);
/*--------------------parameters declaration-----------------------------*/
reg  [7:0] data        ;
reg  send_go           ;
reg  [3:0]state        ;//in order to circle the Data[39:0]
wire tx_done           ;
/*-------------------- instantiate the serial module-----------------------------*/
send_byte s1(   
.sys_clk      (sys_clk )   ,
.rst_n        (rst_n   )   , 
.time_set     (2)          ,
.data         (data    )   ,                           
.send_go      (send_go )   ,
.uart_tx      (uart_tx )   ,
.tx_done      (tx_done) 
);
/*-------------------------------send_go-----------------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        send_go<=1;
    end
    else if (tx_done) begin
        send_go<=1'b1;
    end
    else
        send_go<=0;   
end
/*--------------------------------state---------------------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        state<=0;//idle;
    end
    else if(state<5)begin
        if(tx_done) 
            state<=state+1;
        else
            state<=state;
    end
    else
        state<=0; 
end
/*--------------------------------data---------------------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        data<=8'd0;//0000_0111
    end
    else case (state)
        0:data<=Data[7:0];     //0000_0001                      
        1:data<=Data[15:8];    //0000_0010    
        2:data<=Data[23:16];   //0000_0100    
        3:data<=Data[31:24];   //0000_1000    
        4:data<=Data[39:32];   //0000_0000    
        default: data<=8'd0;       
    endcase
end
endmodule 
