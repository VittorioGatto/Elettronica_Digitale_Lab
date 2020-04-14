library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reaction_timer_display is
	port(
			SW7_0: unsigned(7 downto 0); --pre start seconds
			KEY3: in std_logic; --freeze if 0
			clk: in std_logic;
			KEY0: in std_logic; --equivalent of clear
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			reaction_time: out unsigned(13 downto 0); --milliseconds
			LEDR0: out std_logic; -- is counting if 1
			win_lose: out std_logic_vector(1 downto 0); -- pre_start 00, win 01, lose 10, running 11
			HEX3_0: out std_logic_vector(0 to 27) --milliseconds in 7 segment encoding
		 );
end reaction_timer_display;

architecture Structure of reaction_timer_display is

component segment7_decoder_nums
	port(
			m: in std_logic_vector(3 downto 0);
			segs: out std_logic_vector(0 to 6)
		);
end component;

component binaryToBCD
	port(
		   binary_in: in std_logic_vector(13 downto 0);
			bcd_out: out std_logic_vector(15 downto 0)
		 );
end component;

component reaction_timer
	port(
			pre_start_secs: unsigned(7 downto 0); --pre start seconds
			freeze: in std_logic; --freeze if 0
			clk: in std_logic;
			restart: in std_logic; --equivalent of clear
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			reaction_time: out unsigned(13 downto 0); --milliseconds
			is_counting: buffer std_logic; -- is counting if 1
			win_lose: buffer std_logic_vector(1 downto 0); -- pre_start 00, win 01, lose 10, running 11
			current_count: out unsigned(13 downto 0)
		 );
end component;

signal current_count: unsigned(13 downto 0);
signal current_count_BCD: std_logic_vector(15 downto 0);

begin

	REACT: reaction_timer port map(SW7_0, KEY3, clk, KEY0, speed, reaction_time, LEDR0, win_lose, current_count);
	
	BTBCD: binaryToBCD port map(std_logic_vector(current_count), current_count_BCD);
	
	SEG7_0: segment7_decoder_nums port map (current_count_BCD(3 downto 0), HEX3_0(21 to 27));
	SEG7_1: segment7_decoder_nums port map (current_count_BCD(7 downto 4), HEX3_0(14 to 20));
	SEG7_2: segment7_decoder_nums port map (current_count_BCD(11 downto 8), HEX3_0(7 to 13));
	SEG7_3: segment7_decoder_nums port map (current_count_BCD(15 downto 12), HEX3_0(0 to 6));

end Structure;