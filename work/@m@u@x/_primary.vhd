library verilog;
use verilog.vl_types.all;
entity MUX is
    port(
        start_bit       : in     vl_logic;
        stop_bit        : in     vl_logic;
        ser_data        : in     vl_logic;
        PAR_BIT         : in     vl_logic;
        mux_sel         : in     vl_logic_vector(1 downto 0);
        TX_OUT          : out    vl_logic
    );
end MUX;
