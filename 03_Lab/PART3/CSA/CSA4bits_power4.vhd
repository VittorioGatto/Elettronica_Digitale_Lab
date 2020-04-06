library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Carry select adder generic, can use any power of 4
--It's only purpose is to link blocks of CSA4bits for the necessary generic n bits

entity CSA4bits_power4 is
	generic(n: integer:=16); --n bits MUST BE POWER OF 4!!
	port(
			a, b: in std_logic_vector(n-1 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(n-1 downto 0)
		 );
end CSA4bits_power4;

architecture Stucture of CSA4bits_power4 is

component CSA4bits
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(3 downto 0)
		 );
end component;

signal c_propagate: std_logic_vector(n/4 downto 1);
signal c_carryin_last_vector: std_logic_vector(n/4 downto 1);
signal s_out: std_logic_vector(n-1 downto 0);

begin
	CSA1: CSA4bits port map(std_logic_vector(a(3 downto 0)), 
									std_logic_vector(b(3 downto 0)), 
									c_in, c_carryin_last_vector(1), 
									c_propagate(1), 
									s_out(3 downto 0));
	
	GEN_CSA: for i in 2 to n/4 generate
		CSA: CSA4bits port map(
										a((i*4)-1 downto (i*4)-4),
										b((i*4)-1 downto (i*4)-4),
										c_propagate(i-1), c_carryin_last_vector(i),
										c_propagate(i), 
										s_out((i*4)-1 downto (i*4)-4)); 
	end generate;
	
	s <= s_out;
	c_out <= c_propagate(n/4);
	c_carryin_last <= c_carryin_last_vector(n/4);
end Stucture;