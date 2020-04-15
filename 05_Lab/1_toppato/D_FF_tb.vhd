LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY D_FF_tb IS
end D_FF_tb;

ARCHITECTURE Behavior OF D_FF_tb IS

COMPONENT D_FF
port(	D, clk, res: IN std_logic;
		Q: OUT std_logic
	);
end COMPONENT;

signal D_in: std_logic;
signal clk_in: std_logic;
signal res_in: std_logic := '0';
signal Q_out: std_logic;

BEGIN

PROCESS --clock generation, period = 10 ns
  BEGIN
    clk_in <= '0', '1' after 5 ns;
    wait for 10 ns;
END PROCESS;

DUT: D_FF port map (D => D_in, clk => clk_in, res => res_in, Q => Q_out);
  
PROCESS
  BEGIN
    res_in <= '1';
    D_in <= '1';
    wait for 10 ns;
    D_in <= '0';
    wait for 15 ns;
    D_in <= '0';
    res_in <= '0';
    wait for 5 ns;
END PROCESS;

END Behavior;