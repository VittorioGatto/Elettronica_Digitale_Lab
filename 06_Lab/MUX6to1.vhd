library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX6to1 is
	port(
			u, v, w, x, y, z: in std_logic; --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic --output
		 );
end MUX6to1;

architecture Structure of MUX6to1 is

component MUX2to1
		port(
			x, y: in std_logic; --inputs
			s: in std_logic; --selector
			m: out std_logic --output
		 );
end component;

signal mth_output: std_logic_vector(3 downto 0);

begin
	MUX_UV: MUX2to1 port map (x => u, y => v, s => s(0), m => mth_output(0));
	MUX_WX: MUX2to1 port map (x => w, y => x, s => s(0), m => mth_output(1));
	MUX_YZ: MUX2to1 port map (x => y, y => z, s => s(0), m => mth_output(2));
	MUX_S1: MUX2to1 port map (x => mth_output(0), y => mth_output(1), s => s(1), m => mth_output(3));
	MUX_S2: MUX2to1 port map (x => mth_output(3), y => mth_output(2), s => s(2), m => m);
end Structure;	

