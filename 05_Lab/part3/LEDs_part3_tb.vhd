library ieee;
use ieee.std_logic_1164.all;

entity LEDs_part3_tb is
end LEDs_part3_tb;

architecture Test of LEDs_part3_tb is
component LEDs_part3
  port( SW0: in std_logic; --resetn
        SW1: in std_logic; --w
        KEY0: in std_logic; --clock
        LEDG0: out std_logic; --z
        LEDR8_0: buffer std_logic_vector (8 downto 0) --states
      );
end component;
  
signal resetn: std_logic := '0';
signal w: std_logic := '0';
signal clk: std_logic := '0';
signal z: std_logic;
signal state_decoded: std_logic_vector(8 downto 0);

begin

DUT: LEDs_part3 port map(resetn, w, clk, z, state_decoded);
clk <= not clk after 10 ns;

process
	begin
		resetn <= '0';
		wait for 40 ns;
		resetn <= '1';
		w <= '1';
		wait for 20 ns;
		w <= '0';
		wait for 80 ns;
		w <= '1';
		wait for 100 ns;
		w <= '0'; 
		wait for 40 ns;
end process;
end Test;