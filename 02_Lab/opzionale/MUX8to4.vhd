library ieee;
use ieee.std_logic_1164.all;

entity MUX8to4 is
	port(
			x,y: in std_logic_vector(3 downto 0);
			s: in std_logic;
			m: out std_logic_vector(3 downto 0) --output
		 );
end MUX8to4;

architecture Structure of MUX8to4 is

component MUX2to1
		port(
			x, y: in std_logic;
			s: in std_logic;
			m: out std_logic
		 );
end component;

begin
	MUX_1: MUX2to1 port map (x => x(0), y => y(0), s=> s, m => m(0));
	MUX_2: MUX2to1 port map (x => x(1), y => y(1), s=> s, m => m(1));
	MUX_3: MUX2to1 port map (x => x(2), y => y(2), s=> s, m => m(2));
	MUX_4: MUX2to1 port map (x => x(3), y => y(3), s=> s, m => m(3));
end Structure;	
