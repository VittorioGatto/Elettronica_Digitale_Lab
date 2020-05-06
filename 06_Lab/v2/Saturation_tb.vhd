library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturation_tb is
end Saturation_tb;

architecture Test of Saturation_tb is

component Saturation
	port(
			data_in: in signed(19 downto 0);
			overflow: out std_logic_vector(1 downto 0)
		 );
end component;

constant n: integer := 20;
signal data_in: signed(n-1 downto 0);
signal overflow: std_logic_vector(1 downto 0);

begin

DUT: Saturation port map(data_in, overflow);

process
	begin
	data_in <= to_signed(129, n);--10
	wait for 10 ns;
	data_in <= to_signed(300, n);--10
	wait for 10 ns;
	data_in <= to_signed(50, n);--00
	wait for 10 ns;
	data_in <= to_signed(-150, n);--11
	wait for 10 ns;
	data_in <= to_signed(-30, n);--01
	wait for 10 ns;
	data_in <= to_signed(-129, n);--11
	wait for 10 ns;
	data_in <= to_signed(127, n);--00
	wait for 10 ns;
end process;

end Test;