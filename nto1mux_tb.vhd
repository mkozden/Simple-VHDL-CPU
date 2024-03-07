--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:50:59 12/10/2023
-- Design Name:   
-- Module Name:   /home/ise/xilinx/CPU-ALU-stuff/nto1mux_tb.vhd
-- Project Name:  CPU-ALU-stuff
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nto1mux
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
 
ENTITY nto1mux_tb IS
END nto1mux_tb;
 
ARCHITECTURE behavior OF nto1mux_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nto1mux
	 generic(mux_size,bus_width:integer);
    Port ( input : in  STD_LOGIC_VECTOR((((2**mux_size))*(bus_width))-1 downto 0);
           sel : in  STD_LOGIC_VECTOR (mux_size-1 downto 0);
           output : out STD_LOGIC_VECTOR(bus_width-1 downto 0));
    END COMPONENT;
    
	signal bus_width: integer := 4;
	signal mux_size: integer := 2;
   --Inputs
   signal input : STD_LOGIC_VECTOR((((2**mux_size))*(bus_width))-1 downto 0) := (others => '0');
   signal sel : STD_LOGIC_VECTOR (mux_size-1 downto 0) := (others => '0');

 	--Outputs
   signal output : STD_LOGIC_VECTOR(bus_width-1 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nto1mux generic map (mux_size=>2, bus_width=>4)
	PORT MAP (
          input => input,
          sel => sel,
          output => output
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

		input <= "1011010001011000";
		
		sel <= "00";
      wait for 25 ns;
		sel <= "01";
      wait for 25 ns;
		sel <= "10";
      wait for 25 ns;
		sel <= "11";
		wait;
   end process;

END;
