library ieee;
use ieee.std_logic_1164.all;

--DFF synchronous
entity D_FF is
	port(
			clk, resetn, enable: in std_logic;
			D: in std_logic_vector(0 to 6);
			Q: out std_logic_vector(0 to 6)
		  );
end D_FF;

architecture Behavior of D_FF is
begin
	process(clk, resetn, enable)
	begin	
		if rising_edge(clk) then
			if resetn = '0' then --synchronous reset
				Q <= (others => '0');
			elsif enable = '1' then
				Q <= D;
			end if;
		end if;
	end process;
end Behavior;