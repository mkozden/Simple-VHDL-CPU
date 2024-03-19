----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2024 10:13:28 PM
-- Design Name: 
-- Module Name: fake_rom - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.all;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fake_rom is
    Port ( addr : in STD_LOGIC_VECTOR (31 downto 0);
           data : out STD_LOGIC_VECTOR (15 downto 0));
end fake_rom;

architecture Behavioral of fake_rom is

type rom_array is array(0 to 2**16-1) of std_logic_vector(15 downto 0);
impure function rom_init(filename : string) return rom_array is
  file rom_file : text open read_mode is filename;
  variable rom_line : line;
  variable rom_value : std_logic_vector(15 downto 0);
  variable temp : rom_array;
begin
  for rom_index in 0 to 2**16-1 loop
    readline(rom_file, rom_line);
    read(rom_line, rom_value);
    temp(rom_index) := rom_value;
  end loop;
  return temp;
end function;
     
signal rom : rom_array := rom_init(filename => "romdata.txt");
begin
data <= rom(to_integer(unsigned(addr))/2);
end Behavioral;

