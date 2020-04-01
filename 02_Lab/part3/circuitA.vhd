library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuitA is
	port(
		  v: in unsigned(2 downto 0);
		  v_new: out std_logic_vector(2 downto 0)
		  );
end circuitA;

architecture Behavior of circuitA is
begin
	v_new(2) <= v(2) AND v(1);
	v_new(1) <= v(2) AND (NOT v(1));
	v_new(0) <= (v(1) AND v(0)) OR (v(2) AND v(0));
end Behavior;
