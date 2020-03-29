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
	-- notice a pattern?
	--v_new="000" when v="010", --10   0 - 2
   --"001" when "011", --11
   --"010" when "100", --12
   --"011" when "101", --13
   --"100" when "110", --14   4 - 6
   --"101" when "111", --15   5 - 7
	
	v_new <= std_logic_vector(v - 2);
end Behavior;
