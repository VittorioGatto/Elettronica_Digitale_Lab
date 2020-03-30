library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_to_BCD_tb is
end binary_to_BCD_tb;

architecture Behavior of binary_to_BCD_tb is

component binary_to_BCD
	port(
			v: in unsigned(5 downto 0); -- 2^6 = 64
			BCD: out std_logic_vector(7 downto 0)
		 );
end component;

signal SW_in: unsigned(5 downto 0);
signal number1: std_logic_vector(3 downto 0);
signal number2: std_logic_vector(3 downto 0);

begin
	DUT: binary_to_BCD port map(v => SW_in, BCD(7 downto 4) => number1, BCD(3 downto 0) => number2);
	
process
begin

	SW_in <= "111111"; --63
	wait for 20 ns;
	SW_in <= "101111"; --47
	wait for 20 ns;
	SW_in <= "010111"; --23
	wait for 20 ns;
	SW_in <= "001011"; --11
	wait for 20 ns;
	SW_in <= "000101"; --5
	wait for 20 ns;
	SW_in <= "000001"; --1
	wait for 20 ns;
end process;
end Behavior;
