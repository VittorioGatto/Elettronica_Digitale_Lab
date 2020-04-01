library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity converter_tb is
end converter_tb;

architecture Behavior of converter_tb is

component converter
	port(
			v: in unsigned(3 downto 0);
			m: out std_logic_vector(3 downto 0);
			z: inout std_logic
		 );
end component;

signal v_IN: unsigned(3 downto 0);
signal m_OUT: std_logic_vector(3 downto 0);
signal z_TB: std_logic;

begin
  
  DUT: converter port map(v => v_IN, m => m_OUT, z => z_TB);
    
process
begin
  v_IN <= "0000"; --0
  wait for 10 ns; 
  v_IN <= "0010"; --2
  wait for 10 ns; 
  v_IN <= "0100"; --4
  wait for 10 ns; 
  v_IN <= "1001"; --9
  wait for 10 ns; 
  v_IN <= "1010"; --10
  wait for 10 ns; 
  v_IN <= "1111"; --15
  wait for 10 ns; 
end process;

end Behavior;

	