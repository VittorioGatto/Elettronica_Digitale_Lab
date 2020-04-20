library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity time_counter_tb is
end time_counter_tb;

architecture Behavior of time_counter_tb is

component time_counter is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			change: out std_logic
		 );
end component;

signal en_in, clk_in, clr_in, change_out: std_logic;
signal speed: integer := 1000; --speed up simulation

begin
  clock_gen: process
  begin
    clk_in <= '0', '1' after 10 ns; 
    wait for 20 ns; --50 MHz clock
  end process;
  
  DUT: time_counter port map(en_in, clk_in, clr_in, speed, change_out);

process
begin
  
  en_in <= '1';
  clr_in <= '0';
  wait for 15 ns;
  
  en_in <= '1';
  clr_in <= '1';
  wait for 18 ms;

end process;

end Behavior;
