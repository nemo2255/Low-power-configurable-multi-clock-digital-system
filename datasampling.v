module DATA_SAMPLING (
	input wire  [4:0] prescale ,
    input wire          data_samp_en ,
    input wire          RX_IN ,
	input wire [4:0] edge_counter ,
    input wire          CLK , RST ,
    output reg          sampled_bit
);
reg [2:0] samples ;

wire [3:0]    half_edges ,
              half_edges_p1 ,
			  half_edges_p2 ,
			  half_edges_n1 ;


assign 	half_edges =  (prescale >> 1) - 'b1;
assign 	half_edges_p1 =  half_edges + 'b1 ;
assign 	half_edges_p2 =  half_edges + 'd2 ;
assign 	half_edges_n1 =  half_edges - 'b1 ;



always @(posedge CLK or negedge RST ) begin
    if(!RST)
   begin
    samples <= 'b0 ;
   end
  else 
   begin
    if(data_samp_en) 
	 begin
	  if(edge_counter == half_edges_n1)
       begin
        samples[0] <= RX_IN ;
       end	
      else if(edge_counter == half_edges)
       begin
        samples[1] <= RX_IN ;
       end	
      else if(edge_counter == half_edges_p1)
       begin
        samples[2] <= RX_IN ;
       end
     end
    else
     begin
      samples <= 'b0 ;
     end 
   end	 
end


//isolate
always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
    sampled_bit <= 'b0 ;
   end
  else
   begin
    if(edge_counter == half_edges_p2) 
	 begin
      case (samples)
      3'b000 : begin
                sampled_bit <= 1'b0 ;
               end	
      3'b001 : begin
                sampled_bit <= 1'b0 ;
               end
      3'b010 : begin
                sampled_bit <= 1'b0 ;
               end	
      3'b011 : begin
                sampled_bit <= 1'b1 ;
               end	
      3'b100 : begin
                sampled_bit <= 1'b0 ;
               end
      3'b101 : begin
                sampled_bit <= 1'b1 ;
               end	
      3'b110 : begin
                sampled_bit <= 1'b1 ;
               end
      3'b111 : begin
                sampled_bit <= 1'b1 ;
               end
      endcase
     end
    else
     begin
       sampled_bit <= 1'b0 ;
     end	 
   end
end

    
endmodule