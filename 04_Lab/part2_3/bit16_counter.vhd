library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit16_counter is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			Q: buffer unsigned(15 downto 0)
		 );
end bit16_counter;

architecture Structure of bit16_counter is

component bit4_counter
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			Q: buffer unsigned(3 downto 0);
			enable_nth: out std_logic
		 );
end component;

signal enable_nth: std_logic_vector(3 downto 0); --nth T input

begin
	
	COUNT4_0: bit4_counter port map (enable, clk, clear, Q(3 downto 0), enable_nth(0));
	COUNT4_1: bit4_counter port map (enable_nth(0), clk, clear, Q(7 downto 4), enable_nth(1));
	COUNT4_2: bit4_counter port map (enable_nth(1), clk, clear, Q(11 downto 8), enable_nth(2));
	COUNT4_3: bit4_counter port map (enable_nth(2), clk, clear, Q(15 downto 12), enable_nth(3));
	
end Structure;

-- Pure Behavioral Approach
architecture Behavior of bit16_counter is

constant Q_compare: unsigned(15 downto 0) := (others => '1');

begin
process(clk, enable, clear)
	begin
	if clear = '0' then
		Q <= (others => '0');
		
	elsif enable = '1' then
		if rising_edge(clk) then
			case Q is
				when Q_compare => 
						Q <= (others => '0');
				when others =>
						Q <= Q + 1;
			end case;
		end if;
	end if;
end process;

end Behavior;

