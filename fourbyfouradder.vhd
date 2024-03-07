----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:37:40 10/25/2023 
-- Design Name: 
-- Module Name:    fourbyfouradder - Behavioral 
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

entity nbyfouradder is
	 generic(k:integer);
    Port ( A : in  STD_LOGIC_VECTOR (k-1 downto 0);
           B : in  STD_LOGIC_VECTOR (k-1 downto 0);
			  addsubswitch: in std_logic;
           S : out  STD_LOGIC_VECTOR (k-1 downto 0);
           C : out  STD_LOGIC);
end nbyfouradder;

architecture Behavioral of nbyfouradder is
signal c_n: std_logic_vector((k/4)-1 downto 0);
signal xordB: std_logic_vector(k-1 downto 0);
begin
	Bxor:for i in 0 to k-1 generate
		xordB(i) <= B(i) xor addsubswitch;
	end generate Bxor;
	cla1: entity work.carrylookahead4bit port map(A(3 downto 0),xordB(3 downto 0),addsubswitch,S(3 downto 0),c_n(0));
	gen: for i in 1 to (k/4)-1 generate
		cla: entity work.carrylookahead4bit port map(A(4*(i+1)-1 downto 4*i),xordB(4*(i+1)-1 downto 4*i),c_n(i-1),S(4*(i+1)-1 downto 4*i),c_n(i));
	end generate;
	C <= c_n((k/4)-1);
end Behavioral;

