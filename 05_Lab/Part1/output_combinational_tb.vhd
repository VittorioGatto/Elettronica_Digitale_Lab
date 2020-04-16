library ieee;
use ieee.std_logic_1164.all;

entity output_combinational_tb is
end output_combinational_tb;

architecture Behavior of output_combinational_tb is
component output_combinational
  port( det0_4,det1_4: in std_logic;
        z: out std_logic
      );
end component;

signal idle_in, det0_1_in,det0_2_in,det0_3_in,det0_4_in,det1_1_in,det1_2_in,det1_3_in,det1_4_in: std_logic;
signal z_out: std_logic;

begin
DUT: output_combinational port map (idle_in,det0_1_in,det0_2_in,det0_3_in,det0_4_in,det1_1_in,det1_2_in,det1_3_in,det1_4_in,z_out);

process
  begin
    det0_4_in <= '0', '1' after 20 ns, '0' after 30 ns; --z = '1' for 20 ns < t < 30 ns
    det1_4_in <= '0', '1' after 35 ns; --z = '1' for 35 ns < t < 40 ns
    wait for 40 ns;
end process;
end Behavior;
