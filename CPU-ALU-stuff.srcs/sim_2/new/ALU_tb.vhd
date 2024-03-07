----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2024 09:43:41 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is

end ALU_tb;

architecture Behavioral of ALU_tb is

    component ALU
        generic(k:integer:=16);
        Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0); 
               B: in STD_LOGIC_VECTOR (k-1 downto 0);
               clk: in std_logic;
               rst: in std_logic;
               alu_func_sel : in STD_LOGIC_VECTOR (3 downto 0);
               Output : out STD_LOGIC_VECTOR (k-1 downto 0);
               Flags : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    constant k:integer:=16;
    signal A,B,Output: std_logic_vector(k-1 downto 0);
    signal func_sel: std_logic_vector(3 downto 0);
    signal Flags: std_logic_vector (3 downto 0);
    signal clk, rst: std_logic := '0';
    
    constant clk_period: time := 10 ns;
begin
uut: ALU
        generic map(k=>k)
        port map(A,B,clk,rst,func_sel,Output,Flags);
clk_proc:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

stim_proc:process
begin
    rst <= '1';
    wait for clk_period*2;
    rst <= '0';
    wait for clk_period;
    
    A <= std_logic_vector(to_signed(-123,k));
    B <= std_logic_vector(to_unsigned(4,k));
    func_sel <= "0000";
    wait for clk_period;
    func_sel <= "0001";
    wait for clk_period;
    func_sel <= "0010";
    wait for clk_period;
    func_sel <= "0011";
    wait for clk_period/2;
    A <= std_logic_vector(to_signed(2345,k));
    wait for clk_period/2;
    func_sel <= "0100";
    wait for clk_period;
    func_sel <= "0101";
    wait for clk_period;
    func_sel <= "0110";
    wait for clk_period;
    func_sel <= "0111";
    wait for clk_period;
    func_sel <= "1000";
    wait for clk_period;
    func_sel <= "1001";
    wait for clk_period;
    func_sel <= "1010";
    wait for clk_period;
    func_sel <= "1011";
    wait for clk_period;
    func_sel <= "1100";
    wait for clk_period;
    func_sel <= "1101";
    wait for clk_period;
    func_sel <= "1110";
    wait for clk_period;
    func_sel <= "1111";
    wait;


end process;
end Behavioral;
