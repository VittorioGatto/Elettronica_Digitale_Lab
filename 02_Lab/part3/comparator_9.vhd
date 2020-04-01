library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- comparator that checks if A is bigger than 9
entity comparator_9 is
	port(
			A: in unsigned(3 downto 0);
			z: out std_logic
		 );
end comparator_9;

architecture Behavior of comparator_9 is
  
begin

  z <= (A(3) AND A(2)) OR (A(3) AND NOT A(2) AND A(1));

end Behavior;
