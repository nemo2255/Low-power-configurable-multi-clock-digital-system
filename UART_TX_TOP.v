module UART_TX_TOP #(
    parameter P_DATA_WIDTH = 8 
) (
    input wire [P_DATA_WIDTH-1:0] P_DATA,
    input wire                    Data_Valid ,
    input wire                    PAR_EN ,
    input wire                    PAR_TYP ,
    input wire                 CLK , RST ,
    output wire                   TX_OUT ,
    output wire                   busy
);


wire ser_en ;
wire ser_done ;
wire ser_data ;
wire [1:0] mux_sel ;
wire PAR_BIT ;



serializer #(.P_DATA_WIDTH(P_DATA_WIDTH)) S1 (
.P_DATA(P_DATA),
.CLK(CLK),
.RST(RST),
.ser_data(ser_data),
.ser_done(ser_done),
.ser_en(ser_en),
.Data_Valid(Data_Valid),
.busy(busy));

FSM_TX fsm (
.Data_Valid(Data_Valid),
.PAR_EN(PAR_EN),
.ser_done(ser_done),
.ser_en(ser_en),
.busy(busy),
.mux_sel(mux_sel),
.CLK(CLK),
.RST(RST));

paritycalc #(.P_DATA_WIDTH(P_DATA_WIDTH)) pc (
.PAR_TYP(PAR_TYP),
.PAR_EN(PAR_EN),
.P_DATA(P_DATA),
.Data_Valid(Data_Valid),
.PAR_BIT(PAR_BIT),
.CLK(CLK),
.RST(RST));

MUX m1 (
.mux_sel(mux_sel),
.PAR_BIT(PAR_BIT),
.start_bit(1'b0),
.stop_bit(1'b1),
.ser_data(ser_data),
.TX_OUT(TX_OUT));
endmodule