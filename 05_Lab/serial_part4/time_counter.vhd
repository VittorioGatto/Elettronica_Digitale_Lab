library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity time_counter is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			change: out std_logic
		 );
end time_counter;

architecture Behavior of time_counter is

-- 50MHz -> 20 ns clock
-- (50*10^6 Hz)/1Hz = 50000000	

signal count: integer := 0;

begin
process(clk)
  begin
    if rising_edge(clk) then
      
      if clear = '0' then
        change <= '0';
		    count <= 0;
		  
		  elsif enable = '1' then
			   count <= count + speed; --default	
			   change <= '0';
			   
			  
			   if count = 50000000 then
			     change <= '1';
			     count <= 0;--restart	
			   end if;
		  end if;
	end if;

end process;

end Behavior;
