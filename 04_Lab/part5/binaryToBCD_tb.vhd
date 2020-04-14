library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binaryToBCD_tb is
end binaryToBCD_tb;

architecture Test of binaryToBCD_tb is

component binaryToBCD
	port(
		   binary_in: in std_logic_vector(13 downto 0);
			bcd_out: out std_logic_vector(15 downto 0)
		 );
end component;

signal binary_in: std_logic_vector(13 downto 0) := (others => '0');
signal bcd: std_logic_vector(15 downto 0);

begin

DUT: binaryToBCD port map (binary_in, bcd);

process
	begin
		binary_in <= "10011100001111"; -- 9999
		wait for 20 ns;
		binary_in <= "00000000011110"; --30
		wait for 20 ns;
end process;

end Test;