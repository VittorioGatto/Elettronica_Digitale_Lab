library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturation is
	port(
			data_in: in signed(19 downto 0); --we take only MSB bits to check overflow
			--00 not overflow, positive number
			--01 not overflow, negative number
			--10 overflow, positive number
			--11 overflow, negative number
			overflow: out std_logic_vector(1 downto 0)
		 );
end entity;

architecture Behavior of Saturation is

signal sign: std_logic_vector(18 downto 7); --sign of result
signal overflow_detect: std_logic_vector(18 downto 7);
constant ones: std_logic_vector(18 downto 7) := (others => '1'); --simple vector of ones

begin 

sign <= (others => data_in(19)); --takes sign

--The principle is that every value superior to 127 or inferior to -128
--should have all 0's or 1's in range (nbit-2 downto 7), this 
--checks if nbit-2 downto 7 are all 0's(positive) or 1's(negative)
--if they are, overflow returns 1111...
overflow_detect <= sign XNOR std_logic_vector(data_in(18 downto 7));

process(data_in, overflow_detect)
	begin
	
	if overflow_detect = ones then --not overflow
		if data_in(19) = '0' then --positive
			overflow <= "00";
		else 							  --negative
			overflow <= "01";
		end if;

	else 									--overflow detected
		if data_in(19) = '0' then --positive
			overflow <= "10";
		else 							  --negative
			overflow <= "11";
		end if;
	end if;

end process;
end Behavior;
				