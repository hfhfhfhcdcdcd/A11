module state(
input sys_clk,
input rst_n,
input Trans_go,//need to be assigned a value from top module
input [39:0]Data,
output uart_tx,
output reg all_done
);
/*---------------------variate declaration---------------------------*/
wire tx_done;
reg state;
reg [39:0]Data1;
reg [2:0]Data_cnt; //[2:0] =>3 bits binary digits can express to 8(D)

reg send_go;
reg [7:0]data;
parameter max = 5;
/*-----------------------instantiate serial's module-----------------------------*/ 
send_byte serial_module(                           
        .sys_clk     (sys_clk  )    ,          
        .rst_n       (rst_n    )    ,          
        .time_set    (2 )           ,         
        .data        (data     )    ,          
        .send_go     (send_go  )    ,          
        .uart_tx     (uart_tx  )    ,          
        .tx_done     (tx_done  )
    );
/*----------------------different states--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 0;//IDLE
    end
    else if(Trans_go)begin
        state<=1;//send state
    end
    else if(all_done)begin
        state <= 0;//back IDLE state
    end
    else
        state <= state;
end
/*----------------------Data_cnt--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data_cnt <= 0;
    end
    else if (send_go) begin
        Data_cnt<=Data_cnt+1;
    end
    else if ((Data_cnt==max)&&(tx_done))//clear to zero when add up to the biggest value 
        Data_cnt<=0;    
    else
        Data_cnt<=Data_cnt;
end
/*----------------------Data1--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data1 <= Data;
    end
    else if(tx_done)begin
        Data1<={Data1[7:0],Data1[39:8]};
    end
    else//IDLE
        Data1<=Data1;
end
/*----------------------different data--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 7'd0;
    end
    else if(send_go)begin //send state
        data<=Data1[7:0];
    end
    else
        data<=data;
end
/*----------------------send_go--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        send_go<=1;
    end
    else if(state) begin//send state
        if((Data_cnt<max)&&(tx_done))begin
            send_go<=1;
        end
        else
            send_go<=0;
    end
    else//IDLE
        send_go<=0;//gaile
end
/*----------------------all_done--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        all_done<=0;
    end
    else if((Data_cnt==max)&&(tx_done))begin
        all_done<=1;
    end
    else
        all_done<=all_done;
end
endmodule
