----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 10:45:42 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use work.all;

entity ALU is
    generic(k:integer:=8);
    Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0);
           B : in STD_LOGIC_VECTOR (k-1 downto 0);
           clk: in STD_LOGIC;
           rst: in STD_LOGIC;
           alu_func_sel : in STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (k-1 downto 0);
           Flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
signal al_sel:std_logic_vector(0 downto 0);
signal a_out,l_out:std_logic_vector(k-1 downto 0);
signal flags_signal:std_logic_vector(3 downto 0);
signal sub_check: std_logic;
begin

arithmetic: entity work.arithmeticunit
            generic map(k=>k)
            port map(
            A=>A,
            B=>B,
            func_sel=>alu_func_sel(2 downto 0),
            Output=>a_out,
            Flag_values=>flags_signal);
logic: entity work.logicunit
            generic map(k=>k)
            port map(
            A=>A,
            B=>B,
            Logic_sel=>alu_func_sel(1 downto 0),
            Logic_out=>l_out);

al_sel(0) <= alu_func_sel(3);
AL_mux: entity work.nto1mux
            generic map(bus_width=>k,mux_size=>1)
            port map(
            input(2*k-1 downto k)=>a_out,
            input(k-1 downto 0)=>l_out,
            sel=>al_sel,
            output=>Output);

sub_check <= (not alu_func_sel(3) and not alu_func_sel(2) and not alu_func_sel(1) and alu_func_sel(0));
flags_register: entity work.shift_register
            generic map(k=>4)
            port map(flags_signal,Flags,clk,rst,sub_check,'0','0'); --flags only updated when subtraction is used, since that's what is used for comparing numbers        

end Behavioral;
