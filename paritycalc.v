module paritycalc #(
    parameter P_DATA_WIDTH = 8    //DATA WIDTH
) (
    input wire [P_DATA_WIDTH-1:0] P_DATA ,
    input wire                    Data_Valid ,
    input wire                    PAR_TYP ,
    input wire                    PAR_EN ,
    input wire                    CLK , RST ,
    output reg                   PAR_BIT
);

   reg [P_DATA_WIDTH-1:0]  TEMP ;

   always @(posedge CLK or negedge RST ) begin
        if (!RST) begin
            TEMP <= 'b0 ;
        end else if(Data_Valid) begin
            TEMP <= P_DATA ;
        end
   end

   always @(posedge CLK or negedge RST ) begin
       if (!RST) begin
        PAR_BIT <= 1'b0 ;
       end else begin
        if (PAR_EN) begin
          case (PAR_TYP)
            1'b0: PAR_BIT <= ^TEMP ; //even
            1'b1: PAR_BIT <= ~^TEMP ; //odd
          endcase  
        end
       end
   end
endmodule