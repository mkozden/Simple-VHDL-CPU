--Arbitrary size multiplexer for arbitrary bit inputs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nto1mux is
	 generic(mux_size,bus_width:integer);
    Port ( input : in  STD_LOGIC_VECTOR((((2**mux_size))*(bus_width))-1 downto 0);
           sel : in  STD_LOGIC_VECTOR (mux_size-1 downto 0);
           output : out STD_LOGIC_VECTOR(bus_width-1 downto 0));
end nto1mux;

architecture Behavioral of nto1mux is
type input_array is array(0 to ((2**mux_size)-1)) of std_logic_vector(bus_width-1 downto 0);
signal in_arr: input_array;
begin
	a:for i in 0 to ((2**mux_size)-1) generate
		in_arr(i)<=input((((2**mux_size)-i)*bus_width)-1 downto (((2**mux_size)-(i+1))*bus_width)); --we split the input into (2**mux_size) vectors of size bus_width
	end generate a;
	output <=in_arr(to_integer(unsigned(sel))); --we can then easily select the output
end Behavioral;