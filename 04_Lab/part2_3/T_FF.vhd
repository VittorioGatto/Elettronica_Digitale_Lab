library ieee;
use ieee.std_logic_1164.all;

--simple T FLIP FLOP
entity T_FF is
	port(
			clk, resetn: in std_logic;
			T: in std_logic;
			Q, Qbar: out std_logic
		);
end T_FF;

-- Behavioral approach
architecture Behavior of T_FF is

begin
process(clk, resetn)
	variable tmp: std_logic;
	begin
		if resetn = '0' then
			tmp := '0';
			
		elsif rising_edge(clk) then
				case T is
					when '0' =>
						tmp := tmp; -- retains value
					when '1' =>
						tmp := not tmp; -- toggles value
					when others =>
						tmp := '0';
				end case;
		end if;
		
		Q <= tmp;
		Qbar <= not tmp;
end process;
	
end Behavior;