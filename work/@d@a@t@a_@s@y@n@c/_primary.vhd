library verilog;
use verilog.vl_types.all;
entity DATA_SYNC is
    generic(
        bus_width       : integer := 8
    );
    port(
        dest_clk        : in     vl_logic;
        dest_rst        : in     vl_logic;
        unsync_bus      : in     vl_logic_vector;
        bus_enable      : in     vl_logic;
        sync_bus        : out    vl_logic_vector;
        enable_pulse_d  : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bus_width : constant is 1;
end DATA_SYNC;
