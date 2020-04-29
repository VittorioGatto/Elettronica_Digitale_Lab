library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.state_types.all;

entity CU is
	generic(n: integer:=12);
  port( resetn_in, start_in, clock_in: in std_logic;
        done_out: out std_logic
      );
end CU;

architecture Behavior of CU is
  component DataPath
	generic(n: integer:=12);
  port( current_error: in signed(7 downto 0);
        clock, resetn: in std_logic;
        MUX_sel: in std_logic_vector(2 downto 0);
        sub_sumn, LOADe_k, LOADe_k1, LOADP, LOADsum, LOADI, LOADdif, LOADD, LOADS1, LOADS2, ENABLEcnt: in std_logic;
        cnt: buffer signed(n-1 downto 0);
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
  
  --componente per lettura file
  
  signal y_Q,  Y_D : state_type; --present state, next state
  signal change_state, internal_resetn: std_logic; --changes state if 1
  signal counter: signed(n-1 downto 0);
  signal CS_A, CS_B, r_wn_A, r_wn_B: std_logic;--MEM controls
  signal data_in, data_out, e_current, u_current: signed(7 downto 0);--internal signals
  signal MUX_selector: std_logic_vector(2 downto 0);--MUXes selector
  signal operation, Le_k, Le_k1, LP, Lsum, LI, Ldif, LD, LS1, LS2, ENcnt;--DataPath controls
  
  begin
    
  --lettura file
  MEM_A: MEM port map (clock_in, counter(9 downto 0), CS_A, r_wn_A, data_in, e_current);
  MEM_B: MEM port map (clock_in, counter(9 downto 0), CS_B, r_wn_B, u_current, data_out);
    
  DP: DataPath port map (e_current, clock_in, internal_resetn, MUX_selector, operation, Le_k, Le_k1, LP, Lsum, LI, Ldif, LD, LS1, LS2, ENcnt, counter, u_current);
    
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
  
  
  StateUpdateProcess: process(change_state, y_Q)
	begin
		case y_Q is
			when IDLE =>
  
end Behavior;