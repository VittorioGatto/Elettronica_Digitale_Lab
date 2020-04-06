library ieee;
use ieee.std_logic_1164.all;

-- Carry bypass adder 4 bits
entity Bypass4bits is
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out:  out std_logic;
			s: out std_logic_vector(3 downto 0)
		  );
end Bypass4bits;

architecture Behavior of Bypass4bits is

component MUX2to1
	port(
			x, y: in std_logic;
			s: in std_logic;
			m: out std_logic 
		 );
end component;

component RCA_4bits
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(3 downto 0)
		 );
end component;

signal p: std_logic_vector(3 downto 0); -- Propagate (A XOR B)
signal byp: std_logic; --BYPASS (BYP = P0 AND P1 AND P2 AND P3)
signal c_carryin_last_chain: std_logic;
signal c_out_chain: std_logic;

begin
	p <= (a(3) XOR b(3)) & (a(2) XOR b(2)) & (a(1) XOR b(1)) & (a(0) XOR b(0));
	byp <= p(3) AND p(2) AND p(1) AND p(0);
	
	RCA: RCA_4bits port map (a, b, c_in, c_carryin_last_chain, c_out_chain, s);
	
	MUX_cout: MUX2to1 port map(c_out_chain, c_in, byp, c_out);
	MUX_carryin_last: MUX2to1 port map(c_carryin_last_chain, c_in, byp, c_carryin_last);
end Behavior;

