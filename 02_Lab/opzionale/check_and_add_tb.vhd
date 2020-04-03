library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity check_and_add_tb is
end check_and_add_tb;

architecture Behavior of check_and_add_tb is 

component check_and_add
  port(
			terms: in unsigned(3 downto 0);
			result: out unsigned(3 downto 0)
		 );
end component;

signal terms_in: unsigned(3 downto 0);
signal result_out: unsigned(3 downto 0);

begin 
	DUT: check_and_add port map(terms => terms_in, result => result_out); 
  
process
begin
	terms_in <= "0001"; -- "1 -> 1 ONLY CHECKED";
	wait for 20 ns;
	terms_in <= "0100"; -- "4 -> 4 ONLY CHECKED";
	wait for 20 ns;
	terms_in <= "0101"; -- "5 -> 8 ADDED 3";
	wait for 20 ns;
	terms_in <= "0110"; -- "6 -> 9 ADDED 3";
	wait for 20 ns;
	terms_in <= "1010"; -- "10 -> 13 ADDED 3";
	wait for 20 ns;
end process;
end Behavior;