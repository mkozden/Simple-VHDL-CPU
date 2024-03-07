--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:43 10/25/2023
-- Design Name:   
-- Module Name:   /home/ise/xilinx/CPU-ALU-stuff/cl16_tb.vhd
-- Project Name:  CPU-ALU-stuff
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fourbyfouradder
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cl16_tb IS
END cl16_tb;
 
ARCHITECTURE behavior OF cl16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbyfouradder
	 generic(k:integer:=16);
    PORT(
         A : IN  std_logic_vector(k-1 downto 0);
         B : IN  std_logic_vector(k-1 downto 0);
			addsubswitch: in std_logic;
         S : OUT  std_logic_vector(k-1 downto 0);
			C : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal addsubswitch : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal C : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbyfouradder PORT MAP (
          A => A,
          B => B,
			 addsubswitch => addsubswitch,
          S => S,
          C => C
        );

   -- Stimulus process
   stim_proc: process
   begin
		wait for 25 ns;
		addsubswitch <= '0';
		A <= std_logic_vector(to_signed(64,16));
		B <= std_logic_vector(to_signed(65,16));
      wait for 25 ns;
		addsubswitch <= '1';
		wait for 25 ns;
		wait;
   end process;

END;
