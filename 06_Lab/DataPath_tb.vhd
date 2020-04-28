library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataPath_tb is
end DataPath_tb;

architecture Behavior of DataPath_tb is
  component DataPath
	generic(n: integer:=12);
  port( current_error: in signed(7 downto 0);
        clock, resetn: in std_logic;
        MUX_sel: in std_logic_vector(2 downto 0);
        sub_sumn, LOADe_k, LOADe_k1, LOADP, LOADsum, LOADI, LOADdif, LOADD, LOADS1, LOADS2, ENABLEcnt: in std_logic;
        current_output: out signed(7 downto 0)
      );
  end component;

constant n: integer:=12;
signal e_in, u_out: signed(7 downto 0);
signal clk_in, res_in: std_logic;
signal sel_in: std_logic_vector(2 downto 0);
signal LDe_k, LDe_k1, LDP, LDsum, LDI, LDdif, LDD, LDS1, LDS2, ENcnt: std_logic;
signal opcode: std_logic;


begin
  
	DUT: DataPath port map(e_in, clk_in, res_in, sel_in, opcode, LDe_k, LDe_k1, LDP, LDsum, LDI, LDdif, LDD, LDS1, LDS2, ENcnt, u_out);
	  
  clock_gen: process
		begin
			clk_in <= '0', '1' after 10 ns; 
		wait for 20 ns; --50 MHz clock
	end process;
	
	TEST: process
	  begin
	    e_in <= "10100111", "00000001" after 175 ns, "01111111" after 350 ns;
	    res_in <= '0', '1' after 15 ns;
	   
	   	sel_in <= "000", "001" after 75 ns, "010" after 95 ns, "011" after 115 ns, "100" after 135 ns, "101" after 155 ns;
	   	opcode <= '1', '0' after 75 ns, '1' after 95 ns, '0' after 115 ns;
	    --load e_k + block P

	    LDe_k <= '0', '1' after 35 ns, '0' after 55 ns;
	    LDP <= '0', '1' after 55 ns, '0' after 75 ns;

      --block I
      LDsum <= '0', '1' after 75 ns, '0' after 95 ns;
      LDI <= '0', '1' after 95 ns, '0' after 115 ns;
      
      --block D
      LDdif <= '0', '1' after 95 ns, '0' after 115 ns;
      LDD <= '0', '1' after 115 ns, '0' after 135 ns;
      
      --block S1
      LDS1 <= '0', '1' after 115 ns, '0' after 135 ns;
      
      --block S2
      LDS2 <= '0', '1' after 135 ns, '0' after 155 ns;
	    
	    --block count
	    LDe_k1 <= '0', '1' after 155 ns, '0' after 175 ns;
	    ENcnt <= '0', '1' after 155 ns, '0' after 175 ns;
	    
	    wait for 600 ns;
	  end process;
	  

end Behavior;