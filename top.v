module top (
    input            sys_clk         ,
    input            rst_n           ,
    output [39:0]    Data            ,
    output [39:0]    length          ,
    output           uart_tx
);
/*----------------------declaration--------------------------*/
reg Trans_go;
wire all_done;
state state1(
.sys_clk  (sys_clk ),
.rst_n    (rst_n   ),
.Trans_go (Trans_go),
.length   (length  ),
.Data     (Data    ),
.uart_tx  (uart_tx ),
.all_done (all_done)
);
/*----------------------Trans_go--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Trans_go <= 0;
    end
    else begin 
        if (all_done) begin//i have led the "all_done signal" to the top module 
            Trans_go <= 0;
        end
        else begin
            Trans_go <= 1;
        end
    end
end
/*----------------------Data--------------------------*/
assign Data =  40'hb1_A2_1e_3f_49;
/*----------------------length--------------------------*/
assign length = 40'd40;
endmodule
