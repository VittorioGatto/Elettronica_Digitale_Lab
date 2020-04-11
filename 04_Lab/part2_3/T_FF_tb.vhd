library ieee;
use ieee.std_logic_1164.all;

--simple T FLIP FLOP
entity T_FF_tb is
end T_FF_tb;

architecture Test of T_FF_tb is

component T_FF
	port(
			clk, resetn: in std_logic;
			T: in std_logic;
			Q, Qbar: out std_logic
		);
end component;

constant clk_period: time := 5 ns;

signal clk: std_logic := '0';
signal resetn: std_logic := '0';
signal T, Q, Qbar: std_logic;

begin

DUT: T_FF port map (clk, resetn, T, Q, Qbar);

clk <= not clk after clk_period/2;

process
	begin
		resetn <= '1'; -- wake up
		T <= '1'; --toggle
		wait for 20 ns;
		T <= '0'; --freeze 
		wait for 20 ns;
		T <= '1'; --toggle
		wait for 20 ns;
		resetn <= '0';
		wait for 10 ns;
end process;

end Test;