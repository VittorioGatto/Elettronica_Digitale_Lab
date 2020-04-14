library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--simple binary to bcd converter for numbers up to 9999 (thousands, hundreds, dozenz, units)
--Double Dabble Algorithm
entity binaryToBCD is
	port(
		   binary_in: in std_logic_vector(13 downto 0);
			bcd_out: out std_logic_vector(15 downto 0) --thousands, hundreds, dozenz, units (4 bits for each)
		 );
end binaryToBCD;

architecture Behavior of binaryToBCD is

begin

process(binary_in)

variable binary_temp: unsigned(13 downto 0);
variable bcd: unsigned(15 downto 0);

begin
	binary_temp(13 downto 0) := unsigned(binary_in);
	
	bcd(15 downto 0) := (others => '0');
	
	for i in 13 downto 0 loop
		
		if bcd(15 downto 12) > 4 then
			bcd(15 downto 12) := bcd(15 downto 12) + 3;
		end if;
		
		if bcd(11 downto 8) > 4 then
			bcd(11 downto 8) := bcd(11 downto 8) + 3;
		end if;
		
		if bcd(7 downto 4) > 4 then
			bcd(7 downto 4) := bcd(7 downto 4) + 3;
		end if;
		
		if bcd(3 downto 0) > 4 then
			bcd(3 downto 0) := bcd(3 downto 0) + 3;
		end if;
		
		bcd := shift_left(bcd, 1);
		bcd(0) := binary_temp(13);
		binary_temp := shift_left(binary_temp, 1);
		
	end loop;
	
	bcd_out <= std_logic_vector(bcd);
	
end process;
end Behavior;
	
	