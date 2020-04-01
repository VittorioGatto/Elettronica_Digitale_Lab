library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_tb is
end comparator_tb;

architecture Behavior of comparator_tb is

component comparator
	port(
			A: in unsigned(3 downto 0);
			B: in unsigned(3 downto 0);
			z: out std_logic
		);
end component;

signal A_in: unsigned(3 downto 0); 
signal B_in: unsigned(3 downto 0); 
signal z_out: std_logic;


begin

	DUT : comparator port map (A => A_in, B => B_in, z => z_out );
	  
process
begin
  A_in <= "0001";
  B_in <= "0010"; 
  wait for 10 ns;
  A_in <= "0010";
	B_in <= "0001";
	wait for 10 ns;
	A_in <= "1000";
	B_in <= "0100";
	wait for 10 ns;
	A_in <= "1001";
	B_in <= "1001";
	wait for 10 ns;
	
end process;
	
end Behavior;
