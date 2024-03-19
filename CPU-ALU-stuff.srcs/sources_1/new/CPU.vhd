

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity CPU is
    Port ( --Instr_in : in STD_LOGIC_VECTOR (15 downto 0);
           Mem_data_in : in STD_LOGIC_VECTOR (31 downto 0);
           clk: in STD_LOGIC;
           rst: in STD_LOGIC;
           Mem_RW: out STD_LOGIC;
           Mem_data_out : out STD_LOGIC_VECTOR (31 downto 0);
           Mem_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
           --Instr_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
end CPU;

architecture Behavioral of CPU is
signal RW: std_logic;
signal Reg_sel,A_sel,B_sel: std_logic_vector(2 downto 0);
signal Const_sel,Mem_data_sel: std_logic_vector(0 downto 0);
signal Flags, Alu_func_sel: std_logic_vector(3 downto 0);
signal const: std_logic_vector(5 downto 0);
signal instr_in: std_logic_vector(15 downto 0);
signal instr_addr_out: std_logic_vector(31 downto 0);
begin
    ROM: entity work.fake_rom
                port map(instr_addr_out,instr_in);
    Control: entity work.Control
                port map(
                Flags=>Flags,
                Instr_in=>Instr_in,
                clk=>clk,
                rst=>rst,
                RW=>RW,
                Mem_RW=>Mem_RW,
                Const_out=>const,
                Reg_sel=>Reg_sel,
                A_sel=>A_sel,
                B_sel=>B_sel,
                Const_sel=>Const_sel,
                Mem_data_sel=>Mem_data_sel,
                Alu_func_sel=>Alu_func_sel,
                Instr_addr_out=>Instr_addr_out);

    Datapath: entity work.Datapath
                port map(
                Mem_data_in=>Mem_data_in,
                Constant_in=>const,
                clk=>clk,
                rst=>rst,
                RW=>RW,
                Reg_sel=>Reg_sel,
                A_sel=>A_sel,
                B_sel=>B_sel,
                Const_sel=>Const_sel,
                Mem_data_sel=>Mem_data_sel,
                Alu_func_sel=>Alu_func_sel,
                Flags=>Flags,
                Mem_data_out=>Mem_data_out,
                Mem_addr_out=>Mem_addr_out);

end Behavioral;
