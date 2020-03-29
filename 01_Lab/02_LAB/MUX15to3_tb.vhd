library ieee;
use ieee.std_logic_1164.all;

entity MUX15to3_tb is
end MUX15to3_tb;

architecture Behavior of MUX15to3_tb is

component MUX15to3
		port(
			u, v, w, x, y: in std_logic_vector(2 downto 0); --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic_vector(2 downto 0) --output
		 );
end component;

-- we count from 1 to 5
constant u_in: std_logic_vector(2 downto 0) := "001"; -- number 1
constant v_in: std_logic_vector(2 downto 0) := "010"; -- number 2
constant w_in: std_logic_vector(2 downto 0) := "011"; -- number 3
constant x_in: std_logic_vector(2 downto 0) := "100"; -- number 4
constant y_in: std_logic_vector(2 downto 0) := "101"; -- number 5

signal s_in: std_logic_vector(2 downto 0);
signal m_out: std_logic_vector(2 downto 0);

begin
	UUT: MUX15to3 port map (
		u => u_in, v => v_in, w => w_in, x => x_in, y=> y_in,
		s => s_in, m => m_out
	);
	
process
begin
	s_in <= "000"; -- u (m=001 => "1")
	wait for 10 ns;
	s_in <= "001"; -- v (m=010 => "2")
	wait for 10 ns; 
	s_in <= "010"; -- w (m=011 => "3")
	wait for 10 ns;
	s_in <= "011"; -- x (m=100 => "4")
	wait for 10 ns;
	s_in <= "100"; -- y (m=101 => "5")
	wait for 10 ns;
	s_in <= "101"; -- y (m=101 => "5")
	wait for 10 ns;
	s_in <= "110"; -- y (m=101 => "5")
	wait for 10 ns;
	s_in <= "111"; -- y (m=101 => "5")
	wait for 10 ns;
end process;
end Behavior;	