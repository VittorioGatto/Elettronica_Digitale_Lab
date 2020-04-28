library ieee;
use ieee.std_logic_1164.all;

entity RCA_4bits_tb is
end RCA_4bits_tb;

architecture Behavior of RCA_4bits_tb is

component RCA_4bits
	port(
			a, b: in std_logic_vector(3 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(3 downto 0)
		 );
end component;

signal A_IN: std_logic_vector(3 downto 0);
signal B_IN: std_logic_vector(3 downto 0);
signal S_OUT: std_logic_vector(3 downto 0);
signal C_IN_SIM: std_logic;
signal C_LAST: std_logic;
signal C_OUT_SIM: std_logic;

begin

  DUT: RCA_4bits port map (a => A_in, b => B_IN, c_in => C_IN_SIM, c_carryin_last => C_LAST, s => S_OUT, c_out => C_OUT_SIM);
    
process
begin
  
  A_IN <= "0000";
  B_IN <= "0000";
  C_IN_SIM <= '0';
  wait for 4 ns; -- S_OUT = "0000", C_OUT_SIM = '0', C_LAST = '0'
  
  A_IN <= "0000";
  B_IN <= "0000";
  C_IN_SIM <= '1';
  wait for 4 ns; -- S_OUT = "0001", C_OUT_SIM = '0', C_LAST = '0'
  
  A_IN <= "0101";
  B_IN <= "1010";
  C_IN_SIM <= '0';
  wait for 4 ns; -- S_OUT = "1111", C_OUT_SIM = '0', C_LAST = '0'
  
  A_IN <= "0101";
  B_IN <= "1010";
  C_IN_SIM <= '1';
  wait for 4 ns; -- S_OUT = "0000", C_OUT_SIM = '1', C_LAST = '1'
  
  A_IN <= "1111";
  B_IN <= "1111";
  C_IN_SIM <= '1';
  wait for 4 ns; -- S_OUT = "1111", C_OUT_SIM = '1', C_LAST = '1'


end process;
end Behavior;
