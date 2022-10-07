library verilog;
use verilog.vl_types.all;
entity STOP_CHECK is
    port(
        stop_check_en   : in     vl_logic;
        sampled_bit     : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        stop_error      : out    vl_logic
    );
end STOP_CHECK;
