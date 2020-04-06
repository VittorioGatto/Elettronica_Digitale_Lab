library ieee;
use ieee.std_logic_1164.all;

entity MUX2NtoN_tb is
end MUX2NtoN_tb;

architecture Behavior of MUX2NtoN_tb is

component MUX2NtoN is
	generic(n: integer:=8);
	port(
			x, y: in std_logic_vector((n-1) downto 0); --inputs
			s: in std_logic; --selector
			m: out std_logic_vector((n-1) downto 0) --outputs
		 );
end component;

constant n_set: integer:=8;

signal X_in: std_logic_vector((n_set-1) downto 0);
signal Y_in: std_logic_vector((n_set-1) downto 0);
signal s_in: std_logic;
signal M_out: std_logic_vector((n_set-1) downto 0);

begin
  X_in <= "11111111"; -- we set constants only for demonstration purposes, X and Y
  Y_in <= "00000000"; 
	DUT: MUX2NtoN 
	generic map (8) 
	port map (x => X_in, y=> Y_in, s => s_in, m => M_out);
	
process
begin
	-- if s=0 then m=x that equals to 1 (m = 1)
	-- if s=1 then m=y that equals to 0 (m = 0)
	
	s_in <= '0'; -- if s=0 then M=X
	wait for 10 ns;
	s_in <= '1'; -- if s=0 then M=Y
	wait for 10 ns;
end process;
end Behavior;	