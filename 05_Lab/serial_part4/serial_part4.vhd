library ieee;
use ieee.std_logic_1164.all;
use work.serial_state_types.all;

entity serial_part4 is
	port(
			CLOCK_50: in std_logic;
			KEY0: in std_logic; --resetn
			KEY1: in std_logic; --enable
		   HEX7_0: out std_logic_vector(55 downto 0)
		 );
end serial_part4;

architecture Behavior of serial_part4 is

component ClockCounter1Hz is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			speed: in integer range 1 to 1000000;
			terminal_count: out std_logic
		 );
end component;

component shift_reg56 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic; --tells registers to load
			closed_loop: in std_logic;--tells if the loop must be closed
			serial_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(55 downto 0)
		);
end component;

signal y_Q,  Y_D : HELLO_type; --present state, next state
signal change_state: std_logic; --changes state if 1

signal load, closed_loop: std_logic; --tells registers to load, closed loop feedback
signal serial_input: std_logic_vector(0 to 6); --input chain of registers

begin 

TIMER: ClockCounter1Hz port map(CLOCK_50, KEY0, KEY1, 1000, change_state);

--Shift register
SHIFT_REG: shift_reg56 port map(CLOCK_50, KEY0, load, closed_loop, serial_input, HEX7_0);
										 
ClockProcess: process(CLOCK_50)
	begin
		if rising_edge(CLOCK_50) then
			if KEY0 = '0' then
				y_Q <= IDLE; --reset
			elsif KEY1 ='1' then
				y_Q <= Y_D; --enable
			end if;
		end if;
end process;

StateUpdateProcess: process(change_state, y_Q)
	begin
		case y_Q is
			when IDLE =>
				Y_D <= H;
			
			--load states (these states load the letters before shifting them all)
			when H =>
				if change_state = '1' then
					Y_D <= E;
				else 
					Y_D <= H;
				end if;
				
			when E =>
				if change_state = '1' then
					Y_D <= L1;
				else 
					Y_D <= E;
				end if;
				
			when L1 =>			  
				if change_state = '1' then
					Y_D <= L2; 
				else
					Y_D <= L1;
				end if;
				
			when L2 =>
				if change_state = '1' then
					Y_D <= O; 
				else 
					Y_D <= L2;
				end if;
				
			when O =>
				if change_state = '1' then
					Y_D <= X1; 
				else 
					Y_D <= O;
				end if;
				
			when X1 =>
				if change_state = '1' then
					Y_D <= X2; 
				else 
					Y_D <= X1;
				end if;
				
			when X2 =>
				if change_state = '1' then
					Y_D <= X3; 
				else 
					Y_D <= X2;
				end if;
				
			when X3 =>
				if change_state = '1' then
					Y_D <= SHIFT; 
				else 
					Y_D <= X3;
				end if;
			
			--This state shifts indefinitely 
			when SHIFT =>
			   Y_D <= SHIFT; 
				
			when others =>
				Y_D <= IDLE; 

		end case;
end process;

OutputProcess: process(y_Q, change_state)
	begin
		--default stuff
		load <= change_state;
		closed_loop <= '0';
		serial_input <= "1111111";	
		
		case y_Q is
				when IDLE =>
				when H =>
					serial_input <= "0001001";
				when E =>
				  serial_input <= "0000110";
				when L1 =>			  
				  serial_input <= "1000111";
				when L2 =>
				  serial_input <= "1000111";
				when O =>
				  serial_input <= "1000000";
				when X1 =>
				when X2 =>	
				when X3 =>
				when SHIFT =>
					closed_loop <= '1';
				when others =>
		end case;
end process;

end Behavior;
