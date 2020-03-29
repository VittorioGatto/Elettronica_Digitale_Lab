library ieee;
use ieee.std_logic_1164.all;

entity circuitA is
	port(
		  v: in std_logic_vector(2 downto 0);
		  v_new: out std_logic_vector(2 downto 0)
		  );
end circuitA;

architecture Behavior of circuitA is
begin
	with v select
		v_new <= "000" when "010", --10
				  "001" when "011", --11
				  "010" when "100", --12
				  "011" when "101", --13
				  "100" when "110", --14
				  "101" when "111", --15
				  "111" when others; --condition never used
end Behavior;
