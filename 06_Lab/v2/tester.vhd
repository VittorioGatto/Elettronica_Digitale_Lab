library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tester is
end tester;

architecture Test of tester is

component CU
  port( resetn_in, start_in, clock_in: in std_logic;
		  address: in std_logic_vector(9 downto 0); --address to read/write from outside
		  start_process: in std_logic; --tells CU to start processing data (1)
        data_in: in signed(7 downto 0);
		  data_out: out signed(7 downto 0);
		  --status 00: waiting data_in to be written in mem_a
		  --status 01: processing and writing mem_b
		  --status 10: done processing, reading out mem_b
		  --status 11: waiting to start/ idle
        status: out std_logic_vector(1 downto 0)
      );
end component;

--data file signals
signal mode_file: std_logic := '0'; --read file 0, write file 1
signal error_read: signed(7 downto 0); --error read from file

--CU signals
signal clk: std_logic := '0';
signal resetn: std_logic := '0';
signal start_in: std_logic := '0';
signal current_address: unsigned(9 downto 0) := "0000000000"; --current address reading/writing
signal start_process: std_logic := '0';
signal error_evaluated: signed(7 downto 0); --error evaluated from processing
signal status: std_logic_vector(1 downto 0);

signal error_bitvector: bit_vector(7 downto 0);

begin
	error_bitvector <= to_bitvector(std_logic_vector(error_evaluated));
	
	DUT: CU port map(resetn, start_in, clk, std_logic_vector(current_address), start_process, error_read, error_evaluated, status);
	
	clk <= not clk after 10 ns;
	
process
	variable vec_line : line;
   variable tmp_out: bit_vector(7 downto 0);
   file data_file: text is in "test_data_in.txt";
	
	begin
		resetn <= '0';
		start_process <= '0';
		current_address <= (others => '0');
		
		wait for 20 ns;
		
		resetn <= '1';
		start_in <= '1';
		wait until status = "00";
		
		mode_file <= '0'; --read file
		while (current_address < 1023) and (not endfile(data_file)) loop
			current_address <= current_address + 1;
			
			readline (data_file, vec_line);
			read(vec_line, tmp_out);
			
			error_read <= signed(to_stdlogicvector(tmp_out));
			wait for 20 ns; --trick to simulate clock
		end loop;
		
		current_address <= (others => '0');
		start_process <= '1';
		
		wait until status = "10";
		
		mode_file <= '1';
		
		for i in 0 to 1023 loop --write external file
			current_address <= to_unsigned(i, current_address'length);
			wait for 20 ns;
		end loop;
		
		wait for 20 ns;
		
		current_address <= (others => '0');
		mode_file <= '0';
		start_in <= '0'; --restart
		
		wait for 20 ns;
end process;

WRITE_FILE: process(error_bitvector, mode_file)
	variable vec_line : line;
   file data_file: text;
	begin
		if mode_file = '1' then
			file_open(data_file, "test_data_out.txt", write_mode);
			
			write (vec_line, error_bitvector);
			writeline (data_file, vec_line);
			
			file_close(data_file);
		end if;
end process;

end Test;	

