library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX6NtoN_tb is
end MUX6NtoN_tb;

architecture Behavior of MUX6NtoN_tb is

component MUX6NtoN is
	generic(n: integer:=20);
	port(
			u_sig, v_sig, w_sig, x_sig, y_sig, z_sig: in signed(n-1 downto 0); --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m_sig: out signed(n-1 downto 0) --output
		 );
end component;

constant n: integer:=20;
constant u_in: signed(n-1 downto 0) := "00000000000000000000"; -- 0
constant v_in: signed(n-1 downto 0) := "00000000000000000001"; -- 1
constant w_in: signed(n-1 downto 0) := "10000000000000000000"; -- -2048
constant x_in: signed(n-1 downto 0) := "01111111111111111111"; -- 2047
constant y_in: signed(n-1 downto 0) := "11111111111111111111"; -- -1
constant z_in: signed(n-1 downto 0) := "01010101010101010101"; -- 1365
signal s_in: std_logic_vector(2 downto 0);
signal m_out: signed(n-1 downto 0);

begin
  UUT: MUX6NtoN port map (
		u_sig => u_in, v_sig => v_in, w_sig => w_in, x_sig => x_in, y_sig => y_in,
		z_sig => z_in, s => s_in, m_sig => m_out
	);

process
begin
	s_in <= "000"; -- u 
	wait for 10 ns;
	s_in <= "001"; -- v
	wait for 10 ns; 
	s_in <= "010"; -- w 
	wait for 10 ns;
	s_in <= "011"; -- x
	wait for 10 ns;
	s_in <= "100"; -- y 
	wait for 10 ns;
	s_in <= "101"; -- z 
	wait for 10 ns;
	s_in <= "110"; -- y
	wait for 10 ns;
	s_in <= "111"; -- z 
	wait for 10 ns;
end process;
end Behavior;		
