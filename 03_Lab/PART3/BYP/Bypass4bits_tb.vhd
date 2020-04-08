library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bypass4bits_tb is
end Bypass4bits_tb;

architecture Behavior of Bypass4bits_tb is

component Bypass4bits
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
	DUT: Bypass4bits port map(a => a_IN, b => b_IN, c_in => c_in_IN, 
	c_carryin_last => c_carryin_last_OUT, c_out => c_out_OUT, s => s_OUT);
	
	process
	begin
    a_IN <= "0000";
    b_IN <= "0000";
    c_in_IN <= '0';
    wait for 5 ns;
    
    a_IN <= "1111";
    b_IN <= "1111";
    c_in_IN <= '0';
    wait for 5 ns;
		
		a_IN <= "1010";
    b_IN <= "0101";
    c_in_IN <= '0';
    wait for 5 ns;
    
    a_IN <= "1100";
    b_IN <= "0101";
    c_in_IN <= '1';
    wait for 5 ns;
    
	end process;
end Behavior;