----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 09:31:20 PM
-- Design Name: 
-- Module Name: shiftunit - Behavioral
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

entity shiftunit is
    generic(k:integer:=8);
    Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0); --A is the shifted value
           B: in STD_LOGIC_VECTOR (k-1 downto 0);  --B is how many bits to shift
           shift_sel : in STD_LOGIC_VECTOR (1 downto 0);
           shift_out : out STD_LOGIC_VECTOR (k-1 downto 0));
end shiftunit;

architecture Behavioral of shiftunit is
signal shifted: std_logic_vector(k-1 downto 0);
begin
proc:process(A,B,shift_sel)
begin
    case shift_sel is
        when "00" =>
            shifted <= std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))));
        when "01" =>
            shifted <= std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B))));
        when "10" =>
            shifted <= std_logic_vector(shift_right(signed(A),to_integer(unsigned(B))));
        when others =>
            shifted <= B; --We'll use this to load constants straight into the registers
    end case;
end process;

shift_out <= shifted;
end Behavioral;
