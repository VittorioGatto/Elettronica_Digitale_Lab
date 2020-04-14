library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reaction_timer_display_tb is
end reaction_timer_display_tb;

architecture Test of reaction_timer_display_tb is

component reaction_timer_display
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
end component;

constant clk_period: time := 20 ns; --50 MHz clock
constant clock_simulation: time :=  1 ns; --speed up simulation

signal SW7_0: unsigned(7 downto 0) := "00000001"; --1 second
signal KEY3: std_logic := '1';
signal clk: std_logic := '0';
signal KEY0: std_logic := '0';
signal speed: integer := 1000; --speed up simulation
signal reaction_time: unsigned(13 downto 0);
signal LEDR0: std_logic := '0';
signal win_lose: std_logic_vector(1 downto 0);
signal HEX3_0: std_logic_vector(0 to 27);

begin

DUT: reaction_timer_display port map (SW7_0, KEY3, clk, KEY0, speed, reaction_time, LEDR0, win_lose, HEX3_0);

clk <= not clk after clock_simulation/2;

--1 second = 50000 ns
--we take into account a 10 ns margin for flip flop delays
process
	begin
		KEY0 <= '1'; -- wake up
		wait for 100010 ns; -- 1 second of pre start + 1 second to reach button (0.10 ms simulation)
		KEY3 <= '0';	--won, should be reaction_time approximately = 1000
		wait for 10 ns;
		KEY3 <= '1';
		KEY0 <= '0'; --restarting game
		wait for 10 ns;
		KEY0 <= '1';
		wait for 500010 ns; -- if you want to see it lose... (0.50 ms simulation)
end process;

end Test;
