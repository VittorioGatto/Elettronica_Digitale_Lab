library ieee;
use ieee.std_logic_1164.all;

entity state_sequential_v2_tb is
end state_sequential_v2_tb;

architecture Behavior of state_sequential_v2_tb is
component state_sequential_v2
  port( w, resetn, clock: in std_logic;
        idle_out, det0_1_out,det0_2_out,det0_3_out,det0_4_out,det1_1_out,det1_2_out,det1_3_out,det1_4_out: buffer std_logic
      );
end component;

signal w_in, res, clk, idle_cs, det0_1_cs,det0_2_cs,det0_3_cs,det0_4_cs,det1_1_cs,det1_2_cs,det1_3_cs,det1_4_cs: std_logic;

 begin
   res <= '0', '1' after 6 ns;
   
   clock_gen: process
   begin
     clk <= '0', '1' after 5 ns;
     wait for 10 ns;
   end process;
   
   w_in <= '1', '0' after 2 ns, '1' after 22 ns, '0' after 72 ns, '1' after 82 ns; 
   
   DUT: state_sequential_v2 port map(w_in, res, clk, idle_cs, det0_1_cs,det0_2_cs,det0_3_cs,det0_4_cs,det1_1_cs,det1_2_cs,det1_3_cs,det1_4_cs);
     
end Behavior;