library ieee;
use ieee.std_logic_1164.all;

entity OneHot_v1_tb is
end OneHot_v1_tb;

architecture Behavior of OneHot_v1_tb is
  component OneHot_v1 is
  port( SW0: in std_logic; --resetn
        SW1: in std_logic; --w
        KEY0: in std_logic; --clock
        LEDG0: out std_logic; --z
        LEDR: buffer std_logic_vector (8 downto 0) --states
      );
  end component;

signal resetn_in,w_in,clock_in,z_out: std_logic;
signal states: std_logic_vector(8 downto 0);

begin
  
  resetn_in <= '0', '1' after 2 ns;
  
  clk_gen: process
  begin
    clock_in <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process;
  
  w_in <= '1', '0' after 4 ns, '0' after 14 ns, '1' after 24 ns, '1' after 34 ns, '1' after 44 ns, '1' after 54 ns, '1' after 64 ns, '0' after 74 ns, '1' after 84 ns;
  
  DUT: OneHot_v1 port map(resetn_in,w_in,clock_in,z_out,states);

end Behavior;