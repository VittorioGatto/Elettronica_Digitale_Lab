library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit16_Seq_BYP_tb is
end Bit16_Seq_BYP_tb;

architecture Behavior of Bit16_Seq_BYP_tb is

component Bit16_Seq_BYP
	port(
			A, B: in signed(15 downto 0);
			opcode: in std_logic;
			Clock: in std_logic;
			Resetn: in std_logic;
			Overflow: out std_logic;
			S: out signed(15 downto 0)
		 );
end component;

signal a_in, b_in: signed(15 downto 0);
signal opcode: std_logic;
signal Clock, Resetn, Overflow: std_logic;
signal Result: signed(15 downto 0);

begin
	DUT: Bit16_Seq_BYP port map(a_in, b_in, opcode, Clock, Resetn, Overflow, Result);
	
	process
	begin
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(1013, 16);
		b_in <= to_signed(1000, 16);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(1086, 16);
		b_in <= to_signed(1003, 16);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '0'; --addition
		a_in <= to_signed(32767, 16);
		b_in <= to_signed(2, 16);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		Clock <= '0';
		Resetn <= '1';
		opcode <= '1'; --subtraction
		a_in <= to_signed(1000, 16);
		b_in <= to_signed(108, 16);
		wait for 10 ns;
		
		Clock <= '1';
		Resetn <= '0'; --reset everything in next clock
		
		wait for 10 ns;
		
		Clock <= '0';
		Resetn <= '1';
		opcode <= '1'; --subtraction
		a_in <= to_signed(-1, 16);
		b_in <= to_signed(32768, 16);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		
	end process;
end Behavior;