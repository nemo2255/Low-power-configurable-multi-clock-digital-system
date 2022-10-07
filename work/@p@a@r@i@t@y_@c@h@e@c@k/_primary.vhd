library verilog;
use verilog.vl_types.all;
entity PARITY_CHECK is
    generic(
        WIDTH           : integer := 8
    );
    port(
        parity_check_en : in     vl_logic;
        sampled_bit     : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        PAR_TYP         : in     vl_logic;
        P_DATA          : in     vl_logic_vector;
        parity_error    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end PARITY_CHECK;
