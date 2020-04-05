library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_Multiplier is
	port(
			SW11_8: in unsigned(3 downto 0); -- A
			SW3_0: in unsigned(3 downto 0); -- B
			HEX6: out std_logic_vector(0 to 6); -- hex(A)
			HEX4: out std_logic_vector(0 to 6); -- hex(B)
			HEX1_0: out std_logic_vector(0 to 13) -- hex(P)
		);
end display_Multiplier;

architecture Structure of display_Multiplier is

component Multiplier4bits
	port(
			a, b: in unsigned(3 downto 0);
			p: out unsigned(7 downto 0)
		  );
end component;

component segment7_hex
	port(
			c: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		  );
end component;

signal result: unsigned(7 downto 0);
begin
	M4B: Multiplier4bits port map (SW11_8, SW3_0, result);
	
	HEXA: segment7_hex port map(std_logic_vector(SW11_8), HEX6);
	HEXB: segment7_hex port map(std_logic_vector(SW3_0), HEX4);
	
	HEXS_dozens: segment7_hex port map(std_logic_vector(result(7 downto 4)), HEX1_0(0 to 6));
	HEXS_units: segment7_hex port map(std_logic_vector(result(3 downto 0)), HEX1_0(7 to 13));
	
end Structure;