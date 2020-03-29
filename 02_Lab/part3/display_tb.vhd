library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_tb is
end display_tb;

architecture Behavior of display_tb is
component display
	port(
			SW: in std_logic_vector(3 downto 0);
			HEX0: out std_logic_vector(0 to 6);
			HEX1: out std_logic_vector(0 to 6)
		 );
end component;

signal SW_binary: std_logic_vector(3 downto 0);
signal HEX0_out: std_logic_vector(0 to 6);
signal HEX1_out: std_logic_vector(0 to 6);
begin

	DUT: display port map(SW_binary, HEX0_out, HEX1_out);

process
begin

SW_binary <= "0000"; --0
wait for 10 ns;
SW_binary <= "0001"; --1
wait for 10 ns;
SW_binary <= "0010"; --2
wait for 10 ns;
SW_binary <= "1001"; --9
wait for 10 ns;
SW_binary <= "1010"; --10
wait for 10 ns;
SW_binary <= "1111"; --15
wait for 10 ns;

end process;
end Behavior;
