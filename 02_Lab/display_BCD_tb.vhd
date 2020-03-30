library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_BCD_tb is
end display_BCD_tb;

architecture Behavior of display_BCD_tb is

component display_BCD
	port(
			SW: in std_logic_vector(5 downto 0);
			HEX0: out std_logic_vector(0 to 6);
			HEX1: out std_logic_vector(0 to 6)
		 );
end component;

signal SW_in: std_logic_vector(5 downto 0);
signal HEX0_out: std_logic_vector(0 to 6);
signal HEX1_out: std_logic_vector(0 to 6);

begin
	DUT: display_BCD port map(SW => SW_in, HEX0 => HEX0_out, HEX1 => HEX1_out);
	
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