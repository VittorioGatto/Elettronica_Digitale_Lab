library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX6NtoN is
	generic(n: integer:=20);
	port(
			u_sig, v_sig, w_sig, x_sig, y_sig, z_sig: in signed(n-1 downto 0); --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m_sig: out signed(n-1 downto 0) --output
		 );
end MUX6NtoN;

architecture Structure of MUX6NtoN is

component MUX6to1
		port(
			u, v, w, x, y, z: in std_logic; --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic --output
		 );
end component;
signal u_in, v_in, w_in, x_in, y_in, z_in, m_in: std_logic_vector(n-1 downto 0);

begin
u_in <= std_logic_vector(u_sig);
v_in <= std_logic_vector(v_sig);
w_in <= std_logic_vector(w_sig);
x_in <= std_logic_vector(x_sig);
y_in <= std_logic_vector(y_sig);
z_in <= std_logic_vector(z_sig);

  MUX20bit: for i in 0 to n-1 generate
	   MUX: MUX6to1 port map (u_in(i), v_in(i), w_in(i), x_in(i), y_in(i), z_in(i), s, m_in(i));
	end generate;
	  
m_sig <= signed(m_in);
	  
end Structure;	
