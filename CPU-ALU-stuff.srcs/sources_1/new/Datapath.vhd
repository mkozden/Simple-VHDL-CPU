library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity Datapath is
    Port ( Mem_data_in : in STD_LOGIC_VECTOR (31 downto 0);
           Constant_in : in STD_LOGIC_VECTOR (5 downto 0);
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
end Datapath;


architecture Behavioral of Datapath is
constant zero_fill: std_logic_vector(31 downto 6) := (others => '0');
signal A_data,B_data,D_data,ALU_in_B,ALU_out: std_logic_vector(31 downto 0);
begin

    Mem_data_out <= A_data;
    Mem_addr_out <= ALU_in_B;

    Constant_mux: entity work.nto1mux
                    generic map(bus_width=>32,mux_size=>1)
                    port map(
                    input(63 downto 32)=>B_data,
                    input(31 downto 6)=>zero_fill,
                    input(5 downto 0)=>Constant_in,
                    sel=>Const_sel,
                    output=>ALU_in_B);

    ALU: entity work.ALU
            generic map(k=>32)
            port map(
            A=>A_data,
            B=>ALU_in_B,
            clk=>clk,
            rst=>rst,
            alu_func_sel=>alu_func_sel,
            Output=>ALU_out,
            Flags=>Flags);
            
    Mem_data_mux: entity work.nto1mux
                    generic map(bus_width=>32,mux_size=>1)
                    port map(
                    input(63 downto 32)=>ALU_out,
                    input(31 downto 0)=>Mem_data_in,
                    sel=>Mem_data_sel,
                    output=>D_data);
                    
    Register_file: entity work.register_file
                    port map(
                    Data_in=>D_data,
                    Reg_sel=>Reg_sel,
                    A_sel=>A_sel,
                    B_sel=>B_sel,
                    RW=>RW,
                    clk=>clk,
                    rst=>rst,
                    A_out=>A_data,                
                    B_out=>B_data);                
end Behavioral;
