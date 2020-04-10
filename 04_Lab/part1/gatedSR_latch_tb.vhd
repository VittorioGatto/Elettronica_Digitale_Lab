LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gatedSR_latch_tb IS
END gatedSR_latch_tb;

ARCHITECTURE Behavior OF gatedSR_latch_tb IS
  
COMPONENT gatedSR_latch 
PORT ( Clk, R, S : IN STD_LOGIC;
Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL R_in, S_in, Clk_in, Q_out : STD_LOGIC ;

BEGIN
  
  DUT: gatedSR_latch port map (Clk_in, R_in, S_in, Q_out);
    
PROCESS
BEGIN
  for i in 1 to 4 loop    -- generate clock with period 10 ns
    Clk_in <= '0';
    wait for 5 ns;
    Clk_in <= '1';
    wait for 5 ns;
  end loop;
END PROCESS;

PROCESS
BEGIN
  R_in <= '0';
  S_in <= '0';
  wait for 10 ns;
  R_in <= '0';
  S_in <= '1';
  wait for 10 ns;
  R_in <= '1';
  S_in <= '0';
  wait for 10 ns;
  R_in <= '1';
  S_in <= '1';
  wait for 10 ns;
END PROCESS;

END Behavior;