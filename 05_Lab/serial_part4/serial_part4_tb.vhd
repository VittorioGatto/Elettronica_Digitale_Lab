library ieee;
use ieee.std_logic_1164.all;

entity serial_part4_tb is
end serial_part4_tb;

architecture Behavior of serial_part4_tb is

component serial_part4
	port(
			CLOCK_50: in std_logic;
			KEY0: in std_logic; --resetn
			KEY1: in std_logic; --enable
		   HEX7_0: out std_logic_vector(55 downto 0)
		 );
end component;

component seg7_to_word
	port(
			seg7: in std_logic_vector(0 to 55);
			word: out string(1 to 8)
		 );
end component;

signal clk_in, resetn, enable: std_logic;
signal output: std_logic_vector(55 downto 0);
signal output_decoded: string(1 to 8);

begin
	clock_gen: process
		begin
			clk_in <= '0', '1' after 10 ns; 
		wait for 20 ns; --50 MHz clock
	end process;
  
	DUT: serial_part4 port map(clk_in, resetn, enable, output);
	DECODER: seg7_to_word port map(output, output_decoded);
    
	TestProcess: process
		begin
			resetn <= '0';
			wait for 20 ns;
			resetn <= '1';
			enable <= '1';
			wait for 2000010 ns; -- see what happens in 20 seconds
	end process;
      
end Behavior;