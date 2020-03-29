library ieee;
use ieee.std_logic_1164.all;

entity MUX5to1 is
	port(
			u, v, w, x, y: in std_logic; --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic --output
		 );
end MUX5to1;

architecture Structure of MUX5to1 is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

signal mth_output: std_logic_vector(2 downto 0);
begin
	MUX_UV: MUX2to1 port map (x => u, y => v, s => s(0), m => mth_output(0));
	MUX_WX: MUX2to1 port map (x => w, y => x, s => s(0), m => mth_output(1));
	MUX_S1: MUX2to1 port map (x => mth_output(0), y => mth_output(1), s => s(1), m => mth_output(2));
	MUX_Y: MUX2to1 port map (x => mth_output(2), y => y, s => s(2), m => m);
end Structure;	