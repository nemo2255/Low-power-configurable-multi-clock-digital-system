library verilog;
use verilog.vl_types.all;
entity serializer is
    generic(
        P_DATA_WIDTH    : integer := 8
    );
    port(
        P_DATA          : in     vl_logic_vector;
        ser_en          : in     vl_logic;
        busy            : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Data_Valid      : in     vl_logic;
        ser_done        : out    vl_logic;
        ser_data        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of P_DATA_WIDTH : constant is 1;
end serializer;
