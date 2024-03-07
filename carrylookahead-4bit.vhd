----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:40 10/25/2023 
-- Design Name: 
-- Module Name:    carrylookahead-4bit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carrylookahead4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  Cin : in STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (3 downto 0);
           Cout : out  STD_LOGIC);
end carrylookahead4bit;

architecture Behavioral of carrylookahead4bit is
signal P,G : STD_LOGIC_VECTOR (3 downto 0);
signal C : STD_LOGIC_VECTOR (4 downto 0);
begin
	assign_pg: for i in 0 to 3 generate
		G(i) <= A(i) and B(i);
		P(i) <= A(i) xor B(i);
	end generate assign_pg;
	C(0) <= Cin;
	assign_cs: for i in 0 to 3 generate
		S(i) <= P(i) xor C(i);
		C(i+1) <= (P(i) and C(i)) or G(i);
	end generate assign_cs;
Cout <= C(4);
end Behavioral;

