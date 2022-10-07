library verilog;
use verilog.vl_types.all;
entity SYS_TOP_dft is
    generic(
        DATA_WIDTH      : integer := 8;
        RF_ADDR         : integer := 4;
        NUM_OF_CHAINS   : integer := 3
    );
    port(
        scan_clk        : in     vl_logic;
        scan_rst        : in     vl_logic;
        test_mode       : in     vl_logic;
        SE              : in     vl_logic;
        SI              : in     vl_logic_vector;
        SO              : out    vl_logic_vector;
        RST_N           : in     vl_logic;
        UART_CLK        : in     vl_logic;
        REF_CLK         : in     vl_logic;
        UART_RX_IN      : in     vl_logic;
        UART_TX_O       : out    vl_logic;
        parity_error    : out    vl_logic;
        framing_error   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of RF_ADDR : constant is 1;
    attribute mti_svvh_generic_type of NUM_OF_CHAINS : constant is 1;
end SYS_TOP_dft;
