module state(
input sys_clk,
input rst_n,
input Trans_go,//need to be assigned a value from top module
input [39:0]Data,
output uart_tx
);
/*---------------------variate declaration---------------------------*/
reg tx_done;
reg state;
reg [39:0]Data1;
reg [2:0]Data_cnt; //40/8=5;3 bits binary digits can express to 8(D)
reg all_done;
/*----------------------different states--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 0;//IDLE
    end
    else if(Trans_go)begin
        state<=1;//send state
    end
    else if(all_done==0)begin
        state <= 0;//back IDLE state
    end
end
/*----------------------Data_cnt--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data_cnt <= 0;
    end
    else if (Data_cnt<3'd5) begin//40/8=5
        if(tx_done)begin
            Data_cnt<=Data_cnt+1;
        end
    end
    else if (Data_cnt==3'd4)&&(tx_done)//clear to zero when add up to the biggest value 
        Data_cnt<=0;    
    else
        Data_cnt<=Data_cnt;
end
/*----------------------Data1--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data1 <= 40'd0;
    end
    else if(state)//send state
        if(tx_done)begin
        Data1<={Data[7:0],Data[39:32]};
    end
    else//IDLE
        Data1<=Data1;
end
/*----------------------different data--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 40'd0;
    end
    else if(state==1)begin //send state
        if (Data_cnt==0) begin
            data<=Data[7:0];
        end
        else //Data_cnt!=0 eg:1,2,3,4
            data<=Data1[7:0];
    end
    else if(state==0)begin //IDLE state
        data<=40'd0;
    end
end

always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= 0;
    end
    else if(Data_cnt==3'd4)&&(tx_done)begin
        all_done<=1;
    end
    else
        all_done<=0;
end
endmodule
