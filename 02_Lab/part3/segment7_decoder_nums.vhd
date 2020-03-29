library ieee;
use ieee.std_logic_1164.all;

entity segment7_decoder_nums is
	port(
			m: in std_logic_vector(3 downto 0); --inputs
			segs: out std_logic_vector(0 to 6) --segments
		);
end segment7_decoder_nums;

architecture Behavior of segment7_decoder_nums is
begin
	with m select
		segs <= "0000001" when "0000", -- number 1
				  "1001111" when "0001",
				  "0010010" when "0010",
				  "0000110" when "0011",
				  "1001100" when "0100",
				  "0100100" when "0101",
				  "0100000" when "0110",
				  "0001111" when "0111",
				  "0000000" when "1000",
				  "0000100" when "1001", -- number 9
				  "1111111" when others; -- all segs turned off;
end Behavior;
