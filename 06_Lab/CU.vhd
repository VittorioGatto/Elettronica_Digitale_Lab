library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.state_types.all;

entity CU is
	generic(n: integer:=20);
  port( resetn_in, start_in, clock_in: in std_logic;
        data_in: in signed(7 downto 0); 
        done_out: out std_logic
      );
end CU;

architecture Behavior of CU is
  component DataPath
	generic(n: integer:=20);
  port( current_error: in signed(7 downto 0);
        clock, resetn: in std_logic;
        MUX_sel: in std_logic_vector(2 downto 0);
        sub_sumn, LOADe_k, LOADe_k1, LOADP, LOADsum, LOADI, LOADdif, LOADD, LOADS1, LOADS2, ENABLEcnt: in std_logic;
        controlled_saturation: in std_logic_vector(1 downto 0);
        cnt: buffer signed(n-1 downto 0);
        check_saturation: out std_logic_vector(1 downto 0);
        current_output: out signed(7 downto 0)
      );
  end component;
  
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
  
  signal y_Q,  Y_D : state_type; --present state, next state
  signal internal_resetn: std_logic;--internal reset, useful to reset the counter
  signal counter: signed(n-1 downto 0);--count the steps
  signal CS, CSn, r_wn: std_logic;--MEM controls
  signal data_out, e_current, u_current: signed(7 downto 0);--internal signals
  signal MUX_selector: std_logic_vector(2 downto 0);--MUXes selector
  signal operation, Le_k, Le_k1, LP, Lsum, LI, Ldif, LD, LS1, LS2, ENcnt: std_logic;--DataPath controls
  signal saturation_received, saturation_decision: std_logic_vector(1 downto 0);--saturation controls
  
  begin
    
  MEM_A: MEM port map (clock_in, std_logic_vector(counter(9 downto 0)), CS, r_wn, data_in, e_current);
  MEM_B: MEM port map (clock_in, std_logic_vector(counter(9 downto 0)), CSn, r_wn, u_current, data_out);
    
  DP: DataPath port map (e_current, clock_in, internal_resetn, MUX_selector, operation, Le_k, Le_k1, LP, Lsum, LI, Ldif, LD, LS1, LS2, ENcnt,
                         saturation_decision, counter, saturation_received, u_current);
    
  ClockProcess: process(clock_in)
	begin
		if rising_edge(clock_in) then
			if resetn_in = '0' then
				y_Q <= IDLE; --restart
			elsif start_in ='1' then
				y_Q <= Y_D; --go
			end if;
		end if;
  end process;
  
  
  StateUpdateProcess: process(y_Q)
	begin
		case y_Q is
			when IDLE =>
			  Y_D <= WRITE_A;
			  
			when WRITE_A =>
			  if counter(9 downto 0) = "1111111111" then
					Y_D <= DONE_A;
				else 
					Y_D <= WRITE_A;
				end if;
			
			when DONE_A =>
			  Y_D <= READ_EK;
			  
			when READ_EK =>
			  Y_D <= BLOCK_P;
			  
			when BLOCK_P =>
			  Y_D <= BLOCK_I;
			  
			when BLOCK_I =>
			  Y_D <= BLOCK_D;
			  
			when BLOCK_D =>
			  Y_D <= BLOCK_S1;
			  
			when BLOCK_S1 =>
			  Y_D <= BLOCK_S2;
			  
			when BLOCK_S2 =>
			  Y_D <= SAT_CONTROL;
			  
			when SAT_CONTROL =>
			  Y_D <= WRITE_B;
			  
			when WRITE_B =>
			  if counter(9 downto 0) = "1111111111" then
					Y_D <= DONE_B;
				else 
					Y_D <= WRITE_B;
				end if;
			
			when DONE_B =>
			  if start_in = '0' then
			    Y_D <= IDLE;
			  else
			    Y_D <= DONE_B;
			  end if;
			  
			when others =>
			  Y_D <= IDLE;
			  
		end case;  
	end process;
	
			  
	OutputProcess: process(y_Q)
	begin
		--default stuff
		internal_resetn <= '1'; --default condition: inactive reset
		CS <= '1';    
		CSn <= NOT CS;--MEM_B works when MEM_A does not
		r_wn <= '1';  --default condition: read from MEM_A
		
		MUX_selector <= "000";--MUXes that select operators
		saturation_decision <= "00";--default condition: no overflow, positive number
		
		operation <= '0';--default condition: sum
		ENcnt <= '0';--default condition: do not count
		Le_k <= '0';--default conditions: all the registers can not load
		LP <= '0';
		Lsum <= '0';
		LI <= '0';			
		Ldif <= '0';	 
		LD <= '0';
		LS1 <= '0';
		LS2 <= '0';
		done_out <= '0';--default output: not finished yet
				
		case y_Q is
				when IDLE =>
				  internal_resetn <= '0';
				
				when WRITE_A =>
				  r_wn <= '0';  --write in MEM_A
				  MUX_selector <= "101";
				  ENcnt <= '1';
				  
				when DONE_A =>
				  internal_resetn <= '0'; --reset the counter to restart it
				  
				when READ_EK =>
				  Le_k <= '1';  --load e_k
				  
				when BLOCK_P =>
				  LP <= '1';    --load P
				  operation <= '1'; --difference
				  
				when BLOCK_I =>
				  MUX_selector <= "001";
				  Lsum <= '1';

				when BLOCK_D =>
				  MUX_selector <= "010";
				  LI <= '1';			
				  Ldif <= '1';	 
				  operation <= '1'; --difference 
				
				when BLOCK_S1 =>
				  MUX_selector <= "011";
				  LD <= '1';
				  LS1 <= '1';
				  
				when BLOCK_S2 =>
				  MUX_selector <= "100";
				  LS2 <= '1';
				  
				when SAT_CONTROL =>
				  saturation_decision <= saturation_received;
				  
				when WRITE_B =>
				  r_wn <= '0';
				  CS <= '0';  --write in MEM_B
				  MUX_selector <= "101";
				  ENcnt <= '1'; --increment counter
				
				when DONE_B =>
				  done_out <= '1';
				 
			  when others => 
				  
		end case;
		
  end process;
  
end Behavior;