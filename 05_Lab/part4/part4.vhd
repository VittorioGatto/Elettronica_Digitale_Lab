library ieee;
use ieee.std_logic_1164.all;
use work.State_types.all;

entity part4 is
	port(
			clk: in std_logic;
			KEY0: in std_logic; --resetn
			KEY3: in std_logic; --enable
		   HEX7_0: out std_logic_vector(0 to 55)
		 );
end part4;

architecture Behavior of part4 is

component ClockCounter1Hz
	port(
			clk: in std_logic;
			resetn: in std_logic;
			enable: in std_logic;
			speed: in integer range 1 to 1000000;
			terminal_count: out std_logic
		 );
end component;

component shift_reg56
	port(
			clk: in std_logic;
			resetn: in std_logic;
			load: in std_logic;
			writen_shift: in std_logic; --0 if parallel load, 1 if shift
			parallel_load_data_in: in std_logic_vector(0 to 55);
			data_out: buffer std_logic_vector(0 to 55)
		);
end component; 


signal y_Q,  Y_D : HELLO_type; --present state, next state
signal change_state: std_logic; --changes state if 1

signal load: std_logic; --tells registers to load
signal writen_shift: std_logic; --0 for parallel load, 1 for shift
signal segs: std_logic_vector(0 to 55);

begin 

-- HELLO = 0001001 0000110 1000111 1000111 1000000
segs(21 to 55) <= "00010010000110100011110001111000000";
segs(0 to 20) <= (others => '1');


--clock for 1 second
COUNT_1HZ: ClockCounter1Hz port map(clk, KEY0, KEY3, 1000000, change_state);

--Shift register
SHIFT_REG: shift_reg56 port map(clk, KEY0, load, writen_shift, segs, HEX7_0);
										 
ClockProcess: process(clk, KEY0, KEY3)
	begin
		if rising_edge(clk) then
			if KEY0 = '0' then
				y_Q <= idle;
			elsif KEY3 ='1' then
				y_Q <= Y_D;
			end if;
		end if;
end process;

StateUpdateProcess: process(change_state, y_Q)
	begin
		load <= change_state;
		
		case y_Q is
			when idle =>
				Y_D <= start;
				load <= '1'; --forces registers to parallel load in next state
			when start =>
				if change_state = '1' then
					Y_D <= shift1; 
				else 
					Y_D <= start;
				end if;
			when shift1 =>
				if change_state = '1' then
					Y_D <= shift2; 
				else
					Y_D <= shift1;
				end if;
			when shift2 =>
				if change_state = '1' then
					Y_D <= shift3; 
				else 
					Y_D <= shift2;
				end if;
			when shift3 =>
				if change_state = '1' then
					Y_D <= shift4; 
				else 
					Y_D <= shift3;
				end if;
			when shift4 =>
				if change_state = '1' then
					Y_D <= shift5; 
				else 
					Y_D <= shift4;
				end if;
			when shift5 =>
				if change_state = '1' then
					Y_D <= shift6; 
				else 
					Y_D <= shift5;
				end if;
			when shift6 =>
				if change_state = '1' then
					Y_D <= shift7; 
				else 
					Y_D <= shift6;
				end if;
			when shift7 =>
				if change_state = '1' then
					Y_D <= shift8; 
				else 
					Y_D <= shift7;
				end if;
			when shift8 =>
				if change_state = '1' then
					Y_D <= start; 
				else 
					Y_D <= shift1;
				end if;
		end case;
end process;

OutputProcess: process(y_Q)
	begin
		case y_Q is
			when idle =>
				writen_shift <= '0';
			when start =>
				writen_shift <= '1';
			when others =>
				writen_shift <= '1';
		end case; 
end process;

end Behavior;