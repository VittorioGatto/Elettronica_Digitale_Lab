library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_9_tb is
end comparator_9_tb;

architecture Behavior of comparator_9_tb is

component comparator_9
	port(
			A: in unsigned(3 downto 0);
			z: out std_logic
		);
end component;

signal A_in: unsigned(3 downto 0); 
signal z_out: std_logic;


begin

	DUT : comparator_9 port map (A => A_in, z => z_out );
	  
process
begin
  A_in <= "0001";
  wait for 10 ns;
  A_in <= "0010";
	wait for 10 ns;
	A_in <= "1000";
	wait for 10 ns;
	A_in <= "1001";
	wait for 10 ns;
	A_in <= "1010";
	wait for 10 ns;
	A_in <= "1111";
	wait for 10 ns;
	
end process;
	
end Behavior;
