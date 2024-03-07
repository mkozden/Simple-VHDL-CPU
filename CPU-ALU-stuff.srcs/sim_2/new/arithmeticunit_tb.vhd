----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 09:43:41 PM
-- Design Name: 
-- Module Name: arithmeticunit_tb - Behavioral
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

entity arithmeticunit_tb is

end arithmeticunit_tb;

architecture Behavioral of arithmeticunit_tb is

    component arithmeticunit
        generic(k:integer:=16);
        Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0); 
               B: in STD_LOGIC_VECTOR (k-1 downto 0);
               func_sel : in STD_LOGIC_VECTOR (2 downto 0);
               Output : out STD_LOGIC_VECTOR (k-1 downto 0);
               Flag_values : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    constant k:integer:=16;
    signal A,B,Output: std_logic_vector(k-1 downto 0);
    signal func_sel: std_logic_vector(2 downto 0);
    signal Flag_values: std_logic_vector (3 downto 0);
        
begin
uut: arithmeticunit
        generic map(k=>k)
        port map(A,B,func_sel,Output,Flag_values);
stim_proc:process
begin
    A <= std_logic_vector(to_signed(-123,k));
    B <= std_logic_vector(to_unsigned(4,k));
    func_sel <= "000";
    wait for 25 ns;
    func_sel <= "001";
    wait for 25 ns;
    func_sel <= "010";
    wait for 25 ns;
    func_sel <= "011";
    wait for 25 ns;
    func_sel <= "100";
    wait for 25 ns;
    func_sel <= "101";
    wait for 25 ns;
    func_sel <= "110";
    wait for 25 ns;
    func_sel <= "111";
    wait;


end process;
end Behavioral;
