library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regn is
	generic(n: integer:=8);
	port(
			R: in signed(n-1 downto 0);
			Clock, Resetn: in std_logic;
			Q: out signed(n-1 downto 0)
		  );
end regn;

architecture Behavior of regn is
begin
	process(Clock, Resetn)
	begin
		if(Resetn = '0') then
			Q <= (others => '0');
			
		elsif(Clock'event and Clock = '1') then
			Q <= R;
		end if;
	end process;
end Behavior;