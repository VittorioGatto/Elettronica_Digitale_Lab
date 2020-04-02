library ieee;
use ieee.std_logic_1164.all;

entity circuitB_tb is
end circuitB_tb;


architecture Behavior of circuitB_tb is
  
component circuitB
port(
		  EN: in std_logic;
			HEX1: out std_logic_vector(0 to 6)
		  );
end component;

signal EN_in: std_logic;
signal HEX1_out: std_logic_vector(0 to 6);

begin
  
  DUT: circuitB port map(EN => EN_in, HEX1 => HEX1_out);
    
process
begin
  EN_in <= '0'; -- HEX1_out = 11111110 (lit 0)
  wait for 10 ns; 
  EN_in <= '1'; -- HEX1_out = 10011111  (lit 1)
  wait for 10 ns; 
end process;

end Behavior;
