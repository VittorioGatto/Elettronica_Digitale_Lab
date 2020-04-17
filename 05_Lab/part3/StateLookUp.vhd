library ieee;
use ieee.std_logic_1164.all;

--Behavioral implementation of look up table
entity StateLookUp is
	port(
			address: in integer range 0 to 8;
			result: out std_logic_vector(8 downto 0)
		 );
end StateLookUp;

architecture Behavior of StateLookUp is

begin
process(address)
	begin
		case address is
			when 0 => result <= "000000001";
			when 1 => result <= "000000010";
			when 2 => result <= "000000100";
			when 3 => result <= "000001000";
			when 4 => result <= "000010000";
			when 5 => result <= "000100000";
			when 6 => result <= "001000000";
			when 7 => result <= "010000000";
			when 8 => result <= "100000000";
			when others => result <= "000000001"; --reset
		end case;
end process;
end Behavior;