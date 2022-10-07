library verilog;
use verilog.vl_types.all;
entity UART_RX_TOP is
    generic(
        WIDTH           : integer := 8
    );
    port(
        prescale        : in     vl_logic_vector(4 downto 0);
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        PAR_EN          : in     vl_logic;
        PAR_TYP         : in     vl_logic;
        RX_IN           : in     vl_logic;
        P_DATA          : out    vl_logic_vector;
        Data_Valid      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end UART_RX_TOP;
