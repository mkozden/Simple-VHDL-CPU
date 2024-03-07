----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 09:43:41 PM
-- Design Name: 
-- Module Name: shiftunit_tb - Behavioral
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

entity shiftunit_tb is

end shiftunit_tb;

architecture Behavioral of shiftunit_tb is

    component shiftunit
        generic(k:integer:=8);
        Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0); --A is the shifted value
               B: in STD_LOGIC_VECTOR (k-1 downto 0);  --B is how many bits to shift
               shift_sel : in STD_LOGIC_VECTOR (1 downto 0);
               shift_out : out STD_LOGIC_VECTOR (k-1 downto 0));
    end component;
    
    constant k:integer:=8;
    signal A,B,shift_out: std_logic_vector(k-1 downto 0);
    signal shift_sel: std_logic_vector(1 downto 0);
        
begin
uut: shiftunit
        generic map(k=>k)
        port map(A,B,shift_sel,shift_out);
stim_proc:process
begin
    A <= std_logic_vector(to_unsigned(234,k));
    B <= std_logic_vector(to_unsigned(3,k));
    shift_sel <= "00";
    wait for 25 ns;
    shift_sel <= "01";
    wait for 25 ns;
    shift_sel <= "10";
    wait for 25 ns;
    shift_sel <= "11";
    wait for 25 ns;

end process;
end Behavioral;
