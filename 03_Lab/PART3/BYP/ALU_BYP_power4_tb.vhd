library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_BYP_power4_tb is
end ALU_BYP_power4_tb;

architecture Behavior of ALU_BYP_power4_tb is

component ALU_BYP_power4
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

signal a_in, b_in: signed(7 downto 0);
signal c_in_IN: std_logic;
signal opcode_IN: std_logic;
signal c_carryin_last_OUT: std_logic;
signal c_out_OUT: std_logic;
signal status_OUT: std_logic;
signal s_OUT: signed(7 downto 0);

begin
	DUT: ALU_BYP_power4 port map(a_in, b_in, c_in_IN, opcode_IN, c_carryin_last_OUT, c_out_OUT, status_OUT, s_OUT);
	
	process
	begin
    a_IN <= "00000000";
    b_IN <= "00000000";
    c_in_IN <= '0';
    opcode_IN <= '0';
    wait for 5 ns;
    
    a_IN <= "11111111";
    b_IN <= "11111111";
    c_in_IN <= '0';
    opcode_IN <= '0';
    wait for 5 ns;
		
		a_IN <= "10101010";
    b_IN <= "01010101";
    c_in_IN <= '0';
    opcode_IN <= '1';
    wait for 5 ns;
    
    a_IN <= "11001111";
    b_IN <= "01011111";
    c_in_IN <= '1';
    opcode_IN <= '1';
    wait for 5 ns;
		
	end process;
end Behavior;