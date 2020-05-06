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
component MUX2NtoN 
	generic(n: integer:=20);
	port(
			x, y: in std_logic_vector((n-1) downto 0); --inputs
			s: in std_logic; --selector
			m: out std_logic_vector((n-1) downto 0) --outputs
		 );
end component;

signal u_in, v_in, w_in, internal_output, m_in: std_logic_vector(n_out-1 downto 0);

begin
  u_in <= std_logic_vector(u_sig);
  v_in <= std_logic_vector(v_sig);
  w_in <= std_logic_vector(w_sig);

  MUX_UV: MUX2NtoN
    generic map(n_out)
	  port map (u_in, v_in, s(0), internal_output);
	
	MUX_WS: MUX2NtoN
    generic map(n_out)
	  port map (w_in, internal_output, s(1), m_in);
	
  m_sig <= signed(m_in);
	  
end Structure;	
