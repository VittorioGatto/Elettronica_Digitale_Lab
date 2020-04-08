library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CSA4bits_tb is
end CSA4bits_tb;

architecture Behavior of CSA4bits_tb is

component CSA4bits
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out:  out std_logic;
			s: out std_logic_vector(3 downto 0)
		 );
end component;

signal a_IN, b_IN: std_logic_vector(3 downto 0);
signal c_in_IN: std_logic;
signal c_carryin_last_OUT: std_logic;
signal c_out_OUT: std_logic;
signal s_OUT: std_logic_vector(3 downto 0);

begin
	DUT: CSA4bits port map(a_IN, b_IN, c_IN_IN, c_carryin_last_OUT, c_out_OUT, s_OUT);
	
	process
	begin
		a_IN <= "0101";
		b_IN <= "1010";
		c_IN_IN <= '0';
		wait for 10 ns;
		
    a_IN <= "0001";
		b_IN <= "1111";
		c_IN_IN <= '0';
		wait for 10 ns;
		
		a_IN <= "0010";
		b_IN <= "1000";
		c_IN_IN <= '1';
		wait for 10 ns;
		
		a_IN <= "0111";
		b_IN <= "1111";
		c_IN_IN <= '0';
		wait for 10 ns;
		
	end process;
end Behavior;