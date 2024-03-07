----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:34 02/05/2024 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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
use IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
	 generic(k:integer);
    Port ( dec_input : in  STD_LOGIC_VECTOR (integer(log2(real(k)))-1 downto 0);
           dec_output : out  STD_LOGIC_VECTOR (k-1 downto 0));
end decoder;

architecture Behavioral of decoder is
begin
	proc:process(dec_input)
	begin
		decloop:for i in 0 to k-1 loop
		if(i=to_integer(unsigned(dec_input))) then
				dec_output(i) <= '1';
		else
			   dec_output(i) <= '0';
		end if;
		end loop;
	end process;
end Behavioral;

