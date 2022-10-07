library verilog;
use verilog.vl_types.all;
entity FSM_TX is
    generic(
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        ADDSTART        : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        SERIALIZER      : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        ADDPARITY       : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        ADDSTOP         : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0)
    );
    port(
        PAR_EN          : in     vl_logic;
        Data_Valid      : in     vl_logic;
        ser_done        : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        ser_en          : out    vl_logic;
        busy            : out    vl_logic;
        mux_sel         : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of ADDSTART : constant is 1;
    attribute mti_svvh_generic_type of SERIALIZER : constant is 1;
    attribute mti_svvh_generic_type of ADDPARITY : constant is 1;
    attribute mti_svvh_generic_type of ADDSTOP : constant is 1;
end FSM_TX;
