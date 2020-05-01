library ieee;
use ieee.std_logic_1164.all;

entity FA is
	port(
			a, b, c_in: in std_logic;
			s, c_out: out std_logic
		 );
end FA;

architecture Behavior of FA is

component MUX2to1
	port(
			x, y: in std_logic;
			s: in std_logic;
			m: out std_logic
		 );
end component;

signal aXORb: std_logic;
 
begin
	aXORb <= a XOR b;
	
	MUX: MUX2to1 port map (b, c_in, aXORb, c_out);
	s <= c_in XOR aXORb;
end Behavior;
