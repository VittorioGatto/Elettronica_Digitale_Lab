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
  signal i1, i2, i3: std_logic;

begin
  i3 <= A(3) xnor B(3);
  i2 <= A(2) xnor B(2);
  i1 <= A(1) xnor B(1);
  z <= (A(3) and (not B(3))) or 
        (i3  and (not B(2)) and A(2)) or 
        (i3 and i2 and (not B(1)) and A(1)) or 
        (i3 and i2 and i1 and (not B(0)) and A(0));
  
	

end Behavior;
