library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_tb is
end MEM_tb;

architecture Test of MEM_tb is

component MEM
	port(
			clk: in std_logic;
			reg_addr: in std_logic_vector(9 downto 0);
			enable: in std_logic; --chip select
			read_writen: in std_logic; --1 read, 0 write
			data_in: in signed(7 downto 0);
			data_out: out signed(7 downto 0)
		 );
end component;

signal clk: std_logic := '0';
signal reg_addr: std_logic_vector(9 downto 0);
signal enable: std_logic := '1'; --chip select
signal read_writen: std_logic := '0'; --1 read, 0 write
signal data_in: signed(7 downto 0);
signal data_out: signed(7 downto 0);

begin

clk <= not clk after 10 ns;

DUT: MEM port map(clk, reg_addr, enable, read_writen, data_in, data_out);

process
	begin
	--write phase
	read_writen <= '0';
	reg_addr <= "0000000001";
	data_in <= to_signed(2, data_in'length);
	wait for 10 ns;
	reg_addr <= "0000000010";
	data_in <= to_signed(5, data_in'length);
	wait for 10 ns;
	reg_addr <= "0000000011";
	data_in <= to_signed(10, data_in'length);
	--read phase
	wait for 10 ns;
	read_writen <= '1';
	reg_addr <= "0000000011";
	wait for 10 ns;
	reg_addr <= "0000000001";
	wait for 10 ns;
	reg_addr <= "0000000010";
	--check enable
	wait for 10 ns;
	enable <= '0';
	read_writen <= '0';
	reg_addr <= "0000000001";
	data_in <= to_signed(9, data_in'length);
	wait for 10 ns;
	read_writen <= '0';
	reg_addr <= "0000000011";
	data_in <= to_signed(29, data_in'length);
	wait for 10 ns;
end process;

end Test;
	
	

