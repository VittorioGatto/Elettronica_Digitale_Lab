library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX3NtoN_tb is
end MUX3NtoN_tb;

architecture Behavior of MUX3NtoN_tb is

component MUX3NtoN is
	generic(n_out: integer:=8);
	port(  u_sig, v_sig, w_sig: in signed(n_out-1 downto 0); --inputs
			   s: in std_logic_vector(1 downto 0); --selectors
			   m_sig: out signed(n_out-1 downto 0) --output
		 );
end component;

constant n: integer:=8;
constant u_in: signed(n-1 downto 0) := "00000000"; -- 0
constant v_in: signed(n-1 downto 0) := "00000001"; -- 1
constant w_in: signed(n-1 downto 0) := "10000000"; -- -128
signal s_in: std_logic_vector(1 downto 0);
signal m_out: signed(n-1 downto 0);

begin
  DUT: MUX3NtoN port map (u_sig => u_in, v_sig => v_in, w_sig => w_in, s => s_in, m_sig => m_out);

process
begin
	s_in <= "00"; -- u 
	wait for 10 ns;
	s_in <= "01"; -- v
	wait for 10 ns; 
	s_in <= "10"; -- w 
	wait for 10 ns;
	s_in <= "11"; -- w
	wait for 10 ns;
end process;
end Behavior;		

