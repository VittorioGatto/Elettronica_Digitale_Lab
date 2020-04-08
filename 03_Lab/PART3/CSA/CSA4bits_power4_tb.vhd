library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CSA4bits_power4_tb is
end CSA4bits_power4_tb;

architecture Behavior of CSA4bits_power4_tb is

component CSA4bits_power4
	port(
			a, b: in std_logic_vector(7 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(7 downto 0)
		 );
end component;

signal a_IN, b_IN: std_logic_vector(7 downto 0);
signal c_in_IN: std_logic;
signal c_carryin_last_OUT: std_logic;
signal c_out_OUT: std_logic;
signal s_OUT: std_logic_vector(7 downto 0);

begin
	DUT: CSA4bits_power4 port map(a_IN, b_IN, c_IN_IN, c_carryin_last_OUT, c_out_OUT, s_OUT);
	
	process
	begin
		a_IN <= "01010101";
		b_IN <= "10101010";
		c_IN_IN <= '0';
		wait for 10 ns;
		
    a_IN <= "00010000";
		b_IN <= "11111111";
		c_IN_IN <= '0';
		wait for 10 ns;
		
		a_IN <= "00100101";
		b_IN <= "10001010";
		c_IN_IN <= '1';
		wait for 10 ns;
		
		a_IN <= "01111111";
		b_IN <= "11111111";
		c_IN_IN <= '0';
		wait for 10 ns;
		
	end process;
end Behavior;