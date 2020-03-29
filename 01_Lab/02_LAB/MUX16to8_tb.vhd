library ieee;
use ieee.std_logic_1164.all;

entity MUX16to8_tb is
end MUX16to8_tb;

architecture Behavior of MUX16to8_tb is

component MUX16to8
		port(
			x, y: in std_logic_vector(7 downto 0); --inputs
			s: in std_logic; --selectors
			m: out std_logic_vector(7 downto 0) --outputs
		 );
end component;

signal X_in: std_logic_vector(7 downto 0);
signal Y_in: std_logic_vector(7 downto 0);
signal s_in: std_logic;
signal M_out: std_logic_vector(7 downto 0);

begin
  X_in <= "11111111"; -- we set constants only for demonstration purposes, X and Y
  Y_in <= "00000000"; 
	DUT: MUX16to8 port map (x => X_in, y=> Y_in, s => s_in, m(7 downto 0) => M_out(7 downto 0));
	
process
begin
	-- if s=0 then m=x that equals to 1 (m = 1)
	-- if s=1 then m=y that equals to 0 (m = 0)
	
	s_in <= '0'; -- if s=0 then M=X
	wait for 4 ns;
	s_in <= '1'; -- if s=0 then M=Y
	wait for 4 ns;
end process;
end Behavior;	