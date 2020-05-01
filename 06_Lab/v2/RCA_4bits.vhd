library ieee;
use ieee.std_logic_1164.all;

--Ripple Carry Adder for four bits
entity RCA_4bits is
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic; -- last carry in, useful for overflow detection
			c_out: out std_logic;
			s: out std_logic_vector(3 downto 0)
		 );
end RCA_4bits;

architecture Structure of RCA_4bits is

component FA
	port(
			a, b, c_in: in std_logic;
			s, c_out: out std_logic
		 );
end component;

signal c_carry: std_logic_vector(3 downto 1);
begin
	FA0: FA port map (a(0), b(0), c_in, s(0), c_carry(1));
	FA1: FA port map (a(1), b(1), c_carry(1), s(1), c_carry(2));
	FA2: FA port map (a(2), b(2), c_carry(2), s(2), c_carry(3));
	
	c_carryin_last <= c_carry(3);
	
	FA3: FA port map (a(3), b(3), c_carry(3), s(3), c_out);
end Structure;