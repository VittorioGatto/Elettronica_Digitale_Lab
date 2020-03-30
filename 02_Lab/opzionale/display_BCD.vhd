library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_BCD is
	port(
			SW: in std_logic_vector(5 downto 0);
			HEX0: out std_logic_vector(0 to 6);
			HEX1: out std_logic_vector(0 to 6)
		 );
end display_BCD;

architecture Structure of display_BCD is

component binary_to_BCD 
	port(
			v: in unsigned(5 downto 0);
			BCD: out std_logic_vector(7 downto 0)
		 );
end component;

component segment7_decoder_nums
	port(
			m: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

signal BCD_out: std_logic_vector(7 downto 0);

begin

BTBCD: binary_to_BCD port map(unsigned(SW), BCD_out);
SEG: segment7_decoder_nums port map(BCD_out(7 downto 4), HEX0); -- left display (tens)
SEG1: segment7_decoder_nums port map(BCD_out(3 downto 0), HEX1); -- right display (ones)

end Structure;
