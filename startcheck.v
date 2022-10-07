module START_CHECK (
    input wire          start_check_en ,
    input wire          sampled_bit ,
    input wire          CLK , RST ,
    output reg         start_glitch 
);

wire temp ;

assign temp = start_check_en? ((!sampled_bit)? 1'b0 : 1'b1 ) : 1'b0;

always @(posedge CLK or negedge RST ) begin
   if (!RST) begin
    start_glitch <= 1'b0 ;
   end else begin
    start_glitch <= temp ;
   end 
end

    
endmodule