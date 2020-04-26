library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturation is
	generic(nbit: integer := 12); -- must be more than 8
	port(
			data_in: in signed(nbit-1 downto 0);
			data_out: out signed(7 downto 0)
		 );
end entity;

architecture Behavior of Saturation is

signal sign: std_logic_vector(nbit-2 downto 7); --sign of result
signal overflow: std_logic_vector(nbit-2 downto 7);
constant true: std_logic_vector(nbit-2 downto 7) := (others => '1'); --simple bit 1 in n bits

begin 

sign <= (others => data_in(nbit-1)); --takes sign

--The principle is that every value superior to 127 or inferior to -128
--should have all 0's or 1's in range (nbit-2 downto 7), this 
--checks if nbit-2 downto 7 are all 0's(positive) or 1's(negative)
--if they are, overflow returns 1111...
overflow <= sign XNOR std_logic_vector(data_in(nbit-2 downto 7));

process(data_in, overflow)
	begin
	
	if overflow = true then
		data_out <= resize(data_in, 8);
	else
		if data_in(nbit-1) = '0' then --positive
			data_out <= "01111111";
		else --negative
			data_out <= "10000000";
		end if;
	end if;
end process;
end Behavior;
				