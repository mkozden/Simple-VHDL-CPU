library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JK_FF is
    Port ( J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           Qnot : out  STD_LOGIC);
end JK_FF;

architecture Behavioral of JK_FF is
begin
process (CLOCK)
variable A:std_logic;
begin
	if (rising_edge(CLOCK)) then
	case RESET is
			when '1' => A:='0';
			when '0' =>

		if (J='0' and K='0') then
			A:=A;
		elsif (J='0' and K='1') then
			A:='0';
		elsif (J='1' and K='0') then
			A:='1';
		elsif (J='1' and K='1') then
			A:= not A;
		end if;
	when others => null;
	end case;
	end if;
Q <= A;
Qnot <= not A;
end process;
end Behavioral;

