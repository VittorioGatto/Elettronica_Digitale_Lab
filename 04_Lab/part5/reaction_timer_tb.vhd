library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reaction_timer_tb is
end reaction_timer_tb;

architecture Test of reaction_timer_tb is

component reaction_timer
	port(
			pre_start_secs: unsigned(7 downto 0); --pre start seconds
			freeze: in std_logic; --freeze if 0
			clk: in std_logic;
			restart: in std_logic; --equivalent of clear
			speed: in integer;
			reaction_time: out unsigned(13 downto 0); --milliseconds
			is_counting: buffer std_logic; -- is counting if 1
			win_lose: buffer std_logic_vector(1 downto 0); -- pre_start 00, win 01, lose 10, running 11
			current_count: out unsigned(13 downto 0)
		 );
end component;

constant clk_period: time := 20 ns; --50 MHz clock
constant clock_simulation: time :=  1 ns; --speed up simulation

signal pre_start_secs: unsigned(7 downto 0) := "00000001"; --1 second
signal freeze: std_logic := '1';
signal clk: std_logic := '0';
signal restart: std_logic := '0';
signal speed: integer := 1000; --speed up simulation
signal reaction_time: unsigned(13 downto 0);
signal is_counting: std_logic := '0';
signal win_lose: std_logic_vector(1 downto 0);
signal current_count: unsigned(13 downto 0);

begin

DUT: reaction_timer port map (pre_start_secs, freeze, clk, restart, speed, reaction_time, is_counting, win_lose, current_count);

clk <= not clk after clock_simulation/2;

--1 second = 25000 ns
--we take into account a 10 ns margin for flip flop delays
process
	begin
		restart <= '1'; -- wake up
		wait for 50010 ns; -- 1 second of pre start + 1 second to reach button (0.05 ms simulation)
		freeze <= '0';	--won, should be reaction_time approximately = 1000
		wait for 10 ns;
		freeze <= '1';
		restart <= '0'; --restarting game
		wait for 10 ns;
		restart <= '1';
		wait for 250010 ns; -- if you want to see it lose... (0.25 ms simulation)
		--restart <= '0';
		--wait for 20 ns;
end process;

end Test;
