module DESERIALIZER (
   input wire       deser_en ,
   input wire       sampled_bit ,
   input wire       CLK ,RST ,
   input wire [3:0] bit_counter ,
   output reg [7:0] P_DATA 
);


  always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        P_DATA <= 8'b0 ;
    end else begin
        if (deser_en) begin
           P_DATA[bit_counter-1] <= sampled_bit ;
        end
    end
  end  
endmodule