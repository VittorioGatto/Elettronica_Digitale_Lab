library ieee;
use ieee.std_logic_1164.all;

entity circuitB is
	port(
			EN: in std_logic;
			HEX1: out std_logic_vector(0 to 6)
		  );
end circuitB;

architecture Behavior of circuitB is
begin
	-- remember led is grounded to cathode (negative logic)
	-- if circuit is enabled (EN = 1), lit number "1"
	HEX1(1) <= '0';
	HEX1(2) <= '0'; --always on
	HEX1(6) <= '1'; --always off
	HEX1(3) <= EN;
	HEX1(4) <= EN;
	HEX1(5) <= EN;
	HEX1(0) <= EN;

end Behavior;
	
