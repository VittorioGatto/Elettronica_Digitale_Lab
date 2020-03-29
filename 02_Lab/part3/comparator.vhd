library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- comparator that checks if A is bigger than B
entity comparator is
	port(
			A: in unsigned(3 downto 0);
			B: in unsigned(3 downto 0);
			z: out std_logic
		 );
end comparator;

architecture Behavior of comparator is

begin

	z <= (A(0) and (not B(0))) AND (A(1) and (not B(1))) AND (A(2) and (not B(2))) AND (A(3) and (not B(3)));

end Behavior;
