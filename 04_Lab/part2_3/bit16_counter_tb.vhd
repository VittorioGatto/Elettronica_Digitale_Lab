library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--simple T FLIP FLOP
entity bit16_counter_tb is
end bit16_counter_tb;

architecture Test of bit16_counter_tb is

constant clk_period: time := 5 ns;

signal enable: std_logic := '1';
signal clk: std_logic := '0';
signal clear: std_logic := '0';
signal Q: unsigned(15 downto 0);

begin

DUT: entity work.bit16_counter(Behavior) port map (enable, clk, clear, Q);

clk <= not clk after clk_period/2;

process
	begin
		clear <= '1'; -- wake up
		wait for 30 ns;
		enable <= '0'; --freeze
		wait for 20 ns;
		enable <= '1'; --wake up
		wait for 20 ns;
		clear <= '0'; --clear
		wait for 20 ns;
		clear <= '1';
		wait for 0.330 ms; -- if you want to see it return to 0...
		clear <= '0';
		wait for 20 ns;
end process;

end Test;