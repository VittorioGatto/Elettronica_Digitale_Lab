library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_power4_tb is
end ALU_power4_tb;

architecture Behavior of ALU_power4_tb is

component ALU_power4
	generic(n: integer:=20);
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


constant n: integer:=20;
signal a_in, b_in: signed(n-1 downto 0);
signal c_in: std_logic := '0';
signal opcode: std_logic;
signal c_carryin_last: std_logic;
signal c_out: std_logic;
signal overflow: std_logic;
signal result: signed(n-1 downto 0);

begin
	DUT: ALU_power4 
		 generic map (n) 
		 port map (a_in, b_in, c_in, opcode, c_carryin_last, c_out, overflow, result);
	
	process
	begin
		a_in <= to_signed(13, n);
		b_in <= to_signed(10, n);
		opcode <= '0'; -- addition
		wait for 10 ns;
		a_in <= to_signed(86, n);
		b_in <= to_signed(13, n);
		opcode <= '0'; -- addition 
		wait for 10 ns;
		a_in <= to_signed(127, n);
		b_in <= to_signed(0, n);
		opcode <= '0'; -- addition 
		wait for 10 ns;
		a_in <= to_signed(127, n);
		b_in <= to_signed(2, n);
		opcode <= '0'; -- addition 
		wait for 10 ns;
		a_in <= to_signed(-50, n);
		b_in <= to_signed(20, n);
		opcode <= '0'; -- addition 
		wait for 10 ns;

		a_in <= to_signed(10, n);
		b_in <= to_signed(8, n);
		opcode <= '1'; -- subtraction 
		wait for 10 ns;
		a_in <= to_signed(9, n);
		b_in <= to_signed(15, n);
		opcode <= '1'; -- subtraction 
		wait for 10 ns;
		a_in <= to_signed(128, n);
		b_in <= to_signed(0, n);
		opcode <= '1'; -- subtraction 
		wait for 10 ns;
		a_in <= to_signed(-1, n);
		b_in <= to_signed(128, n);
		opcode <= '1'; -- subtraction 
		wait for 10 ns;
		a_in <= to_signed(-50, n);
		b_in <= to_signed(-20, n);
		opcode <= '1'; -- subtraction 
		wait for 10 ns;
	end process;
end Behavior;