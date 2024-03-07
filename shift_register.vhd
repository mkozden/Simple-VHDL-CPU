----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:24 12/10/2023 
-- Design Name: 
-- Module Name:    shift_register_8bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
	 generic(K:integer);
    Port ( data_in : in  STD_LOGIC_VECTOR (K-1 downto 0);
           data_out : out  STD_LOGIC_VECTOR (K-1 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Load : in  STD_LOGIC;
           Shift : in  STD_LOGIC;
           Shift_dir : in  STD_LOGIC); --0 for left shift, 1 for right shift
end shift_register;

architecture Behavioral of shift_register is
signal enable: std_logic_vector(K-1 downto 0);
signal ff_states: std_logic_vector(K-1 downto 0);
signal ff_states_shifted: std_logic_vector(K-1 downto 0);
constant allzero: std_logic_vector(K-1 downto 0) := (others => '0');
begin
	e:for i in K-1 downto 0 generate
		enable(i) <= (Load and data_in(i)) or (not Load and ff_states_shifted(i));
	end generate e;
	f:for i in K-1 downto 0 generate
		FF: entity work.JK_FF port map(enable(i), not enable(i), clk, rst, ff_states(i), open);
	end generate f;
	process(clk,Shift,ff_states,ff_states_shifted,rst,Shift_dir) is
	begin
	case Shift is
		when '1' =>
			case Shift_dir is
				when '0' =>
					ff_states_shifted <= std_logic_vector(shift_left(unsigned(ff_states),1));
					data_out <= ff_states_shifted;
				when '1' =>
					ff_states_shifted <= std_logic_vector(shift_right(unsigned(ff_states),1));
					data_out <= ff_states_shifted;
				when others =>
					ff_states_shifted <= ff_states;
					data_out <=ff_states_shifted;
			end case;
		when others => 
			ff_states_shifted <= ff_states;
			data_out <=ff_states_shifted;
	end case;
	case rst is
		when '1' =>
			data_out <= allzero;
		when others =>
			null;
	end case;
	end process;
end Behavioral;
