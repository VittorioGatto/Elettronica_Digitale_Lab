library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockCounter1Hz_tb is
end ClockCounter1Hz_tb;

architecture Behavior of ClockCounter1Hz_tb is

component ClockCounter1Hz is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			speed: in integer range 1 to 1000000; --1000000 for simulation = 50 clocks 1000 ns
			terminal_count: out std_logic
		 );
end component;

signal clk_in, clr_in, en_in, terminal_out: std_logic;
signal speed: integer := 1000; --speed up simulation

begin
  clock_gen: process
  begin
    clk_in <= '0', '1' after 10 ns; 
    wait for 20 ns; --50 MHz clock
  end process;
  
  DUT: ClockCounter1Hz port map(clk_in, clr_in, en_in, speed, terminal_out);

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
