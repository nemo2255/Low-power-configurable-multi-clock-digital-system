library verilog;
use verilog.vl_types.all;
entity FSM_RX is
    generic(
        IDLE            : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        CHECKSTART      : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        CHECKDATA       : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        CHECKPARITY     : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        CHECKSTOP       : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        ERROR           : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi1)
    );
    port(
        prescale        : in     vl_logic_vector(4 downto 0);
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        RX_IN           : in     vl_logic;
        PAR_EN          : in     vl_logic;
        parity_error    : in     vl_logic;
        stop_error      : in     vl_logic;
        start_glitch    : in     vl_logic;
        bit_counter     : in     vl_logic_vector(3 downto 0);
        edge_counter    : in     vl_logic_vector(4 downto 0);
        data_samp_en    : out    vl_logic;
        parity_check_en : out    vl_logic;
        start_check_en  : out    vl_logic;
        stop_check_en   : out    vl_logic;
        deser_en        : out    vl_logic;
        Data_Valid      : out    vl_logic;
        enable          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of CHECKSTART : constant is 1;
    attribute mti_svvh_generic_type of CHECKDATA : constant is 1;
    attribute mti_svvh_generic_type of CHECKPARITY : constant is 1;
    attribute mti_svvh_generic_type of CHECKSTOP : constant is 1;
    attribute mti_svvh_generic_type of ERROR : constant is 1;
end FSM_RX;
