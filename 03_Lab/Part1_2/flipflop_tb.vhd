library ieee;
use ieee.std_logic_1164.all;

entity flipflop_tb is
end flipflop_tb;

architecture Behavior of flipflop_tb is

component flipflop is
	port(
			D, Clock, Resetn: in std_logic;
			Q: out std_logic
		 );
end component;

signal D_IN: std_logic;
signal Clock_IN: std_logic;
signal Resetn_IN: std_logic;
signal Q_OUT: std_logic;

begin
  DUT: flipflop port map (D => D_IN, Clock => Clock_IN, Resetn => Resetn_IN, Q => Q_OUT);
   
   -- generate clock 
process
  begin
  for i in 1 to 2 loop    -- clock period 10 ns
    clock_IN <= '0';
    wait for 5 ns;
    clock_IN <= '1';
    wait for 5 ns;
  end loop;
end process;

  -- generate input
process  
begin
  D_IN <= '0';
  wait for 2 ns;
   
  D_IN <= '1';
  wait for 6 ns;
  
  D_IN <= '0';
  wait for 8 ns;
  
  D_IN <= '1';
  wait for 4 ns;

end process;
  
  -- generate reset
process
  begin
    Resetn_IN <= '1'; 
    wait for 12 ns;
    
    Resetn_IN <= '0';
    wait for 8 ns;
  end process;

end Behavior;