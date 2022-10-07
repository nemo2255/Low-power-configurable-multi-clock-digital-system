module FSM_TX (
    input  wire         PAR_EN ,
    input  wire         Data_Valid ,
    input  wire         ser_done ,
    input  wire         CLK ,RST ,
    output reg          ser_en ,
    output reg          busy ,
    output reg   [1:0]  mux_sel
);
parameter IDLE = 3'b000 ;
parameter ADDSTART = 3'b001 ;
parameter SERIALIZER = 3'b010 ;
parameter ADDPARITY = 3'b11 ;
parameter ADDSTOP = 3'b100 ;

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
        IDLE:begin
            if (Data_Valid) begin
                next_state = ADDSTART ;
            end else begin
               next_state = IDLE ; 
            end
        end
        ADDSTART:begin
            next_state = SERIALIZER ;
        end
        SERIALIZER:begin
            if (ser_done) begin
                if (PAR_EN) begin
                  next_state = ADDPARITY ;  
                end else begin
                  next_state = ADDSTOP ;  
                end
            end else begin
               next_state = SERIALIZER ; 
            end
        end
        ADDPARITY:begin
            next_state = ADDSTOP ;
        end
        ADDSTOP:begin
            if (Data_Valid) begin
                next_state = ADDSTART ;
            end else begin
               next_state = IDLE ; 
            end
        end    
        default: next_state = IDLE ;
    endcase
end
always @(*) begin
       case (state)
        IDLE: begin
            busy <= 1'b0 ;
            ser_en <= 1'b0 ;
            mux_sel <= 2'b01 ;
        end
        ADDSTART: begin
            busy <= 1'b1 ;
            ser_en <= 1'b0 ;
            mux_sel <= 2'b00 ;
        end
        SERIALIZER: begin
            busy <= 1'b1 ;
            mux_sel <= 2'b10 ;
            if (ser_done) begin
               ser_en <= 1'b0 ; 
            end else begin
               ser_en <= 1'b1 ; 
            end
        end
        ADDPARITY: begin
            busy <= 1'b1 ;
            ser_en <= 1'b0 ;
            mux_sel <= 2'b11 ;
        end
        ADDSTOP: begin
            busy <= 1'b1 ;
            ser_en <= 1'b0 ;
            mux_sel <= 2'b01 ;
        end
        default: begin
            busy <= 1'b0 ;
            ser_en <= 1'b0 ;
            mux_sel <= 2'b01 ;
        end 
       endcase 
    end
    
endmodule