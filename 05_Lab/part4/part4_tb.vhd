library ieee;
use ieee.std_logic_1164.all;

entity part4_tb is
end part4_tb;

architecture Test of part4_tb is

component part4
	port(
			clk: in std_logic;
			KEY0: in std_logic;
			KEY3: in std_logic;
		   HEX7_0: out std_logic_vector(0 to 55)
		 );
end component;

component seg7_to_word
	port(
			seg7: in std_logic_vector(0 to 55);
			word: out string(1 to 8)
		 );
end component;

signal clk: std_logic := '0';
signal resetn: std_logic := '0';
signal enable: std_logic := '1';
signal shifted_word: std_logic_vector(0 to 55);
signal display_represent: string(1 to 8);

begin

DUT: part4 port map(clk, resetn, enable, shifted_word);

TRANSLATOR: seg7_to_word port map(shifted_word, display_represent);

clk <= not clk after 10 ns;

process
	begin
		resetn <= '0';
		wait for 20 ns;
		resetn <= '1';
		enable <= '1';
		wait for 2000010 ns; -- see what happens in 20 seconds
end process;
end Test;