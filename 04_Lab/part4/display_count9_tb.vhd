library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_count9_tb is
end display_count9_tb;

architecture Behavior of display_count9_tb is
  component display_count9
  port(
			EN: in std_logic;
			CK: in std_logic;
			CLR: in std_logic;
			SPD: in integer; --defines increment (real = 1, simulation = 1000)
			SEGS_OUT: out std_logic_vector(0 to 6)
		 );
end component;

signal en_in: std_logic;
signal ck_in: std_logic;
signal clr_in: std_logic := '0';
signal spd_in: integer := 1000;
signal output: std_logic_vector(0 to 6);

begin
process --clock generation, period = 20 ns
  begin
    ck_in <= '0', '1' after 10 ns;
    wait for 20 ns;
end process;

  DUT: display_count9 port map (en_in, ck_in, clr_in, spd_in, output);
    
  process  
   begin
    clr_in <= '1';
    en_in <= '1';
    wait for 12 ms;
    en_in <= '0';
    wait for 2 ms;
    clr_in <= '0';
    wait for 1 ms;
end process;
    

end Behavior;