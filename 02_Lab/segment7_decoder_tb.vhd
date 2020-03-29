library ieee;
use ieee.std_logic_1164.all;

entity segment7_decoder_tb is
end segment7_decoder_tb;

architecture Behavior of segment7_decoder_tb is

component segment7_decoder
	port(
			c: in std_logic_vector(2 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

signal c_in: std_logic_vector(2 downto 0) := "111"; --all segs turned off
signal segs_out: std_logic_vector(0 to 6);
begin
	DUT : segment7_decoder port map (c => c_in, segs => segs_out);
process
begin
	c_in <= "000"; -- "H => 1001000"
	wait for 10 ns;
	c_in <= "001"; -- "E => 0110000"
	wait for 10 ns;
	c_in <= "010"; -- "L => 1110001"
	wait for 10 ns;
	c_in <= "011"; -- "O => 0000001"
	wait for 10 ns;
	c_in <= "100"; -- "blank from now on => 1111111"
	wait for 10 ns;
	c_in <= "101";
	wait for 10 ns;
	c_in <= "110";
	wait for 10 ns;
	c_in <= "111";
	wait for 10 ns;
end process;
	
end Behavior;