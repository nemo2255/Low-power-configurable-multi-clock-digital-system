module PARITY_CHECK #(parameter WIDTH = 8) 
(
    input wire          parity_check_en ,
    input wire          sampled_bit ,
    input wire          CLK , RST ,
    input wire          PAR_TYP ,
    input wire [WIDTH-1:0] P_DATA ,
    output reg          parity_error 
);

wire temp ;
wire parity ;

assign parity = PAR_TYP? ~^P_DATA : ^P_DATA ;
assign temp = parity_check_en? ((sampled_bit == parity)? 1'b0 : 1'b1 ) : 1'b0;

always @(posedge CLK or negedge RST ) begin
   if (!RST) begin
    parity_error <= 1'b0 ;
   end else begin
    parity_error <= temp ;
   end 
end

    
endmodule