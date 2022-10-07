library verilog;
use verilog.vl_types.all;
entity UART_TX_TOP is
    generic(
        P_DATA_WIDTH    : integer := 8
    );
    port(
        P_DATA          : in     vl_logic_vector;
        Data_Valid      : in     vl_logic;
        PAR_EN          : in     vl_logic;
        PAR_TYP         : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        TX_OUT          : out    vl_logic;
        busy            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of P_DATA_WIDTH : constant is 1;
end UART_TX_TOP;
