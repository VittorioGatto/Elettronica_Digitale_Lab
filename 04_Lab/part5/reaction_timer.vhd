library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reaction_timer is
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
end reaction_timer;

architecture Behavior of reaction_timer is

type reactionTimerType is (pre_start, counting, won, lost);
signal current_state, next_state: reactionTimerType;

constant lose_ms: unsigned(13 downto 0) := to_unsigned(9999, 14);

begin
process(clk, freeze, restart)
	--we acknowledge that starting by zero leads to count + 1 for every 25000 cycle
	--but in order to maintain the design simple, and in the simulation add 1000
	--for speed, we chose to keep it this way, considering it produces a result
	--in simulation, that is wrong only by 0.001 seconds (or 1 milli second).
	--For a reaction timer of ten seconds, this error is completely insignificant.
	
	variable count: unsigned(13 downto 0) := (others => '0');

	variable count_pre_start: integer := 0;
	variable counter_ms: integer := 0;
	
	begin
	if restart = '0' then
		is_counting <= '0';
		win_lose <= "00";
		count_pre_start := 0;
		counter_ms := 0;
		count := (others => '0');
		
		current_state <= pre_start;
		
	elsif rising_edge(clk) then
			current_state <= next_state;
			
			case current_state is
				when pre_start =>
					if count_pre_start = 50000000*to_integer(pre_start_secs) then --1 second
						is_counting <= '1';
					else
						is_counting <= '0';
						count_pre_start := count_pre_start + speed;
					end if;
				when counting =>
					if freeze = '0' then
						win_lose <= "01"; --won
					elsif count = lose_ms then
						win_lose <= "10"; --lost
					else
						is_counting <= '1';
						win_lose <= "11";
						if ((counter_ms rem 50000) = 0) then --1 milli second
							current_count <= count + 1;
							count := count + 1;
							counter_ms := counter_ms + speed;
						else 
							counter_ms := counter_ms + speed;
						end if;
					end if;
				when won =>
					is_counting <= '0';
					win_lose <= "01";
					reaction_time <= count;
				when lost =>
					is_counting <= '0';
					win_lose <= "10";
					reaction_time <= lose_ms;		
			end case;
			
	end if;
end process;

process(current_state, is_counting, win_lose)
begin
	case current_state is
		when pre_start =>
			if is_counting = '1' then
				next_state <= counting;
			else
				next_state <= pre_start;
			end if;
		when counting =>
			if win_lose = "01" then
				next_state <= won;
			elsif win_lose = "10" then
				next_state <= lost;
			else
				next_state <= counting;
			end if;
		when won =>
			--wait for restart
			next_state <= won;
		when lost =>
			--wait for restart
			next_state <= lost;
	end case;
end process;

end Behavior;
