library ieee;
use ieee.std_logic_1164.all;

entity segment7_mux_tb is
end segment7_mux_tb;

architecture Behavior of segment7_mux_tb is 

component segment7_mux
  port(
    SW: in std_logic_vector(17 downto 0);
    HEX0: out std_logic_vector(0 to 6)
  );
end component;

signal SW_in: std_logic_vector(17 downto 0) := "000000001010011100"; -- Displays 'H' as default
signal HEX0_out: std_logic_vector(0 to 6);

begin 
DUT: segment7_mux port map(SW => SW_in, HEX0 => HEX0_out); 
  
  
process
begin
	SW_in(17 downto 15) <= "000"; -- "H => 1001000";
	wait for 20 ns;
	SW_in(17 downto 15) <= "001"; -- "E => 0110000";
	wait for 20 ns;
	SW_in(17 downto 15) <= "010"; -- "L => 1110001";
	wait for 20 ns;
	SW_in(17 downto 15) <= "011"; -- "L => 1110001";
	wait for 20 ns;
	SW_in(17 downto 15) <= "100"; -- "O => 0000001";
	wait for 20 ns;
end process;
end Behavior;