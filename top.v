module top (
    input           sys_clk         ,
    input           rst_n           ,
    input [39:0]    Data            ,
    input [39:0]    length          ,
    output          uart_tx
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
endmodule
