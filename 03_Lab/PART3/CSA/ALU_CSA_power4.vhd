library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Simplified ALU (can only add and subtract) that takes as inputs two signed numbers
--This ALU uses a Carry Select Adder
--status: simplified status, 1 if operation results in overflow, 0 if else
--opcode: simplified opcdoe, 0 if addition, 1 if subtraction

entity ALU_CSA_power4 is
	generic(n: integer:=8); --n bits MUST BE POWER OF 4!!
	port(
			a, b: in signed(n-1 downto 0);
			c_in: in std_logic;
			opcode: in std_logic;
			c_carryin_last: buffer std_logic;
			c_out: buffer std_logic;
			status: out std_logic;
			s: out signed(n-1 downto 0)
		 );
end ALU_CSA_power4;

architecture Behavior of ALU_CSA_power4 is

component MUX2NtoN
	generic(n: integer:=8);
	port(
			x, y: in std_logic_vector((n-1) downto 0);
			s: in std_logic;
			m: out std_logic_vector((n-1) downto 0)
		 );
end component;

component CSA4bits_power4
	generic(n: integer:=8);
	port(
			a, b: in std_logic_vector(n-1 downto 0);
			c_in: in std_logic;
			c_carryin_last: out std_logic;
			c_out: out std_logic;
			s: out std_logic_vector(n-1 downto 0)
		 );
end component;

signal b_complemented: std_logic_vector(n-1 downto 0);
signal b_negative: std_logic_vector(n-1 downto 0);
constant number1: std_logic_vector(n-1 downto 0) := std_logic_vector(to_unsigned(1, n));
signal b_opcode: std_logic_vector(n-1 downto 0);

signal s_out: std_logic_vector(n-1 downto 0);

begin
	b_complemented <= not std_logic_vector(b); --complements b
	
	CSA_opcode: CSA4bits_power4 
	     generic map (n)
		  port map (b_complemented, number1, c_in, open, open, b_negative); --adds 1 to b_complemented, now we have (minus "-") -b
		  
	MUX_opcode: MUX2NtoN 
					generic map (n)
					port map (std_logic_vector(b), b_negative, opcode, b_opcode); -- opcode toggles addition(0) or subtraction(1)
		  
   CSA: CSA4bits_power4 
	     generic map (n)
		  port map (std_logic_vector(a), std_logic_vector(b_opcode), c_in, c_carryin_last, c_out, s_out);
		  
	s <= signed(s_out);
	status <= c_carryin_last XOR c_out; -- 1 if overflow, 0 if else
	
end Behavior;