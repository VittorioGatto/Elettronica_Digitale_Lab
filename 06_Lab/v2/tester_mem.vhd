library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tester_mem is
end tester_mem;

architecture Test of tester_mem is

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

--data file signals
signal mode_file: std_logic := '0'; --read file 0, write file 1
signal error_read: signed(7 downto 0); --error read from file

--CU signals
signal clk: std_logic := '0';
signal enable: std_logic := '1';
signal read_writen: std_logic := '0';
signal current_address: unsigned(9 downto 0) := "0000000000"; --current address reading/writing
signal error_evaluated: signed(7 downto 0); --error evaluated from processing

signal error_bitvector: bit_vector(7 downto 0);

begin
	error_bitvector <= to_bitvector(std_logic_vector(error_evaluated));
	
	DUT: MEM port map(clk, std_logic_vector(current_address), enable, read_writen, error_read, error_evaluated); 
	
	clk <= not clk after 10 ns;
	
process
	variable vec_line : line;
   variable tmp_out: bit_vector(7 downto 0);
   file data_file: text;
	
	begin
		enable <= '0';
		current_address <= (others => '0');
		
		wait for 1000 ns;
		
		enable <= '1';
		mode_file <= '0'; --read file
		read_writen <= '0'; --write memory
		
		file_open(data_file, "test_data_in.txt", read_mode);
		while (current_address < 1023) and (not endfile(data_file)) loop
			current_address <= current_address + 1;
			
			readline (data_file, vec_line);
			read(vec_line, tmp_out);
			
			error_read <= signed(to_stdlogicvector(tmp_out));
			wait for 20 ns; --trick to simulate clock
		end loop;
		file_close(data_file);
		
		current_address <= (others => '0');
		
		wait for 1000 ns;
		
		mode_file <= '1'; --write from mem to file
		read_writen <= '1'; --read memory
		
		---
		file_open(data_file, "test_data_out.txt", write_mode);
		
		for i in 0 to 1023 loop --write external file
			current_address <= to_unsigned(i, current_address'length);
			wait for 20 ns; --trick to simulate clock
			
			write (vec_line, error_bitvector);
			writeline (data_file, vec_line);
			
		end loop;
		
		file_close(data_file);
		---
		
		wait for 1000 ns;
		
		current_address <= (others => '0');
		mode_file <= '0';
		enable <= '0';
		
		wait for 1000 ns;
end process;

end Test;	

