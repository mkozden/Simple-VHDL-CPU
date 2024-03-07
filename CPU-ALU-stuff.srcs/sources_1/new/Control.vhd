library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity Control is
    Port ( Flags : in STD_LOGIC_VECTOR (3 downto 0);
           Instr_in : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           RW : out STD_LOGIC;
           Mem_RW : out STD_LOGIC;
           Const_out : out STD_LOGIC_VECTOR (5 downto 0);
           Reg_sel : out STD_LOGIC_VECTOR (2 downto 0);
           A_sel : out STD_LOGIC_VECTOR (2 downto 0);
           B_sel : out STD_LOGIC_VECTOR (2 downto 0);
           Const_sel : out STD_LOGIC_VECTOR (0 downto 0);
           Mem_data_sel : out STD_LOGIC_VECTOR (0 downto 0);
           alu_func_sel : out STD_LOGIC_VECTOR (3 downto 0);
           Instr_addr_out : out STD_LOGIC_VECTOR (31 downto 0));
end Control;

architecture Behavioral of Control is
signal Branch_enable,Branch_enable_control, cmp_enable, mov_enable: std_logic;
signal Add_mux_sel,PC_mux_sel: std_logic_vector(0 downto 0);
signal Branch_mode: std_logic_vector(1 downto 0);
signal Branch_offset: std_logic_vector(31 downto 0);
signal PC_in,PC_out,Add_in,Add_out,Branch_offset_shifted: std_logic_vector(31 downto 0);
signal N,Z: std_logic;
constant two: std_logic_vector(31 downto 0) := (1=>'1',others=>'0');
begin

N <= Flags(3);
Z <= Flags(2);
Branch_enable <= (Branch_mode(0) and not N) or (Branch_mode(1) and N) or (not Branch_mode(1) and not Branch_mode(0) and Z);
Instr_addr_out <= PC_out;

Branch_offset(7 downto 0) <= Instr_in(7 downto 0); --Branch offset is given by combination of Reg_sel,A_sel and B_sel, since we do a compare operation before to set the flags
Branch_offset(31 downto 8) <= (others=>Instr_in(8)); --preserve offset sign
PC_mux_sel(0) <= (Branch_mode(1) and Branch_mode(0)) and Branch_enable_control;
Branch_offset_shifted <= std_logic_vector(shift_left(unsigned(Branch_offset),1));
Add_mux_sel(0) <= Branch_enable and Branch_enable_control;


    PC: entity work.shift_register
            generic map(k=>32)
            port map(
            Data_in=>PC_in,
            Data_out=>PC_out,
            clk=>clk,
            rst=>rst,
            Load=>'1',
            Shift=>'0',
            Shift_dir=>'0');
            
    PC_mux: entity work.nto1mux
                generic map(bus_width=>32,mux_size=>1)
                port map(
                input(63 downto 32)=>Add_out,
                input(31 downto 0)=>Branch_offset_shifted,
                sel=>PC_mux_sel,
                output=>PC_in);

    Add_mux: entity work.nto1mux
                generic map(bus_width=>32,mux_size=>1)
                port map(
                input(63 downto 32)=>two,
                input(31 downto 0)=>Branch_offset_shifted,
                sel=>Add_mux_sel,
                output=>Add_in);
    
    Adder: entity work.nbyfouradder
            generic map(k=>32)
            port map(
            A=>PC_out,
            B=>Add_in,
            addsubswitch=>'0',
            S=>Add_out,
            C=>open);

--refer to excel table in the folder  
Reg_sel <= Instr_in(8 downto 6);
A_sel <= Instr_in(5 downto 3);
B_sel <= Instr_in(2 downto 0);
Const_sel(0) <= Instr_in(15);

mov_enable <= Instr_in(15) and not Instr_in(14) and Instr_in(13);
cmp_enable <= Instr_in(14) and Instr_in(13);

const_out(2 downto 0) <= Instr_in(2 downto 0);
const_out(3) <= Instr_in(3) and mov_enable;
const_out(4) <= Instr_in(4) and mov_enable;
const_out(5) <= Instr_in(5) and mov_enable;


ALU_func_sel(3) <= Instr_in(12) and not cmp_enable and not mov_enable;
ALU_func_sel(2) <= (Instr_in(11) and not cmp_enable) or mov_enable;
ALU_func_sel(1) <= (Instr_in(10) and not cmp_enable) or mov_enable;
ALU_func_sel(0) <= Instr_in(9) or cmp_enable or mov_enable;       --so that we force ALU to SUB mode if CMP instruction sent, and to B mode when MOV sent
mem_data_sel(0) <= Instr_in(13) and not Instr_in(14) and not Instr_in(15);
RW <= not Instr_in(14);
Mem_RW <= Instr_in(14) and not Instr_in(15) and not Instr_in(13);
Branch_enable_control <= Instr_in(14) and Instr_in(15);
Branch_mode(1) <= Instr_in(13);
Branch_mode(0) <= Instr_in(9);
end Behavioral;
