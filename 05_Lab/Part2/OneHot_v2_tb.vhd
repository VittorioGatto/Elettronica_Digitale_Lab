library ieee;
use ieee.std_logic_1164.all;

entity OneHot_v2_tb is
end OneHot_v2_tb;

architecture Behavior of OneHot_v2_tb is
  component OneHot_v2 is
  port( SW0: in std_logic; --resetn
        SW1: in std_logic; --w
        KEY0: in std_logic; --clock
        LEDG0: out std_logic; --z
        LEDR8_0: buffer std_logic_vector (8 downto 0) --states
      );
  end component;

signal resetn_in,w_in,clock_in,z_out: std_logic;
signal states: std_logic_vector(8 downto 0);

begin
  
  resetn_in <= '0', '1' after 6 ns;
  
  clk_gen: process
  begin
    clock_in <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process;
  
  w_in <= '1', '0' after 2 ns, '1' after 22 ns, '0' after 72 ns, '1' after 82 ns; 
  
  DUT: OneHot_v2 port map(resetn_in,w_in,clock_in,z_out,states);

end Behavior;