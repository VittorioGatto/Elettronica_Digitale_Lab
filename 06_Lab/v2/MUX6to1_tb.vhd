library ieee;
use ieee.std_logic_1164.all;

entity MUX6to1_tb is
end MUX6to1_tb;

architecture Behavior of MUX6to1_tb is

component MUX6to1 is
	port(
			u, v, w, x, y, z: in std_logic; --inputs
			s: in std_logic_vector(2 downto 0); --selectors
			m: out std_logic --output
		 );
end component;

constant v_in, x_in, z_in: std_logic := '1'; -- we set constants only for demonstration purposes: u,v,w,x,y
constant u_in, w_in, y_in: std_logic:= '0'; -- should be any input value in the circuit
signal s_in: std_logic_vector(2 downto 0);
signal m_out: std_logic;

begin
	UUT: MUX6to1 port map (
		u => u_in, v => v_in, w => w_in, x => x_in, y=> y_in,
		z => z_in, s => s_in, m => m_out
	);
	
process
begin
	-- if s=0 then m=x that equals to 1 (m = 1)
	-- if s=1 then m=y that equals to 0 (m = 0)
	
	s_in <= "000"; -- u (m=0)
	wait for 10 ns;
	s_in <= "001"; -- v (m=1)
	wait for 10 ns; 
	s_in <= "010"; -- w (m=0)
	wait for 10 ns;
	s_in <= "011"; -- x (m=1)
	wait for 10 ns;
	s_in <= "100"; -- y (m=0)
	wait for 10 ns;
	s_in <= "101"; -- z (m=1)
	wait for 10 ns;
	s_in <= "110"; -- y (m=0)
	wait for 10 ns;
	s_in <= "111"; -- z (m=1)
	wait for 10 ns;
end process;
end Behavior;	
