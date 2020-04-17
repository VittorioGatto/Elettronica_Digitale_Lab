library ieee;
use ieee.std_logic_1164.all;

entity part3_tb is
end part3_tb;

architecture Test of part3_tb is

component part3
	port(
			clk: in std_logic;
			resetn: in std_logic;
			w: in std_logic;
			z: out std_logic;
			state: buffer std_logic_vector(8 downto 0)
		 );
end component;

signal clk: std_logic := '0';
signal resetn: std_logic := '0';
signal w: std_logic := '0';
signal z: std_logic;
signal state: std_logic_vector(8 downto 0);

begin

DUT: part3 port map(clk, resetn, w, z, state);
clk <= not clk after 10 ns;

process
	begin
		resetn <= '0';
		wait for 40 ns;
		resetn <= '1';
		w <= '1';
		wait for 20 ns;
		w <= '0';
		wait for 80 ns;
		w <= '1';
		wait for 100 ns;
		w <= '0'; 
		wait for 40 ns;
end process;
end Test;
		
	
	