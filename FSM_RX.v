module FSM_RX (
input wire  [4:0]	   prescale ,
input wire      CLK , RST ,   
input wire      RX_IN ,
input wire      PAR_EN ,
input wire      parity_error ,
input wire      stop_error ,
input wire      start_glitch ,
input wire  [3:0]    bit_counter ,
input wire  [4:0]    edge_counter ,
output reg      data_samp_en ,
output reg      parity_check_en ,
output reg      start_check_en ,
output reg      stop_check_en ,
output reg      deser_en , 
output reg      Data_Valid ,
output reg      enable 
);
/*prescale calculation*/
wire [3:0] half ,half_p2,half_p3;
assign half = prescale >> 1 ;
assign half_p2 =half + 'd2 ;
assign half_p3 =half + 'd3 ;



/*states encoding*/
parameter IDLE = 3'b000 ;
parameter CHECKSTART = 3'b001 ;
parameter CHECKDATA = 3'b011 ;
parameter CHECKPARITY = 3'b010 ;
parameter CHECKSTOP = 3'b110 ;
parameter ERROR = 3'b111 ;

reg [2:0] state , next_state ;

always @(posedge CLK or negedge RST ) begin
   if (!RST) begin
    state <= IDLE ;
   end else begin
    state <= next_state ;
   end 
end

always @(*) begin
    case (state)
       IDLE : begin
        if (!RX_IN) begin
           next_state = CHECKSTART ; 
        end else begin
            next_state = IDLE ;
        end
       end
       CHECKSTART : begin
        if (!start_glitch) begin
            if (edge_counter == prescale) begin
            next_state = CHECKDATA ;
        end else begin
            next_state = CHECKSTART ;
        end
        end else begin
            next_state = IDLE ;
        end
        
       end
       CHECKDATA : begin
        if (bit_counter == 4'b1000 && edge_counter == prescale) begin
            if (PAR_EN) begin
                next_state = CHECKPARITY ;
            end else begin
                next_state = CHECKSTOP ;
            end
        end else begin
            next_state = CHECKDATA ;
        end
       end
       CHECKPARITY : begin
        if (!parity_error) begin
           if (edge_counter == prescale) begin
            next_state = CHECKSTOP ;
        end else begin
            next_state = CHECKPARITY ;
        end 
        end else begin
           next_state = ERROR ; 
        end
        
        end
       CHECKSTOP : begin
        if (edge_counter == prescale) begin
            if (!RX_IN && !stop_error) begin
                next_state = CHECKSTART ;
            end else begin
                next_state = IDLE ;
            end
        end else begin
            next_state = CHECKSTOP ;
        end
        end
        ERROR : begin
            if (edge_counter == prescale) begin
                next_state = IDLE ;
            end else begin
               next_state = ERROR ; 
            end
        end 
        default: next_state = IDLE ; 
    endcase
end

/*outputs logic*/
always @(*) begin
    data_samp_en = 1'b0 ;
    start_check_en = 1'b0 ;
    parity_check_en = 1'b0 ;
    stop_check_en = 1'b0 ;
    deser_en = 1'b0 ;
    Data_Valid = 1'b0 ;
    enable = 1'b0 ;

    case (state)
        IDLE : begin
            // nothing
        end 
        CHECKSTART : begin
            enable = 1'b1 ;
			data_samp_en = 1'b1 ; 
            if (edge_counter == half_p2 ) begin
                start_check_en = 1'b1 ;
            end
        end
        CHECKDATA : begin
            enable = 1'b1 ;
			data_samp_en = 1'b1 ;
            if (edge_counter == half_p2 ) begin
                deser_en = 1'b1 ;
            end
        end
        CHECKPARITY : begin
            enable = 1'b1 ;
			data_samp_en = 1'b1 ; 
            if (edge_counter == half_p2 ) begin
                parity_check_en = 1'b1 ;
            end
        end
        CHECKSTOP : begin
            enable = 1'b1 ;
			data_samp_en = 1'b1 ;      
            if (edge_counter == half_p2 ) begin
                stop_check_en = 1'b1 ;
            end
            if (edge_counter == half_p3 ) begin
                Data_Valid = 1'b1 ;
            end 
        end
        default: begin
        data_samp_en = 1'b0 ;
        start_check_en = 1'b0 ;
        parity_check_en = 1'b0 ;
        stop_check_en = 1'b0 ;
        deser_en = 1'b0 ;
        Data_Valid = 1'b0 ;
        enable = 1'b0 ;
        end
    endcase
end

    
endmodule