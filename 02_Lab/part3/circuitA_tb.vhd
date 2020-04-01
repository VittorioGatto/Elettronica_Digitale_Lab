library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuitA_tb is
end circuitA_tb;

architecture Behavior of circuitA_tb is
  
component circuitA

port(
		  v: in unsigned(2 downto 0);
		  v_new: out std_logic_vector(2 downto 0)
		  );

end component;

signal v_IN: unsigned(2 downto 0);
signal v_OUT: std_logic_vector(2 downto 0);

begin
  
  DUT: circuitA port map(v => v_IN, v_new => v_OUT);
    
process
begin
  v_IN <= "010"; --10
  wait for 10 ns; 
  v_IN <= "011"; --11
  wait for 10 ns; 
  v_IN <= "100"; --12
  wait for 10 ns; 
  v_IN <= "101"; --13
  wait for 10 ns; 
  v_IN <= "110"; --14
  wait for 10 ns; 
  v_IN <= "111"; --15
  wait for 10 ns; 
end process;

end Behavior;