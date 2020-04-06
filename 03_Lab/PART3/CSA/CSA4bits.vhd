library ieee;
use ieee.std_logic_1164.all;

-- Carry Select Adder 4 bits
entity CSA4bits is
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out:  out std_logic;
			s: out std_logic_vector(3 downto 0)
		  );
end CSA4bits;

architecture Behavior of CSA4bits is

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

signal c_out_0chain: std_logic;
signal c_out_1chain: std_logic;

signal c_carryin_last_0chain: std_logic;
signal c_carryin_last_1chain: std_logic;

signal s_0chain: std_logic_vector(3 downto 0);
signal s_1chain: std_logic_vector(3 downto 0);


begin
	
	RCA_0chain: RCA_4bits port map (a, b, '0', c_carryin_last_0chain, c_out_0chain, s_0chain);
	RCA_1chain: RCA_4bits port map (a, b, '1', c_carryin_last_1chain, c_out_1chain, s_1chain);
	
	MUX_cout: MUX2to1 port map(c_out_0chain, c_out_1chain, c_in, c_out);
	
	MUX_S0: MUX2to1 port map(s_0chain(0), s_1chain(0), c_in, s(0));
	MUX_S1: MUX2to1 port map(s_0chain(1), s_1chain(1), c_in, s(1));
	MUX_S2: MUX2to1 port map(s_0chain(2), s_1chain(2), c_in, s(2));
	MUX_S3: MUX2to1 port map(s_0chain(3), s_1chain(3), c_in, s(3));
	
	MUX_carryin_last: MUX2to1 port map(c_carryin_last_0chain, c_carryin_last_1chain, c_in, c_carryin_last);
end Behavior;