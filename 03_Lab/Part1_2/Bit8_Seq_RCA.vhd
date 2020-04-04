library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--8 bit sequential RCA
entity Bit8_Seq_RCA is
	port(
			A, B: in signed(7 downto 0);
			opcode: in std_logic; -- 0 addition 1 subtraction
			Clock: in std_logic;
			Resetn: in std_logic; -- push button defaults this to 1
			Overflow: out std_logic;
			S: out signed(7 downto 0)
		 );
end Bit8_Seq_RCA;

architecture Structure of Bit8_Seq_RCA is

component ALU_power4
	generic(n: integer:=8);
	port(
			a, b: in signed(n-1 downto 0);
			c_in: in std_logic;
			opcode: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			status: out std_logic;
			s: out signed(n-1 downto 0)
		 );
end component;

component regn
	generic(n: integer:=8);
	port(
			R: in signed(n-1 downto 0);
			Clock, Resetn: in std_logic;
			Q: out signed(n-1 downto 0)
		  );
end component;

component flipflop
	generic(n: integer:=8);
	port(
			D, Clock, Resetn: in std_logic;
			Q: out std_logic
		  );
end component;

signal A_in, B_in: signed(7 downto 0);
signal status: std_logic;
signal S_out: signed(7 downto 0);

begin
	ALU: ALU_power4
		  generic map(8)
		  port map(A_in, B_in, '0', opcode, open, open, status, S_out);
		  
	REGA: regn 
			generic map(8)
			port map(A, Clock, Resetn, A_in);
	
	REGB: regn 
			generic map(8)
			port map(B, Clock, Resetn, B_in);
	
	REG_SUM: regn 
			generic map(8)
			port map(S_out, Clock, Resetn, S);
			
	FF_OVERFLOW: flipflop port map(status, Clock, Resetn, Overflow);

end Structure;