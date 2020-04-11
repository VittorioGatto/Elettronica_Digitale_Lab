library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bit4_counter_tb is
end bit4_counter_tb;

architecture Test of bit4_counter_tb is
  
component bit4_counter
  port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			Q: buffer unsigned(3 downto 0);
			enable_nth: out std_logic 
		 );
end component;

constant clk_period: time := 5 ns;

signal enable_IN: std_logic;
signal clk_IN: std_logic := '0';
signal clear_IN: std_logic;
signal Q_OUT: unsigned(3 downto 0);
signal enable_nth_OUT: std_logic;

begin

DUT: bit4_counter port map (enable_IN, clk_IN, clear_IN, Q_OUT, enable_nth_OUT);

clk_IN <= not clk_IN after clk_period/2;

process
	begin
		enable_IN <= '1';
		clear_IN <= '1';
		wait for 160 ns;
		
		enable_IN <= '0';
		clear_IN <= '0';
		wait for 10 ns;
		
		
	
end process;

end Test;