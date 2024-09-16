module top (
    input sys_clk,
    input rst_n,
    output uart_tx
);
/*----------------------declaration--------------------------*/
reg Trans_go;
reg [39:0]Data;
wire all_done;
state state1(
.sys_clk  (sys_clk ),
.rst_n    (rst_n   ),
.Trans_go (Trans_go),
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
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Data <= 40'h10_08_04_02_01;//IDLE
    end
    else begin
        Data <= Data;
    end
end
endmodule