----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 10:10:06 PM
-- Design Name: 
-- Module Name: nbitmultiplier - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nbitmultiplier is
    generic (k:integer:=8);
    Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0);
           B : in STD_LOGIC_VECTOR (k-1 downto 0);
           output : out STD_LOGIC_VECTOR (k-1 downto 0)); --only take the first k bits
end nbitmultiplier;

architecture Behavioral of nbitmultiplier is
signal dummy: std_logic_vector(k-1 downto 0);
signal full_result: std_logic_vector(2*k-1 downto 0);
begin

full_result <= std_logic_vector(unsigned(A)*unsigned(B));
dummy <= full_result(2*k-1 downto k);
output <= full_result(k-1 downto 0);

end Behavioral;
