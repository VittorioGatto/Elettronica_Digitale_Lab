library ieee;
use ieee.std_logic_1164.all;

entity segment7_decoder_nums_tb is
end segment7_decoder_nums_tb;

architecture Behavior of segment7_decoder_nums_tb is

component segment7_decoder_nums
	port(
			m: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

signal c_in: std_logic_vector(3 downto 0) := "1111"; 
signal segs_out: std_logic_vector(0 to 6);
begin
	DUT : segment7_decoder_nums port map (m => c_in, segs => segs_out);
process
begin
	c_in <= "0000"; -- 0 
	wait for 10 ns;
	c_in <= "0001"; -- 1
	wait for 10 ns;
	c_in <= "0010"; -- 2
	wait for 10 ns;
	c_in <= "0011"; -- 3
	wait for 10 ns; 
	c_in <= "0100"; -- 4 
	wait for 10 ns;
	c_in <= "0101"; -- 5
	wait for 10 ns;
	c_in <= "0110"; -- 6
	wait for 10 ns;
	c_in <= "0111"; -- 7
	wait for 10 ns;
	c_in <= "1000"; -- 8
	wait for 10 ns;
	c_in <= "1001"; -- 9
	wait for 10 ns;
	c_in <= "1010"; -- 10
	wait for 10 ns;
	c_in <= "1011"; -- 11
	wait for 10 ns; 
	c_in <= "1100"; -- 12
	wait for 10 ns;
	c_in <= "1101"; -- 13
	wait for 10 ns; 
	c_in <= "1110"; -- 14
	wait for 10 ns;
	c_in <= "1111"; -- 15
	wait for 10 ns;
end process;
	
end Behavior;
