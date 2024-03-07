--A register file with 8 32-bit registers

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;
entity register_file is
    Port ( Data_in : in STD_LOGIC_VECTOR (31 downto 0);
           Reg_sel : in STD_LOGIC_VECTOR (2 downto 0);
           A_sel : in STD_LOGIC_VECTOR (2 downto 0);
           B_sel : in STD_LOGIC_VECTOR (2 downto 0);
           RW : in STD_LOGIC;
           clk: in STD_LOGIC;
           rst: in STD_LOGIC;
           A_out : out STD_LOGIC_VECTOR (31 downto 0);
           B_out : out STD_LOGIC_VECTOR (31 downto 0));
end register_file;

architecture Behavioral of register_file is
signal reg_loads: std_logic_vector(7 downto 0);
signal decoder_out:std_logic_vector(7 downto 0);
type regtype is array(0 to 7) of std_logic_vector(31 downto 0);
signal registers:regtype;
begin
    decoder: entity work.decoder
                generic map(k=>8)
                port map(
                dec_input=>Reg_sel,
                dec_output=>decoder_out);

    regload:for i in 0 to 7 generate
        reg_loads(i) <= decoder_out(i) and RW;
    end generate regload;

    regs:for i in 0 to 7 generate
        reg: entity work.shift_register
            generic map(k=>32)
            port map(
            data_in=>Data_in,
            data_out=>registers(i),
            clk=>clk,
            rst=>rst,
            Load=>reg_loads(i),
            Shift=>'0',
            Shift_dir=>'0');
    end generate regs;
    
    A_mux: entity work.nto1mux
            generic map(bus_width=>32,mux_size=>3)
            port map(
            input(8*32-1 downto 7*32)=>registers(0),
            input(7*32-1 downto 6*32)=>registers(1),
            input(6*32-1 downto 5*32)=>registers(2),
            input(5*32-1 downto 4*32)=>registers(3),
            input(4*32-1 downto 3*32)=>registers(4),
            input(3*32-1 downto 2*32)=>registers(5),
            input(2*32-1 downto 1*32)=>registers(6),
            input(31 downto 0)=>registers(7),
            sel=>A_sel,
            output=>A_out);
            
    B_mux: entity work.nto1mux
            generic map(bus_width=>32,mux_size=>3)
            port map(
            input(8*32-1 downto 7*32)=>registers(0),
            input(7*32-1 downto 6*32)=>registers(1),
            input(6*32-1 downto 5*32)=>registers(2),
            input(5*32-1 downto 4*32)=>registers(3),
            input(4*32-1 downto 3*32)=>registers(4),
            input(3*32-1 downto 2*32)=>registers(5),
            input(2*32-1 downto 1*32)=>registers(6),
            input(31 downto 0)=>registers(7),
            sel=>B_sel,
            output=>B_out);

end Behavioral;
