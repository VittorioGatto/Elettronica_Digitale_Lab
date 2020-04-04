library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
	generic(n: integer:=8);
	port(
			D, Clock, Resetn: in std_logic;
			Q: out std_logic
		  );
end flipflop;

architecture Behavior of flipflop is
begin
	process(Clock, Resetn)
	begin
		if(Resetn = '0') then -- asynchronous clear
			Q <= '0';
			
		elsif(Clock'event and Clock = '1') then
			Q <= D;
		end if;
	end process;
end Behavior;