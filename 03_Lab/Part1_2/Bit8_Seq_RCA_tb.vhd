library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit8_Seq_RCA_tb is
end Bit8_Seq_RCA_tb;

architecture Behavior of Bit8_Seq_RCA_tb is

component Bit8_Seq_RCA
	port(
			A, B: in signed(7 downto 0);
			opcode: in std_logic;
			Clock: in std_logic;
			Resetn: in std_logic;
			Overflow: out std_logic;
			S: out signed(7 downto 0)
		 );
end component;

signal a_in, b_in: signed(7 downto 0);
signal opcode: std_logic;
signal Clock, Resetn, Overflow: std_logic;
signal Result: signed(7 downto 0);

begin
	DUT: Bit8_Seq_RCA port map(a_in, b_in, opcode, Clock, Resetn, Overflow, Result);
	
	process
	begin
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(13, 8);
		b_in <= to_signed(10, 8);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(86, 8);
		b_in <= to_signed(13, 8);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(127, 8);
		b_in <= to_signed(2, 8);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '1'; --subtraction
		a_in <= to_signed(10, 8);
		b_in <= to_signed(8, 8);
		wait for 10 ns;
		
		Clock <= '1';
		Resetn <= '0'; --reset everything in next clock
		
		wait for 10 ns;
		
		Clock <= '0';
		Resetn <= '1';
		opcode <= '1'; --subtraction
		a_in <= to_signed(-1, 8);
		b_in <= to_signed(128, 8);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		
	end process;
end Behavior;