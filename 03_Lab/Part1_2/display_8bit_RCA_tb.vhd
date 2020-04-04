library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_8bit_RCA_tb is
end display_8bit_RCA_tb;

architecture Behavior of display_8bit_RCA_tb is

component display_8bit_RCA 
	port(
			SW15_8: in signed(7 downto 0); -- A
			SW7_0: in signed(7 downto 0); -- B
			SW16: in std_logic; -- opcode 0 for addition and 1 for subtraction
			KEY0: in std_logic; -- RESETN
			KEY1: in std_logic; -- CLOCK
			LEDR7_0: out signed(7 downto 0); --S display in two's complement (binary)
			LEDG8: out std_logic; --Overflow
			HEX7_6: out std_logic_vector(0 to 13); --A display 7 segment
			HEX5_4: out std_logic_vector(0 to 13); --B display 7 segment
			HEX1_0: out std_logic_vector(0 to 13) --S display 7 segment
	    );
end component;

signal A: signed(7 downto 0);
signal B: signed(7 downto 0);
signal opcode: std_logic;
signal resetn: std_logic;
signal clock: std_logic;
signal S_binary: signed(7 downto 0);
signal overflow: std_logic;
signal A_7SEG: std_logic_vector(0 to 13);
signal B_7SEG: std_logic_vector(0 to 13);
signal S_7SEG: std_logic_vector(0 to 13);

begin
	DUT: display_8bit_RCA port map(A,B,opcode,resetn,clock,S_binary,overflow,A_7SEG,B_7SEG,S_7SEG);
	
	process
	begin
		clock <= '0';
		resetn <= '1';
		opcode <= '0'; --addition
		A <= to_signed(13, 8);
		B <= to_signed(10, 8);
		wait for 10 ns;
		
		clock <= '1';
		
		wait for 10 ns;
		clock <= '0';
		resetn <= '1';
		opcode <= '0'; --addition
		A <= to_signed(86, 8);
		B <= to_signed(13, 8);
		wait for 10 ns;
		
		Clock <= '1';
		
		wait for 10 ns;
		clock <= '0';
		resetn <= '1';
		opcode <= '0'; --addition
		A <= to_signed(127, 8);
		B <= to_signed(2, 8);
		wait for 10 ns;
		
		clock <= '1';
		
		wait for 10 ns;
		clock <= '0';
		resetn <= '1';
		opcode <= '1'; --subtraction
		A <= to_signed(10, 8);
		B <= to_signed(8, 8);
		wait for 10 ns;
		
		clock <= '1';
		resetn <= '0'; --reset everything in next clock
		
		wait for 10 ns;
		
		clock <= '0';
		resetn <= '1';
		opcode <= '1'; --subtraction
		A <= to_signed(-1, 8);
		B <= to_signed(128, 8);
		wait for 10 ns;
		
		clock <= '1';
		
		wait for 10 ns;
		
	end process;
end Behavior;