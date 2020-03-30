library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity check_and_add is
	port(
			terms: in unsigned(3 downto 0);
			result: out unsigned(3 downto 0)
		 );
end check_and_add;

architecture Behavior of check_and_add is

component MUX8to4
	port(
			x,y: in std_logic_vector(3 downto 0);
			s: in std_logic;
			m: out std_logic_vector(3 downto 0)
		 );
end component;

component comparator
	port(
			A: in unsigned(3 downto 0);
			B: in unsigned(3 downto 0);
			z: out std_logic
		 );
end component;

signal sum: std_logic_vector(3 downto 0);
signal comparation_result: std_logic;
signal m_out: std_logic_vector(3 downto 0);

begin
	sum <= std_logic_vector(terms + 3);
	COMP: comparator port map(terms, "0100", comparation_result); --checks if bigger than 4
	MUX: MUX8to4 port map(std_logic_vector(terms), sum, comparation_result, m_out);
	
	result <= unsigned(m_out);
end Behavior;