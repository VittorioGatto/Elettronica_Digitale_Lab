library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count9 is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			Q: buffer unsigned(3 downto 0)
		 );
end count9;

architecture Behavior of count9 is

-- 50MHz -> 20 ns clock
-- (50*10^6 Hz)/1Hz = 50000000
	

signal count: integer := 0;

begin
process(clk, enable, clear)
	variable tmp: unsigned(3 downto 0);
	begin
	if clear = '0' then
		count <= 0;
		tmp := (others => '0');
		
	elsif enable = '1' then
		if rising_edge(clk) then
		
			count <= count + speed; --default
			
			if tmp = "1010" then --10
				count <= 0;
				tmp := "0000"; --restarts at 0
			elsif count = 50000000 then
				count <= 0;
				tmp := tmp + 1;		
			end if;
		end if;
	end if;
	
	Q <= tmp;
end process;

end Behavior;
			
