library ieee;
use ieee.std_logic_1164.all;

entity state_sequential_tb is
end state_sequential_tb;

architecture Behavior of state_sequential_tb is
component state_sequential
  port( w, resetn, clock: in std_logic;
        idle_out, det0_1_out,det0_2_out,det0_3_out,det0_4_out,det1_1_out,det1_2_out,det1_3_out,det1_4_out: buffer std_logic
      );
end component;

signal w_in, res, clk, idle_cs, det0_1_cs,det0_2_cs,det0_3_cs,det0_4_cs,det1_1_cs,det1_2_cs,det1_3_cs,det1_4_cs: std_logic;

 begin
   res <= '0', '1' after 2 ns;
   
   clock_gen: process
   begin
     clk <= '0', '1' after 5 ns;
     wait for 10 ns;
   end process;
   
   w_in <= '1', '0' after 4 ns, '0' after 14 ns, '1' after 24 ns, '1' after 34 ns, '1' after 44 ns, '1' after 54 ns, '1' after 64 ns, '0' after 74 ns, '1' after 84 ns; 
   
   DUT: state_sequential port map(w_in, res, clk, idle_cs, det0_1_cs,det0_2_cs,det0_3_cs,det0_4_cs,det1_1_cs,det1_2_cs,det1_3_cs,det1_4_cs);
     
end Behavior;