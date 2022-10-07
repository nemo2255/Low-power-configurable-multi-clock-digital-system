library verilog;
use verilog.vl_types.all;
entity DESERIALIZER is
    port(
        deser_en        : in     vl_logic;
        sampled_bit     : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        bit_counter     : in     vl_logic_vector(3 downto 0);
        P_DATA          : out    vl_logic_vector(7 downto 0)
    );
end DESERIALIZER;
