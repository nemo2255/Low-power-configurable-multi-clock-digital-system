library verilog;
use verilog.vl_types.all;
entity START_CHECK is
    port(
        start_check_en  : in     vl_logic;
        sampled_bit     : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        start_glitch    : out    vl_logic
    );
end START_CHECK;
