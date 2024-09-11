module top (
    input sys_clk,
    input rst_n,
    output uart_tx
);

state state1(
.sys_clk  (sys_clk ),
.rst_n    (rst_n   ),
.Trans_go (Trans_go),
.Data     (Data    ),
.uart_tx  (uart_tx )
);
/*----------------------declaration--------------------------*/
reg Trans_go;
reg [39:0]Data;
/*----------------------Trans_go--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Trans_go <= 1;
    end
    else 
        Trans_go <= 0;
end
/*----------------------Data--------------------------*/
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data <= 40'h1008040201;//IDLE
    end
    else begin
        Data <= Data;
    end
end
endmodule