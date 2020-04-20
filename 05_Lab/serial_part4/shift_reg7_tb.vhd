library ieee;
use ieee.std_logic_1164.all;

entity shift_reg7_tb is
end shift_reg7_tb;

architecture Behavior of shift_reg7_tb is

component shift_reg7
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic;
			serial_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(0 to 6)
		);
end component;

signal clk_in, resetn_in, load_in: std_logic;
signal s_in, d_out: std_logic_vector(0 to 6);

begin
  clock_gen: process
  begin
    clk_in <= '0', '1' after 10 ns; 
    wait for 20 ns; --50 MHz clock
  end process;
  
  DUT: shift_reg7 port map(clk_in, resetn_in, load_in, s_in, d_out);
  
  process
    begin
      resetn_in <= '0';
      load_in <= '1';
      s_in <= "0000111";
      wait for 15 ns;     --out = "1111111"
      
      resetn_in <= '1';
      load_in <= '1';
      s_in <= "0000111";
      wait for 20 ns;     --out = "0000111"
      
      resetn_in <= '1';
      load_in <= '1';
      s_in <= "0001110";
      wait for 20 ns;     --out = "0001110"
      
      resetn_in <= '1';
      load_in <= '0';
      s_in <= "0011100";
      wait for 20 ns;     --out = "0001110"
      
      resetn_in <= '1';
      load_in <= '1';
      s_in <= "0011100";
      wait for 20 ns;     --out = "0011100"
	end process;
	
end Behavior;