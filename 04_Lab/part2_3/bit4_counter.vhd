library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit4_counter is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			Q: buffer unsigned(3 downto 0);
			enable_nth: out std_logic -- last input in chain (T)
		 );
end bit4_counter;

architecture Structure of bit4_counter is

component T_FF
	port(
			clk, resetn: in std_logic;
			T: in std_logic;
			Q, Qbar: out std_logic
		);
end component;

signal nth: std_logic_vector(3 downto 0); --nth T input

begin
	nth(0) <= enable AND Q(0);
	nth(1) <= nth(0) AND Q(1);
	nth(2) <= nth(1) AND Q(2);
	nth(3) <= nth(2) AND Q(3);
	
	TFF0: T_FF port map (clk, clear, enable, Q(0), open);
	TFF1: T_FF port map (clk, clear, nth(0), Q(1), open);
	TFF2: T_FF port map (clk, clear, nth(1), Q(2), open);
	TFF3: T_FF port map (clk, clear, nth(2), Q(3), open);
	
	enable_nth <= nth(3);

end Structure;