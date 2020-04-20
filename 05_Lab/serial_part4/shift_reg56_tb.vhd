library ieee;
use ieee.std_logic_1164.all;

--shift register 56 bit PIPO
entity shift_reg56_tb is
end shift_reg56_tb;

architecture Behavior of shift_reg56_tb is

component shift_reg56 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic; --tells registers to load
			s_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(55 downto 0)
		);
end component;

component seg7_to_word
	port(
			seg7: in std_logic_vector(0 to 55);
			word: out string(1 to 8)
		 );
end component;

signal clk_in, res_in, load_in: std_logic;
signal input: std_logic_vector(0 to 6);
signal output: std_logic_vector(55 downto 0);
signal output_decoded: string(1 to 8);

begin
  clock_gen: process
  begin
    clk_in <= '0', '1' after 10 ns; 
    wait for 20 ns; --50 MHz clock
  end process;
  
  DUT: shift_reg56 port map(clk_in, res_in, load_in, input, output);
  DECODER: seg7_to_word port map(output, output_decoded);
    
  process
    begin
      res_in <= '0';
      load_in <= '1';
      input <= "0001001";
      wait for 15 ns;     --out = "XXXXXXX"
      
      res_in <= '1';
      load_in <= '1';
      input <= "0001001";
      wait for 20 ns;     --out = "XXXXXXH"
      
      res_in <= '1';
      load_in <= '1';
      input <= "0000110";
      wait for 20 ns;     --out = "XXXXXHE"
      
      res_in <= '1';
      load_in <= '0';
      input <= "1000111";
      wait for 20 ns;     --out = "XXXXXHE"
      
      res_in <= '1';
      load_in <= '1';
      input <= "1000111";
      wait for 20 ns;     --out = "XXXXHEL"
	end process;


end Behavior;
	