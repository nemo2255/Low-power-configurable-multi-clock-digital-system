module EDGE_BIT_COUNTER 
(
	input wire 	[4:0]   prescale ,
    input wire      CLK ,
    input wire      RST ,
    input wire      PAR_EN ,
    input wire      enable ,
    output reg [4:0] edge_counter ,
    output wire [3:0] bit_counter 
);


wire edge_done ;
wire     bit_done ;
reg [3:0] bitcount ;

assign edge_done = (edge_counter== prescale) ;
assign bit_done = PAR_EN? (bitcount==4'b1011):(bitcount==4'b1010) ;
assign bit_counter = bit_done? 4'b0: bitcount ;

always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        edge_counter <= 5'b0 ;
    end else begin
        if (!edge_done && enable) begin
            edge_counter <= edge_counter + 5'b1 ;
        end else begin
            edge_counter <= 5'b1 ;
        end
        
    end
    
end

always @(posedge CLK or negedge RST ) begin
    if (!RST) begin
        bitcount <= 4'b0 ;
    end else begin
        if (enable && !bit_done ) begin
        if( edge_done ) begin
          bitcount <= bitcount + 4'b1 ;  
        end 
        end else begin
            bitcount <= 4'b0 ;
        end
    end
    
end
    
endmodule