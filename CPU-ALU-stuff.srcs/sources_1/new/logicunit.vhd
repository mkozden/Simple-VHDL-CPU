-- Logic_sel = "00" -> A and B
-- Logic_sel = "01" -> A or B
-- Logic_sel = "10" -> A xor B
-- Logic_sel = "11" -> not A

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity logicunit is
    generic(k:integer:=8);
    Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0);
           B : in STD_LOGIC_VECTOR (k-1 downto 0);
           Logic_sel : in STD_LOGIC_VECTOR (1 downto 0);
           Logic_out : out STD_LOGIC_VECTOR (k-1 downto 0));
end logicunit;

architecture Behavioral of logicunit is
signal l_and,l_or,l_xor,l_not: std_logic_vector(k-1 downto 0);
begin
l_and <= A and B;
l_or <= A or B;
l_xor <= A xor B;
l_not <= not A;


logic_mux: entity work.nto1mux
            generic map(bus_width=>k,mux_size=>2)
            port map(input(4*k-1 downto 3*k)=>l_and,
                     input(3*k-1 downto 2*k)=>l_or,
                     input(2*k-1 downto k)=>l_xor,
                     input(k-1 downto 0)=>l_not,
                     sel=>Logic_sel,
                     output=>Logic_out);
end Behavioral;
