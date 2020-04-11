library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--simple T FLIP FLOP
entity display_bit16_counter_tb is
end display_bit16_counter_tb;

architecture Test of display_bit16_counter_tb is

component  display_bit16_counter
  port(
      SW1: in std_logic; --enalble
      SW0: in std_logic; --reset
      clock: in std_logic;
      HEX: out std_logic_vector (0 to 6)
      );
end component;
  
constant clk_period: time := 5 ns;
  
signal SW1_IN: std_logic :='1';
signal SW0_IN: std_logic :='0';
signal clock_IN: std_logic := '0';
signal HEX_OUT: std_logic_vector (0 to 6);

begin

DUT: display_bit16_counter port map (SW1_IN, SW0_IN, clock_IN, HEX_OUT);

clock_IN <= not clock_IN after clk_period/2;

process
	begin
	  SW0_IN <= '1'; -- wake up
		wait for 30 ns;
		SW1_IN <= '0'; --freeze
		wait for 20 ns;
		SW1_IN <= '1'; --wake up
		wait for 20 ns;
		SW0_IN <= '0'; --clear
		wait for 20 ns;
		SW0_IN <= '1';
		wait for 0.330 ms; -- if you want to see it return to 0...
		SW0_IN <= '0';
		wait for 20 ns;
end process;

end Test;