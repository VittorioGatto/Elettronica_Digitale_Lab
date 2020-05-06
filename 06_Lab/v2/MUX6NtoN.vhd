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

component MUX2NtoN 
	generic(n: integer:=20);
	port(
			x, y: in std_logic_vector((n-1) downto 0); --inputs
			s: in std_logic; --selector
			m: out std_logic_vector((n-1) downto 0) --outputs
		 );
end component;
type int_array is array (3 downto 0) of std_logic_vector(n-1 downto 0);
signal u_in, v_in, w_in, x_in, y_in, z_in, m_in: std_logic_vector(n-1 downto 0);
signal internal_output: int_array;

begin
u_in <= std_logic_vector(u_sig);
v_in <= std_logic_vector(v_sig);
w_in <= std_logic_vector(w_sig);
x_in <= std_logic_vector(x_sig);
y_in <= std_logic_vector(y_sig);
z_in <= std_logic_vector(z_sig);

	MUX_UV: MUX2NtoN
	   generic map(20)
	   port map (x => u_in, y => v_in, s => s(0), m => internal_output(0));
	     
	MUX_WX: MUX2NtoN
	   generic map(20)
	   port map (x => w_in, y => x_in, s => s(0), m => internal_output(1));
	     
	MUX_YZ: MUX2NtoN
	   generic map(20)
	   port map (x => y_in, y => z_in, s => s(0), m => internal_output(2));
	     
	     
	MUX_S1: MUX2NtoN
	   generic map(20)
	   port map (x => internal_output(0), y => internal_output(1), s => s(1), m => internal_output(3));
	     
	MUX_S2:  MUX2NtoN
	   generic map(20)
	   port map (x => internal_output(3), y => internal_output(2), s => s(2), m => m_in);
	  
m_sig <= signed(m_in);
	  
end Structure;	
