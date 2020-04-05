library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier4bits is
	port(
			a, b: in unsigned(3 downto 0);
			p: out unsigned(7 downto 0)
		  );
end Multiplier4bits;

architecture Behavior of Multiplier4bits is

component Multiplier_row
	port(
			a, c: in unsigned(3 downto 0);
			b: in std_logic;
			c_in: in std_logic;
			c_out: out std_logic;
			s: out unsigned(3 downto 0)
		 );
end component;

signal c_1row: unsigned(3 downto 0);
signal c_2row: unsigned(3 downto 0);
signal c_3row: unsigned(3 downto 0);
signal c_4row: unsigned(3 downto 0);

signal c_in_propagate: std_logic_vector(3 downto 1);

begin
	c_1row <= '0' & (a(3) AND b(0)) & (a(2) AND b(0)) & (a(1) AND b(0));
	
	M1: Multiplier_row port map(a => a,
										 c => c_1row,
										 b => b(1),
										 c_in => '0', c_out => c_in_propagate(1),
										 s => c_2row);
										 
	M2: Multiplier_row port map(a => a,
										 c(3) => c_in_propagate(1),
										 c(2 downto 0) => c_2row(3 downto 1),
										 b => b(2),
										 c_in => '0', c_out => c_in_propagate(2),
										 s => c_3row);
										 
	M3: Multiplier_row port map(a => a,
										 c(3) => c_in_propagate(2),
										 c(2 downto 0) => c_3row(3 downto 1),
										 b => b(3),
										 c_in => '0', c_out => c_in_propagate(3),
										 s => c_4row);
										 
	p <= c_in_propagate(3) & c_4row & c_3row(0) & c_2row(0) & (a(0) AND b(0));

end Behavior;