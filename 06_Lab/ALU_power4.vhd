library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Simplified ALU (can only add and subtract) that takes as inputs two signed numbers
--status: simplified status, 1 if operation results in overflow, 0 if else
--opcode: simplified opcode, 0 if addition, 1 if subtraction

entity ALU_power4 is
	generic(n: integer:=12); --n bits MUST BE MULTIPLE OF 4!!
	port(
			a, b: in signed(n-1 downto 0);
			c_in: in std_logic;
			opcode: in std_logic;
			c_carryin_last: buffer std_logic;
			c_out: buffer std_logic;
			status: out std_logic;
			s: out signed(n-1 downto 0)
		 );
end ALU_power4;

architecture Behavior of ALU_power4 is

component MUX2NtoN
	generic(n: integer:=12);
	port(
			x, y: in std_logic_vector((n-1) downto 0);
			s: in std_logic;
			m: out std_logic_vector((n-1) downto 0)
		 );
end component;

component RCA_power4
	generic(n: integer:=12);
	port(
			a, b: in std_logic_vector(n-1 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(n-1 downto 0)
		 );
end component;

signal b_complemented: std_logic_vector(n-1 downto 0);
signal opcode_nbit: std_logic_vector(n-1 downto 0);

signal s_out: std_logic_vector(n-1 downto 0);

begin
	opcode_nbit <= (others => opcode);
	b_complemented <= std_logic_vector(b) XOR opcode_nbit;
	
	RCA: RCA_power4 
	     generic map (n)
		  port map (std_logic_vector(a), b_complemented, opcode, c_carryin_last, c_out, s_out); --c_in = opcode allows to do correctly both sum and subtraction
		  
	s <= signed(s_out);
	status <= c_carryin_last XOR c_out; -- 1 if overflow, 0 if else
	
end Behavior;