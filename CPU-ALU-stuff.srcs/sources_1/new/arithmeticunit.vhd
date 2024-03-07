--Add -> "000"
--Sub -> "001"
--Mul -> "010"
--Logical shift left -> "100"
--Logical shift right -> "101"
--Arithmetic shift right -> "110"

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;


entity arithmeticunit is
    generic(k:integer:=8);
    Port ( A : in STD_LOGIC_VECTOR (k-1 downto 0);
           B : in STD_LOGIC_VECTOR (k-1 downto 0);
           func_sel : in STD_LOGIC_VECTOR (2 downto 0);
           Output : out STD_LOGIC_VECTOR (k-1 downto 0);
           Flag_values : out STD_LOGIC_VECTOR (3 downto 0));
end arithmeticunit;

architecture Behavioral of arithmeticunit is
signal add_sub_sel: std_logic;
signal shift_sel: std_logic_vector(1 downto 0);
signal as_out,mul_out,shift_out,out_signal: std_logic_vector(k-1 downto 0);
signal carry: std_logic;
-- greater,equal,less: std_logic;
signal negative, zero, overflow, sign_A, sign_B, sign_O: std_logic;
constant all_zero: std_logic_vector(k-1 downto 0) := (others => '0');
begin
add_sub_sel <= func_sel(0);
shift_sel <= func_sel(1 downto 0);

addsub: entity work.nbyfouradder
        generic map(k=>k)
        port map(
        A => A,
        B => B,
        addsubswitch => add_sub_sel,
        S => as_out,
        C => carry);
        
mul: entity work.nbitmultiplier
        generic map(k=>k)
        port map(
        A => A,
        B => B,
        output => mul_out);
        
shifter: entity work.shiftunit
        generic map(k=>k)
        port map(
        A => A,
        B => B,
        shift_sel => shift_sel,
        shift_out => shift_out);
              
mux: entity work.nto1mux
        generic map(bus_width=>k, mux_size=>2)
        port map(
        input(4*k-1 downto 3*k)=>as_out,
        input(3*k-1 downto 2*k)=>mul_out,
        input(2*k-1 downto k)=>shift_out,
        input(k-1 downto 0)=>shift_out,
        sel=>func_sel(2 downto 1),
        output=>out_signal);

--comparator: entity work.POZ_COMPARE
--        generic map(k=>k)
--        port map(
--        A=>A,
--        B=>B,
--        greater=>greater,
--        equal=>equal,
--        less=>less);

output <= out_signal;

sign_A <= A(k-1);
sign_B <= B(k-1);
sign_O <= out_signal(k-1);

negative <= out_signal(k-1);
overflow <= sign_O xor (add_sub_sel and sign_A) xor (add_sub_sel and sign_O) xor (sign_A and sign_B) xor (sign_A and sign_O) xor (sign_B and sign_O); --analyzed all the conditions where an overflow might happen
zero <= '1' when (out_signal=all_zero) else '0';

--Flags are N Z C V
Flag_values(3) <= negative;
Flag_values(2) <= zero;
Flag_values(1) <= carry;
Flag_values(0) <= overflow;

end Behavioral;
