library ieee;
use ieee.std_logic_1164.all;

entity MUX15to3 is
	port(
			u, v, w, x, y: in std_logic_vector(2 downto 0); --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic_vector(2 downto 0) --output
		 );
end MUX15to3;

architecture Structure of MUX15to3 is

component MUX5to1
		port(
			u, v, w, x, y: in std_logic; --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic --output
		 );
end component;

begin
	MUX_1: MUX5to1 port map (u => u(0), v => v(0), w => w(0), x => x(0), y => y(0), s => s, m => m(0));
	MUX_2: MUX5to1 port map (u => u(1), v => v(1), w => w(1), x => x(1), y => y(1), s => s, m => m(1));
	MUX_3: MUX5to1 port map (u => u(2), v => v(2), w => w(2), x => x(2), y => y(2), s => s, m => m(2));
end Structure;	