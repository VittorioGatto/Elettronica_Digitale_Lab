library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	port(
			SW: in std_logic_vector(3 downto 0);
			HEX0: out std_logic_vector(0 to 6);
			HEX1: out std_logic_vector(0 to 6)
		 );
end display;

architecture Structure of display is

component converter 
	port(
			v: in unsigned(3 downto 0);
			m: out std_logic_vector(3 downto 0);
			z: inout std_logic
		 );
end component;

component circuitB
	port(
			EN: in std_logic;
			HEX1: out std_logic_vector(0 to 6)
		  );
end component;

component segment7_decoder_nums
	port(
			m: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

signal m_out: std_logic_vector(3 downto 0);
signal z_out: std_logic;

begin

CONV: converter port map(unsigned(SW), m_out, z_out);
CIRB: circuitB port map(z_out, HEX1);
SEG: segment7_decoder_nums port map(m_out, HEX0);

end Structure;



