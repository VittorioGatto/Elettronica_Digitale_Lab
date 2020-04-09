library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplier_row_tb is
end Multiplier_row_tb;

architecture Behavior of Multiplier_row_tb is

component Multiplier_row
	port(
			a, c: in unsigned(3 downto 0);
			b: in std_logic;
			c_in: in std_logic;
			c_out: out std_logic;
			s: out unsigned(3 downto 0)
		  );
end component;

signal a_map, c_map: unsigned(3 downto 0);
signal b_map: std_logic;
signal c_in_map: std_logic;
signal c_out_map: std_logic;
signal s_map: unsigned(3 downto 0);

begin
	DUT: Multiplier_row port map(a => a_map, c => c_map, b => b_map, c_in => c_in_map, c_out => c_out_map, s => s_map);

process
begin
	a_map <= to_unsigned(1, a_map'length);
	c_map <= to_unsigned(1, c_map'length);
	b_map <= '0';
	c_in_map <= '1';
	wait for 20 ns;
	
	a_map <= to_unsigned(5, a_map'length);
	c_map <= to_unsigned(10, c_map'length);
	b_map <= '0';
	c_in_map <= '1';
	wait for 20 ns;
	
	a_map <= to_unsigned(3, a_map'length);
	c_map <= to_unsigned(5, c_map'length);
	b_map <= '0';
	c_in_map <= '1';
	wait for 20 ns;
	
	a_map <= to_unsigned(10, a_map'length);
	c_map <= to_unsigned(14, c_map'length);
	b_map <= '0';
	c_in_map <= '1';
	wait for 20 ns;
	
end process;
end Behavior;
	