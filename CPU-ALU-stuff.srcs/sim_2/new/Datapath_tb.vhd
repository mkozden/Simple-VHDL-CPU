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

entity Datapath_tb is

end Datapath_tb;

architecture Behavioral of Datapath_tb is

    component Datapath
        Port ( Mem_data_in : in STD_LOGIC_VECTOR (31 downto 0);
               Constant_in : in STD_LOGIC_VECTOR (2 downto 0);
               clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               RW : in STD_LOGIC;
               Reg_sel : in STD_LOGIC_VECTOR (2 downto 0);
               A_sel : in STD_LOGIC_VECTOR (2 downto 0);
               B_sel : in STD_LOGIC_VECTOR (2 downto 0);
               Const_sel : in STD_LOGIC_VECTOR(0 downto 0);
               Mem_data_sel : in STD_LOGIC_VECTOR(0 downto 0);
               alu_func_sel : in STD_LOGIC_VECTOR (3 downto 0);
               Flags : out STD_LOGIC_VECTOR (3 downto 0);
               Mem_data_out : out STD_LOGIC_VECTOR (31 downto 0);
               Mem_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal Mem_data_in,Mem_data_out,Mem_addr_out: std_logic_vector(31 downto 0) := (others => '0');
    signal Constant_in,Reg_sel,A_sel,B_sel: std_logic_vector(2 downto 0) := (others => '0');
    signal Const_sel, Mem_data_sel: std_logic_vector(0 downto 0) := (others => '0');
    signal alu_func_sel, Flags: std_logic_vector(3 downto 0) := (others => '0');
    signal clk, rst, RW: std_logic := '0';
    
    constant clk_period: time := 10 ns;
begin
uut: Datapath
        port map(Mem_data_in,Constant_in,clk,rst,RW,Reg_sel,A_sel,B_sel,Const_sel,Mem_data_sel,alu_func_sel,Flags,Mem_data_out,Mem_addr_out);
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
    wait for clk_period; --ADD R1,R0,#5
    Constant_in <= "101";
    Reg_sel <= "001"; --R1
    Const_sel <= "1";
    A_sel <= "000"; --R0
    alu_func_sel <= "0000";
    RW <= '1';
    wait for clk_period; --ADD R2,R1,#5
    Constant_in <= "101";
    Reg_sel <= "010"; --
    Const_sel <= "1";
    A_sel <= "001";
    alu_func_sel <= "0000";
    RW <= '1';
    wait for clk_period; --MUL R3,R2,R1
    Reg_sel <= "011"; --
    Const_sel <= "0";
    A_sel <= "010";
    B_sel <= "001";
    alu_func_sel <= "0010";
    RW <= '1';
    wait for clk_period; --MUL R3,R3,R3
    Reg_sel <= "011"; --
    Const_sel <= "0";
    A_sel <= "011";
    B_sel <= "011";
    alu_func_sel <= "0010";
    RW <= '1';
    wait for clk_period; --LSL R3,R3,#2
    Reg_sel <= "011"; --
    Const_sel <= "1";
    A_sel <= "011";
    Constant_in <= "010";
    alu_func_sel <= "0100";
    RW <= '1';
    wait for clk_period; --XOR R4,R3,R2
    Reg_sel <= "100"; --
    Const_sel <= "0";
    A_sel <= "011";
    B_sel <= "010";
    alu_func_sel <= "1010";
    RW <= '1';
    wait for clk_period; --SUB R5,R4,R3
    Reg_sel <= "101"; --
    Const_sel <= "0";
    A_sel <= "100";
    B_sel <= "011";
    alu_func_sel <= "0001";
    RW <= '1';
    wait for clk_period; --ASR R5,R5,#3
    Reg_sel <= "101"; --
    Const_sel <= "1";
    A_sel <= "101";
    Constant_in <= "011";
    alu_func_sel <= "0110";
    RW <= '1'; 
    wait for clk_period; --MUL R6,R3,R3
    Reg_sel <= "110"; --
    Const_sel <= "0";
    A_sel <= "011";
    B_sel <= "011";
    alu_func_sel <= "0010";
    RW <= '1';
    wait for clk_period; --MUL R6,R6,R3
    Reg_sel <= "110"; --
    Const_sel <= "0";
    A_sel <= "110";
    B_sel <= "011";
    alu_func_sel <= "0010";
    RW <= '1';
    wait for clk_period;
    RW <= '0';
    wait;


end process;
end Behavioral;
