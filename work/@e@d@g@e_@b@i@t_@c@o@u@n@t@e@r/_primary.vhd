library verilog;
use verilog.vl_types.all;
entity EDGE_BIT_COUNTER is
    port(
        prescale        : in     vl_logic_vector(4 downto 0);
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        PAR_EN          : in     vl_logic;
        enable          : in     vl_logic;
        edge_counter    : out    vl_logic_vector(4 downto 0);
        bit_counter     : out    vl_logic_vector(3 downto 0)
    );
end EDGE_BIT_COUNTER;
