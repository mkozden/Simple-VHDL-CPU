----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:12 10/26/2023 
-- Design Name: 
-- Module Name:    multiplier-16bit - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier16bit is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           Product : out  STD_LOGIC_VECTOR (31 downto 0));
end multiplier16bit;

architecture Behavioral of multiplier16bit is
type twodim is array(0 to 15) of std_logic_vector(15 downto 0);
signal prd,conn : twodim;
begin
	b_i:for i in 0 to 15 generate
		a_j:for j in 0 to 15 generate
		prd(i)(j) <= a(j) and b(i);
		end generate a_j;
	end generate b_i;
	Product(0)<= prd(0)(0);
	adder1: entity work.fourbyfouradder port map(A=>prd(1),
													  B(15)=>'0',
													  B(14 downto 0)=>prd(0)(15 downto 1),
													  addsubswitch=>'0',
													  S(0)=>Product(1),
													  S(15 downto 1)=>conn(0)(14 downto 0),
													  C=>conn(0)(15));
	adder2: entity work.fourbyfouradder port map(A=>prd(2),
													  B=>conn(0),
													  addsubswitch=>'0',
													  S(0)=>Product(2),
													  S(15 downto 1)=>conn(1)(14 downto 0),
													  C=>conn(1)(15));
	adder3: entity work.fourbyfouradder port map(A=>prd(3),
													  B=>conn(1),
													  addsubswitch=>'0',
													  S(0)=>Product(3),
													  S(15 downto 1)=>conn(2)(14 downto 0),
													  C=>conn(2)(15));
	adder4: entity work.fourbyfouradder port map(A=>prd(4),
													  B=>conn(2),
													  addsubswitch=>'0',
													  S(0)=>Product(4),
													  S(15 downto 1)=>conn(3)(14 downto 0),
													  C=>conn(3)(15));
	adder5: entity work.fourbyfouradder port map(A=>prd(5),
													  B=>conn(3),
													  addsubswitch=>'0',
													  S(0)=>Product(5),
													  S(15 downto 1)=>conn(4)(14 downto 0),
													  C=>conn(4)(15));
	adder6: entity work.fourbyfouradder port map(A=>prd(6),
													  B=>conn(4),
													  addsubswitch=>'0',
													  S(0)=>Product(6),
													  S(15 downto 1)=>conn(5)(14 downto 0),
													  C=>conn(5)(15));
	adder7: entity work.fourbyfouradder port map(A=>prd(7),
													  B=>conn(5),
													  addsubswitch=>'0',
													  S(0)=>Product(7),
													  S(15 downto 1)=>conn(6)(14 downto 0),
													  C=>conn(6)(15));
	adder8: entity work.fourbyfouradder port map(A=>prd(8),
													  B=>conn(6),
													  addsubswitch=>'0',
													  S(0)=>Product(8),
													  S(15 downto 1)=>conn(7)(14 downto 0),
													  C=>conn(7)(15));
	adder9: entity work.fourbyfouradder port map(A=>prd(9),
													  B=>conn(7),
													  addsubswitch=>'0',
													  S(0)=>Product(9),
													  S(15 downto 1)=>conn(8)(14 downto 0),
													  C=>conn(8)(15));
	adder10: entity work.fourbyfouradder port map(A=>prd(10),
													  B=>conn(8),
													  addsubswitch=>'0',
													  S(0)=>Product(10),
													  S(15 downto 1)=>conn(9)(14 downto 0),
													  C=>conn(9)(15));
	adder11: entity work.fourbyfouradder port map(A=>prd(11),
													  B=>conn(9),
													  addsubswitch=>'0',
													  S(0)=>Product(11),
													  S(15 downto 1)=>conn(10)(14 downto 0),
													  C=>conn(10)(15));
	adder12: entity work.fourbyfouradder port map(A=>prd(12),
													  B=>conn(10),
													  addsubswitch=>'0',
													  S(0)=>Product(12),
													  S(15 downto 1)=>conn(11)(14 downto 0),
													  C=>conn(11)(15));
	adder13: entity work.fourbyfouradder port map(A=>prd(13),
													  B=>conn(11),
													  addsubswitch=>'0',
													  S(0)=>Product(13),
													  S(15 downto 1)=>conn(12)(14 downto 0),
													  C=>conn(12)(15));
	adder14: entity work.fourbyfouradder port map(A=>prd(14),
													  B=>conn(12),
													  addsubswitch=>'0',
													  S(0)=>Product(14),
													  S(15 downto 1)=>conn(13)(14 downto 0),
													  C=>conn(13)(15));
	adder15: entity work.fourbyfouradder port map(A=>prd(15),
													  B=>conn(13),
													  addsubswitch=>'0',
													  S=>Product(30 downto 15),
													  C=>Product(31));

end Behavioral;

