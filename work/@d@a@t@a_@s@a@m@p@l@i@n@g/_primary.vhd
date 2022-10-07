library verilog;
use verilog.vl_types.all;
entity DATA_SAMPLING is
    port(
        prescale        : in     vl_logic_vector(4 downto 0);
        data_samp_en    : in     vl_logic;
        RX_IN           : in     vl_logic;
        edge_counter    : in     vl_logic_vector(4 downto 0);
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        sampled_bit     : out    vl_logic
    );
end DATA_SAMPLING;
