library verilog;
use verilog.vl_types.all;
entity RST_SYNC is
    port(
        RST             : in     vl_logic;
        CLK             : in     vl_logic;
        SYNC_RST        : out    vl_logic
    );
end RST_SYNC;
