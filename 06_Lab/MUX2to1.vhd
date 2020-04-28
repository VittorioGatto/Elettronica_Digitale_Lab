library ieee;
use ieee.std_logic_1164.all;

entity MUX2to1 is
	port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end MUX2to1;

architecture Behavior of MUX2to1 is
begin
	m <= (NOT (s) AND x) OR (s AND y);
end Behavior;	
			