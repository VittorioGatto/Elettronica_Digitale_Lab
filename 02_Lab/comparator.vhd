library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
	port(
			v: in unsigned(3 downto 0);
			z: out std_logic
		 );
end comparator;

architecture Behavior of comparator is

constant v_compare: unsigned(3 downto 0) := "1010"; -- number 10

begin

z <= '1' when (v = v_compare) else '0';

end Behavior;
