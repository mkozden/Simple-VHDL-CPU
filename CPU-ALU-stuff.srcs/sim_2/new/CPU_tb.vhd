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

entity CPU_tb is

end CPU_tb;

architecture Behavioral of CPU_tb is

    component CPU
    Port ( --Instr_in : in STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_in : in STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC;
           rst: in STD_LOGIC;
           Mem_RW: out STD_LOGIC;
           Mem_data_out : out STD_LOGIC_VECTOR (31 downto 0);
           Mem_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
           --Instr_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal Mem_data_in,Mem_data_out,Mem_addr_out: std_logic_vector(31 downto 0);
    --signal Instr_in: std_logic_vector(15 downto 0);
    signal clk, rst, Mem_RW: std_logic;
    
    constant clk_period: time := 10 ns;
begin
uut: CPU
        --port map(Instr_in,Mem_data_in,clk,rst,Mem_RW,Mem_data_out,Mem_addr_out,Instr_addr_out);
        port map(Mem_data_in,clk,rst,Mem_RW,Mem_data_out,Mem_addr_out);
clk_proc:process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

emulated_data_memory: process(Mem_addr_out)
begin
    case Mem_addr_out is
        when std_logic_vector(to_unsigned(0,32)) =>
            Mem_data_in <= std_logic_vector(to_unsigned(2147483647,32));
        when std_logic_vector(to_unsigned(4,32)) =>
            Mem_data_in <= std_logic_vector(to_unsigned(5,32));
        when others =>
            Mem_data_in <= std_logic_vector(to_unsigned(0,32));
    end case;
end process;

--emulated_instr_memory: process(Instr_addr_out)
--begin
--    case Instr_addr_out is
--        when std_logic_vector(to_unsigned(0,32)) =>
--                Instr_in <= "001XXXX111XXX101"; --LDR R7, R5
--        when std_logic_vector(to_unsigned(2,32)) =>
--                Instr_in <= "1000000101101100"; --ADD R5, R5, #4
--        when std_logic_vector(to_unsigned(4,32)) =>
--                Instr_in <= "001XXXX110XXX101"; --LDR R6, R5
--        when std_logic_vector(to_unsigned(6,32)) =>
--                Instr_in <= "0000111101XXX111"; --MOV R5, R7
--        when std_logic_vector(to_unsigned(8,32)) =>
--                Instr_in <= "1000101101101001"; --LSR R5,R5,#1
--        when std_logic_vector(to_unsigned(10,32)) =>
--                Instr_in <= "1000000010010001"; --ADD R2,R2,#1
--        when std_logic_vector(to_unsigned(12,32)) =>
--                Instr_in <= "0110001XXX100101"; --CMP R4,R5
--        when std_logic_vector(to_unsigned(14,32)) =>
--                Instr_in <= "111XXX0111111101"; --BLT -3
--        when std_logic_vector(to_unsigned(16,32)) =>
--                Instr_in <= "1000001010010001"; --SUB R2,R2,#1
--        when std_logic_vector(to_unsigned(18,32)) =>
--                Instr_in <= "1000100000000001"; --LSL R0,R0,#1
--        when std_logic_vector(to_unsigned(20,32)) =>
--                Instr_in <= "0000101100111010"; --LSL R4,R7,R2
--        when std_logic_vector(to_unsigned(22,32)) =>
--                Instr_in <= "1001000100100001"; --AND R4,R4,#1
--        when std_logic_vector(to_unsigned(24,32)) =>
--                Instr_in <= "0001001000000100"; --ORR R0,R0,R4
--        when std_logic_vector(to_unsigned(26,32)) =>
--                Instr_in <= "0110001XXX000110"; --CMP R0,R6
--        when std_logic_vector(to_unsigned(28,32)) =>
--                Instr_in <= "111XXX0000000101"; --BLT 5
--        when std_logic_vector(to_unsigned(30,32)) =>
--                Instr_in <= "0000001000000110"; --SUB R0,R0,R6
--        when std_logic_vector(to_unsigned(32,32)) =>
--                Instr_in <= "1010111100000001"; --MOV R4,#1
--        when std_logic_vector(to_unsigned(34,32)) =>
--                Instr_in <= "0000100100100010"; --LSL R4,R4,R2
--        when std_logic_vector(to_unsigned(36,32)) =>
--                Instr_in <= "0001001001001100"; --ORR R1,R1,R4
--        when std_logic_vector(to_unsigned(38,32)) =>
--                Instr_in <= "1010111100000000"; --MOV R4,#0
--        when std_logic_vector(to_unsigned(40,32)) =>
--                Instr_in <= "0110001XXX010100"; --CMP R2,R4
--        when std_logic_vector(to_unsigned(42,32)) =>
--                Instr_in <= "110XXX0000000011"; --BEQ 3
--        when std_logic_vector(to_unsigned(44,32)) =>
--                Instr_in <= "1000001010010001"; --SUB R2,R2,#1
--        when std_logic_vector(to_unsigned(46,32)) =>
--                Instr_in <= "111XXX1000001001"; --JMP 9
--        when std_logic_vector(to_unsigned(48,32)) =>
--                Instr_in <= "1010111110001000"; --MOV R5,#8
--        when std_logic_vector(to_unsigned(50,32)) =>
--                Instr_in <= "010XXXXXXX000110"; --STO R0, R5
--        when std_logic_vector(to_unsigned(52,32)) =>
--                Instr_in <= "1010111110001100"; --MOV R5,#12
--        when std_logic_vector(to_unsigned(54,32)) =>
--                Instr_in <= "010XXXXXXX001110"; --STO R1, R5
--        when others =>
--                Instr_in <= "111XXX1010000000"; --JMP 128

--    end case;
--end process;
stim_proc:process
begin
    rst <= '1';
    wait for clk_period*2;
    rst <= '0';
    wait;
end process;
end Behavioral;
