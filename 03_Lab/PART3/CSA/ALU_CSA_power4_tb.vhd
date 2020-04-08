library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_CSA_power4_tb is
end ALU_CSA_power4_tb;

architecture Behavior of ALU_CSA_power4_tb is

component ALU_CSA_power4
	port(
			a, b: in signed(7 downto 0);
			c_in: in std_logic;
			opcode: in std_logic;
			c_carryin_last: buffer std_logic;
			c_out: buffer std_logic;
			status: out std_logic;
			s: out signed(7 downto 0)
		 );
end component;

signal a_IN, b_IN: signed(7 downto 0);
signal c_in_IN: std_logic;
signal opcode_IN: std_logic;
signal c_carryin_last_OUT: std_logic;
signal c_out_OUT: std_logic;
signal s_OUT: signed(7 downto 0);

begin
	DUT: ALU_CSA_power4 port map(a => a_IN, b => b_IN, c_in => c_IN_IN, opcode => opcode_IN, c_carryin_last => c_carryin_last_OUT, c_out => c_out_OUT, s => s_OUT);
	
	process
	begin
		a_IN <= "01010000";
		b_IN <= "10100000";
		opcode_In <='0';
		c_IN_IN <= '0';
		wait for 10 ns;
		
    a_IN <= "00011111";
		b_IN <= "11111111";
		opcode_In <='0';
		c_IN_IN <= '0';
		wait for 10 ns;
		
		a_IN <= "00100101";
		b_IN <= "10000101";
		opcode_In <='0';
		c_IN_IN <= '1';
		wait for 10 ns;
		
		a_IN <= "01111111";
		b_IN <= "11111111";
		opcode_In <='1';
		c_IN_IN <= '0';
		wait for 10 ns;
		
	end process;
end Behavior;