module MUX (
    input wire start_bit ,
    input wire stop_bit ,
    input wire ser_data ,
    input wire PAR_BIT ,
    input wire [1:0] mux_sel,
    output reg TX_OUT 
);
 

always @(*) begin
    case (mux_sel)
        2'b00:TX_OUT = start_bit ;
        2'b01:TX_OUT = stop_bit ;
        2'b10:TX_OUT = ser_data ;
        2'b11:TX_OUT = PAR_BIT ; 
        default: TX_OUT = 1'b1 ;
    endcase
end

endmodule