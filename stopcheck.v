module STOP_CHECK (
    input wire          stop_check_en ,
    input wire          sampled_bit ,
    input wire          CLK , RST ,
    output reg         stop_error 
);

wire temp ;

assign temp = stop_check_en? ((sampled_bit)? 1'b0 : 1'b1 ) : 1'b0;

always @(posedge CLK or negedge RST ) begin
   if (!RST) begin
    stop_error <= 1'b0 ;
   end else begin
    stop_error <= temp ;
   end 
end

    
endmodule