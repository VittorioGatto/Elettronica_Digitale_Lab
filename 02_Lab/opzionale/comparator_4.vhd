library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- comparator that checks if A is bigger than 4
entity comparator_4 is
	port(
			A: in unsigned(3 downto 0);
			z: out std_logic
		 );
end comparator_4;

architecture Behavior of comparator_4 is
  
begin

  z <= A(3) OR (NOT A(3) AND A(2) AND A(1)) OR (NOT A(3) AND A(2) AND A(0));

end Behavior;
