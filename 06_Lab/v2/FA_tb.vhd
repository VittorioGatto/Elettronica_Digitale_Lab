library ieee;
use ieee.std_logic_1164.all;

entity FA_tb is
end FA_tb;

architecture Behavior of FA_tb is

component FA is
	port(
			a, b, c_in: in std_logic;
			s, c_out: out std_logic
		 );
end component;

signal A_IN: std_logic;
signal B_IN: std_logic;
signal C_IN: std_logic;
signal S_OUT: std_logic;
signal C_OUT: std_logic;

begin
  
  DUT: FA port map (a => A_in, b => B_IN, c_in => C_IN, s => S_OUT, c_out => C_OUT);
    
process
begin
  A_IN <= '0';
  B_IN <= '0';
  C_IN <= '0';
  wait for 4 ns; -- S_OUT = '0', C_OUT = '0'
  
  A_IN <= '0';
  B_IN <= '0';
  C_IN <= '1';
  wait for 4 ns; -- S_OUT = '1', C_OUT = '0'

  A_IN <= '1';
  B_IN <= '1';
  C_IN <= '0';
  wait for 4 ns; -- S_OUT = '0', C_OUT = '1'

  A_IN <= '1';
  B_IN <= '0';
  C_IN <= '1';
  wait for 4 ns; -- S_OUT = '0', C_OUT = '1'

  A_IN <= '1';
  B_IN <= '1';
  C_IN <= '1';
  wait for 4 ns; -- S_OUT = '1', C_OUT = '1'

end process;
end Behavior;
