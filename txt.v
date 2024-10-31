


 always @(posedge sys_clk or negedge rst_n) begin
     if (!rst_n) begin
         Data1 <= Data;
     end
     else if(tx_done)begin
        case (length1)
            16: Data1<={Data1[7:0],Data1[15:8]}; 
            32: Data1<={Data1[7:0],Data1[31:8]};
            40: Data1<={Data1[7:0],Data1[39:8]};
            default: ;
        endcase  
     end
     else//IDLE
         Data1<=Data1;