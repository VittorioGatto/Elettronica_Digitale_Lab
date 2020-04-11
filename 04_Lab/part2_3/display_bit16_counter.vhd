library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_bit16_counter is
  port(
      SW1: in std_logic; --enalble
      SW0: in std_logic; --reset
      clock: in std_logic;
      HEX: out std_logic_vector (0 to 6)
      );
end display_bit16_counter;

architecture Structure of display_bit16_counter is

component bit16_counter
  port(
      enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			Q: buffer unsigned(15 downto 0)
		 );
end component;
     
component segment7_hex
  	port(
			c: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		  );
end component;
       
signal result: unsigned(15 downto 0);
       
begin
  COU: bit16_counter port map (SW1, clock, SW0, result);
  
  
  DIS: segment7_hex port map (std_logic_vector(result(3 downto 0)), HEX(0 to 6));       
       
end Structure;