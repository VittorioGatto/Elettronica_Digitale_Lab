library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count9_tb is
end count9_tb;

architecture Test of count9_tb is

component count9
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer;
			Q: buffer unsigned(3 downto 0)
		 );
end component;

constant clk_period: time := 20 ns;

signal enable: std_logic := '1';
signal clk: std_logic := '0';
signal clear: std_logic := '0';
signal speed: integer := 1000; --speed up simulation
signal Q: unsigned(3 downto 0);

begin

DUT: count9 port map (enable, clk, clear, speed, Q);

clk <= not clk after clk_period/2;

process
	begin
		clear <= '1'; -- wake up
		wait for 25000000 ns; -- if you want to see it return to 0... (25 ms simulation)
		clear <= '0';
		wait for 20 ns;
end process;

end Test;
