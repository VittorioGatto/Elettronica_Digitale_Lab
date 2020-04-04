library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Entity that links the 8 bit sequential RCA port to various buttons, push buttons, leds and 7 segment displays
entity display_8bit_RCA is
	port(
			SW15_8: in signed(7 downto 0); -- A
			SW7_0: in signed(7 downto 0); -- B
			SW16: in std_logic; -- opcode 0 for addition and 1 for subtraction
			KEY0: in std_logic; -- RESETN
			KEY1: in std_logic; -- CLOCK
			LEDR7_0: out signed(7 downto 0); --S display in two's complement (binary)
			LEDG8: out std_logic; --Overflow
			HEX7_6: out std_logic_vector(0 to 13); --A display 7 segment
			HEX5_4: out std_logic_vector(0 to 13); --B display 7 segment
			HEX1_0: out std_logic_vector(0 to 13) --S display 7 segment
	    );
end display_8bit_RCA;

architecture Structure of display_8bit_RCA is

component Bit8_Seq_RCA
	port(
			A, B: in signed(7 downto 0);
			opcode: in std_logic; -- 0 addition 1 subtraction
			Clock: in std_logic;
			Resetn: in std_logic; -- push button defaults this to 1
			Overflow: out std_logic;
			S: out signed(7 downto 0)
		 );
end component;

component segment7_hex
	port(
			c: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		  );
end component;

signal result: signed(7 downto 0);
begin
	RCA8: Bit8_Seq_RCA port map (SW15_8, SW7_0, SW16, KEY1, KEY0, LEDG8, result);
	
	LEDR7_0 <= result;
	
	SEG_A_dozens: segment7_hex port map (std_logic_vector(SW15_8(7 downto 4)), HEX7_6(0 to 6));
	SEG_A_ones: segment7_hex port map (std_logic_vector(SW15_8(3 downto 0)), HEX7_6(7 to 13));
	SEG_B_dozens: segment7_hex port map (std_logic_vector(SW7_0(7 downto 4)), HEX5_4(0 to 6));
	SEG_B_ones: segment7_hex port map (std_logic_vector(SW7_0(3 downto 0)), HEX5_4(7 to 13));
	
	SEG_S_dozens: segment7_hex port map (std_logic_vector(result(7 downto 4)), HEX1_0(0 to 6));
	SEG_S_ones: segment7_hex port map (std_logic_vector(result(3 downto 0)), HEX1_0(7 to 13));
end Structure;