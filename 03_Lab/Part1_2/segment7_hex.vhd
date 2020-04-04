library ieee;
use ieee.std_logic_1164.all;

-- Hexadecimal decoder
entity segment7_hex is
	port(
			c: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		  );
end segment7_hex;

architecture Structure of segment7_hex is
begin
	with c select segs <= 
		  "0000001" when "0000",
		  "1001111" when "0001",
		  "0010010" when "0010",
		  "0000110" when "0011",
		  "1001100" when "0100",
		  "0100100" when "0101",
		  "0100000" when "0110",
		  "0001111" when "0111",
		  "0000000" when "1000",
		  "0000100" when "1001",
		  "0001000" when "1010", --A
		  "1100000" when "1011", --B lowercase b
		  "0110001" when "1100", --C
		  "1000010" when "1101", --D lowercase d
		  "0110000" when "1110", --E
		  "0111000" when "1111", --F
		  "1111111" when others; -- ModelSim gets mad unless you do this
end Structure;