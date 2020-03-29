library ieee;
use ieee.std_logic_1164.all;

entity segment7_decoder is
	port(
			c: in std_logic_vector(2 downto 0); --inputs
			segs: out std_logic_vector(0 to 6) --segments
		);
end segment7_decoder;

architecture Behavior of segment7_decoder is
begin
  segs(0) <= c(2) OR (NOT c(0));
  segs(1) <= (c(2) OR c(1) OR c(0)) AND (c(2) OR (NOT c(1)) OR (NOT c(0)));
  segs(2) <= (c(2) OR c(1) OR c(0)) AND (c(2) OR (NOT c(1)) OR (NOT c(0)));
  segs(3) <= (c(2) OR ( NOT c(0))) AND ( c(2) OR ( NOT c(1)));
  segs(4) <= (c(2) OR c(1)) AND (c(2) OR (NOT c(1)));
  segs(5) <= (c(2) OR c(1)) AND (c(2) OR (NOT c(1)));
  segs(6) <= c(2) OR c(1);
end Behavior;