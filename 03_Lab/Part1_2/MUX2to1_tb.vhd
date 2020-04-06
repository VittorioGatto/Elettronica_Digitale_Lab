library ieee;
use ieee.std_logic_1164.all;

entity MUX2to1_tb is
end MUX2to1_tb;

architecture Behavior of MUX2to1_tb is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

signal x_in: std_logic;
signal y_in: std_logic;
signal s_in, m_out: std_logic;

begin
  x_in <= '1';
  y_in <= '0'; --constant inputs in order to verify the behaviour of the circuit, emulating the switches
	DUT: MUX2to1 port map (x => x_in, y=> y_in, s => s_in, m => m_out);
	
process
begin
	s_in <= '0'; -- if s=0 then m=x that equals to 1 (m = 1)
	wait for 4 ns;
	s_in <= '1'; -- if s=1 then m=y that equals to 0 (m = 0)
	wait for 4 ns;
end process;
end Behavior;	