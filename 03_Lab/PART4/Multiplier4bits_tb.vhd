library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier4bits_tb is
end Multiplier4bits_tb;

architecture Behavior of Multiplier4bits_tb is

component Multiplier4bits
	port(
			a, b: in unsigned(3 downto 0);
			p: out unsigned(7 downto 0)
		  );
end component;

signal a_in, b_in: unsigned(3 downto 0);
signal p: unsigned(7 downto 0);

begin
	DUT: Multiplier4bits port map(a_in, b_in, p);

process
begin
	a_in <= to_unsigned(1, a_in'length);
	b_in <= to_unsigned(1, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(3, a_in'length);
	b_in <= to_unsigned(4, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(5, a_in'length);
	b_in <= to_unsigned(2, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(12, a_in'length);
	b_in <= to_unsigned(14, b_in'length);
	wait for 20 ns;
	a_in <= to_unsigned(15, a_in'length);
	b_in <= to_unsigned(15, b_in'length);
	wait for 20 ns;
	
end process;
end Behavior;
	