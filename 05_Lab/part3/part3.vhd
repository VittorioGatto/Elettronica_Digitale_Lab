library ieee;
use ieee.std_logic_1164.all;
use work.serial_tate_types.all;

entity part3 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			w: in std_logic;
			z: out std_logic;
			state: out State_type;
			state_decoded: buffer std_logic_vector(8 downto 0)
		 );
end part3;

architecture Behavior of part3 is

component StateLookUp
	port(
			current_state: in State_type;
			result: out std_logic_vector(8 downto 0)
		 );
end component;

signal y_Q,  Y_D  :  State_type; --present state, next state

begin 

state <= y_Q;

S_LUT: StateLookUp port map(current_state => y_Q, result => state_decoded);

ClockProcess: process(clk)
	begin
		if rising_edge(clk) then
		
			if resetn = '0' then
				y_Q <= A;
			else
				y_Q <= Y_D;
			end if;
			
		end if;
end process;

StateUpdateProcess: process(w, y_Q)
	begin
		case y_Q is
			when A =>
				if w = '0' then
					Y_D <= B; 
				else 
					Y_D <= F;
				end if;
			when B =>
				if w = '0' then
					Y_D <= C; 
				else 
					Y_D <= F;
				end if;
			when C =>
				if w = '0' then
					Y_D <= D; 
				else 
					Y_D <= F;
				end if;
			when D =>
				if w = '0' then
					Y_D <= E; 
				else 
					Y_D <= F;
				end if;
			when E =>
				if w = '0' then
					Y_D <= E; 
				else 
					Y_D <= F;
				end if;
			when F =>
				if w = '1' then
					Y_D <= G; 
				else 
					Y_D <= B;
				end if;
			when G =>
				if w = '1' then
					Y_D <= H; 
				else 
					Y_D <= B;
				end if;
			when H =>
				if w = '1' then
					Y_D <= I; 
				else 
					Y_D <= B;
				end if;
			when I =>
				if w = '1' then
					Y_D <= I; 
				else 
					Y_D <= B;
				end if;
		end case;
end process;

OutputProcess: process(y_Q)
	begin
		case y_Q is
			when E =>
				z <= '1';
			when I =>
				z <= '1';
			when others =>
				z <= '0';
		end case; 
end process;

end Behavior;