library ieee;
use ieee.std_logic_1164.all;
use work.serial_state_types.all;

entity serial_part4 is
	port(
			CLOCK_50: in std_logic;
			KEY0: in std_logic; --resetn
			KEY1: in std_logic; --start_control
		  HEX7_0: out std_logic_vector(55 downto 0)
		 );
end serial_part4;

architecture Behavior of serial_part4 is

component time_counter is
	port(
			enable: in std_logic;
			clk: in std_logic;
			clear: in std_logic;
			speed: in integer; -- defines increment (real = 1, simulation = 1000)
			change: out std_logic
		 );
end component;

component shift_reg56 is
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic; --tells registers to load
			closed_loop: in std_logic;--tells if the loop must be closed
			s_in: in std_logic_vector(0 to 6);
			data_out: buffer std_logic_vector(55 downto 0)
		);
end component;

signal y_Q,  Y_D : HELLO_type; --present state, next state
signal change_state: std_logic; --changes state if 1

signal c_load, c_enable, c_resetn, c_loop: std_logic; --tells registers to load, counter to count, both to reset
signal c_speed: integer := 1000; --speed up simulation
signal segs_out: std_logic_vector(55 downto 0);
signal feedback: std_logic_vector(0 to 6);
signal serial_input: std_logic_vector(0 to 6);

begin 

TIMER: time_counter port map(c_enable, CLOCK_50, c_resetn, c_speed, change_state);

--Shift register
SHIFT_REG: shift_reg56 port map(CLOCK_50, c_resetn, c_load, c_loop, serial_input, segs_out);
  feedback <= segs_out(55 downto 49);
										 
ClockProcess: process(CLOCK_50)
	begin
		if rising_edge(CLOCK_50) then
			if KEY0 = '0' then
				y_Q <= IDLE;
			elsif KEY1 ='1' then
				y_Q <= y_D;
			end if;
		end if;
end process;

StateUpdateProcess: process(change_state, y_Q)
	begin
		case y_Q is
			when IDLE =>
				Y_D <= START;
				c_loop <= '0';
				c_load <= '0';
				c_enable <= '0';
				c_resetn <= '0';
				serial_input <= "1111111";
				
				when START =>
				Y_D <= H;
				c_loop <= '0';
				c_load <= '1';
				c_enable <= '1';
				c_resetn <= '1';
				serial_input <= "1111111";
				
			when H =>
				serial_input <= "0001001";
				c_loop <= '0';
				c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1'; 
					Y_D <= E;
				else 
				  c_load <= '0';
					Y_D <= H;
				end if;
				
			when E =>
			  serial_input <= "0000110";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= L1;
				else 
				  c_load <= '0';
					Y_D <= E;
				end if;
				
			when L1 =>			  
			  serial_input <= "1000111";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= L2; 
				else
				  c_load <= '0';
					Y_D <= L1;
				end if;
				
			when L2 =>
			  serial_input <= "1000111";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= O; 
				else 
				  c_load <= '0';
					Y_D <= L2;
				end if;
				
			when O =>
			  serial_input <= "1000000";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= X1; 
				else 
				  c_load <= '0';
					Y_D <= O;
				end if;
				
			when X1 =>
			  serial_input <= "1111111";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= X2; 
				else 
				  c_load <= '0';
					Y_D <= X1;
				end if;
				
			when X2 =>
			  serial_input <= "1111111";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= X3; 
				else 
				  c_load <= '0';
					Y_D <= X2;
				end if;
				
			when X3 =>
			  serial_input <= "1111111";
			  c_loop <= '0';
			  c_enable <= '1';
				c_resetn <= '1';
				if change_state'event and change_state = '1' then
				  c_load <= '1';
					Y_D <= LOCK; 
				else 
				  c_load <= '0';
					Y_D <= X3;
				end if;
				
			when LOCK =>
			  serial_input <= "1111111";
			  c_loop <= '1';
			  c_enable <= '1';
				c_resetn <= '1';
			  Y_D <= LOCK; 
				if change_state'event and change_state = '1' then
				  c_load <= '1';
				 else
				   c_load <= '0';
				end if;
				
			when others =>
				Y_D <= IDLE; 

		end case;
end process;

HEX7_0 <= segs_out;

end Behavior;