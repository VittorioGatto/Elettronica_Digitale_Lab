library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataPath_tb is
end DataPath_tb;

architecture Behavior of DataPath_tb is
  component DataPath
	generic(n: integer:=20);
  port( current_error: in signed(7 downto 0);
        clock, resetn: in std_logic;
        MUX_sel: in std_logic_vector(2 downto 0);
        sub_sumn, LOADe_k, LOADe_k1, LOADP, LOADsum, LOADI, LOADdif, LOADD, LOADS1, LOADS2, LOADu_k, ENABLEcnt: in std_logic;
        controlled_saturation: in std_logic_vector(1 downto 0);
        cnt: buffer signed(9 downto 0); 
        check_saturation: out std_logic_vector(1 downto 0);
        current_output: out signed(7 downto 0)
      );
  end component;

constant n: integer:=20;
signal e_in, u_out: signed(7 downto 0);
signal clk_in, res_in: std_logic;
signal sel_in: std_logic_vector(2 downto 0);
signal LDe_k, LDe_k1, LDP, LDsum, LDI, LDdif, LDD, LDS1, LDS2, LDu_k, ENcnt: std_logic;
signal sat_in: std_logic_vector(1 downto 0);
signal opcode: std_logic;
signal counter: signed(9 downto 0);


begin
  
	DUT: DataPath port map(e_in, clk_in, res_in, sel_in, opcode, LDe_k, LDe_k1, LDP, LDsum, LDI, LDdif, LDD, LDS1, LDS2, LDu_k, ENcnt, sat_in, counter, sat_in, u_out);
	  
  clock_gen: process
		begin
			clk_in <= '0', '1' after 10 ns; 
		wait for 20 ns; --50 MHz clock
	end process;
	
	TEST: process
	  begin
	    e_in <= "10100111", "00000001" after 175 ns, "01111111" after 315 ns;
	    res_in <= '0', '1' after 15 ns;
	   
	   	sel_in <= "000", "001" after 75 ns, "010" after 95 ns, "011" after 115 ns, "100" after 135 ns, "101" after 155 ns, --first number
	   	           "000" after 175 ns, "001" after 215 ns, "010" after 235 ns, "011" after 255 ns, "100" after 275 ns, "101" after 295 ns, --second number
	   	           "000" after 315 ns, "001" after 355 ns, "010" after 375 ns, "011" after 395 ns, "100" after 415 ns, "101" after 435 ns; --third number
	   	opcode <= '1', '0' after 75 ns, '1' after 95 ns, '0' after 115 ns,--first number
	   	          '1' after 175 ns, '0' after 215 ns, '1' after 235 ns, '0' after 255 ns, --second number
	   	          '1' after 315 ns, '0' after 355 ns, '1' after 375 ns, '0' after 395 ns; --third number
	   	          
	    --load e_k + block P

	    LDe_k <= '0', '1' after 35 ns, '0' after 55 ns, --first number
	                  '1' after 175 ns, '0' after 195 ns, --second number
	                  '1' after 315 ns, '0' after 335 ns; --third number
	    LDP <= '0', '1' after 55 ns, '0' after 75 ns, --first number
	                '1' after 195 ns, '0' after 215 ns, --second number
	                '1' after 335 ns, '0' after 355 ns; --third number

      --block I
      LDsum <= '0', '1' after 75 ns, '0' after 95 ns, --first number
                    '1' after 215 ns, '0' after 235 ns, --second number
	                  '1' after 355 ns, '0' after 375 ns; --third number
      LDI <= '0', '1' after 95 ns, '0' after 115 ns, --first number 
                  '1' after 235 ns, '0' after 255 ns, --second number
	                '1' after 375 ns, '0' after 395 ns; --third number
      
      --block D
      LDdif <= '0', '1' after 95 ns, '0' after 115 ns, --first number
                    '1' after 235 ns, '0' after 255 ns, --second number
	                  '1' after 375 ns, '0' after 395 ns; --third number
      LDD <= '0', '1' after 115 ns, '0' after 135 ns, --first number
                  '1' after 255 ns, '0' after 275 ns, --second number
	                '1' after 395 ns, '0' after 415 ns; --third number
      
      --block S1
      LDS1 <= '0', '1' after 115 ns, '0' after 135 ns, --first number
                   '1' after 255 ns, '0' after 275 ns, --second number
	                 '1' after 395 ns, '0' after 415 ns; --third number
      
      --block S2
      LDS2 <= '0', '1' after 135 ns, '0' after 155 ns, --first number
                   '1' after 275 ns, '0' after 295 ns, --second number
	                 '1' after 415 ns, '0' after 435 ns; --third number
	                 
	                 
	    --u_k
      LDu_k <= '0',  '1' after 155 ns, '0' after 175 ns, --first number
	                   '1' after 295 ns, '0' after 315 ns, --second number
	                   '1' after 435 ns, '0' after 455 ns; --third number
	    
	    --block count
	    LDe_k1 <= '0', '1' after 155 ns, '0' after 175 ns, --first number
	                   '1' after 295 ns, '0' after 315 ns, --second number
	                   '1' after 435 ns, '0' after 455 ns; --third number
	    ENcnt <= '0', '1' after 155 ns, '0' after 175 ns, --first number
	                  '1' after 295 ns, '0' after 315 ns, --second number
	                  '1' after 435 ns, '0' after 455 ns; --third number
	    
	    wait for 455 ns;
	  end process;
	  

end Behavior;