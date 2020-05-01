library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count1024 is
	port(
			clk, resetn: in std_logic;
			count: out unsigned(9 downto 0)
		 );
end count1024;

--Behavioral of counter
architecture Behavior of count1024 is

begin
process(clk, resetn)
	variable tmp: unsigned(9 downto 0);
	begin
			if resetn = '0' then
				tmp := 0;
			elsif rising_edge(clk) then
				if tmp < 1024 then
					tmp := count + 1;
				else
					--waiting to resetn
					tmp := 1023;
				end if;
			end if;
		   
			count <= tmp;
end process;
end Behavior;
			