module serializer #(
    parameter P_DATA_WIDTH = 8    //DATA WIDTH
) (
    input wire [P_DATA_WIDTH-1:0]  P_DATA ,
    input wire                    ser_en ,
	input wire                    busy ,
    input wire                    CLK , RST ,
    input wire                    Data_Valid ,
    output wire                   ser_done ,
    output wire                    ser_data 
);
reg [2:0] counter ;
reg [P_DATA_WIDTH-1:0] TEMP ;


assign ser_done = (counter == 3'b111) ;
assign ser_data = TEMP[0] ;

always @(posedge CLK or negedge RST ) begin
 if (!RST) begin
    TEMP <= 'b0 ;
 end else if (Data_Valid  &&  !busy) begin
    TEMP <= P_DATA ;
 end else if(ser_en) begin
    TEMP <= TEMP >> 1 ;
 end  
end

always @(posedge CLK or negedge RST ) begin
  if (!RST) begin
    counter <= 3'b0 ; 
  end else if (ser_en) begin
     counter <= counter + 3'b1 ;
  end else begin
    counter <= 3'b0 ;
  end 
end
    
endmodule