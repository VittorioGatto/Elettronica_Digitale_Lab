library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regn is
	generic(n: integer:=20);
	port(
			R: in signed(n-1 downto 0);
			Clock, Resetn, Load: in std_logic;
			Q: out signed(n-1 downto 0)
		  );
end regn;

architecture Behavior of regn is
begin
	process(Clock)
	begin			
		if rising_edge(Clock) then
		  
		  	if(Resetn = '0') then
			   Q <= (others => '0');
			 elsif(Load = '1') then
			   Q <= R;
		   end if;
		   
		end if;	   
	end process;
end Behavior;