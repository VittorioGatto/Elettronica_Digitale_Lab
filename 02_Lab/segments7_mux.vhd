library ieee;
use ieee.std_logic_1164.all;

entity segments7_mux is
	port( 
			SW: in std_logic_vector(17 downto 0);
			HEX0: out std_logic_vector(0 to 6)
		 );
end segments7_mux;

architecture Structure of segments7_mux is

component MUX15to3
	port(
			u, v, w, x, y: in std_logic_vector(2 downto 0);
			s: in std_logic_vector(2 downto 0);
			m: out std_logic_vector(2 downto 0)
		 );
end component;

component segment7_decoder
	port(
			c: in std_logic_vector(2 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

signal m: std_logic_vector(2 downto 0);

begin
	M0: MUX15to3 port map(SW(14 downto 12), SW(11 downto 9), SW(8 downto 6),
								 SW(5 downto 3), SW(2 downto 0), SW(17 downto 15), m);
	H0: segment7_decoder port map(c => m, segs => HEX0);

end Structure;
	