library verilog;
use verilog.vl_types.all;
entity BIT_SYNC is
    generic(
        bus_width       : integer := 8
    );
    port(
        dest_clk        : in     vl_logic;
        dest_rst        : in     vl_logic;
        unsync_bit      : in     vl_logic;
        sync_bit        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bus_width : constant is 1;
end BIT_SYNC;
