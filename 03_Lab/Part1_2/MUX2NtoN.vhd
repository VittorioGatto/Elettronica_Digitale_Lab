library ieee;
use ieee.std_logic_1164.all;

-- MUX2to1 wide n bits
entity MUX2NtoN is
	generic(n: integer:=8);
	port(
			x, y: in std_logic_vector((n-1) downto 0); --inputs
			s: in std_logic; --selector
			m: out std_logic_vector((n-1) downto 0) --outputs
		 );
end MUX2NtoN;

architecture Structure of MUX2NtoN is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

begin
	GEN: for i in (n-1) downto 0 generate
		MUX: MUX2to1 port map (x => x(i), y => y(i), s => s, m => m(i));
	end generate GEN;
end Structure;	