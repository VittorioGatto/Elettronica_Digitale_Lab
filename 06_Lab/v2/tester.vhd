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
		  done_testing: in std_logic; --tells CU to wait the new start input
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
signal end_test: std_logic := '0';
signal error_evaluated: signed(7 downto 0); --error evaluated from processing
signal status: std_logic_vector(1 downto 0);

signal error_bitvector: bit_vector(7 downto 0);

begin
	error_bitvector <= to_bitvector(std_logic_vector(error_evaluated));
	
	DUT: CU port map(resetn, start_in, clk, std_logic_vector(current_address), start_process, end_test, error_read, error_evaluated, status);
	
	clk <= not clk after 10 ns;--50 MHz clock
	
process
	variable vec_line : line;
   variable tmp_out: bit_vector(7 downto 0);
   file data_file: text;
	
	begin
		resetn <= '0';
		start_process <= '0';
		end_test <= '0';
		current_address <= (others => '0');
		
		wait for 20 ns;
		
		resetn <= '1';
		start_in <= '1';
		wait until status = "00";
		
		mode_file <= '0'; --read file
		
		file_open(data_file, "test_data_in_bit.txt", read_mode);
		while (current_address < 1024) and (not endfile(data_file)) loop
			
			readline (data_file, vec_line);
			read(vec_line, tmp_out);
			
			error_read <= signed(to_stdlogicvector(tmp_out));
			
			if current_address = 1022 then
		    start_process <= '1';
		  else
		    start_process <= '0';
		  end if;
		    
			wait for 20 ns; --trick to simulate clock
			current_address <= current_address + 1;
		end loop;
		
		file_close(data_file);
		
		wait for 20 ns;
		
		current_address <= (others => '0');
		
		wait until status = "10";
		
		mode_file <= '1';--write file
		start_process <= '0';
		
		---
		
		file_open(data_file, "test_data_out.txt", write_mode);
		
		while (current_address < 1024) loop
			
			wait until rising_edge(clk);
			
			write (vec_line, error_bitvector);
			writeline (data_file, vec_line);
			
			if current_address = 1023 then
		    end_test <= '1';
		  else
		    end_test <= '0';
		  end if;
			
			current_address <= current_address + 1;
		end loop;
		
		file_close(data_file);
		
		wait for 20 ns;
		
		current_address <= (others => '0');
		
	  wait until status = "11";
	  
	  mode_file <= '0';
	  end_test <= '0';
		

    wait for 100 ns;
    
		start_in <= '0'; --restart
		
		wait until status = "00";
end process;

end Test;	

