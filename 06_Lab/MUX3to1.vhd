library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX3to1 is
	port(
			u, v, w: in std_logic; --inputs
			s: in std_logic_vector(1 downto 0); --selectors
			m: out std_logic --output
		 );
end MUX3to1;

architecture Structure of MUX3to1 is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

signal internal_output: std_logic;

begin
	MUX_UV: MUX2to1 port map (x => u, y => v, s => s(0), m => internal_output);
	MUX_WS: MUX2to1 port map (x => w, y => internal_output, s => s(1), m => m);
end Structure;	

