library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX3NtoN is
	generic(n_out: integer:=8);
	port(
			u_sig, v_sig, w_sig: in signed(n_out-1 downto 0); --inputs
			s: in std_logic_vector(1 downto 0); --selectors
			m_sig: out signed(n_out-1 downto 0) --output
		 );
end MUX3NtoN;

architecture Structure of MUX3NtoN is

component MUX3to1
		port(
			u, v, w: in std_logic; --inputs
			s: in std_logic_vector(1 downto 0); --selectors
			m: out std_logic --output
		 );
end component;
signal u_in, v_in, w_in, m_in: std_logic_vector(n_out-1 downto 0);

begin
u_in <= std_logic_vector(u_sig);
v_in <= std_logic_vector(v_sig);
w_in <= std_logic_vector(w_sig);

  MUX8bit: for i in 0 to n_out-1 generate
	   MUX: MUX3to1 port map (u_in(i), v_in(i), w_in(i), s, m_in(i));
	end generate;
	  
m_sig <= signed(m_in);
	  
end Structure;	

