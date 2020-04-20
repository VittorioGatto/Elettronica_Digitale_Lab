library ieee;
use ieee.std_logic_1164.all;

--Segments7 look up table (only for simulation purposes)
entity seg7_to_word is
	port(
			seg7: in std_logic_vector(0 to 55);
			word: out string(1 to 8)
		 );
end seg7_to_word;

architecture Behavior of seg7_to_word is

begin

process(seg7)
variable counter_segs: integer := 6;
	begin
		counter_segs := 6;
		for i in word'range loop
			if seg7(counter_segs-6 to counter_segs) = "0001001" then
				word(i) <= 'H';
			elsif seg7(counter_segs-6 to counter_segs) = "0000110" then
				word(i) <= 'E';
			elsif seg7(counter_segs-6 to counter_segs) = "1000111" then
				word(i) <= 'L';
			elsif seg7(counter_segs-6 to counter_segs) = "1000000" then
				word(i) <= 'O';
			else
				word(i) <= 'X'; -- blank space
			end if;
			
			counter_segs := counter_segs + 7;
		end loop;
		
end process;
end Behavior;