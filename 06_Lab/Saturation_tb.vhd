library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Saturation_tb is
end Saturation_tb;

architecture Test of Saturation_tb is

component Saturation
	generic(nbit: integer := 12);
	port(
			data_in: in signed(nbit-1 downto 0);
			data_out: out signed(7 downto 0)
		 );
end component;

constant n: integer := 12;
signal data_in: signed(n-1 downto 0);
signal data_out: signed(7 downto 0);

begin

DUT: Saturation generic map(n)
						 port map(data_in, data_out);

process
	begin
	data_in <= to_signed(129, n);
	wait for 10 ns;
	data_in <= to_signed(300, n);
	wait for 10 ns;
	data_in <= to_signed(50, n);
	wait for 10 ns;
	data_in <= to_signed(-150, n);
	wait for 10 ns;
	data_in <= to_signed(-30, n);
	wait for 10 ns;
	data_in <= to_signed(-128, n);
	wait for 10 ns;
	data_in <= to_signed(127, n);
	wait for 10 ns;
end process;

end Test;