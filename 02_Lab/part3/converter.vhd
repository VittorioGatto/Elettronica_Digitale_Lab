library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity converter is
	port(
			v: in unsigned(3 downto 0);
			m: out std_logic_vector(3 downto 0);
			z: inout std_logic
		 );
end converter;

architecture Structure of converter is

component circuitA
	port(
		  v: in unsigned(2 downto 0);
		  v_new: out std_logic_vector(2 downto 0)
		  );
end component;

component MUX2to1
	port(
			x, y: in std_logic;
			s: in std_logic;
			m: out std_logic
		 );
end component;

component comparator
	port(
			A: in unsigned(3 downto 0);
			B: in unsigned(3 downto 0);
			z: out std_logic
		 );
end component;

signal w: std_logic_vector(2 downto 0);
begin
	COMP: comparator port map(v, "1001", z); --comparator that checks if v is bigger than 9
	CIRA: circuitA port map(v(2 downto 0), w);
	
	MUX0: MUX2to1 port map(v(0), w(0), z, m(0));
	MUX1: MUX2to1 port map(v(1), w(1), z, m(1));
	MUX2: MUX2to1 port map(v(2), w(2), z, m(2));
	MUX3: MUX2to1 port map(v(3), '0', z, m(3));
	
end Structure;
	