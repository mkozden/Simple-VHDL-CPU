--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:32:57 12/10/2023
-- Design Name:   
-- Module Name:   /home/ise/xilinx/CPU-ALU-stuff/register_tb.vhd
-- Project Name:  CPU-ALU-stuff
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shift_register
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY register_tb IS
END register_tb;
 
ARCHITECTURE behavior OF register_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_register
    PORT(
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         Load : IN  std_logic;
         Shift : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal Load : std_logic := '0';
   signal Shift : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_register PORT MAP (
          data_in => data_in,
          data_out => data_out,
          clk => clk,
          rst => rst,
          Load => Load,
          Shift => Shift
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for 100 ns;	
		rst <= '0';
		wait for clk_period;
		data_in <= "10110100";
      wait for clk_period*3;
		Load <= '1';
		wait for clk_period*3;
		Load <= '0';
		data_in <= "00101110";
      wait for clk_period*3;
		Load <= '1';
		wait for clk_period*3;
		Load <= '0';
      wait for clk_period*3;
		Shift <= '1';
		wait for clk_period;
		Shift <= '0';
		wait for clk_period;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait;
   end process;

END;
