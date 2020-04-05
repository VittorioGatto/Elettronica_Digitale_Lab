library ieee;
use ieee.std_logic_1164.all;

entity segment7_hex_tb is
end segment7_hex_tb;

architecture Behavior of segment7_hex_tb is

component segment7_hex
	port(
			c: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		  );
end component;

signal c_IN: std_logic_vector(3 downto 0);
signal segs_OUT: std_logic_vector(0 to 6);


begin

  DUT: segment7_hex port map (c => c_IN, segs => segs_OUT);
    
process
begin

c_IN <= "0000"; -- "0000001"
wait for 5 ns;

c_IN <= "0010"; -- "0010010"
wait for 5 ns;

c_IN <= "0100"; -- "1001100"
wait for 5 ns;

c_IN <= "1100"; -- "0110001"
wait for 5 ns;

c_IN <= "1110"; -- "0110000"
wait for 5 ns;


end process;
end Behavior;
