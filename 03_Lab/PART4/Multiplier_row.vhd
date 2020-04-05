library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Single row of an array multiplier, see scheme in the report
entity Multiplier_row is
	port(
			a, c: in unsigned(3 downto 0);
			b: in std_logic;
			c_in: in std_logic;
			c_out: out std_logic;
			s: out unsigned(3 downto 0)
		 );
end Multiplier_row;

architecture Behavior of Multiplier_row is

component FA
	port(
			a, b, c_in: in std_logic;
			s, c_out: out std_logic
		 );
end component;

signal c_in_propagate: std_logic_vector(3 downto 1);
signal d0: std_logic;
signal d1: std_logic;
signal d2: std_logic;
signal d3: std_logic;

begin
	d0 <= a(0) AND b;
	d1 <= a(1) AND b;
	d2 <= a(2) AND b;
	d3 <= a(3) AND b;
	
	FA0: FA port map(c(0), d0, c_in, s(0), c_in_propagate(1));
	FA1: FA port map(c(1), d1, c_in_propagate(1), s(1), c_in_propagate(2));
	FA2: FA port map(c(2), d2, c_in_propagate(2), s(2), c_in_propagate(3));
	FA3: FA port map(c(3), d3, c_in_propagate(3), s(3), c_out);
end Behavior;