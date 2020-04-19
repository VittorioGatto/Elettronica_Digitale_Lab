library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockCounter1Hz is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			speed: in integer range 1 to 1000000; --1000000 for simulation = 50 clocks 1000 ns
			terminal_count: out std_logic
		 );
end ClockCounter1Hz;

--Behavior of counter
architecture Behavior of ClockCounter1Hz is

begin
process(clk, resetn, enable)
	variable counter: integer range 0 to 50000000 := 0;
	begin
		if rising_edge(clk) then
			if resetn = '0' then
				terminal_count <= '0';
				counter := 0;
			elsif enable = '1' then
				terminal_count <= '0'; --default
				
				if counter >= 49999999 then --1Hz
					counter := 0;
					terminal_count <= '1';
				else
					counter := counter + speed;
				end if;
			end if;
		end if;
end process;
end Behavior;