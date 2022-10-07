module UART_RX_TOP #(
    parameter WIDTH = 8 
) (
	input wire	[4:0]   prescale ,
    input wire              CLK ,
    input wire              RST ,
	input wire              PAR_EN ,
    input wire              PAR_TYP ,
    input wire              RX_IN ,
    output wire [WIDTH-1:0]  P_DATA ,
    output wire              Data_Valid 

);

wire data_samp_en ;
wire [3:0] bit_counter ;
wire [4:0] edge_counter ;
wire enable ;
wire deser_en ;
wire parity_check_en , start_check_en ,stop_check_en ;
wire parity_error , start_glitch , stop_error ;



 FSM_RX U0_FSM (
	.prescale(prescale),
    .RX_IN(RX_IN),
    .PAR_EN(PAR_EN),
    .parity_error(parity_error),
    .stop_error(stop_error),
    .start_glitch(start_glitch),
    .bit_counter(bit_counter),
    .edge_counter(edge_counter),
    .data_samp_en(data_samp_en),
    .start_check_en(start_check_en),
    .parity_check_en(parity_check_en),
    .stop_check_en(stop_check_en),
    .deser_en(deser_en),
    .Data_Valid(Data_Valid),
    .enable(enable),
    .CLK(CLK),
    .RST(RST)
 );

 EDGE_BIT_COUNTER  U0_EBC (
    .prescale(prescale),
	.CLK(CLK),
    .RST(RST),
    .enable(enable),
    .PAR_EN(PAR_EN),
    .edge_counter(edge_counter),
    .bit_counter(bit_counter)
 );

DATA_SAMPLING U0_DS (
	.prescale(prescale),
	.edge_counter(edge_counter),
    .CLK(CLK),
    .RST(RST),
    .RX_IN(RX_IN),
    .data_samp_en(data_samp_en),
    .sampled_bit(sampled_bit)
 );

 DESERIALIZER U0_DESER (
    .CLK(CLK),
    .RST(RST),
    .deser_en(deser_en),
    .bit_counter (bit_counter),
    .sampled_bit(sampled_bit),
    .P_DATA(P_DATA)
 );

 START_CHECK U0_SRTC (
    .CLK(CLK),
    .RST(RST),
    .sampled_bit(sampled_bit),
    .start_check_en(start_check_en),
    .start_glitch(start_glitch)
 );

 PARITY_CHECK U0_PARC (
    .CLK(CLK),
    .RST(RST),
    .parity_check_en(parity_check_en),
    .sampled_bit(sampled_bit),
    .P_DATA(P_DATA),
    .parity_error(parity_error),
    .PAR_TYP(PAR_TYP)
 );

 STOP_CHECK U0_STPC (
    .CLK(CLK),
    .RST(RST),
    .stop_check_en(stop_check_en),
    .stop_error(stop_error),
    .sampled_bit(sampled_bit)
 );
    
endmodule