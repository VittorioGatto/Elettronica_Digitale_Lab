library ieee;
use ieee.std_logic_1164.all;

entity MUX16to8 is
	port(
			x, y: in std_logic_vector(7 downto 0); --inputs
			s: in std_logic; --selectors
			m: out std_logic_vector(7 downto 0) --outputs
		 );
end MUX16to8;

architecture Structure of MUX16to8 is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

begin
	GEN: for i in 7 downto 0 generate
		MUX: MUX2to1 port map (x => x(i), y => y(i), s => s, m => m(i));
	end generate GEN;
end Structure;	