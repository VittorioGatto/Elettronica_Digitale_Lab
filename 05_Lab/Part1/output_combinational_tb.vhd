library ieee;
use ieee.std_logic_1164.all;

entity output_combinational_tb is
end output_combinational_tb;

architecture Behavior of output_combinational_tb is
component output_combinational
  port( idle, det0_1,det0_2,det0_3,det0_4,det1_1,det1_2,det1_3,det1_4: in std_logic;
        z: out std_logic
      );
end component;

signal idle_in, det0_1_in,det0_2_in,det0_3_in,det0_4_in,det1_1_in,det1_2_in,det1_3_in,det1_4_in: std_logic;
signal z_out: std_logic;

begin
DUT: output_combinational port map (idle_in,det0_1_in,det0_2_in,det0_3_in,det0_4_in,det1_1_in,det1_2_in,det1_3_in,det1_4_in,z_out);

process
  begin
    idle_in <= '1', '0' after 5 ns;
    det0_1_in <= '0', '1' after 5 ns, '0' after 10 ns;
    det0_2_in <= '0', '1' after 10 ns, '0' after 15 ns;
    det0_3_in <= '0', '1' after 15 ns, '0' after 20 ns;
    det0_4_in <= '0', '1' after 20 ns, '0' after 30 ns; --z = '1' for 20 ns < t < 30 ns
    det1_1_in <= '0';
    det1_2_in <= '0';
    det1_3_in <= '0', '1' after 30 ns, '0' after 35 ns;
    det1_4_in <= '0', '1' after 35 ns;
    wait for 40 ns;
end process;
end Behavior;